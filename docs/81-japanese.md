# (APPENDIX) APPENDIX {-}
# 日本語の扱いについて {#japanese}



## 日本語・中国語・韓国語

文字化けが、起こることが多く、対応が、一定せず、難しかったのですが、どうやら、現在は、どの場合も、次の設定で、解決しているようです。下の例を確認してください。


```r
# showtext を、インストールしていない場合は、一回だけ、右上の三角をクリックして実行
install.packages('showtext')
```

### パッケージをロード

`library` によって、Package をロード（いつでも使えるように）します。


```r
library(tidyverse)
library(showtext) 
font_add_google('Noto Sans')
showtext_auto()
```

## Base R でタイトルに日本語


```r
plot(cars, main="散布図")
```

![](81-japanese_files/figure-epub3/unnamed-chunk-3-1.png)<!-- -->


## 列名や、データに日本語



```r
df_iris <- iris
colnames(df_iris) <- c("萼長","萼幅","葉長","葉幅","Species" )
tab <- data.frame(Species = c("setosa", "versicolor", "virginica"), 
                  "種別" = c("ヒオウギアヤメ", "ブルーフラッグ", "バージニカ"))
df_iris <- df_iris %>% left_join(tab, by=c("Species" = "Species")) %>% select(-5)
df_iris %>% slice(1:2)
#>   萼長 萼幅 葉長 葉幅           種別
#> 1  5.1  3.5  1.4  0.2 ヒオウギアヤメ
#> 2  4.9  3.0  1.4  0.2 ヒオウギアヤメ
```

## `kable` で表示


```r
knitr::kable(df_iris[1:6, ])
```



| 萼長| 萼幅| 葉長| 葉幅|種別           |
|----:|----:|----:|----:|:--------------|
|  5.1|  3.5|  1.4|  0.2|ヒオウギアヤメ |
|  4.9|  3.0|  1.4|  0.2|ヒオウギアヤメ |
|  4.7|  3.2|  1.3|  0.2|ヒオウギアヤメ |
|  4.6|  3.1|  1.5|  0.2|ヒオウギアヤメ |
|  5.0|  3.6|  1.4|  0.2|ヒオウギアヤメ |
|  5.4|  3.9|  1.7|  0.4|ヒオウギアヤメ |


## `ggplot` でグラフを作成

![](81-japanese_files/figure-epub3/unnamed-chunk-5-1.png)<!-- -->


