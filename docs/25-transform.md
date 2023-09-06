# 変形（Transform） {#transform}

> ここでは、`tidyverse` パッケージを構成する `dplyr` パッケージを用いて、データを変形することを学びます。変形とは、例えば、データのなかのある条件を満たす行や列を抽出したり、特定の列を修正したり、データの中のいくつかの列に含まれる情報をもとに計算して、新たな列を作ったり、グループに分けたり、順番を入れ替えたりといったことです。データを集約したり、グラフを作成するときにも、必要不可欠な作業です。
>
> `dplyr` パッケージを用いて、二つのデータを結合することなども可能ですが、それは、あとから扱います。これも、`tidyverse` パッケージを構成する `tidyr` パッケージ による変形も、後ほど扱います。

`dplyr` パッケージは、`tidyverse` パッケージをインストールしたり、使えるように `library(tidyverse)` で読み込んだりするときに、一緒に読み込まれますから、あらためて、`dplyr` を指定する必要はありません。


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
```

## `dplyr` [概要](https://dplyr.tidyverse.org)

`dplyr` はデータ操作の文法のようなもので、最も一般的なデータ操作に役立つ一貫したいくつかの「動詞」の役割を果たすものを提供しています。

-   `select()` 変数をその名前によって選択 - 列の選択に対応します。
-   `filter()` ケースをその値によって選択 - 行の選択に対応します。
-   `mutate()` 新しい変数を既存の値を使って定義します - 新しい列を作成することに対応しています。
-   `summarise()` たくさんの値を一つの値に集約します - 代表値（平均、メディアンなど）を求めることに対応します。
-   `arrange()` 行の順序を変更します。
-   `group_by()` グループを指定した表に変換します。

さらに詳しく知りたい場合は Console（コンソールに）vignette("dplyr") と入れるか、[こちら](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html) を参照してください。上では、一つの表について述べていますが、二つの表の扱い方は、Console（コンソール）に vignette("two-table") と入れるか、[こちら](https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html) を参照してください。二つの表の扱いについては、後から説明します。

`dplyr` を初めて使われる場合には、まず [R for data science (2e) Transform](https://r4ds.hadley.nz/transform) を学ばれることをお勧めします。以下も、このサイトに沿った説明をします。

### [`select`](https://dplyr.tidyverse.org/reference/select.html): 名前とタイプによって、列（変数）を選択

| 補助関数      | 条件                   | 例                                            |
|---------------|------------------------|-----------------------------------------------|
| \-            | 列の排除               | select(babynames, -prop)                      |
| :             | 列の範囲               | select(babynames, year:n)                     |
| contains()    | 指定文字列を含         | select(babynames, contains("n"))              |
| ends_with()   | 指定文字列で終わる     | select(babynames, ends_with("n"))             |
| matches()     | 正規表現に適合         | select(babynames, matches("n"))               |
| num_range()   | 末尾の指定数値範囲     | Not applicable with babynames                 |
| one_of()      | 指定した名前に含まれる | select(babynames, one_of(c("sex", "gender"))) |
| starts_with() | 指定文字列で始まる     | select(babynames, starts_with("n"))           |

### [`filter`](https://dplyr.tidyverse.org/reference/filter.html): 列の値の条件に適合した行の選択

| 論理作用素 | 条件             | 例        |
|------------|------------------|-----------|
| \>         | y より大きい x   | x \> y    |
| \>=        | y 以上の x       | x \>= y   |
| \<         | y より小さい x   | x \< y    |
| \<=        | y 以下の x       | x \<= y   |
| ==         | y と等しい x     | x == y    |
| !=         | y と等しくない x | x != y    |
| is.na()    | 値が NA である x | is.na(x)  |
| !is.na()   | 値が NA でない x | !is.na(x) |

### [`arrange`](https://dplyr.tidyverse.org/reference/arrange.html)

`arrange()` では、選択した列の値によって、行を並び替えます。

注意点すべきは、他の、`dplyr` の動詞とは異なり、基本的に、グループ化は、無視し、その表全体に適用します。グループ内で並び替えをしたい場合には、グループ化した変数を指定するか、`.by_group = TRUE` とします。

### [`mutate`](https://dplyr.tidyverse.org/reference/mutate.html)

新しい列を作成または、既存の列を修正、削除します。

以下は便利な補助関数の例です。

-   +, -, log(), etc., for their usual mathematical meanings

-   lead(), lag()

-   dense_rank(), min_rank(), percent_rank(), row_number(), cume_dist(), ntile()

-   cumsum(), cummean(), cummin(), cummax(), cumany(), cumall()

-   na_if(), coalesce()\### `group_by()` and `summarise()`

### [`group_by`](https://dplyr.tidyverse.org/reference/group_by.html)

指定した列の値によって表全体をグループ化した表を作成します。表自体が変形されるわけではありませんから、注意してください。次の、`summarize` と合わせて利用すると便利です。

### [`summarise` or `summarize`](https://dplyr.tidyverse.org/reference/summarise.html)

値の集約 (summarize) に利用します。グループ化された表の場合には、そのグループごとに、値を集約します。

#### 集約のための関数

`summarize` には、 `sum()`, `max()`, や `mean()` が使われますが、ベクトルに対して定義され、一つの値だけを出力する関数でであれば、なんでも使うことができます。以下は、その例です。それぞれの関数については、Help で調べてください。

1.  特定の値 - `mean(x)`, `median(x)`, `quantile(x, 0.25)`, `min(x)`, `max(x)`

2.  分布の値 - `sd(x)`, `var(x)`, `IQR(x)`, `mad(x)`

3.  値の位置 - `first(x)`, `nth(x, 2)`, `last(x)`

4.  個数 - `n_distinct(x),` `n()` （引数なし：表またはグループのサイズ）

5.  論理値の数または割合 - sum(!is.na(x)), mean(y == 0)

条件文で値を指定することも可能です。

-   if_else(), recode(), case_when()

### パイプ（Pipe）`%>%` `|>`

[`pipes`](https://r4ds.hadley.nz/workflow-style.html#sec-pipes) in R for Data Science.

`%>%` は、`tidyverse` パッケージで、関数のチェーン化を行うために使用されるパイプ演算子ですが、R 4.1 以降は、`|>` が、R に組み込まれた、ネイティブなパイプライン演算子になっています。`tidyverse` を使っているときは、どちらを使うことも可能ですが、`|>` を使うことをお勧めします。R の versoin を確認するには、コンソール（Console）で、`R.Version()` または、`R.version$version.string` とします。

#### **備考**

1.  パイプを使うコードで、複数行にまたがるときは、`|>` の後で、改行してください。次の行に続くことがわかります。

2.  実際には、`tidyverse` の `%>%` と、R に組み込まれた `|>` とは多少異なるようです。こちらの[記事](https://www.tidyverse.org/blog/2023/04/base-vs-magrittr-pipe/)をご覧ください。本書では、`|>` を使いますが、注意が必要な場合は、コメントします。

## 例から学ぶ `dplyr` I

### Data `iris`

R 起動時に読み込まれる、`datasets` の中の、`iris` （あやめのデータ）を使い、いくつかの例を示します。`iris` は、何もしなくてもそのまま使えますが、もし、下の結果と違う場合には、すでに、`iris` を使い、変形などをしている可能性がありますから、そのときは、下のコードを実行してください。


```r
iris <- datasets::iris
```

確認します。


```r
head(iris)
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa
```


```r
str(iris)
#> 'data.frame':	150 obs. of  5 variables:
#>  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#>  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#>  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#>  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#>  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

