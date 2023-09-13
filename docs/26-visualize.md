---
---
---

# 視覚化（Visualize） {#visualize}

## 基本的なこと

R では、追加パッケージを使わなくても、簡単に、グラフを描画できますが、質の高いグラフを作成するには、`ggplot2` パッケージを用いたものが標準となっています。`ggplot2` は、`tidyverse` パッケージの一部ですので、`tidyverse` パッケージをインストール、使えるように、`library(tidyverse)` として読み込んであれば、そのまま使うことができます。

サイト：<https://ggplot2.tidyverse.org> パッケージサイト：<https://CRAN.R-project.org/package=ggplot2>

### ggplot2 概要

> ggplot2 is a system for declaratively creating graphics, based on *The Grammar of Graphics*. You provide the data, tell ggplot2 how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.
>
> ggplot2は、グラフィックスの生成に関する「Grammar of Graphics（グラフィックスの文法）」に基づいて、一つ一つの要素を定めていくことによって、グラフを作成するシステムです。データを提供し、変数を視覚的要素にマッピングする方法や、どのようなグラフィカルな基本要素を使用するかをggplot2に伝えると、詳細な部分はggplot2 が処理してくれます。

### 基本的な例

#### `tidyverse` の読み込み

タイトルや、列名などにに日本語を使う場合があるときは、`install.packages('showtext')` で、`showtext` パッケージをインストールして、下のように設定してください。そうでない場合は、最初の行 `library(tidyverse)` だけで他は不要です。


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
showtext_auto()
```

#### 復習

Tidyverse の章で、[紹介した例](https://icu-hsuzuki.github.io/ds4aj/tidyverse.html#ggplot2-グラフの描画)の復習から始めましょう。


```r
df_iris <- datasets::iris
```


```r
df_iris |> ggplot(aes(Sepal.Width, Sepal.Length)) + geom_point()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-3-1.png)<!-- -->

さまざまな描画が可能ですが、一番、一般的な、散布図、`plot` に対応するものです。`ggplot` の中の、`aes` （aesthetic）の部分に、x 軸、y 軸に対応する変数（列名）を書きます。

| `<DATA> |> ggplot(aes(<変数 x の列名>, <変数 y の列名>)) + geom_point()`

もっと明示的に

| `<DATA> |> ggplot(aes(x = <変数 x の列名>, y = <変数 y の列名>)) + geom_point()`

さらには

| `<DATA> |> ggplot(mapping = aes(x = <変数 x の列名>, y = <変数 y の列名>)) + geom_point()`

パイプを使わず

| `ggplot(<DATA>, aes(x = <変数 x の列名>, y = <変数 y の列名>)) + geom_point()`

や、さらに、詳しく

| `ggplot(data = <DATA>, mapping = aes(x = <変数 x の列名>, y = <変数 y の列名>)) + geom_point()`

も可能です。

種類（Species）ごとに色を変える場合には、`color = Species` とします。


```r
df_iris |> ggplot(aes(Sepal.Width, Sepal.Length, color = Species)) +
  geom_point()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-4-1.png)<!-- -->

さらに、点の大きさを、Petal.Width によって変える場合には次のように、`size = Petal.Width` を加えます。


```r
df_iris |> 
  ggplot(aes(Sepal.Width, Sepal.Length, color = Species, 
             size = Petal.Width)) +
  geom_point()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-5-1.png)<!-- -->

ここでは、散布図でしたから、`geom_point()` を使いましたが、これを他のものに変えていくと、さまざまなグラフが描けるようになっています。

## 散布図（Scatter Plot）

散布図は、データの二つの変数（列） を x と y に対応させる、最も基本的なグラフです。最初に試すべきグラフだともいうことができます。`mapping =` は省略することができます。

```         
ggplot(data = <data>, aes(x = <column name for x>, y = <column name for y>)) +
  geom_point()
```

```         
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
```

変形（Transform）のときにつかった、`iris` データを使います。


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-6-1.png)<!-- -->

### ラベル [Labels](https://ggplot2.tidyverse.org/reference/labs.html)

グラフの表題や、x 軸、y 軸のラベルをつけるには `labs()` を使います。

```         
ggplot(data = <data>, aes(x = <column name for x>, y = <column name for y>)) +
  geom_point() +
  labs(title = "Title", x = "Label for x", y = "Label for y")
```


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() + 
  labs(title = "Scatter Plot of Sepal Data of Iris", x = "Sepal Length", y = "Sepal Width")
