# e-Stat {#estat}

## API の使い方

### はじめての e-Stat with API

はじめて、R の `etatapi` を使って、e-Stat のデータを取得する方法を簡単に説明します。

### 初期設定 {-}

パッケージの、`estatapi` が、e-Stat のデータを取得するためのものです。`tidyverse` は基本的な解析をおこなうため、`showtext` と `showtext_auto()` は、グラフなどに、日本語が含まれる場合の文字化けを防ぐためのものです。

インストールされていないパッケージがありましたら、上のメニューの Tools > Install Packages から、インストールしてください。


```r
library(tidyverse)
#> ── Attaching core tidyverse packages ──── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.2     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.0
#> ✔ ggplot2   3.4.2     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.1     
#> ── Conflicts ────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(showtext)
#> Loading required package: sysfonts
#> Loading required package: showtextdb
library(estatapi)
#> このサービスは、政府統計総合窓口(e-Stat)のAPI機能を使用していますが、サービスの内容は国によって保証されたものではありません。
showtext_auto()
```

### e-Stat 登録と、アプリケーションIDの取得

e-Stat API を利用するには、appId が必要です。

1. e-stat: https://www.e-stat.go.jp/ のページへ行く。
2. 右上の新規登録から、アカウント登録をします。
    - メールアドレスを入力し、そこに届いてリンクを開き、パスワードを設定。
    - パスワード設定は、Google などのアカウント連携ですることも可能です。
3. アカウントにログイン。上の帯に、メールアドレスが表示されます。
4. その右のマイページに行き、API機能（アプリケーションID発行）へ。まず、必要事項の入力が必要ですが、説明をみてください。
    - 名称：API機能を利用するアプリケーション名（システム名等）- R または、RStudio
    - URL：アプリケーションのURL（トップページ等のURL）
* If you do not use it on the public site, please enter "http: // test.localhost /" etc. - localhost でよいでしょう。
    - 概要：アプリケーション（システム）の概要 - estatapi とでも書いておけば良いでしょう。
    - 右の発行を押すと、appId が表示されます。これを記録。
    
    
## `estatapi` 利用概要

CRAN `estatspi` URL: https://CRAN.R-project.org/package=estatapi

### アプリケーションIDの設定

```
appId <- " " # 私のものは、英数40文字
```



### 統計表情報取得（estat_getStatsList()）

提供されている統計表を検索します。この関数は、結果をtbl_df（dplyrのdata.frame。data.frameとほぼ同じように扱える）として返します。

STAT_NAMEやGOV_ORGは人間が読みやすい形式のラベルになっていますが、 プログラム中で扱う場合はコードのままの方が都合がいいこともあります。そのときは.use_label = FALSEを指定してください。

```
estat_getStatsList(appId = appId, searchWord = "")
```


```r
estat_getStatsList(appId = appId, searchWord = "人口推計")
#> # A tibble: 478 × 21
#>    `@id`      STAT_NAME GOV_ORG STATISTICS_NAME TITLE CYCLE
#>    <chr>      <chr>     <chr>   <chr>           <chr> <chr>
#>  1 0000150001 人口推計  総務省  人口推計 平成3… 年齢… -    
#>  2 0000150002 人口推計  総務省  人口推計 平成3… 年齢… -    
#>  3 0000150003 人口推計  総務省  人口推計 平成3… 人口… -    
#>  4 0000150004 人口推計  総務省  人口推計 平成3… 年齢… -    
#>  5 0000150005 人口推計  総務省  人口推計 平成3… 年齢… -    
#>  6 0000150006 人口推計  総務省  人口推計 平成3… 年齢… -    
#>  7 0000150007 人口推計  総務省  人口推計 平成3… 男女… -    
#>  8 0000150008 人口推計  総務省  人口推計 平成3… 男女… -    
#>  9 0000150009 人口推計  総務省  人口推計 平成3… 年（… -    
#> 10 0000150010 人口推計  総務省  人口推計 平成3… 男女… -    
#> # ℹ 468 more rows
#> # ℹ 15 more variables: SURVEY_DATE <chr>, OPEN_DATE <chr>,
#> #   SMALL_AREA <chr>, COLLECT_AREA <chr>,
#> #   MAIN_CATEGORY <chr>, SUB_CATEGORY <chr>,
#> #   OVERALL_TOTAL_NUMBER <chr>, UPDATED_DATE <chr>,
#> #   TABULATION_CATEGORY <chr>,
#> #   TABULATION_SUB_CATEGORY1 <chr>, DESCRIPTION <chr>, …
```


