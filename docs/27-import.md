# データ読み込み（Import） {#import}

## はじめに

データの読み込みは、データサイエンスの最初のステップです。しかし、データを読み込む時に、その後の、データの整形・変形、さらには、視覚化について、ある程度の理解をしているかどうかで、変わってきますので、順番を、Tidyverse での、dplyr をつかった変形と、ggplot2 を使った視覚化のあとにしました。

個々のデータの読み込みは、それぞれのサイトに特徴的なこともありますし、R のパッケージ（API: Application Programing Interface を用いたプログラム群）を用いて読み込む場合などによって、異なりますので、それは、第三部で扱いたいと思います。

## 概略

まずは、基本を確認しましょう。

すでに、WDI パッケージを用いて、データを読み込みましが。同様に、他にも、それぞれのサイトが、コンピュータで直接データを取得できるようにするために、提供している、API（Application Programing Interface）を用いたパッケージが存在します。十分な質のものが提供されている場合は、それを使うのが適切だと思います。

そのような パッケージが提供されていない場合には、データファイルを取得して読み込むことになります。この場合にも、データファイルの URL（universal resource locator）から直接取り込むことができる場合と、一旦、自分のコンピュータにダウンロードして、それから、読み込む場合とがあります。

再現性（reproducibility）を考えると、URL から、直接読み込む方がよいと思いますが、そうはいかない場合、また、自分で作成した、データファイルもあるでしょうから、その場合は、コンピュータから読み込むことになります。

データの形式はさまざまでが、オープンデータでは、CSV（comma separated values) 形式のテキストデータ[^27-import-1]か、MicroSoft の Excel 形式のデジタルデータのどちらかを提供している場合がほとんどです。ですから、どちらの形式のファイルなのかを確認することが必要です。

