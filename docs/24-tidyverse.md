# Tidyverse {#tidyverse}

## はじめに

R のはじめかたについて少し説明しました。R を起動させると、最初に `base` などいくつかのパッケージが自動的に読み込まれますが、その基本の基本を紹介したということです。ここでは、第二部で学ぶことの、核となる `tidyverse` というパッケージ群についてその基本を学びます。

サイト：<https://www.tidyverse.org>

R は、さまざまな分野で、統計分析に利用されてきたこともあり、それぞれの分析でよく使われる関数（functions, 小さなプログラム）を集めたパッケージが作られ、それぞれの分野で使われてきました。まさに、痒いところに手が届く、さまざまなパッケージが存在します。他方、さまざまな人たちが開発を続けてきたために、統一性がない、保守の継続性が十分ではない、異なるパッケージに同じ名前の関数があるなどの問題も生じてきたように思います。

さらに、それぞれの分野での、統計分析だけではなく、学際分野としてのデータサイエンスでの利用、AI への応用などにも使われるようになったこと、さらに、データサイエンスでは、特に可視化が重要で、その部分の基本が、幾何表現の文法（Grammar of Graphics）を踏まえた `ggplot2` パッケージのによって、確立したことから、統一した思想のもとで、構築されたのが、`tidyverse` パッケージ群です。さまざまな改善によって、プログラミング言語としても、十分なレベルの言語となっていると思います。

一連の `tidyverse` パッケージ群の開発が、R 自体にも影響を与え、R の起動時に読み込まれるようになったものもあります。

パッケージ群と呼びましたが、たくさんのパッケージが全体として、`tidyverse` と呼ばれ、`tidyverse` をインストールすると、`tidyverse` パッケージ群のパッケージがすべてインストールされます。

それを、`library(tidyverse)` などで、ロード（使えるようにするために）すると、`tidyverse` パッケージ群の主要なパッケージがみな、読み込まれます。ただ、こちらは、「主要な」ものだけですので、`tidyverse` パッケージ群 のパッケージでも、後ほど、個別に読み込む必要があるものもありますので、注意してください。

## あやめ（iris）のデータ

利用するデータ、特に、その変数（列）名に日本語（中国語・韓国語など）を使う場合には、`install.packages('showtext')` で、`showtext` パッケージをインストールして、下のように設定ます。標準的には、最初の行 `library(tidyverse)` だけで十分です。


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

以下では、R の起動時に読み込まれる、 `datasets` パッケージの中の、`iris` データを使います。以前には、同じパッケージに含まれる、`cars` を使いました。まず、このデータに、`ds_iris` という名前をつけて使うことにします。これは、アサインと言い、`<-` を使います。半角で入力します。

備考：

1.  Help の Keyboard Shortcuts Help をみると、さまざまなキーボードショートカットが書かれています。`<-` は、Windows では、`Alt + -` 、Mac では、`Option + -` で、入力することもできます。`Alt + -` などは、`Alt` キーを推しながら、`-`　キーを押すという意味です。
2.  `df_iris <- iris` でも問題ないと思います。下にようにするのは、すでに、`iris` という変数を使っているかもしれないので、`datasets` パッケージの `iris` を使うという意味です。


```r
df_iris <- datasets::iris 
class(df_iris)
#> [1] "data.frame"
```

あやめのデータ `iris` は `data.frame` というクラスであることがわかります。`tidyverse` には、`tibble` というデータのクラス（`data.frame` のサブクラス）もあります。


```r
tbl_iris <- as_tibble(datasets::iris)
class(tbl_iris)
#> [1] "tbl_df"     "tbl"        "data.frame"
```

`df_iris` と `tbl_iris` で出力が変わる場合もありますが、今のところは、あまり気にせず、`df_iris` を使っていきたいと思います。

### データを見てみよう

#### いくつかの方法

The `View` command opens up a window to show the contents of the data, and you can also use the filter.


```r
View(df_iris)
```

The following simple command also shows the data.


```r
df_iris
```