`iris` データは、名前のついた5個の変数（列）Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species があり、それぞれ、150の値（observations (obs.) 観察値）からなっています。5番目の Species は、三つのレベルのファクター（factor）setosa, versicolor ともう一つ virginica からなっていることがわかります。`unique` は、ベクトル型の変数（今の場合は、`iris` の `Species` という列）の中の異なる値を抽出します。ファクター（factor）は、ある分け方がされているという意味です。いずれ説明します。


```r
unique(iris$Species)
#> [1] setosa     versicolor virginica 
#> Levels: setosa versicolor virginica
```

### `select` 列の抽出

### `select` 1 - 第 1, 2, 5 列を抽出


```r
head(select(iris, c(1,2,5)))
#>   Sepal.Length Sepal.Width Species
#> 1          5.1         3.5  setosa
#> 2          4.9         3.0  setosa
#> 3          4.7         3.2  setosa
#> 4          4.6         3.1  setosa
#> 5          5.0         3.6  setosa
#> 6          5.4         3.9  setosa
```

第1列、第2列、第5列を、`c(1,2,5)` で表しています。列名で指定することもできます。

`head(select(iris, c(1,2,5)))` としてありますから、その最初の6行を表示していますが、新しい変数を割り当ててはいませんから、`iris` 自体は変更されていません。


