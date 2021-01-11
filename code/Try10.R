library("xgboost")
library(Matrix)
library(lattice)
library(mice)
library(caret)

DataScreeningStep <- function(Data, type) {
  Data <- Data[-1, 2 : 64]
  for (i in 2 : 63) {
    Data[, i] <- as.numeric(as.character(Data[, i]))
    q1 <- quantile(Data[, i], 0.01)
    q99 <- quantile(Data[, i], 0.99)
    Data[which(Data[, i] < q1), i] <- q1
    Data[which(Data[, i] > q99), i] <- q99
    Mean <- mean(Data[, i])
    Sd <- sd(Data[, i])
    Data[, i] <- (Data[, i] - Mean) / Sd
  }
  return(Data)
}

RpartModel <- function(Data) {
  a <-c(1, 3 : 63)
  traindata1 <- data.matrix(Data[, a]) 
  traindata2 <- Matrix(traindata1, sparse = T) 
  traindata3 <- Data[, 2]
  traindata4 <- list(data = traindata2, label = traindata3) 
  dtrain <- xgb.DMatrix(data = traindata4$data, label = traindata4$label)
  Model <- xgboost(data = dtrain, max_depth = 15, eta = 0.001, nround = 3000)
  return(Model)
}

PredictStep1 <- function(Data, Model) {
  a <-c(1, 3 : 63)
  predictdata1 <- data.matrix(Data[, a]) 
  predictdata2 <- Matrix(predictdata1, sparse = T) 
  predictdata3 <- Data[, 2]
  predictdata4 <- list(data = predictdata2, label = predictdata3) 
  dpredict <- xgb.DMatrix(data = predictdata4$data, label = predictdata4$label)
  Result <- cor(predictdata3, predict(Model, newdata = dpredict)) ^ 2
  return(Result)
}

args = commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  stop("USAGE: Rscript Try10.R --fold 5  --train d_all.csv --report performance.csv", call. = FALSE)
} else {
  i <- 1 
  while (i < length(args)) {
    if (args[i] == "--fold") {
      Fold <- as.integer(args[i + 1])
      i <- i + 1
    } else if (args[i] == "--train") {
      Train <- args[i + 1]
      i <- i + 1
    } else if (args[i] == "--report") {
      Report <- args[i + 1]
      i <- i + 1
    } else {
      stop(paste("Unknown flag", args[i]), call. = FALSE)
    }
    i <- i + 1
  }
  
  if (length(grep(".csv", Train)) != 1) {
    Train <- paste0(Train, ".csv")
  }
  if (length(grep(".csv", Report)) != 1) {
    Report <- paste0(Report, ".csv")
  }
  Data <- read.csv(Train, header = F)
  NewData <- DataScreeningStep(Data, 0)
  Spacing <- floor(length(NewData[, 1]) / Fold)
  RandomIndex <- sample(1 : length(NewData[, 1]), length(NewData[, 1]), replace = FALSE)
  ExchangeData <- NewData[RandomIndex, ]
  set <- c()
  training <- c()	
  validation <- c()	
  test <- c()
  for (i in 1 : Fold) {
    TrainData <- ExchangeData
    TestIndex <- ((i - 1) * Spacing + 1) : (Spacing * i)
    TestData <- ExchangeData[TestIndex, ]
    if ((i + 1) %% Fold == 0) {
      n <- Fold
      ValidationIndex <- ((n - 1) * Spacing + 1) : (Spacing * n)
    } else {
      n <- (i + 1) %% Fold
      ValidationIndex <- ((n - 1) * Spacing + 1) : (Spacing * n)
    }
    ValidationData <- ExchangeData[ValidationIndex, ]
    DeleteIndex <- c(TestIndex, ValidationIndex) * (-1)
    TrainData <- TrainData[DeleteIndex, ]
    set[i] <- paste0("fold", i)
    Model<- RpartModel(TrainData)
    training[i] <- round(PredictStep1(TrainData, Model), 2)
    validation[i] <- round(PredictStep1(ValidationData, Model), 2)
    test[i] <- round(PredictStep1(TestData, Model), 2)
  }
  set[i + 1] <- "ave."
  training[i + 1] <- round(mean(training), 2)
  validation[i + 1] <- round(mean(validation), 2)
  test[i + 1] <- round(mean(test), 2)
  result <- data.frame(set = set, training = training, validation = validation, test = test)
  write.table(result, file = Report, quote = F, sep = ",", row.names = F, na = "NA")
}