[^27-import-1]: Separator 分離記号として、comma（カンマ）以外（space （スペース）、tab（タブ）,

    bar（縦棒）など）を用いる場合もありますが、それらは、ほとんど問題なく、CSV の場合と同様に読み込めます。これらについては、簡単に言及します。


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
library(readxl)
library(WDI)
library(owidR)
library(wid)
```

上で説明した三つの方法を簡単にまとめておきます。

### テキストファイル（CSV など）の読み込み

-   `readr` パッケージで読み込みます。`tidyverse` パッケージ群に含まれる基本パッケージなので、`library(tidyverse)` としてあれば使えます。データ間の分離記号の種類によって使う関数が異なります。

    -   [`read_csv()`](https://readr.tidyverse.org/reference/read_delim.html): comma-separated values (CSV) - カンマの場合

    -   [`read_tsv()`](https://readr.tidyverse.org/reference/read_delim.html): tab-separated values (TSV) - タブの場合

    -   [`read_csv2()`](https://readr.tidyverse.org/reference/read_delim.html): semicolon-separated values with `,` as the decimal mark - セミコロン; の場合で、少数点に カンマが使われている場合（ヨーロッパでよく使われています）

    -   [`read_delim()`](https://readr.tidyverse.org/reference/read_delim.html): delimited files (CSV and TSV are important special cases) - 分離記号を指定する場合

    -   [`read_fwf()`](https://readr.tidyverse.org/reference/read_fwf.html): fixed-width files - 固定幅でデータが並んでいる場合

    -   [`read_table()`](https://readr.tidyverse.org/reference/read_table.html): whitespace-separated files - 空白が分離記号に使われている場合

    -   [`read_log()`](https://readr.tidyverse.org/reference/read_log.html): web log files - ログファイルを読み込む場合

    -   例：`df_name <- read_csv("./data/datafile.csv")`

-   詳細は、[readr サイト](https://readr.tidyverse.org) を参照してください。サイトには、Data Importing CheatSheet もあります。

### Excel ファイルの読み込み

-   readxl パッケージで読み込みます。`tidyverse` パッケージ群に含まれていますから、新たに、インストールする必要はありませんが、基本パッケージではないので、`library(readxl)` としてから使います。

    -   例：`df_name <- read_excel("./data/datafile.xlsx")`

    -   Excel ファイルには、xls 形式と、xlsx 形式があります。どちらも、read_excel で読み込むことが可能ですが、それぞれの形式に特化した `read_xls` と `read_xlsx` も用意されています。

    -   Excel ファイルには、複数のシートが含まれる場合があります。そのときには、シートを、何番目のシートか（例：`sheet = 2`）、または、シート名を指定（例：sheet = "name"）して読み込みます。

    -   シートの一部を読み込むような場合もあり、その場合は、指定が必要です。Help や、リンク、または、後から示す例を参照してください。

-   詳細は、[readxl サイト](https://readxl.tidyverse.org) を参照してください。サイトには、Data Importing CheatSheet もあります。

### データのダウンロード

-   データの URL がわかっている場合は、直接、データを取り込んだり、data ディレクトリ（フォルダー）にダウンロードすることができます。ダウンロードしたら、テキストファイルか、Excel ファイルかによって、上で説明した方法を使って読み込んでください。

-   圧縮ファイルになっている場合もあります。圧縮ファイルも R 起動時に読み込まれる util パッケージで解凍できますが、基本的に、コンピュータのプログラムを使いますから、ファイルをダブルクリックするなどして、解凍する場合と同じです。

-   CSV のようなテキストふぁいると、Excel ファイルのようなデジタルファイルで少しだけ異なります。下に例を書きます。いずれも、data ディレクトリ（フォルダー）に保存しています。詳しくは、`download.file` の Help を参照してください。

    -   テキストファイル（CSV）：`download.file(url = "URL", destfile = "./data/file_name.csv")`

    -   デジタルファイル（Excel）：`download.file(url = "URL", destfile = "./data/file_name.xlsx", mode = "wb")`

        -   `mode = "wb"` デジタルファイルの指定です。Mac の場合には、リソースファイルと呼ばれる不可視ファイルを使っているので、この設定がなくても、読み込めるようです。

-   URL がわかっている、CSV ファイルの場合には、直接、readr でも読み込むことができます。

    -   例：`df_name <- read_csv(URL)`

-   URL がわかっていて、read_csv などで読み込んだ場合も、保存しておくことをお勧めします。

    -   保存：`write_csv(df_name, "./data/df_name.csv")`

    -   読み込み：`df_name <- read_csv("./data/df_name.csv")`

### パッケージの利用

-   `WDI`, `wir`, `eurostat`, `estatapi` など
    -   例：`wdi_shortname <- WDI(indicator = "indicator's name")`
-   毎回、読み込むのは時間もかかりますし、サイト負荷も増えますから、data ディレクトリ（フォルダ）に書き込み、そこから、読み込むのが適切です。
    -   保存：`write_csv(wdi_shortname, "./data/wdi_shortname.csv")`
    -   読み込み：`wdi_shortname <- read_csv("./data/wdi_shortname.csv")`

## データの整形 tidyr

> R にとって大切な整形されたデータ（tidy data）について学び、Tidyverse パッケージ群の主要なパッケージの一つ `tidyr` について学びます。特に、`pivot_longer` とその逆変換である、 `pivot_wider` の使い方について学びます。

### 変数、値、観測

データには、変数があり、それぞれの観測における、その変数に関する観測値がありあす。それを、表に記したものが、データ表（Data Table）です。

-   変数（variable）は、量的または質的な値を、測定することが可能なもの
-   値（観測値 value）は、観測し計測した時の測定値
-   観測または場合（observation, case) ある一定のとき、ある一定の条件のもとで、それぞれの変数について行う測定
-   データ表（Tabular data）は、観測に基づく、それぞれの変数の値を表にしたもの

### 整形済みデータ（tidy data）

> 整形済みの（データ）表とは、それぞれの値が表の一つの枠（ある行ある列）に割り当てられ、変数が列に、それぞれの観測が行に割り当てられたもの

今までは、整形済みのデータを多くみてきましたが、データ表は、必ずしも、整形済みではなく、整形済みのデータが良いデータ表というわけではありません。しかし、**R で分析をするときには**、整形済みのデータ表の概念を理解し、整形済みのデータに dplyr などを使って 変形にしておくことが重要なステップになります。

まとめると、整形済みデータ（表）とは：

1.  各変数が一つの列に対応（Each variable is in its own column）
2.  各観測・場合が一つの行に対応（Each observation is in its own row）
3.  ある変数のある観測における値が枠（セル）に書き込まれてる（1,2 から自動的に従うことです） （Each value is in its own cell (this follows from #1 and #2)）

<img src="./data/tidy-1.png" width="100%" />

Tidyverse の中心的な開発者である H. ウィッカム（Hadley Wickham）は次のように言っています。

> "Tidy data sets are all alike; but every messy data set is messy in its own way." --- Hadley Wickham
>
> 訳：整形済みのデータは似たり寄ったりだが、整形されていないデータの乱雑さはそれぞれである。（H. ウィッカム）

> "all happy families are all alike; each unhappy family is unhappy in its own way" - Tolstoy's Anna Karenina
>
> 幸せな家族はみな似たり寄ったりだが、不幸な家族は、それぞれに不幸だ。（トルストイ「アンナ・カレーニナ」より）

トルストイの小説「アンナ・カレーニナ」の冒頭の言葉から変形したものですが、実際の世の中を表現するものとして、さまざまな分野で引用されます。データサイエンスでは、アンナ・カレーニナの法則（Anna Karenina Principle (AKP) ）とも呼ばれています。

ある指標に関して、平均値や中央値付近のケースは、似たり寄ったりの状況が多いが、外れ値を取るようなケースは、一つの理由ではなく、さまざまな原因で外れ値となっており、それぞれの原因を考察することは、背景を理解する上で重要だという意味にとれると、わたしは理解しています。

### 整形済みデータと整形済みでないデータ

`tidyr` パッケージには、例がデータとして含まれていますので、table1, table2, table3, table4a, table4b, table5 をまずはみてみましょう。




```r
table1
#> # A tibble: 6 × 4
#>   country      year  cases population
#>   <chr>       <dbl>  <dbl>      <dbl>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583
```


```r
table2
#> # A tibble: 12 × 4
#>    country      year type            count
#>    <chr>       <dbl> <chr>           <dbl>
#>  1 Afghanistan  1999 cases             745
#>  2 Afghanistan  1999 population   19987071
#>  3 Afghanistan  2000 cases            2666
#>  4 Afghanistan  2000 population   20595360
#>  5 Brazil       1999 cases           37737
#>  6 Brazil       1999 population  172006362
#>  7 Brazil       2000 cases           80488
#>  8 Brazil       2000 population  174504898
#>  9 China        1999 cases          212258
#> 10 China        1999 population 1272915272
#> 11 China        2000 cases          213766
#> 12 China        2000 population 1280428583
```


```r
table3
#> # A tibble: 6 × 3
#>   country      year rate             
#>   <chr>       <dbl> <chr>            
#> 1 Afghanistan  1999 745/19987071     
#> 2 Afghanistan  2000 2666/20595360    
#> 3 Brazil       1999 37737/172006362  
#> 4 Brazil       2000 80488/174504898  
#> 5 China        1999 212258/1272915272
#> 6 China        2000 213766/1280428583
```


```r
table4a
#> # A tibble: 3 × 3
#>   country     `1999` `2000`
#>   <chr>        <dbl>  <dbl>
#> 1 Afghanistan    745   2666
#> 2 Brazil       37737  80488
#> 3 China       212258 213766
```


```r
table4b
#> # A tibble: 3 × 3
#>   country         `1999`     `2000`
#>   <chr>            <dbl>      <dbl>
#> 1 Afghanistan   19987071   20595360
#> 2 Brazil       172006362  174504898
#> 3 China       1272915272 1280428583
```


```r
table5
#> # A tibble: 6 × 4
#>   country     century year  rate             
#>   <chr>       <chr>   <chr> <chr>            
#> 1 Afghanistan 19      99    745/19987071     
#> 2 Afghanistan 20      00    2666/20595360    
#> 3 Brazil      19      99    37737/172006362  
#> 4 Brazil      20      00    80488/174504898  
#> 5 China       19      99    212258/1272915272
#> 6 China       20      00    213766/1280428583
```

どうでしょうか。どれが、整形済みか、どれが整形済みでないかわかりましたか。何を持って、整形済みではないとしているのでしょうか。

ここでは、table1 は整形済み、それ以外は、整形済みでないとして、table1 のように変形するにはどうしたら良いかを考えていきます。

簡単に理由を書いておきます。

-   table2: count とありますが、人口（population）と場合（case）を一つの物差しでは計れません。

-   table3: 割合（率）が書かれていますが、同時に、この表記で、人口と、場合を同時に表そうとしています。それぞれの観測において、一つの物差しでの計測値ではありません。

-   table4a, table4b: どちらも、年毎に別の列になっています。観測値として、同時に計測できるわけではありません。また、これらを、統合する必要もあるでしょう。

-   table5: 年が二つに分かれています。このように分けることが便利なこともあるでしょうが、まとまっていた方が自然です。

### `tidyr` による整形の基礎 [Pivoting](https://tidyr.tidyverse.org/articles/pivot.html)

長型データ（long data）と、幅広型データ（wide data）の変換です。pivoting はある箇所を支点として、回転または折り返すという意味です。Excel にも同様の機能があります。以前は、pivot_longer() は、gather()、pivot_wider() は、spread() という関数が使われていましたから、少し前の文献には、そちらが使われているかもしれません。Posit Primers でもまだ、古いものが使われているようです。

設定値（arguments）やその初期値（default）については、Help をみてください。下には、もっとも簡単なもののみを書きます。

-   `pivot_longer()`:[Pivot data from wide to long](https://tidyr.tidyverse.org/reference/pivot_longer.html)

```         
pivot_longer(data = <data>, cols = <column>, 
    names_to = <new column>, values_to = <value column>)