```r
estat_getStatsList(appId = appId, searchWord = "外国人人口")
#> # A tibble: 38 × 22
#>    `@id`      STAT_NAME GOV_ORG STATISTICS_NAME  TITLE CYCLE
#>    <chr>      <chr>     <chr>   <chr>            <chr> <chr>
#>  1 0000150003 人口推計  総務省  人口推計 平成3…  人口… -    
#>  2 0000150022 人口推計  総務省  人口推計 平成4…  人口… -    
#>  3 0000150041 人口推計  総務省  人口推計 平成5…  人口… -    
#>  4 0000150062 人口推計  総務省  人口推計 平成6…  人口… -    
#>  5 0000150083 人口推計  総務省  人口推計 平成8…  人口… -    
#>  6 0000150115 人口推計  総務省  人口推計 平成9…  [参…  -    
#>  7 0000150137 人口推計  総務省  人口推計 平成10… [参…  -    
#>  8 0000150159 人口推計  総務省  人口推計 平成11… [参…  -    
#>  9 0000150181 人口推計  総務省  人口推計 平成13… [参…  -    
#> 10 0000150203 人口推計  総務省  人口推計 平成14… [参…  -    
#> # ℹ 28 more rows
#> # ℹ 16 more variables: SURVEY_DATE <chr>, OPEN_DATE <chr>,
#> #   SMALL_AREA <chr>, COLLECT_AREA <chr>,
#> #   MAIN_CATEGORY <chr>, SUB_CATEGORY <chr>,
#> #   OVERALL_TOTAL_NUMBER <chr>, UPDATED_DATE <chr>,
#> #   TABULATION_CATEGORY <chr>,
#> #   TABULATION_SUB_CATEGORY1 <chr>, DESCRIPTION <chr>, …
```

statsDataAPI=0003448219
statsDataAPI=0004001640


```r
estat_getStatsList(appId = appId, searchWord = "国勢調査 時系列データ 男女，年齢，配偶関係")
#> # A tibble: 16 × 19
#>    `@id`      STAT_NAME GOV_ORG STATISTICS_NAME  TITLE CYCLE
#>    <chr>      <chr>     <chr>   <chr>            <chr> <chr>
#>  1 0003410379 国勢調査  総務省  時系列データ 男… 男女… -    
#>  2 0003410380 国勢調査  総務省  時系列データ 男… 年齢… -    
#>  3 0003410381 国勢調査  総務省  時系列データ 男… 年齢… -    
#>  4 0003410382 国勢調査  総務省  時系列データ 男… 配偶… -    
#>  5 0003410383 国勢調査  総務省  時系列データ 男… 年齢… -    
#>  6 0003412413 国勢調査  総務省  時系列データ 男… 年齢… -    
#>  7 0003412414 国勢調査  総務省  時系列データ 男… 年齢… -    
#>  8 0003412415 国勢調査  総務省  時系列データ 男… 年齢… -    
#>  9 0003412416 国勢調査  総務省  時系列データ 男… 年齢… -    
#> 10 0003412417 国勢調査  総務省  時系列データ 男… 年齢… -    
#> 11 0003412418 国勢調査  総務省  時系列データ 男… 年齢… -    
#> 12 0003412419 国勢調査  総務省  時系列データ 男… 年齢… -    
#> 13 0003412420 国勢調査  総務省  時系列データ 男… 年齢… -    
#> 14 0003448300 国勢調査  総務省  時系列データ 男… 【不… -    
#> 15 0003448299 国勢調査  総務省  時系列データ 男… 年齢… -    
#> 16 0003448301 国勢調査  総務省  時系列データ 男… 【不… -    
#> # ℹ 13 more variables: SURVEY_DATE <chr>, OPEN_DATE <chr>,
#> #   SMALL_AREA <chr>, COLLECT_AREA <chr>,
#> #   MAIN_CATEGORY <chr>, SUB_CATEGORY <chr>,
#> #   OVERALL_TOTAL_NUMBER <chr>, UPDATED_DATE <chr>,
#> #   TABULATION_CATEGORY <chr>,
#> #   TABULATION_SUB_CATEGORY1 <chr>, DESCRIPTION <chr>,
#> #   TABLE_NAME <chr>, TABLE_EXPLANATION <chr>
```

