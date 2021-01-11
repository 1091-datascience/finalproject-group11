# Group11 美國與各國間匯率預測

### Groups
* 許育誠, 107753001

### Goal
想必大家都希望透過將剩餘可投資閒錢，透過證券交易方式或是夠買其它幣值來獲取豐沃的利潤。但金融市場有風平浪靜、卻有時如洪水一般，殺的投資者措手不及、血本無歸。仿間充斥許多名嘴老師或投資客開班是授課，但是你（妳）相信嗎？除非，你（妳）掌握內線消息，否則就如同電視廣告台詞一般，“投資有風險..."。我們常說要進入這市場，還是要拿點學費練經驗。然而，機器學習不就是透過大數據找尋隱藏於數據之中規則。因此，本組希望透過機器學習技術，去預測未來一天的匯率，若預測價格扣掉手續費仍高於今日價格便買進、低於今日價格便賣出的投資方式進行理財規劃。

### Demo 
You should provide an example commend to reproduce your result
```R
Rscript Try10.R --fold 5 --train d_all.csv --report performance.csv
```

## Folder organization and its related information

### docs
* Your presentation, 1091_datascience_FP_107753001.ppt, by **Jan. 12**

### data

* Source
  * yahoo股票
* Input format
  * 
* Any preprocessing?
  * 文字類別轉換成數字
  * 缺失值刪除
  * 離群值修正
  * 資料正規化
  
### code

* Which method do you use?
  * 線性回歸
  * xgboost
* What is a null model for comparison?
  * 使用 K-Fold Cross Validation 來進行模型驗證
* How do your perform evaluation?
  
  在進行預測時，都需進行一些資料的前處理動作，以為資料特徵更為顯著，也如同在本頁面上述所提方法。但是在資料整理完到進行模型訓練過程，事實上仍還需要有許多工作要執行，以這個專案為例，將會分成三個步驟為大家說明。
  
  第一步，資料是否具時間性：雖然每一筆匯率資料都列出了許多的影響影因子。可是說到底，匯率仍是一個與時間波動習習相關資訊。如與時間有關聯，則需採用跟時間序列相關的預測方法。因此，需要藉由仍進行檢驗之。可透過兩種方式進行檢驗，一為使用時間域轉空間域方式，講隱藏與數據中的週期規律展現出來。二為調查資料間是否存在穩態(資料點彼此間是否具有共同的平均值和標準差)
![image](https://github.com/1091-datascience/finalproject-group11/blob/master/%E5%88%A4%E6%96%B7%E6%98%AF%E5%90%A6%E7%A9%A9%E6%85%8B.png)
![image](https://github.com/1091-datascience/finalproject-group11/blob/master/%E6%8E%A2%E8%A8%8E%E6%99%82%E9%96%93%E9%80%B1%E6%9C%9F%E5%95%8F%E9%A1%8C.png)
  
  第二步，分析資料間對於結果的貢獻度，從這一步驟可以看出哪些資料對於結果是有其架大影想的。
![image](https://github.com/1091-datascience/finalproject-group11/blob/master/%E7%89%B9%E5%BE%B5%E5%80%BC%E9%87%8D%E8%A6%81%E6%80%A7.png)
  
  第三步，訓練模型與模型挑選。到了這一步，大家就會開始嘗試各種自己所知可運用在這上面的模型。事實上，每種模型都有其建構的理論背景，並無哪一個模型佳或差，僅只是是否有剛好這一類的資料特性，可以將隱藏與資料中的規律給挑選出來。然而，這也是一種與第二步驟的循環，會不斷挑選因子、修正模型參數，甚制回到第一步修正資料。
### results

* Which metric do you use 
  * R-square
![image](https://github.com/1091-datascience/finalproject-group11/blob/master/%20r%20square.pdf)
* Is your improvement significant?
  
  從上面R-square的結果可以看出，其結果非常的差，也發生了過度擬合等問題，接下來的發展空間仍然非常的大。
* What is the challenge part of your project?
  
  或許自己原本以為時間充裕，想要選擇較有挑戰性的來施作，像是時間序列等股票趨勢來分析。但是過程中，遇到很多程式語法、時間序列模型使用前檢定一直不合格(回歸三大假設：誤差具有常態分配、相同標準差等)。在時間壓迫下也只能選擇較好掌握的課題。在資料選擇方面，其因子共有62個，但可用資料筆數僅有678筆，相對而言也有可能是造成模型學習成效不佳的嚴重主因。

## References
* Code/implementation which you include/reference (__You should indicate in your presentation if you use code for others. Otherwise, cheating will result in 0 score for final project.__)
* Packages you use
  * library("quantmod")
  * library("xgboost")
  * library(Matrix)
  * library(lattice)
  * library(mice)
  * library(caret)
* Related publications
  * https://blog.csdn.net/zpxcod007/article/details/80118580
  * https://ithelp.ithome.com.tw/articles/10244840
  * http://blog.fens.me/r-na-mice/