```
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1           5.1         3.5          1.4         0.2
#> 2           4.9         3.0          1.4         0.2
#> 3           4.7         3.2          1.3         0.2
#> 4           4.6         3.1          1.5         0.2
#> 5           5.0         3.6          1.4         0.2
#> 6           5.4         3.9          1.7         0.4
#> 7           4.6         3.4          1.4         0.3
#> 8           5.0         3.4          1.5         0.2
#> 9           4.4         2.9          1.4         0.2
#> 10          4.9         3.1          1.5         0.1
#>    Species
#> 1   setosa
#> 2   setosa
#> 3   setosa
#> 4   setosa
#> 5   setosa
#> 6   setosa
#> 7   setosa
#> 8   setosa
#> 9   setosa
#> 10  setosa
```

`%>%` is called a pipe command, and we use it often.

The output within R Notebook is a tibble style. Try the same command in Console.


```r
slice(df_iris, 1:10)
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1           5.1         3.5          1.4         0.2
#> 2           4.9         3.0          1.4         0.2
#> 3           4.7         3.2          1.3         0.2
#> 4           4.6         3.1          1.5         0.2
#> 5           5.0         3.6          1.4         0.2
#> 6           5.4         3.9          1.7         0.4
#> 7           4.6         3.4          1.4         0.3
#> 8           5.0         3.4          1.5         0.2
#> 9           4.4         2.9          1.4         0.2
#> 10          4.9         3.1          1.5         0.1
#>    Species
#> 1   setosa
#> 2   setosa
#> 3   setosa
#> 4   setosa
#> 5   setosa
#> 6   setosa
#> 7   setosa
#> 8   setosa
#> 9   setosa
#> 10  setosa
```


```r
1:10
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

#### Data Structure

Let us look at the structure of the data. You can try `str(df_iris)` on Console or by adding a code chunk in R Notebook introducing later.


```r
glimpse(df_iris)
#> Rows: 150
#> Columns: 5
#> $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.…
#> $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.…
#> $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.…
#> $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.…
#> $ Species      <fct> setosa, setosa, setosa, setosa, setos…
```

There are six types of data in R; Double, Integer, Character, Logical, Raw, and Complex. In this course, we use only the first four.

The names after \$ are column names. If you call `df_iris$Species`, you have the Species column. Species is in the 5th column, `typeof(df_iris[[5]])` does the same as the next.

``` df_iris[2,4] = `0.2`` is the fourth entry of Sepal.Width.


```r
typeof(df_iris$Species)
#> [1] "integer"
```


```r
class(df_iris$Species)
#> [1] "factor"
```

For `factors = fct` see [the R Document](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/factor) or an explanation in [Factor in R: Categorical Variable & Continuous Variables](https://www.guru99.com/r-factor-categorical-continuous.html).


```r
typeof(df_iris$Sepal.Length)
#> [1] "double"
class(df_iris$Sepal.Length)
#> [1] "numeric"
```

**Q1.** What are the differences of `df_iris`, `slice(df_iris, 1:10)` and `glimpse(df_iris)` above?

**Q2.** What are the differences of`df_iris`, `slice(df_iris, 1:10)` and `glimpse(df_iris)` in the console?

#### Summary of the Data

The following is very convenient to get the summary information of a data.


```r
summary(df_iris)
#>   Sepal.Length    Sepal.Width     Petal.Length  
#>  Min.   :4.300   Min.   :2.000   Min.   :1.000  
#>  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600  
#>  Median :5.800   Median :3.000   Median :4.350  
#>  Mean   :5.843   Mean   :3.057   Mean   :3.758  
#>  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100  
#>  Max.   :7.900   Max.   :4.400   Max.   :6.900  
#>   Petal.Width          Species  
#>  Min.   :0.100   setosa    :50  
#>  1st Qu.:0.300   versicolor:50  
#>  Median :1.300   virginica :50  
#>  Mean   :1.199                  
#>  3rd Qu.:1.800                  
#>  Max.   :2.500
```

Minimum, 1st Quadrant (25%), Median, Mean, 3rd Quadrant (75%), Maximum, and the count of each factor.