```r
head(iris)
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa
```

第1列、第2列、第5列を選んだものを、あとから使いたいときは、新しい名前をつける必要があります。以下同様ですが、この場合だけ、df\_`iris125` という名前（object name）をつけておきましょう。


```r
df_iris125 <- select(iris, c(1,2,5))
head(df_iris125)
#>   Sepal.Length Sepal.Width Species
#> 1          5.1         3.5  setosa
#> 2          4.9         3.0  setosa
#> 3          4.7         3.2  setosa
#> 4          4.6         3.1  setosa
#> 5          5.0         3.6  setosa
#> 6          5.4         3.9  setosa
```

#### パイプ（Pipe） `|>` を使ったコード

最初の例では `head(select(iris, c(1,2,5)))` としました。`head` の引数として、 `select(iris, c(1,2,5))` を使ったからです。しかし、慣れてくると、順番に関数を適用することを表現するには、 パイプを使うのも便利です。パイプでは、直前の出力が次の関数の第一引数として引き継がれるというルールになっています。以下のようになります。


```r
iris |> select(c(1,2,5)) |> head()
#>   Sepal.Length Sepal.Width Species
#> 1          5.1         3.5  setosa
#> 2          4.9         3.0  setosa
#> 3          4.7         3.2  setosa
#> 4          4.6         3.1  setosa
#> 5          5.0         3.6  setosa
#> 6          5.4         3.9  setosa
```

より、詳しく知りたい場合には、Help に `|>` と入れて説明を読んでください。

In the following, we use pipes.

### `select` 2 - Species 列以外

列名の前に、`-` ハイフン（半角）をつけると、その列以外を抽出します。


```r
select(iris, -Species) |> head()
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1          5.1         3.5          1.4         0.2
#> 2          4.9         3.0          1.4         0.2
#> 3          4.7         3.2          1.3         0.2
#> 4          4.6         3.1          1.5         0.2
#> 5          5.0         3.6          1.4         0.2
#> 6          5.4         3.9          1.7         0.4
```

### `select` 3 - 列を抽出するとともに列名も変更

新しい列名 = 現在の列名 という形式で、列名を変更することも可能です。


```r
select(iris, sl = Sepal.Length, sw = Sepal.Width, sp = Species) |> 
  head()
#>    sl  sw     sp
#> 1 5.1 3.5 setosa
#> 2 4.9 3.0 setosa
#> 3 4.7 3.2 setosa
#> 4 4.6 3.1 setosa
#> 5 5.0 3.6 setosa
#> 6 5.4 3.9 setosa
```

### `select` 4 - 列順の変更


```r
select(iris, c(5,3,4,1,2)) %>% head()
#>   Species Petal.Length Petal.Width Sepal.Length Sepal.Width
#> 1  setosa          1.4         0.2          5.1         3.5
#> 2  setosa          1.4         0.2          4.9         3.0
#> 3  setosa          1.3         0.2          4.7         3.2
#> 4  setosa          1.5         0.2          4.6         3.1
#> 5  setosa          1.4         0.2          5.0         3.6
#> 6  setosa          1.7         0.4          5.4         3.9
```

#### 備考