statsDataID=0003410379

### メタ情報取得（estat_getMetaInfo()）

統計データのメタ情報を取得します。この関数は、結果をlistとして返します。listの各要素が、それぞれのデータ項目についてのメタ情報を含んだtbl_dfになっています。

```
meta_info <- estat_getMetaInfo(appId = appId, statsDataId = "")
```


```r
meta_info <- estat_getMetaInfo(appId = appId, statsDataId = "0003410379")
glimpse(meta_info)
#> List of 5
#>  $ tab   : tibble [2 × 4] (S3: tbl_df/tbl/data.frame)
#>   ..$ @code : chr [1:2] "020" "1120"
#>   ..$ @name : chr [1:2] "人口" "人口性比"
#>   ..$ @level: chr [1:2] "" ""
#>   ..$ @unit : chr [1:2] "人" NA
#>  $ cat01 : tibble [3 × 3] (S3: tbl_df/tbl/data.frame)
#>   ..$ @code : chr [1:3] "100" "110" "120"
#>   ..$ @name : chr [1:3] "総数" "男" "女"
#>   ..$ @level: chr [1:3] "1" "1" "1"
#>  $ area  : tibble [50 × 4] (S3: tbl_df/tbl/data.frame)
#>   ..$ @code      : chr [1:50] "00000" "00100" "00200" "01000" ...
#>   ..$ @name      : chr [1:50] "全国" "人口集中地区" "人口集中地区以外の地区" "北海道" ...
#>   ..$ @level     : chr [1:50] "1" "2" "2" "2" ...
#>   ..$ @parentCode: chr [1:50] NA "00000" "00000" "00000" ...
#>  $ time  : tibble [21 × 3] (S3: tbl_df/tbl/data.frame)
#>   ..$ @code : chr [1:21] "1920000000" "1925000000" "1930000000" "1935000000" ...
#>   ..$ @name : chr [1:21] "1920年" "1925年" "1930年" "1935年" ...
#>   ..$ @level: chr [1:21] "1" "1" "1" "1" ...
#>  $ .names: tibble [4 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id  : chr [1:4] "tab" "cat01" "area" "time"
#>   ..$ name: chr [1:4] "表章項目" "男女_時系列" "地域_時系列" "時間軸（調査年）"
```


```r
meta_info$cat01
#> # A tibble: 3 × 3
#>   `@code` `@name` `@level`
#>   <chr>   <chr>   <chr>   
#> 1 100     総数    1       
#> 2 110     男      1       
#> 3 120     女      1
```

### 統計データ取得（estat_getStatsData()）

統計データを取得します。この関数は、結果をメタ情報と紐づけてtbl_dfとして返します。

必ず指定しなくてはいけないのはappIdとstatsDataIdだけですが、それだけだとデータがかなり大きくなって取得に時間がかかります。cdCat01（分類事項01）などを指定して必要な項目だけに絞ることをおすすめします。他に絞り込みに指定できるパラメータについては公式ドキュメントを参照してください。

```
estat_getStatsData(
  appId = appId,
  statsDataId = "",
  cdCat01 = c("",""))
```


```r
estat_pop <- estat_getStatsData(appId = appId, statsDataId = "0003410379")
#> Fetching record 1-4200... (total: 4200 records)
```


```r
estat_pop
#> # A tibble: 4,200 × 11
#>    tab_code 表章項目 cat01_code 男女_時系列 area_code
#>    <chr>    <chr>    <chr>      <chr>       <chr>    
#>  1 020      人口     100        総数        00000    
#>  2 020      人口     100        総数        00000    
#>  3 020      人口     100        総数        00000    
#>  4 020      人口     100        総数        00000    
#>  5 020      人口     100        総数        00000    
#>  6 020      人口     100        総数        00000    
#>  7 020      人口     100        総数        00000    
#>  8 020      人口     100        総数        00000    
#>  9 020      人口     100        総数        00000    
#> 10 020      人口     100        総数        00000    
#> # ℹ 4,190 more rows
#> # ℹ 6 more variables: 地域_時系列 <chr>, time_code <chr>,
#> #   `時間軸（調査年）` <chr>, unit <chr>, value <dbl>,
#> #   annotation <chr>
```