```

![](26-visualize_files/figure-epub3/unnamed-chunk-7-1.png)<!-- -->


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() + 
  labs(title = "菖蒲の萼の長さと幅についての散布図", x = "萼の長さ", y = "萼の幅")
```

![](26-visualize_files/figure-epub3/unnamed-chunk-8-1.png)<!-- -->

このように、日本語をタイトルや、ラベルに使うことも可能ですが、以後は、データに日本語が含まれていない場合には、そのまま表示します。

### 色付き [Colors](https://ggplot2.tidyverse.org/reference/aes_colour_fill_alpha.html)

菖蒲（iris）のデータは、Species 列に、三種類の菖蒲の名前が含まれていました。それぞれに、違う色で表示してみましょう。それには、x 軸、y 軸に対応する変数を指定したように、`color = Species` と指定します。


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-9-1.png)<!-- -->

### 形状 [Shapes](https://ggplot2.tidyverse.org/articles/ggplot2-specs.html)

色ではなく、形で Species を区別することも可能です。


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width, shape = Species)) +
  geom_point()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-10-1.png)<!-- -->

色と、形、両方を同時に使うことも可能です。


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species, shape = Species)) +
  geom_point()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-11-1.png)<!-- -->

## 箱ひげ図 [Boxplot](https://ggplot2.tidyverse.org/reference/geom_boxplot.html)

The boxplot compactly displays the distribution of a continuous variable.

箱ひげ図は、連続な値をとる変数の分布を簡潔な表示でみることができるグラフです。箱や、線の長さ、外れ値の表示なども、正確に決まっていますので、次のビデオをみてください。英語ですが、わかりやすく、まとまっていると思います。

<https://vimeo.com/222358034>

Transcript ボタンから、スクリプトを表示することもできます。

例のように、それぞれのグループごとに箱ひげ図を表示することもできますが、その場合は、文字データや、離散的な数値データ（いくつかの飛び飛びの値をとる変数）を使います。x と y を入れ替えれば、横向きになります。


```r
ggplot(data = df_iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-12-1.png)<!-- -->


```r
ggplot(data = df_iris, aes(y = Species, x = Sepal.Length)) +
  geom_boxplot()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-13-1.png)<!-- -->

各、種類（Species）ごとに、Sepal.Width（萼（がく）幅）が、どのように分布しているかを示しています。真ん中の太い線が、中央値（median）、箱が、第一四分位（Q1）から第三四分位（Q3）、線と点で表される外れ値も、どのような基準か定められています。(IQR = Q3-Q1, 線は、Q3+1.5$\times$ IQR 以下に入っている実際の値までと、Q1-1.5 $\times$ IQR 以上に入っている実際の値まで。それらに入っていないものが外れ値)。

color を指定すると、枠に色がつき、fill を指定すると、箱の中が塗り潰されます。


```r
ggplot(data = df_iris, aes(x = Species, y = Sepal.Length, color = Species)) +
  geom_boxplot()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-14-1.png)<!-- -->


```r
ggplot(data = df_iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-15-1.png)<!-- -->

### ヒストグラム [Histogram](https://ggplot2.tidyverse.org/reference/geom_histogram.html)

Visualize the distribution of a single continuous variable by dividing the x axis into bins and counting the number of observations in each bin. Histograms (geom_histogram()) display the counts with bars; frequency polygons (`geom_freqpoly()`) display the counts with lines. Frequency polygons are more suitable when you want to compare the distribution across the levels of a categorical variable.

単一の連続変数の分布を可視化するために、x軸をビンに分割し、各ビン内の観測値の数を数えます。ヒストグラム（geom_histogram()）は、棒で数を表示します。一方、頻度多角形（geom_freqpoly()）は、数を線で表示します。頻度多角形は、カテゴリ変数のレベル間の分布を比較したい場合により適しています。

説明ビデオです。<https://vimeo.com/221607341>


```r
ggplot(data = df_iris, aes(x = Sepal.Length)) +
  geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
```

![](26-visualize_files/figure-epub3/unnamed-chunk-16-1.png)<!-- -->

枠（bins）を幾つに分けるか、または枠の幅を指定するようにとのメッセージが表示されます。

枠（bins）の数を変更するには `bins =` `<number>`　を使います。幅を指定するときは、`binwidth = <number>` とします。