1.  上の、`select`\` の 補助関数（helper functions）にも書きましたように、他にも様々な方法で、列を抽出することが可能です。たくさんの列がある、表に出会ったら、ぜひ使ってください。

### `filter` - 値による抽出

Species の列の値が、virginica であるものだけを抽出します。`==` とイコールが二つであることと、文字列の場合には、半角の引用符（double quote）でくくります。'verginica' でも同じです。（列名に空白や、特殊記号が含まれているときには、back tick と呼ばれる、反対向きの引用符で括ります。あとからその必要が生じたときに説明します。）


```r
filter(iris, Species == "virginica") %>% head()
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1          6.3         3.3          6.0         2.5
#> 2          5.8         2.7          5.1         1.9
#> 3          7.1         3.0          5.9         2.1
#> 4          6.3         2.9          5.6         1.8
#> 5          6.5         3.0          5.8         2.2
#> 6          7.6         3.0          6.6         2.1
#>     Species
#> 1 virginica
#> 2 virginica
#> 3 virginica
#> 4 virginica
#> 5 virginica
#> 6 virginica
```

### `arrange` - 昇順、降順

次の例では、Sepal.Length の値の、昇順（小さい順）にし、同じ値の中では、Spepal.Width の降順（大きい順 （desc は descending order からとったもの）にします。Sepal.Length の値が、4.4 の部分の、Sepal.Width の値をみてください。


```r
arrange(iris, Sepal.Length, desc(Sepal.Width)) %>% head()
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          4.3         3.0          1.1         0.1  setosa
#> 2          4.4         3.2          1.3         0.2  setosa
#> 3          4.4         3.0          1.3         0.2  setosa
#> 4          4.4         2.9          1.4         0.2  setosa
#> 5          4.5         2.3          1.3         0.3  setosa
#> 6          4.6         3.6          1.0         0.2  setosa
```

### `mutate` - rank（階級）

小さい順に順序付けて新しい列を作成し、その順序で表示します。順序付も様々な種類があります。ここでは、同じ値のときには、同じ階級にしています。下の出力を右の方を見てください。1, 2, 2, 2, 5, ... となっています。


```r
iris |> mutate(sl_rank = min_rank(Sepal.Length)) |> 
  arrange(sl_rank) |> head()
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          4.3         3.0          1.1         0.1  setosa
#> 2          4.4         2.9          1.4         0.2  setosa
#> 3          4.4         3.0          1.3         0.2  setosa
#> 4          4.4         3.2          1.3         0.2  setosa
#> 5          4.5         2.3          1.3         0.3  setosa
#> 6          4.6         3.1          1.5         0.2  setosa
#>   sl_rank
#> 1       1
#> 2       2
#> 3       2
#> 4       2
#> 5       5
#> 6       6
```

#### 備考

1.  パイプを紹介したときにも書きましたが、改行は、`|>` のあとでしてください。

### `group_by` and `summarize`

グループにわけて、グループごとに、平均を求めています。


```r
iris |> 
  group_by(Species) |>
  summarize(sl = mean(Sepal.Length), sw = mean(Sepal.Width), 
  pl = mean(Petal.Length), pw = mean(Petal.Width))
#> # A tibble: 3 × 5
#>   Species       sl    sw    pl    pw
#>   <fct>      <dbl> <dbl> <dbl> <dbl>
#> 1 setosa      5.01  3.43  1.46 0.246
#> 2 versicolor  5.94  2.77  4.26 1.33 
#> 3 virginica   6.59  2.97  5.55 2.03
```

-   mean: `mean()` or `mean(x, na.rm = TRUE)` - 相加平均 (average)
-   median: `median()` , `median(x, na.rm = TRUE)` - 中央値（mid value）

以下のリンクには、もう少し例が書かれています。

[dplr_iris](https://icu-hsuzuki.github.io/da4r2022_note/dplyr-iris.nb.html)

## `dplyr` の参考文献

より詳しい説明は、教科書の該当箇所を見てください。

-   [R for Data Science, Part II Explore](https://r4ds.had.co.nz/wrangle-intro.html#wrangle-intro)
-   [R for Data Science (2e), Transform](https://r4ds.hadley.nz/transform)

### RStudio Primers: 対話型の演習問題

2.  Work with Data -- [r4ds: Wrangle, I](https://r4ds.had.co.nz/wrangle-intro.html#wrangle-intro)

-   [Working with Tibbles](https://rstudio.cloud/learn/primers/2.1)
-   [Isolating Data with dplyr](https://rstudio.cloud/learn/primers/2.2)
-   [Deriving Information with dplyr](https://rstudio.cloud/learn/primers/2.3)

## 例から学ぶ `dplyr` II - `gapminder`

`gapminder` というパッケージのデータを使って、`dplyr` を学びます。この次の章で、`ggplot2` を使った視覚化について学びますが、この章で学んでいる変形は、`ggplot2` で、視覚化する準備のために、する場合も多いので、ここでも、`ggplot2` を使います。

### `ggplot2` [概要](https://ggplot2.tidyverse.org)

次のような形式で使います。

**例1 散布図**

```         
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
```

**例2 箱ひげ図**

```         
ggplot(data = mpg) + 
  geom_boxplot(mapping = aes(x = class, y = hwy))