```

```         
pivot_longer(data = table4a, cols = c(1999,2000), 
    names_to = "year", values_to = "population" )
```

-   `pivot_wider()`:[Pivot data from long to wide](https://tidyr.tidyverse.org/reference/pivot_wider.html),

```         
pivot_wider(data = <data>, names_from = <specified column>, 
    values_from = <value column>)
```

```         
pivot_wider(data = table2, names_from = type, 
    values_from = count)
```

#### 例 1: `pivot_longer`

年（cols = c("1999","2000")）を year （names_to = "year"）という列にまとめ、それぞれの値を、values_to = "cases" にします。同時に、年が、連続変数の　dbl ですから、それを離散変数（飛び飛びの値をとる）int（整数に変形します）


```r
table4a
#> # A tibble: 3 × 3
#>   country     `1999` `2000`
#>   <chr>        <dbl>  <dbl>
#> 1 Afghanistan    745   2666
#> 2 Brazil       37737  80488
#> 3 China       212258 213766
```

```         
pivot_longer(data = table4a, cols = c("1999","2000"), 
             names_to = "year", values_to = "cases",
             names_transform = list("year" = as.integer))
```


```r
pivot_longer(data = table4a, cols = c("1999","2000"), 
             names_to = "year", values_to = "cases", 
             names_transform = list("year" = as.integer))