最初の例では、枠の個数を（初期設定では30になっているものを）10個とし、二つ目の例では、幅を1にしています。


```r
ggplot(data = df_iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 10)
```

![](26-visualize_files/figure-epub3/unnamed-chunk-17-1.png)<!-- -->


```r
ggplot(data = df_iris, aes(x = Sepal.Length)) +
  geom_histogram(binwidth = 1)
```

![](26-visualize_files/figure-epub3/unnamed-chunk-18-1.png)<!-- -->

頻度多角形（geom_freqpoly()）を使うと以下のようになります。Species ごとに比べたり、色をつけたりもできます。


```r
ggplot(data = df_iris, aes(x = Sepal.Length)) +
  geom_freqpoly()
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
```

![](26-visualize_files/figure-epub3/unnamed-chunk-19-1.png)<!-- -->


```r
ggplot(data = df_iris, aes(x = Sepal.Length, color = Species)) +
  geom_freqpoly(bins = 10)
```

![](26-visualize_files/figure-epub3/unnamed-chunk-20-1.png)<!-- -->

滑らかな曲線にするときは、density plot を使います。alpha は透明度で 0 から 1 の値で指定します。数が小さい方が薄くなります。color で線の色もあわせて設定することも可能です。いろいろと試してみてください。


```r
ggplot(data = df_iris, aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.5)
```

![](26-visualize_files/figure-epub3/unnamed-chunk-21-1.png)<!-- -->

### 線形モデル Data Modeling

回帰直線を加えたり、他の近似曲線を加えることも可能です。グラフとしても直感的理解を助けますが、統計的な扱いについては、Modeling で説明します。


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```

![](26-visualize_files/figure-epub3/unnamed-chunk-22-1.png)<!-- -->


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth()
```

![](26-visualize_files/figure-epub3/unnamed-chunk-23-1.png)<!-- -->

## 例から学ぶ ggplot2`,` I

#### mpg を使って

`ggplot2` に含まれている、`mpg`（Fuel economy data from 1999 to 2008 for 38 popular models of cars - 1999年から2008年の38の型式の車の年燃費）データを使って、簡単な、散布図と、箱ひげ図を描いてみます。`mpg` の変数などについては、Help で調べてください。

manufacturer は、メーカー名、model は、型式、disp は、排気量（単位：リットル）、year は年式、cyl は、気筒数、trans は、オートマかマニュアルか、drv は、f が前輪駆動、r は後輪駆動、4 は四輪駆動、cty は街中での燃費（１ガロンで何マイル走るか）、hwy は高速道路での燃費（１ガロンで何マイル走るか）、fl 燃料の種類、class タイプ


```r
df_mpg <- ggplot2::mpg
df_mpg
#> # A tibble: 234 × 11
#>    manufacturer model    displ  year   cyl trans drv     cty
#>    <chr>        <chr>    <dbl> <int> <int> <chr> <chr> <int>
#>  1 audi         a4         1.8  1999     4 auto… f        18
#>  2 audi         a4         1.8  1999     4 manu… f        21
#>  3 audi         a4         2    2008     4 manu… f        20
#>  4 audi         a4         2    2008     4 auto… f        21
#>  5 audi         a4         2.8  1999     6 auto… f        16
#>  6 audi         a4         2.8  1999     6 manu… f        18
#>  7 audi         a4         3.1  2008     6 auto… f        18
#>  8 audi         a4 quat…   1.8  1999     4 manu… 4        18
#>  9 audi         a4 quat…   1.8  1999     4 auto… 4        16
#> 10 audi         a4 quat…   2    2008     4 manu… 4        20
#> # ℹ 224 more rows
#> # ℹ 3 more variables: hwy <int>, fl <chr>, class <chr>
```


```r
glimpse(df_mpg)
#> Rows: 234
#> Columns: 11
#> $ manufacturer <chr> "audi", "audi", "audi", "audi", "audi…
#> $ model        <chr> "a4", "a4", "a4", "a4", "a4", "a4", "…
#> $ displ        <dbl> 1.8, 1.8, 2.0, 2.0, 2.8, 2.8, 3.1, 1.…
#> $ year         <int> 1999, 1999, 2008, 2008, 1999, 1999, 2…
#> $ cyl          <int> 4, 4, 4, 4, 6, 6, 6, 4, 4, 4, 4, 6, 6…
#> $ trans        <chr> "auto(l5)", "manual(m5)", "manual(m6)…
#> $ drv          <chr> "f", "f", "f", "f", "f", "f", "f", "4…
#> $ cty          <int> 18, 21, 20, 21, 16, 18, 18, 18, 16, 2…
#> $ hwy          <int> 29, 29, 31, 30, 26, 26, 27, 26, 25, 2…
#> $ fl           <chr> "p", "p", "p", "p", "p", "p", "p", "p…
#> $ class        <chr> "compact", "compact", "compact", "com…
```