```

**テンプレート**

```         
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
```

#### Gapminder と R Package `gapminder`

> Gapminder は オラ ロスリング（Ola Rosling） と アンナ ロスリング（Anna Rosling Rönnlund）と ハンス ロスリング（Hans Rosling）が設立した組織です。
>
> ハンス・ロスリング は、**FACTFULNESS（ファクトフルネス）10の思い込みを乗り越え、データを基に世界を正しく見る習慣** の著者です。
>
> また、R の gapminder パッケージには、ファクトフルネス にも登場するデータで、Gapminder サイトでも使っているデータの一部を、使いやすい、練習用のデータとして提供しているものです。

-   Gapminder: <https://www.gapminder.org>

    -   Test on Top: You are probably wrong about - upgrade your worldview
    -   Bubble Chart: <https://www.gapminder.org/tools/#$chart-type=bubbles&url=v1>
    -   Dallar Street: <https://www.gapminder.org/tools/#$chart-type=bubbles&url=v1>
    -   Data: <https://www.gapminder.org/data/>

-   R Package gapminder by Jennifer Bryan

    -   Package site: <https://CRAN.R-project.org/package=gapminder>
    -   Site: <https://github.com/jennybc/gapminder>
    -   Documents: <https://www.rdocumentation.org/packages/gapminder/versions/0.3.0>

-   Package Help `?gapminder` or `gapminder` in the search window of Help

    -   The main data frame gapminder has 1704 rows and 6 variables:
        -   country: factor with 142 levels
        -   continent: factor with 5 levels
        -   year: ranges from 1952 to 2007 in increments of 5 years
        -   lifeExp: life expectancy at birth, in years
        -   pop: population
        -   gdpPercap: GDP per capita (US\$, inflation-adjusted)


```r
library(tidyverse)
library(gapminder)
library(WDI)
```

#### R Package `gapminder` data

We will use a `tidyverse` function `slice` replacing `head`. Check `slice` in the search window under the Help tab on the bottom right pane.


```r
df_gm <- gapminder
df_gm
#> # A tibble: 1,704 × 6
#>    country     continent  year lifeExp      pop gdpPercap
#>    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
#>  1 Afghanistan Asia       1952    28.8  8425333      779.
#>  2 Afghanistan Asia       1957    30.3  9240934      821.
#>  3 Afghanistan Asia       1962    32.0 10267083      853.
#>  4 Afghanistan Asia       1967    34.0 11537966      836.
#>  5 Afghanistan Asia       1972    36.1 13079460      740.
#>  6 Afghanistan Asia       1977    38.4 14880372      786.
#>  7 Afghanistan Asia       1982    39.9 12881816      978.
#>  8 Afghanistan Asia       1987    40.8 13867957      852.
#>  9 Afghanistan Asia       1992    41.7 16317921      649.
#> 10 Afghanistan Asia       1997    41.8 22227415      635.
#> # ℹ 1,694 more rows
```


```r
glimpse(df_gm)
#> Rows: 1,704
#> Columns: 6
#> $ country   <fct> "Afghanistan", "Afghanistan", "Afghanist…
#> $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia…
#> $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982…
#> $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, …
#> $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13…
#> $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, …
```


```r
summary(df_gm)
#>         country        continent        year     
#>  Afghanistan:  12   Africa  :624   Min.   :1952  
#>  Albania    :  12   Americas:300   1st Qu.:1966  
#>  Algeria    :  12   Asia    :396   Median :1980  
#>  Angola     :  12   Europe  :360   Mean   :1980  
#>  Argentina  :  12   Oceania : 24   3rd Qu.:1993  
#>  Australia  :  12                  Max.   :2007  
#>  (Other)    :1632                                
#>     lifeExp           pop              gdpPercap       
#>  Min.   :23.60   Min.   :6.001e+04   Min.   :   241.2  
#>  1st Qu.:48.20   1st Qu.:2.794e+06   1st Qu.:  1202.1  
#>  Median :60.71   Median :7.024e+06   Median :  3531.8  
#>  Mean   :59.47   Mean   :2.960e+07   Mean   :  7215.3  
#>  3rd Qu.:70.85   3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
#>  Max.   :82.60   Max.   :1.319e+09   Max.   :113523.1  
#> 
```

#### `dplyr` の応用

##### `filter`

一番上に、国名（country）に、アフガニスタン（Afghanistan） がありましたから、aアフガニスタンのデータを選び、平均寿命（lifeExp: Life Expectancy）の折線グラフ（line graph）を描いてみましょう。まずは、filter で、アフガニスタンのデータを抽出します。スペルに注意してください。コピーをするのが安全かもしれません。

`filter(country == "Afghanistan")`

特定の値のデータを抽出するには、`==` を使うのでした。二つの `=` ですから、間違わないでください。


```r
df_gm %>% filter(country == "Afghanistan")
#> # A tibble: 12 × 6
#>    country     continent  year lifeExp      pop gdpPercap
#>    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
#>  1 Afghanistan Asia       1952    28.8  8425333      779.
#>  2 Afghanistan Asia       1957    30.3  9240934      821.
#>  3 Afghanistan Asia       1962    32.0 10267083      853.
#>  4 Afghanistan Asia       1967    34.0 11537966      836.
#>  5 Afghanistan Asia       1972    36.1 13079460      740.
#>  6 Afghanistan Asia       1977    38.4 14880372      786.
#>  7 Afghanistan Asia       1982    39.9 12881816      978.
#>  8 Afghanistan Asia       1987    40.8 13867957      852.
#>  9 Afghanistan Asia       1992    41.7 16317921      649.
#> 10 Afghanistan Asia       1997    41.8 22227415      635.
#> 11 Afghanistan Asia       2002    42.1 25268405      727.
#> 12 Afghanistan Asia       2007    43.8 31889923      975.
```

確認できましたか。

折線グラフを書きます。この場合は、GEOM は、`geom_line` です。


```r
df_gm %>% filter(country == "Afghanistan") %>%
  ggplot(aes(x = year, y = lifeExp)) + geom_line()