#> # A tibble: 6 × 3
#>   country      year  cases
#>   <chr>       <int>  <dbl>
#> 1 Afghanistan  1999    745
#> 2 Afghanistan  2000   2666
#> 3 Brazil       1999  37737
#> 4 Brazil       2000  80488
#> 5 China        1999 212258
#> 6 China        2000 213766
```

#### 例 2: `pivot_wider`

type （names_from = type）を二種類の変数に分け、値を cases （values_from = count） からとります。


```r
table2
#> # A tibble: 12 × 4
#>    country      year type            count
#>    <chr>       <dbl> <chr>           <dbl>
#>  1 Afghanistan  1999 cases             745
#>  2 Afghanistan  1999 population   19987071
#>  3 Afghanistan  2000 cases            2666
#>  4 Afghanistan  2000 population   20595360
#>  5 Brazil       1999 cases           37737
#>  6 Brazil       1999 population  172006362
#>  7 Brazil       2000 cases           80488
#>  8 Brazil       2000 population  174504898
#>  9 China        1999 cases          212258
#> 10 China        1999 population 1272915272
#> 11 China        2000 cases          213766
#> 12 China        2000 population 1280428583
```

```         
pivot_wider(data = table2, names_from = type, 
            values_from = count)
```


```r
pivot_wider(data = table2, names_from = type, 
            values_from = count)
#> # A tibble: 6 × 4
#>   country      year  cases population
#>   <chr>       <dbl>  <dbl>      <dbl>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583
```

#### 例 3: `separate`

分け方はいろいろとありますが、ここでは、"/" で分けることにします。正規表現を使うことでかなり複雑な分離方法も可能です。[参照](https://tidyr.tidyverse.org/reference/separate.html)


```r
table3
#> # A tibble: 6 × 3
#>   country      year rate             
#>   <chr>       <dbl> <chr>            
#> 1 Afghanistan  1999 745/19987071     
#> 2 Afghanistan  2000 2666/20595360    
#> 3 Brazil       1999 37737/172006362  
#> 4 Brazil       2000 80488/174504898  
#> 5 China        1999 212258/1272915272
#> 6 China        2000 213766/1280428583
```

```         
separate(table3, rate, c("cases", "population"), 
         sep = "/", convert = TRUE)