```r
estat_pop_alien <- estat_getStatsData(appId = appId, statsDataId = "0003448219")
#> Fetching record 1-87... (total: 87 records)
estat_pop_alien
#> # A tibble: 87 × 15
#>    tab_code 表章項目 cat01_code 人口及び人口増減 cat02_code
#>    <chr>    <chr>    <chr>      <chr>            <chr>     
#>  1 008      人口     204        人口             000       
#>  2 008      人口     204        人口             000       
#>  3 008      人口     204        人口             000       
#>  4 008      人口     204        人口             000       
#>  5 008      人口     204        人口             000       
#>  6 008      人口     204        人口             000       
#>  7 008      人口     204        人口             001       
#>  8 008      人口     204        人口             001       
#>  9 008      人口     204        人口             001       
#> 10 008      人口     204        人口             001       
#> # ℹ 77 more rows
#> # ℹ 10 more variables: 男女別 <chr>, cat03_code <chr>,
#> #   人口 <chr>, area_code <chr>, 全国 <chr>,
#> #   time_code <chr>, `時間軸（年間）` <chr>, unit <chr>,
#> #   value <dbl>, annotation <chr>
```


```r
estat_pop_alien2 <- estat_getStatsData(appId = appId, statsDataId = "0004001640")
#> Fetching record 1-87... (total: 87 records)
estat_pop_alien2
#> # A tibble: 87 × 15
#>    tab_code 表章項目 cat01_code 人口及び人口増減 cat02_code
#>    <chr>    <chr>    <chr>      <chr>            <chr>     
#>  1 008      人口     204        人口             000       
#>  2 008      人口     204        人口             000       
#>  3 008      人口     204        人口             000       
#>  4 008      人口     204        人口             000       
#>  5 008      人口     204        人口             000       
#>  6 008      人口     204        人口             000       
#>  7 008      人口     204        人口             001       
#>  8 008      人口     204        人口             001       
#>  9 008      人口     204        人口             001       
#> 10 008      人口     204        人口             001       
#> # ℹ 77 more rows
#> # ℹ 10 more variables: 男女別 <chr>, cat03_code <chr>,
#> #   人口 <chr>, area_code <chr>, 全国 <chr>,
#> #   time_code <chr>, `時間軸（年間）` <chr>, unit <chr>,
#> #   value <dbl>, annotation <chr>
```
0003445244


```r
estat_pop_alien0 <- estat_getStatsData(appId = appId, lang = "E", statsDataId = "0003445244")
#> Fetching record 1-100000... (total: 100215 records)
#> Fetching record 100001-100215... (total: 100215 records)
estat_pop_alien0
#> # A tibble: 100,215 × 13
#>    tab_code tab_name cat01_code Sex   cat02_code Nationality
#>    <chr>    <chr>    <chr>      <chr> <chr>      <chr>      
#>  1 2020_01  Populat… 0          Total 0          Total      
#>  2 2020_01  Populat… 0          Total 0          Total      
#>  3 2020_01  Populat… 0          Total 0          Total      
#>  4 2020_01  Populat… 0          Total 0          Total      
#>  5 2020_01  Populat… 0          Total 0          Total      
#>  6 2020_01  Populat… 0          Total 0          Total      
#>  7 2020_01  Populat… 0          Total 0          Total      
#>  8 2020_01  Populat… 0          Total 0          Total      
#>  9 2020_01  Populat… 0          Total 0          Total      
#> 10 2020_01  Populat… 0          Total 0          Total      
#> # ℹ 100,205 more rows
#> # ℹ 7 more variables: area_code <chr>,
#> #   `Japan, Prefectures, Municipalities` <chr>,
#> #   time_code <chr>, Time <chr>, unit <chr>, value <dbl>,
#> #   annotation <chr>
```
 

```r
estat_pop_alien0 |> distinct(Nationality) |> pull()
#>  [1] "Total"                                               
#>  [2] "Foreigner"                                           
#>  [3] "Republic of Korea"                                   
#>  [4] "People's Republic of China"                          
#>  [5] "Republic of the Philippines"                         
#>  [6] "Kingdom of Thailand"                                 
#>  [7] "Republic of Indonesia"                               
#>  [8] "Socialist Republic of Viet Nam"                      
#>  [9] "India"                                               
#> [10] "Federal Democratic Republic of Nepal"                
#> [11] "United Kingdom of Great Britain and Northern Ireland"
#> [12] "United States of America"                            
#> [13] "Federative Republic of Brazil"                       
#> [14] "Republic of Peru"                                    
#> [15] "Others"                                              
#> [16] "Japanese"                                            
#> [17] "Nationality not reported"
```