```

<img src="25-transform_files/figure-html/unnamed-chunk-21-1.png" width="672" />

アフガニスタンでは 1952年 の誕生時の平均寿命（life expectancy at birth）は　30歳以下 （28.8歳）でした。2007年でも50歳以下（48.8 歳）のようですね。改善されていることも確かです。

アフガニスタンと日本両方を抽出してみましょう。そのときは、 `country %in% c("Afghanistan", "Japan")`　とします。


```r
df_gm %>% filter(country %in% c("Afghanistan", "Japan"))
#> # A tibble: 24 × 6
#>    country     continent  year lifeExp      pop gdpPercap
#>    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
#>  1 Afghanistan Asia       1952    28.8  8425333      779.
#>  2 Afghanistan Asia       1957    30.3  9240934      821.
#>  3 Afghanistan Asia       1962    32.0 10267083      853.
#>  4 Afghanistan Asia       1967    34.0 11537966      836.
#>  5 Afghanistan Asia       1972    36.1 13079460      740.
#>  6 Afghanistan Asia       1977    38.4 14880372      786.
#>  7 Afghanistan Asia       1982    39.9 12881816      978.
#>  8 Afghanistan Asia       1987    40.8 13867957      852.
#>  9 Afghanistan Asia       1992    41.7 16317921      649.
#> 10 Afghanistan Asia       1997    41.8 22227415      635.
#> # ℹ 14 more rows
```

グラフにしてみましょう。今度は、区別のため、`color = country` を追加します。すると、線が違う色で表示されます。詳しくは、視覚化を参照してください。


```r
df_gm %>% filter(country %in% c("Afghanistan", "Japan")) %>%
  ggplot(aes(x = year, y = lifeExp, color = country)) + geom_line()