```


```r
separate(table3, rate, c("cases", "population"), 
         sep = "/", convert = TRUE)
#> # A tibble: 6 × 4
#>   country      year  cases population
#>   <chr>       <dbl>  <int>      <int>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583
```

#### 例 4: `unite`

結合します。[参照](https://tidyr.tidyverse.org/reference/unite.html)


```r
table5
#> # A tibble: 6 × 4
#>   country     century year  rate             
#>   <chr>       <chr>   <chr> <chr>            
#> 1 Afghanistan 19      99    745/19987071     
#> 2 Afghanistan 20      00    2666/20595360    
#> 3 Brazil      19      99    37737/172006362  
#> 4 Brazil      20      00    80488/174504898  
#> 5 China       19      99    212258/1272915272
#> 6 China       20      00    213766/1280428583
```

```         
table5 %>% unite(col = "year", century, year, sep = "") %>%
  separate(rate, c("cases", "population"), sep = "/", 
           convert = TRUE) %>%
  mutate(year = as.integer(year), rate = cases / population)
```


```r
table5 %>% unite(col = "year", century, year, sep = "") %>%
  separate(rate, c("cases", "population"), sep = "/", 
           convert = TRUE) %>%
  mutate(year = as.integer(year), rate = cases / population)
#> # A tibble: 6 × 5
#>   country      year  cases population      rate
#>   <chr>       <int>  <int>      <int>     <dbl>
#> 1 Afghanistan  1999    745   19987071 0.0000373
#> 2 Afghanistan  2000   2666   20595360 0.000129 
#> 3 Brazil       1999  37737  172006362 0.000219 
#> 4 Brazil       2000  80488  174504898 0.000461 
#> 5 China        1999 212258 1272915272 0.000167 
#> 6 China        2000 213766 1280428583 0.000167
```

#### 例 5: [`bind_rows`](https://dplyr.tidyverse.org/reference/bind.html)

二つの表を結合します。行や列の結合：[参照](https://dplyr.tidyverse.org/reference/bind.html)


```r
table4a; table4b
#> # A tibble: 3 × 3
#>   country     `1999` `2000`
#>   <chr>        <dbl>  <dbl>
#> 1 Afghanistan    745   2666
#> 2 Brazil       37737  80488
#> 3 China       212258 213766
#> # A tibble: 3 × 3
#>   country         `1999`     `2000`
#>   <chr>            <dbl>      <dbl>
#> 1 Afghanistan   19987071   20595360
#> 2 Brazil       172006362  174504898
#> 3 China       1272915272 1280428583
```


```r
tables <- list(cases = table4a, population = table4b)
tables %>% bind_rows(.id = "type")
#> # A tibble: 6 × 4
#>   type       country         `1999`     `2000`
#>   <chr>      <chr>            <dbl>      <dbl>
#> 1 cases      Afghanistan        745       2666
#> 2 cases      Brazil           37737      80488
#> 3 cases      China           212258     213766
#> 4 population Afghanistan   19987071   20595360
#> 5 population Brazil       172006362  174504898
#> 6 population China       1272915272 1280428583
```


```r
tables <- list(cases = table4a, population = table4b)
tables %>% bind_rows(.id = "type") %>%
  pivot_longer(cols = c("1999", "2000"), names_to = "year") %>%
  pivot_wider(names_from = "type", values_from = "value") %>%
  mutate(year = as.integer(year)) %>% arrange(country)