```r
estat_pop_alien2020 <- estat_getStatsData(appId = appId, statsDataId = "0003445244")
#> Fetching record 1-100000... (total: 100215 records)
#> Fetching record 100001-100215... (total: 100215 records)
estat_pop_alien2020
#> # A tibble: 100,215 × 13
#>    tab_code 表章事項 cat01_code 男女  cat02_code 国籍 
#>    <chr>    <chr>    <chr>      <chr> <chr>      <chr>
#>  1 2020_01  人口     0          総数  0          総数 
#>  2 2020_01  人口     0          総数  0          総数 
#>  3 2020_01  人口     0          総数  0          総数 
#>  4 2020_01  人口     0          総数  0          総数 
#>  5 2020_01  人口     0          総数  0          総数 
#>  6 2020_01  人口     0          総数  0          総数 
#>  7 2020_01  人口     0          総数  0          総数 
#>  8 2020_01  人口     0          総数  0          総数 
#>  9 2020_01  人口     0          総数  0          総数 
#> 10 2020_01  人口     0          総数  0          総数 
#> # ℹ 100,205 more rows
#> # ℹ 7 more variables: area_code <chr>,
#> #   `全国，都道府県，市区町村` <chr>, time_code <chr>,
#> #   `時間軸（年次）` <chr>, unit <chr>, value <dbl>,
#> #   annotation <chr>
```


```r
estat_pop_alien2020 |> distinct(国籍) |> pull()
#>  [1] "総数"                      
#>  [2] "外国人"                    
#>  [3] "韓国，朝鮮"                
#>  [4] "中国"                      
#>  [5] "フィリピン"                
#>  [6] "タイ"                      
#>  [7] "インドネシア"              
#>  [8] "ベトナム"                  
#>  [9] "インド"                    
#> [10] "ネパール"                  
#> [11] "イギリス"                  
#> [12] "アメリカ"                  
#> [13] "ブラジル"                  
#> [14] "ペルー"                    
#> [15] "その他"                    
#> [16] "日本人"                    
#> [17] "日本人・外国人の別「不詳」"
```

```r
estat_pop_alien2020 |> distinct(男女) |> pull()
#> [1] "総数" "男"   "女"
```


```r
colnames(estat_pop_alien2020)
#>  [1] "tab_code"                 "表章事項"                
#>  [3] "cat01_code"               "男女"                    
#>  [5] "cat02_code"               "国籍"                    
#>  [7] "area_code"                "全国，都道府県，市区町村"
#>  [9] "time_code"                "時間軸（年次）"          
#> [11] "unit"                     "value"                   
#> [13] "annotation"
```

```r
estat_pop_alien2020 |> 
  filter(`全国，都道府県，市区町村` == "全国") |>
  filter(男女 == "総数") |>
  filter(国籍 != "総数") |>
  select(国籍, value) |>
  arrange(desc(value))
#> # A tibble: 16 × 2
#>    国籍                           value
#>    <chr>                          <dbl>
#>  1 日本人                     121541155
#>  2 外国人                       2402460
#>  3 日本人・外国人の別「不詳」   2202484
#>  4 中国                          667475
#>  5 韓国，朝鮮                    374593
#>  6 その他                        339634
#>  7 ベトナム                      320805
#>  8 フィリピン                    230351
#>  9 ブラジル                      180014
#> 10 ネパール                       67325
#> 11 インドネシア                   49147
#> 12 アメリカ                       47875
#> 13 タイ                           42702
#> 14 ペルー                         41034
#> 15 インド                         27915
#> 16 イギリス                       13590
```


```r
estat_pop_alien2020 |> 
  filter(`全国，都道府県，市区町村` == "全国") |>
  filter(男女 != "総数") |>
  filter(!(国籍 %in% c("総数", "日本人", "外国人", "日本人・外国人の別「不詳」"))) |>
  select(国籍, 男女, value) |>
  arrange(desc(value)) |> 
  mutate(国籍別 = factor(fct_inorder(国籍))) |>
  mutate(`人数（千人）`= value/1000) |>
  ggplot(aes(国籍別, `人数（千人）`, fill = 男女)) + geom_col() +
  labs(title = "国籍別日本在住外国人数", caption = "令和2（2020）年 国勢調査 統計表表示ID=0003445244")
```

![](37-estat_files/figure-epub3/unnamed-chunk-19-1.png)<!-- -->