```

<img src="25-transform_files/figure-html/unnamed-chunk-23-1.png" width="672" />

どのような発見がありますか。かならず書き留めておいてください。

他の国についても調べるときは、国のリストがあるとよいので、 `unique(df_gm$country)` とすると、リストが得られます。`distinct(country)` で、異なる国を選択してから、その部分をベクトルとして出力することもできます。


```r
df_gm %>% distinct(country) %>% pull()
#>   [1] Afghanistan              Albania                 
#>   [3] Algeria                  Angola                  
#>   [5] Argentina                Australia               
#>   [7] Austria                  Bahrain                 
#>   [9] Bangladesh               Belgium                 
#>  [11] Benin                    Bolivia                 
#>  [13] Bosnia and Herzegovina   Botswana                
#>  [15] Brazil                   Bulgaria                
#>  [17] Burkina Faso             Burundi                 
#>  [19] Cambodia                 Cameroon                
#>  [21] Canada                   Central African Republic
#>  [23] Chad                     Chile                   
#>  [25] China                    Colombia                
#>  [27] Comoros                  Congo, Dem. Rep.        
#>  [29] Congo, Rep.              Costa Rica              
#>  [31] Cote d'Ivoire            Croatia                 
#>  [33] Cuba                     Czech Republic          
#>  [35] Denmark                  Djibouti                
#>  [37] Dominican Republic       Ecuador                 
#>  [39] Egypt                    El Salvador             
#>  [41] Equatorial Guinea        Eritrea                 
#>  [43] Ethiopia                 Finland                 
#>  [45] France                   Gabon                   
#>  [47] Gambia                   Germany                 
#>  [49] Ghana                    Greece                  
#>  [51] Guatemala                Guinea                  
#>  [53] Guinea-Bissau            Haiti                   
#>  [55] Honduras                 Hong Kong, China        
#>  [57] Hungary                  Iceland                 
#>  [59] India                    Indonesia               
#>  [61] Iran                     Iraq                    
#>  [63] Ireland                  Israel                  
#>  [65] Italy                    Jamaica                 
#>  [67] Japan                    Jordan                  
#>  [69] Kenya                    Korea, Dem. Rep.        
#>  [71] Korea, Rep.              Kuwait                  
#>  [73] Lebanon                  Lesotho                 
#>  [75] Liberia                  Libya                   
#>  [77] Madagascar               Malawi                  
#>  [79] Malaysia                 Mali                    
#>  [81] Mauritania               Mauritius               
#>  [83] Mexico                   Mongolia                
#>  [85] Montenegro               Morocco                 
#>  [87] Mozambique               Myanmar                 
#>  [89] Namibia                  Nepal                   
#>  [91] Netherlands              New Zealand             
#>  [93] Nicaragua                Niger                   
#>  [95] Nigeria                  Norway                  
#>  [97] Oman                     Pakistan                
#>  [99] Panama                   Paraguay                
#> [101] Peru                     Philippines             
#> [103] Poland                   Portugal                
#> [105] Puerto Rico              Reunion                 
#> [107] Romania                  Rwanda                  
#> [109] Sao Tome and Principe    Saudi Arabia            
#> [111] Senegal                  Serbia                  
#> [113] Sierra Leone             Singapore               
#> [115] Slovak Republic          Slovenia                
#> [117] Somalia                  South Africa            
#> [119] Spain                    Sri Lanka               
#> [121] Sudan                    Swaziland               
#> [123] Sweden                   Switzerland             
#> [125] Syria                    Taiwan                  
#> [127] Tanzania                 Thailand                
#> [129] Togo                     Trinidad and Tobago     
#> [131] Tunisia                  Turkey                  
#> [133] Uganda                   United Kingdom          
#> [135] United States            Uruguay                 
#> [137] Venezuela                Vietnam                 
#> [139] West Bank and Gaza       Yemen, Rep.             
#> [141] Zambia                   Zimbabwe                
#> 142 Levels: Afghanistan Albania Algeria Angola ... Zimbabwe
```

このデータには 142 の国のデータがあることがわかりました。

BRICs を選んでみるとどうなるでしょうか。最近は、BRICS として、South Africa を加えることが増えてきているようです。


```r
df_gm %>% filter(country %in% c("Brazil", "Russia", "India", "China")) %>%
  ggplot(aes(x = year, y = lifeExp, color = country)) + geom_line()