#> # A tibble: 6 × 4
#>   country      year  cases population
#>   <chr>       <int>  <dbl>      <dbl>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583
```

## 参照： `tidyr`

-   Textbook: [R for Data Science,Tidy Data](https://r4ds.had.co.nz/tidy-data.html#tidy-data)
-   Reference: <https://tidyr.tidyverse.org>

### RStudio Primers: See References in Moodle at the bottom

4.  Tidy Your Data -- [r4ds: Wrangle, II](https://r4ds.had.co.nz/wrangle-intro.html#wrangle-intro)

-   [Reshape Data - a bit old](https://rstudio.cloud/learn/primers/4.1)
-   [Separate and Unite](https://rstudio.cloud/learn/primers/4.2)
-   [Join Data Sets](https://rstudio.cloud/learn/primers/4.3)

The first component, 'Reshape Data' deals with `pivot_longer` and `pivot_wider`. However, it uses an older version of these functions calls `gather` and `spread`.

## 二つの表の結合

最初に紹介した、世界開発指標（WDI）は、同じ規格でデータを提供してくれていますし、WDI パッケージを使えば、いくつもの指標について同時に入手することもできます。そのようなデータベースに、広範囲の 1400以上の分野からの指標が提供され、毎年定められたときに、更新してくれています。その意味でも、初心者にはとても親切なデータベースです。

しかし、一般的に、データサイエンスにおいては、2つの異なる出処（ソース）のデータを一つにまとめて行うことで、世界が広がり、独自の、データサイエンスが始められるとも言えます。

ここでは、そのための基本的な手法を学びます。変形のところで少し書きましたが、Tidyverse パッケージ群の、dplyr パッケージでは、一つのデータ表の変形だけではなく、2つ以上のデータ表も扱えます。基本的には、2つのデータ表を一つにすることができれば、それに3つ目のデータ表を加えていけば良いので、2つの場合を説明ます。

整理されたデータ表（tidy data）について上に書きましたが、それぞれのデータ表は、整理されているものとして話を進めます。すでに、上で、unite の説明をしてありますから、参考にしてください。

この部分は、Two Table Verbs として、dplyr の機能にある部分ですが、ここで紹介します。

-   R for Datascience (2ed) Joins: <https://r4ds.hadley.nz/joins#introduction>
-   Two Table Verbs: <https://dplyr.tidyverse.org/articles/two-table.html>
-   Vignette: <https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html>
-   早見表（p.2）Cheat sheet: <https://github.com/rstudio/cheatsheets/blob/main/data-transformation.pdf>

### 三種類の結合

-   融合結合：適合するものを他から読み込む：Mutating joins, which add new variables to one table from matching rows in another.

-   抽出結合：同一のもの相異なるものを抽出：Filtering joins, which filter observations from one table based on whether or not they match an observation in the other table.

-   集合算結合：データ集合として結合：Set operations, which combine the observations in the data sets as if they were set elements.

### 融合結合（mutating joins）

いずれの場合にも両方の表に共通の key を定め、key を媒介として結合する。たとえば、a 列が共通なら、by = "a", a, b 列が共通に存在する場合は、by = c("a", "b") とし、x の a と、y の c, x の b と y の d が対応する場合は、by = c("a" = "c", "b" = "d') などとする。共通するものが明らかな場合は、省略することも可能。

-   left_join(x,y): x をもとに、y を加える

    -   例：left_join(x,y, by = "a")

    -   b, c 列も共通の場合は、b.1, b,2, c.1, c.2 などとなる。必要なものだけにして結合したほうが安全である。

-   right_join(x,y): y をもとに、x を加える

-   full_join(x,y): x も y も含める

### 抽出結合（Filtering joins）

-   anti_join()
    -   anti_join(x,y, ...): x の行で、y に含まれないもの（return all rows from x without a match in y.）
-   semi_join()
    -   semi_join(x,y, ...): x の行で、y に含まれるもの（return all rows from x with a match in y.）

### 集合算結合（Set joins）

-   `intersect(x, y)`: return only observations in both `x` and `y`
-   `union(x, y)`: return unique observations in `x` and `y`
-   `setdiff(x, y)`: return observations in `x`, but not in `y`.

### 例

以下では、三種類の結合の例を見てみます。Data Transformation with dplyr の早見表の 2ページ目の例も参照してください。


```r
(df_1 <- tibble(A = c('a','b','c'), B = c('t','u','v'), C = c(1,2,3)))
#> # A tibble: 3 × 3
#>   A     B         C
#>   <chr> <chr> <dbl>
#> 1 a     t         1
#> 2 b     u         2
#> 3 c     v         3
```


```r
(df_2 <- tibble(A = c('a','b','c'), F = c('t','u','w'), G = c(3,2,1)))
#> # A tibble: 3 × 3
#>   A     F         G
#>   <chr> <chr> <dbl>
#> 1 a     t         3
#> 2 b     u         2
#> 3 c     w         1
```


```r
(df_3 <- tibble(A = c('a','C','d'), B = c('t','u','w'), C = c(1,3,4)))
#> # A tibble: 3 × 3
#>   A     B         C
#>   <chr> <chr> <dbl>
#> 1 a     t         1
#> 2 C     u         3
#> 3 d     w         4
```

df_1, df_2 では、A 列は共通ですから、何も指定しないと、by = 'A' を仮定して結合します。


```r
left_join(df_1, df_2)
#> Joining with `by = join_by(A)`
#> # A tibble: 3 × 5
#>   A     B         C F         G
#>   <chr> <chr> <dbl> <chr> <dbl>
#> 1 a     t         1 t         3
#> 2 b     u         2 u         2
#> 3 c     v         3 w         1
```


```r
left_join(df_1, df_2, by = "A")
#> # A tibble: 3 × 5
#>   A     B         C F         G
#>   <chr> <chr> <dbl> <chr> <dbl>
#> 1 a     t         1 t         3
#> 2 b     u         2 u         2
#> 3 c     v         3 w         1
```

by = c("A", "B"="F") としましたが、B と F では一致していない箇所があります。そこで、一致していない場所は、左側の表 df_1 はそのまま C 列を読み込みますが、右側の表 df_2 は、その部分を NA にして読み込んでいません。つまり、一致した行のみ読み込んでいます。


```r
left_join(df_1, df_2, by = c("A", "B"="F"))
#> # A tibble: 3 × 4
#>   A     B         C     G
#>   <chr> <chr> <dbl> <dbl>
#> 1 a     t         1     3
#> 2 b     u         2     2
#> 3 c     v         3    NA
```

A 列も一致していますが、それは指定していないので、それは別と考えて、A.x, A.y と列名を別にして、かつ左側の表をもとにして読み込んでいます。


```r
left_join(df_1, df_2, by = c("B"="F"))
#> # A tibble: 3 × 5
#>   A.x   B         C A.y       G
#>   <chr> <chr> <dbl> <chr> <dbl>
#> 1 a     t         1 a         3
#> 2 b     u         2 b         2
#> 3 c     v         3 <NA>     NA
```

roght_join ですから、今度は、右側の表 df_2 をもとにして読み込みます。B 列には、F 列が入っています。


```r
right_join(df_1, df_2, by = c("A", "B"="F"))
#> # A tibble: 3 × 4
#>   A     B         C     G
#>   <chr> <chr> <dbl> <dbl>
#> 1 a     t         1     3
#> 2 b     u         2     2
#> 3 c     w        NA     1
```

左側の表 df_1 と 右側の表 df_2 が一致していない行は、B と F の値によって分けて、読み込んでいます。


```r
full_join(df_1, df_2, by = c("A", "B"="F"))
#> # A tibble: 4 × 4
#>   A     B         C     G
#>   <chr> <chr> <dbl> <dbl>
#> 1 a     t         1     3
#> 2 b     u         2     2
#> 3 c     v         3    NA
#> 4 c     w        NA     1
```

左側の表と一致しないものに入れ替えています。たとえば、a, b, c は、右側の行でも、t, u, v であるべきときに、違っている部分をチェックするようなときにも使えます。


```r
anti_join(df_1, df_2, by = c("A", "B" = "F"))
#> # A tibble: 1 × 3
#>   A     B         C
#>   <chr> <chr> <dbl>
#> 1 c     v         3
```

anti_join とは逆に、一致しているもののみ取り出します。


```r
semi_join(df_1, df_2, by = c("A", "B" = "F"))
#> # A tibble: 2 × 3
#>   A     B         C
#>   <chr> <chr> <dbl>
#> 1 a     t         1
#> 2 b     u         2
```

集合算では、同じ列について、intersect は共通な部分を取り出します。


```r
intersect(df_1, df_3)
#> # A tibble: 1 × 3
#>   A     B         C
#>   <chr> <chr> <dbl>
#> 1 a     t         1
```

union は、和集合ですから、すべてを含むものを作成します。


```r
union(df_1, df_3)
#> # A tibble: 5 × 3
#>   A     B         C
#>   <chr> <chr> <dbl>
#> 1 a     t         1
#> 2 b     u         2
#> 3 c     v         3
#> 4 C     u         3
#> 5 d     w         4
```

setdiff は差集合ですから、df_1 に入っていて、df_3 には入っていないものを取り出します。


```r
setdiff(df_1, df_3)
#> # A tibble: 2 × 3
#>   A     B         C
#>   <chr> <chr> <dbl>
#> 1 b     u         2
#> 2 c     v         3
```
