# Group11 利用時間序列進行股票回測

### Groups
* 許育誠, 107753001

### Goal
想必大家都希望透過將剩餘可投資閒錢，透過證券交易方式來獲取豐沃的利潤。但股票市場有風平浪靜、卻有時如洪水一般，殺的投資者措手不及、血本無歸。仿間充斥許多名嘴老師，但是你（妳）相信嗎？除非，你（妳）掌握內線消息，否則就如同電視廣告台詞一般，“投資有風險..."。本組希望透過回測技術，去預測未來一天的股價，若預測價格扣掉手續費仍高於今日價格便買進、低於今日價格便賣出的投資方式進行理財規劃。

### Demo 
You should provide an example commend to reproduce your result
```R
Rscript code/Try.R --StartＤate 2010-01-01 --EndＤate 2020-12-31 --fold 10 --output results/performance.tsv
```

## Folder organization and its related information

### docs
* Your presentation, 1091_datascience_FP_107753001.ppt, by **Jan. 12**

### data

* Source
  * yahoo股票
* Input format
  * 股價
* Any preprocessing?
  * 缺失值刪除

### code

* Which method do you use?
  * ARIMA
* What is a null model for comparison?
  * ARIMA我們使用 K-Fold Cross Validation 來進行模型驗證
* How do your perform evaluation? ie. Cross-validation, or extra separated data

### results

* Which metric do you use 
  * precision, recall, R-square
* Is your improvement significant?
* What is the challenge part of your project?

## References
* Code/implementation which you include/reference (__You should indicate in your presentation if you use code for others. Otherwise, cheating will result in 0 score for final project.__)
* Packages you use
  * library("quantmod")
  * library(tseries)
  * library(tseries)
  * llibrary(ggplot2)
  * llibrary(dplyr)
* Related publications
  * https://ithelp.ithome.com.tw/articles/10244840
  *  