```r
ggplot(data = df_mpg) + geom_point(mapping = aes(x = displ, y = hwy))
```

![](26-visualize_files/figure-epub3/unnamed-chunk-26-1.png)<!-- -->


```r
ggplot(data = df_mpg) + geom_boxplot(mapping = aes(x = class, y = hwy))
```

![](26-visualize_files/figure-epub3/unnamed-chunk-27-1.png)<!-- -->

1.  `data = df_mpg` でデータを指定します。

2.  どのようなグラフにするか、幾何関数（Geometric Function）を指定します。散布図では、`geom_pont()` 、箱ひげ図では、`geom_boxplot()` などです。

3.  x 軸、y 軸などに対応する変数の写像（mapping）を指定します。

    -   散布図では、`dspl` （displacemnt エンジンの排気量（単位 リットル））を x 軸に、`hwy` 高速道路で１ガロンで走れる距離（単位 マイル）を y 軸に割り当てています。

    -   箱ひげ図では、`class` 車の型式を、x 軸に、`hwy` 高速道路で１ガロンで走れる距離（単位 マイル）を y 軸に割り当てています。

記号的に書くと、下のようになっています。

`ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))`

## 例から学ぶ ggplot2`,` II

### df_wdi, df_wdi_extra

前の章の `Tidyverse` で読み込み、概観した、世界開発指標（World Development Indicators）のデータを使います。[参照：WDI のデータ](https://icu-hsuzuki.github.io/ds4aj/tidyverse.html#wdi-のデータ)


```r
library(tidyverse)
library(WDI)
```

WDI の使い方は、世界銀行の部分で紹介しますが、はじめてのデータサイエンスの例でも紹介したように、データコードを利用して、データを読み込みます。ここでは、出生時の平均寿命と、一人当たりの　GDP と、総人口のデータを使います。

-   SP.DYN.LE00.IN: Life expectancy at birth, total (years) 出生時の平均寿命
-   SP.POP.TOTL: Population, total 総人口
-   NY.GDP.PCAP.KD: GDP per capita (constant 2015 US\$) 一人当たりの　GDP

次のコードで読み込みます。


```r
df_wdi <- WDI(
  country = "all", 
  indicator = c(lifeExp = "SP.DYN.LE00.IN", pop = "SP.POP.TOTL", gdpPercap = "NY.GDP.PCAP.KD")
)
```




```
#> Rows: 16758 Columns: 7
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr (3): country, iso2c, iso3c
#> dbl (4): year, lifeExp, pop, gdpPercap
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
df_wdi_extra <- WDI(
  country = "all", 
  indicator = c(lifeExp = "SP.DYN.LE00.IN", pop = "SP.POP.TOTL", gdpPercap = "NY.GDP.PCAP.KD"), 
  extra = TRUE
)
```

すこし、追加情報を付加したものも取得しておきます。




```
#> Rows: 16758 Columns: 15
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (6): year, lifeExp, pop, gdpPercap, longitude, lati...
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
df_wdi
#> # A tibble: 16,758 × 7
#>    country     iso2c iso3c  year lifeExp      pop gdpPercap
#>    <chr>       <chr> <chr> <dbl>   <dbl>    <dbl>     <dbl>
#>  1 Afghanistan AF    AFG    1960    32.5  8622466        NA
#>  2 Afghanistan AF    AFG    1961    33.1  8790140        NA
#>  3 Afghanistan AF    AFG    1962    33.5  8969047        NA
#>  4 Afghanistan AF    AFG    1963    34.0  9157465        NA
#>  5 Afghanistan AF    AFG    1964    34.5  9355514        NA
#>  6 Afghanistan AF    AFG    1965    35.0  9565147        NA
#>  7 Afghanistan AF    AFG    1966    35.5  9783147        NA
#>  8 Afghanistan AF    AFG    1967    35.9 10010030        NA
#>  9 Afghanistan AF    AFG    1968    36.4 10247780        NA
#> 10 Afghanistan AF    AFG    1969    36.9 10494489        NA
#> # ℹ 16,748 more rows
```

### 

### **折線グラフ（line graph）**

WDI は時系列データですから、折れ線グラフも使います。後ほど紹介しますが、

| `<DATA> |> ggplot(aes(year, lifeExp)) + geom_line()`

と言った感じです。

まずは、失敗例から。次のコードでグラフが描けるでしょうか。


```r
df_wdi |> ggplot(aes(year, lifeExp)) + geom_line()
#> Warning: Removed 266 rows containing missing values
#> (`geom_line()`).
```

![](26-visualize_files/figure-epub3/unnamed-chunk-36-1.png)<!-- -->

何が起こっているかわかりますか。これは、鋸の刃グラフ（saw-tooth chart）と言われる標準的な失敗例です。


```r
ggplot(df_wdi, aes(x = year, y = lifeExp)) + geom_boxplot()
#> Warning: Continuous x aesthetic
#> ℹ did you forget `aes(group = ...)`?
#> Warning: Removed 892 rows containing non-finite values
#> (`stat_boxplot()`).
```

![](26-visualize_files/figure-epub3/unnamed-chunk-37-1.png)<!-- -->

これも期待した箱ひげ図にはなっていません。年は、カテゴリーではなく、数値データですね。


```r
typeof(pull(df_wdi, year)) # same as typeof(df$year)
#> [1] "double"
```

次のようにすると少しマシになります。


```r
ggplot(df_wdi, aes(y = lifeExp, group = year)) + geom_boxplot()
#> Warning: Removed 892 rows containing non-finite values
#> (`stat_boxplot()`).
```

![](26-visualize_files/figure-epub3/unnamed-chunk-39-1.png)<!-- -->

##### Box Plot


```r
ggplot(df_wdi, aes(x = as_factor(year), y = lifeExp)) + geom_boxplot()
#> Warning: Removed 892 rows containing non-finite values
#> (`stat_boxplot()`).
```

![](26-visualize_files/figure-epub3/unnamed-chunk-40-1.png)<!-- -->

とはいえ、数が多すぎますね。色もつけてみましょう。塗りつぶしは、fill 枠の線に色をつけるのは、color ですから、ここでは、fill を使います。


```r
df_wdi_extra |> filter(income != "Aggregates") |> 
  filter(year %in% c(1960, 1980, 2000, 2020)) |>
  ggplot(aes(x=as_factor(year), y = lifeExp, fill = income)) +
  geom_boxplot()
#> Warning: Removed 37 rows containing non-finite values
#> (`stat_boxplot()`).
```

![](26-visualize_files/figure-epub3/unnamed-chunk-41-1.png)<!-- -->

折線グラフの例としては次のようなものがあります。


```r
df_lifeExp <- df_wdi_extra |> filter(region != "Aggregates") |>  
  group_by(region, year) |>
  summarize(mean_lifeExp = mean(lifeExp), median_lifeExp = median(lifeExp), max_lifeExp = max(lifeExp), min_lifeExp = min(lifeExp), .groups = "keep")
```


```r
df_lifeExp %>% ggplot(aes(x = year, y = mean_lifeExp, color = region)) +
  geom_line()
#> Warning: Removed 243 rows containing missing values
#> (`geom_line()`).
```

![](26-visualize_files/figure-epub3/unnamed-chunk-43-1.png)<!-- -->


```r
df_lifeExp %>% ggplot(aes(x = year, y = mean_lifeExp, color = region, linetype = region)) +
  geom_line()
#> Warning: Removed 243 rows containing missing values
#> (`geom_line()`).
```

![](26-visualize_files/figure-epub3/unnamed-chunk-44-1.png)<!-- -->


```r
df_lifeExp %>% ggplot() +
  geom_line(aes(x = year, y = mean_lifeExp, color = region)) + 
  geom_line(aes(x = year, y = median_lifeExp, linetype = region))
#> Warning: Removed 243 rows containing missing values (`geom_line()`).
#> Removed 243 rows containing missing values (`geom_line()`).
```

![](26-visualize_files/figure-epub3/unnamed-chunk-45-1.png)<!-- -->

#### WDI

-   SP.DYN.LE00.IN: Life expectancy at birth, total (years)
-   NY.GDP.PCAP.KD: GDP per capita (constant 2015 US\$)
-   SP.POP.TOTL: Population, total


```r
df_wdi <- WDI(
  country = "all", 
  indicator = c(lifeExp = "SP.DYN.LE00.IN", pop = "SP.POP.TOTL", gdpPercap = "NY.GDP.PCAP.KD")
)
```




```
#> Rows: 16758 Columns: 7
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr (3): country, iso2c, iso3c
#> dbl (4): year, lifeExp, pop, gdpPercap
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
df_wdi %>% slice(1:10)
#> # A tibble: 10 × 7
#>    country     iso2c iso3c  year lifeExp      pop gdpPercap
#>    <chr>       <chr> <chr> <dbl>   <dbl>    <dbl>     <dbl>
#>  1 Afghanistan AF    AFG    1960    32.5  8622466        NA
#>  2 Afghanistan AF    AFG    1961    33.1  8790140        NA
#>  3 Afghanistan AF    AFG    1962    33.5  8969047        NA
#>  4 Afghanistan AF    AFG    1963    34.0  9157465        NA
#>  5 Afghanistan AF    AFG    1964    34.5  9355514        NA
#>  6 Afghanistan AF    AFG    1965    35.0  9565147        NA
#>  7 Afghanistan AF    AFG    1966    35.5  9783147        NA
#>  8 Afghanistan AF    AFG    1967    35.9 10010030        NA
#>  9 Afghanistan AF    AFG    1968    36.4 10247780        NA
#> 10 Afghanistan AF    AFG    1969    36.9 10494489        NA
```


```r
df_wdi_extra <- WDI(
  country = "all", 
  indicator = c(lifeExp = "SP.DYN.LE00.IN", pop = "SP.POP.TOTL", gdpPercap = "NY.GDP.PCAP.KD"), 
  extra = TRUE
)
```




```
#> Rows: 16758 Columns: 15
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (6): year, lifeExp, pop, gdpPercap, longitude, lati...
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
df_wdi_extra
#> # A tibble: 16,758 × 15
#>    country     iso2c iso3c  year status lastupdated lifeExp
#>    <chr>       <chr> <chr> <dbl> <lgl>  <date>        <dbl>
#>  1 Afghanistan AF    AFG    2014 NA     2023-07-25     62.5
#>  2 Afghanistan AF    AFG    2012 NA     2023-07-25     61.9
#>  3 Afghanistan AF    AFG    2009 NA     2023-07-25     60.4
#>  4 Afghanistan AF    AFG    2013 NA     2023-07-25     62.4
#>  5 Afghanistan AF    AFG    1971 NA     2023-07-25     37.9
#>  6 Afghanistan AF    AFG    2015 NA     2023-07-25     62.7
#>  7 Afghanistan AF    AFG    1969 NA     2023-07-25     36.9
#>  8 Afghanistan AF    AFG    2010 NA     2023-07-25     60.9
#>  9 Afghanistan AF    AFG    2011 NA     2023-07-25     61.4
#> 10 Afghanistan AF    AFG    2008 NA     2023-07-25     59.9
#> # ℹ 16,748 more rows
#> # ℹ 8 more variables: pop <dbl>, gdpPercap <dbl>,
#> #   region <chr>, capital <chr>, longitude <dbl>,
#> #   latitude <dbl>, income <chr>, lending <chr>
```

違いはわかりましたか。同じような変数についてのデータですが、WDI からダウンロードした実際のデータの場合には、練習用のデータとは、違った困難がいくつもあります。それを、少しず見ていきながら、現実世界のデータを扱えるようにしていきましょう。

## コメント

### 参考文献

-   Cheat Sheet in RStudio: <https://www.rstudio.com/resources/cheatsheets/>

    -   [RStudio IED](https://raw.githubusercontent.com/rstudio/cheatsheets/main/rstudio-ide.pdf)
    -   [Base R Cheat Sheet](https://github.com/rstudio/cheatsheets/raw/main/base-r.pdf)

-   'Quick R' by DataCamp: <https://www.statmethods.net/management>

-   [An Introduction to R](https://cran.rstudio.com)

## 練習

### Posit Primers <https://posit.cloud/learn/primers>

1.  The Basics -- [r4ds: Explore, I](https://r4ds.had.co.nz/explore-intro.html#explore-intro)

-   [Visualization Basics](https://rstudio.cloud/learn/primers/1.1)
-   [Programming Basics](https://rstudio.cloud/learn/primers/1.2)
