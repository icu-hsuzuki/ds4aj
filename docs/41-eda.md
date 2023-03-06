# (PART) PART IV EDA {-}
# 探索的データ解析 {#intro2eda}



## 探索的データ解析 (EDA)とは

![image from r4ds](https://d33wubrfki0l68.cloudfront.net/571b056757d68e6df81a3e3853f54d3c76ad6efc/32d37/diagrams/data-science.png)

以下は、[Posit Primers: Visualise Data](https://posit.cloud/learn/primers/3.1) から

探索的データ解析 (EDA) は、データを理解するための反復的なサイクルです。EDAでは、以下のことを行います。

1. データに関する問いを作成する

2. データの可視化、変形・整形、モデリングによって、問いの答えを探索する。

3. 学んだことを使って、問いをより洗練されたものとする。

EDAは、あらゆるデータ分析において重要な役割を担います。EDA によって、課題解決のいとぐちを発見することもありますし、他の課題との関係性を発見する場合もあります。EDAを使用してデータの問題や品質を確認したり、データが信頼できるものであるかを見極める問いを作成できる場合もあります。


## 探索的データ解析 (EDA) の一例

WDI の一つの指標を使って、流れを見てみましょう。



### データの取得と読み込み - Data Import

NY.GDP.PCAP.CD: GDP per capita (current US$)


```r
df_wdi_gdppcap <- WDI(country = "all", indicator = c(gdp_pcap = "NY.GDP.PCAP.CD"))
write_csv(df_wdi_gdppcap, "./data/df_wdi_gdppcap.csv")
```




```r
df_wdi_gdppcap
#> # A tibble: 16,492 × 5
#>    country                     iso2c iso3c  year gdp_pcap
#>    <chr>                       <chr> <chr> <dbl>    <dbl>
#>  1 Africa Eastern and Southern ZH    AFE    2021    1550.
#>  2 Africa Eastern and Southern ZH    AFE    2020    1364.
#>  3 Africa Eastern and Southern ZH    AFE    2019    1512.
#>  4 Africa Eastern and Southern ZH    AFE    2018    1565.
#>  5 Africa Eastern and Southern ZH    AFE    2017    1629.
#>  6 Africa Eastern and Southern ZH    AFE    2016    1444.
#>  7 Africa Eastern and Southern ZH    AFE    2015    1539.
#>  8 Africa Eastern and Southern ZH    AFE    2014    1719.
#>  9 Africa Eastern and Southern ZH    AFE    2013    1730.
#> 10 Africa Eastern and Southern ZH    AFE    2012    1759.
#> # … with 16,482 more rows
```

### データ変形・整形 - Data Transformation

#### 列を `select`

どの変数について分析するかを選ぶ。


```r
df_wdi_gdppcap_small <- df_wdi_gdppcap %>% 
  select(country, year, gdp_pcap)
df_wdi_gdppcap_small
#> # A tibble: 16,492 × 3
#>    country                      year gdp_pcap
#>    <chr>                       <dbl>    <dbl>
#>  1 Africa Eastern and Southern  2021    1550.
#>  2 Africa Eastern and Southern  2020    1364.
#>  3 Africa Eastern and Southern  2019    1512.
#>  4 Africa Eastern and Southern  2018    1565.
#>  5 Africa Eastern and Southern  2017    1629.
#>  6 Africa Eastern and Southern  2016    1444.
#>  7 Africa Eastern and Southern  2015    1539.
#>  8 Africa Eastern and Southern  2014    1719.
#>  9 Africa Eastern and Southern  2013    1730.
#> 10 Africa Eastern and Southern  2012    1759.
#> # … with 16,482 more rows
```

#### 行を `filter`

いくつかの国に、フォーカスして調べる。


```r
df_wdi_gdppcap_short <- df_wdi_gdppcap %>% 
  filter(country %in% c("Japan", "Germany", "United States"))
df_wdi_gdppcap_short
#> # A tibble: 186 × 5
#>    country iso2c iso3c  year gdp_pcap
#>    <chr>   <chr> <chr> <dbl>    <dbl>
#>  1 Germany DE    DEU    2021   51204.
#>  2 Germany DE    DEU    2020   46773.
#>  3 Germany DE    DEU    2019   46794.
#>  4 Germany DE    DEU    2018   47939.
#>  5 Germany DE    DEU    2017   44653.
#>  6 Germany DE    DEU    2016   42136.
#>  7 Germany DE    DEU    2015   41103.
#>  8 Germany DE    DEU    2014   48024.
#>  9 Germany DE    DEU    2013   46299.
#> 10 Germany DE    DEU    2012   43856.
#> # … with 176 more rows
```

列（変数）と、行（国）の選択を続けて、実行すると次のようになる。
一つ一つ変形したデータ（オブジェクト）に名前をつけて、保存する必要がないので、パイプ（`%>% `）の活用は有用である。


```r
df_wdi_gdppcap_small_short <- df_wdi_gdppcap %>% select(country, year, gdp_pcap) %>%
  filter(country %in% c("Japan", "Germany", "United States"))
df_wdi_gdppcap_small_short
#> # A tibble: 186 × 3
#>    country  year gdp_pcap
#>    <chr>   <dbl>    <dbl>
#>  1 Germany  2021   51204.
#>  2 Germany  2020   46773.
#>  3 Germany  2019   46794.
#>  4 Germany  2018   47939.
#>  5 Germany  2017   44653.
#>  6 Germany  2016   42136.
#>  7 Germany  2015   41103.
#>  8 Germany  2014   48024.
#>  9 Germany  2013   46299.
#> 10 Germany  2012   43856.
#> # … with 176 more rows
```


### 可視化 Data Visualization

次は、よく生じる、誤りの例で、ノコギリの歯（sawtoothed）のようなギザギザ・グラフと呼ばれます。なぜこのようなことが起きているかわかりますか。


```r
df_wdi_gdppcap_small_short %>%
  ggplot(aes(x = year, y = gdp_pcap)) + geom_line()
#> Warning: Removed 1 row containing missing values
#> (`geom_line()`).
```

<img src="41-eda_files/figure-html/unnamed-chunk-9-1.png" width="672" />

同じ年に、多くのデータがあるので、折れ線グラフを適切に書くことができませんでした。


```r
df_wdi_gdppcap_small_short %>% filter(country %in% c("Japan")) %>%
  ggplot(aes(x = year, y = gdp_pcap)) + geom_line()
```

<img src="41-eda_files/figure-html/unnamed-chunk-10-1.png" width="672" />

一般的には、散布図をまず、書いてみるのも一つです。


```r
df_wdi_gdppcap_small_short %>%
  ggplot(aes(x = year, y = gdp_pcap)) + geom_point()
#> Warning: Removed 10 rows containing missing values
#> (`geom_point()`).
```

<img src="41-eda_files/figure-html/unnamed-chunk-11-1.png" width="672" />

国別に、異なる色を使うことで、折れ線グラフを書くことも可能です。


```r
df_wdi_gdppcap_small_short %>% drop_na(gdp_pcap) %>%
  ggplot(aes(x = year, y = gdp_pcap, col = country)) + geom_line()
```

<img src="41-eda_files/figure-html/unnamed-chunk-12-1.png" width="672" />

折線グラフと、散布図を同時に描くこともかのうです。


```r
df_wdi_gdppcap_small_short %>% drop_na(gdp_pcap) %>%
  ggplot(aes(x = year, y = gdp_pcap, col = country)) + geom_line() +
  geom_point()
```

<img src="41-eda_files/figure-html/unnamed-chunk-13-1.png" width="672" />

点を、曲線で近似する方法はいくつも知られているが、ある幅で、近似していく、LOESS が初期値となっている。`method='loess'` を省略しても、同じ近似がなされる。`span` という値を調節することで、ことなる幅での近似曲線を書くことも可能である。初期値は、0.75。


```r
df_wdi_gdppcap_small_short %>% drop_na(gdp_pcap) %>%
  ggplot(aes(x = year, y = gdp_pcap)) + 
  geom_point(aes(color = country)) + 
  geom_smooth(method = 'loess', formula = 'y ~ x')
```

<img src="41-eda_files/figure-html/unnamed-chunk-14-1.png" width="672" />

### データモデリング Data Modeling

上の例では、曲線ではなく、直線で近似することも考えられる。


```r
df_wdi_gdppcap_small_short %>% drop_na(gdp_pcap) %>%
  ggplot(aes(x = year, y = gdp_pcap)) + 
  geom_point(aes(color = country)) + 
  geom_smooth(method = 'lm', formula = 'y ~ x')
```

<img src="41-eda_files/figure-html/unnamed-chunk-15-1.png" width="672" />

簡単な線形回帰モデルでの、回帰直線の y-切片や、傾きは、次のコードで与えられ、p-value や、R squared の値も求められる。

この例では、年とともに、増加の傾向があること。そして、線形モデルが$$、90% 程度説明していると表現される。すなわち、

$$gdppcap \sim 98.3 \cdot year -1902497.5$$

は、良い、近似であることがわかる。


```r
df_wdi_gdppcap_small_short %>% lm(gdp_pcap ~ year, .) %>% summary()
#> 
#> Call:
#> lm(formula = gdp_pcap ~ year, data = .)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -14156.8  -3200.5   -507.4   3237.7  16779.2 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -1903497.5    48007.9  -39.65   <2e-16 ***
#> year             968.3       24.1   40.18   <2e-16 ***
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 5514 on 174 degrees of freedom
#>   (10 observations deleted due to missingness)
#> Multiple R-squared:  0.9027,	Adjusted R-squared:  0.9021 
#> F-statistic:  1614 on 1 and 174 DF,  p-value: < 2.2e-16
```