```

<img src="25-transform_files/figure-html/unnamed-chunk-25-1.png" width="672" />

ロシアが含まれていないことがわかります。ロシアは、以前は、ソビエト社会主義連邦でしたから、国が変化したものは含まれていないのかもしれません。上の国のリストで見てもありませんね。2007年より新しいデータ、ロシアなども含むデータなど、実際のデータでも見てみたいですね。それは、また後ほど。

### 練習

1.  平均寿命 `lifeExp` を人口 `pop` や、一人当たりの GDP `gdpPercap` に変えて、試してみてください。
2.  ASEAN （東南アジア諸国連合）ではどうでしょうか。

-   Brunei, Cambodia, Indonesia, Laos, Malaysia, Myanmar, Philippines, Singapore.

-   このうち幾つの国がこのデータに含まれていますか。

3.  興味のある国をいくつか選んで、三つの指標について調べてみてください。

### `group_by` と `summarize`

データには大陸（`continent` ）という変数があります。幾つの大陸があり、それぞれの大陸のいくつ国のデータがこのデータには入っているでしょうか。

それぞれの大陸ごとの2007年の平均寿命の平均と中央値と最大、最小を求めてみましょう。


```r
df_gm %>% filter(year == 2007) %>% 
  group_by(continent) %>% 
  summarize(mean_lifeExp = mean(lifeExp), median_lifeExp = median(lifeExp), max_lifeExp = max(lifeExp), min_lifeExp = min(lifeExp), .groups = "keep")
#> # A tibble: 5 × 5
#> # Groups:   continent [5]
#>   continent mean_lifeExp median_lifeExp max_lifeExp
#>   <fct>            <dbl>          <dbl>       <dbl>
#> 1 Africa            54.8           52.9        76.4
#> 2 Americas          73.6           72.9        80.7
#> 3 Asia              70.7           72.4        82.6
#> 4 Europe            77.6           78.6        81.8
#> 5 Oceania           80.7           80.7        81.2
#> # ℹ 1 more variable: min_lifeExp <dbl>
```

## 練習問題

**R Markdown and `dplyr`**

-   Create an R Notebook of a Data Analysis containing the following and submit the rendered HTML file (eg. `a2_123456.nb.html`)
    1.  create an R Notebook using the R Notebook Template in Moodle, save as `a2_123456.Rmd`,
    2.  write your name and ID and the contents,
    3.  run each code block,
    4.  preview to create `a2_123456.nb.html`,
    5.  submit `a2_123456.nb.html` to Moodle.

1.  Pick data from the built-in datasets besides `cars`. (`library(help = "datasets")` or go to the site [The R Datasets Package](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html))

    -   Information of the data: Name, Description, Usage, Format, Source, References (Hint: ?cars)
    -   Use `head()`, `str()`, ..., and create at least one chart using `ggplot2` - Code Chunk.
        -   Don't forget to add `library(tidyverse)` in the first code chunk.
    -   An observation of the chart - in your own words.

2.  Load `gapminder` by `library(gapminder)`.

    -   Choose `pop` or `gdpPercap`, or both, one country in the data, a group of countries in the data.
    -   Create charts using ggplot2 with geom_line and the variables and countries chosen in 1. (See examples of the charts for `lifeExp`.)
    -   Study the data as you like.
    -   Observations and difficulties encountered.
