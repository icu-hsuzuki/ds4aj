# 数理モデル（Modeling） {#modeling}

## はじめに

データサイエンスにおいて、数理モデルを考えるとはどのようなことを意味するのでしょうか。簡単な表現は、データの（主要な）特徴の簡単な概要、またはそれを（いくつかの）数値で表現すること、と言ってもよいと思います。

![image](data/data-science.png)

その意味では、平均値や、中央値、四分位、最大値、最小値などの、代表値と言われるものも、そうですし、正規分布など、特定の分布に近い場合に、それを定める、平均値と、標準偏差の組みも、ひとつの数理モデルを与えると言えるでしょう。

ここでは、もう少し一般的な分布に関して使われる、数理モデルについて学びます。その中でも、基本的な、二変数に関する、線形モデルについてすこし、ていねいにみていきたいと思います。

簡単にいうと、X と Y という変数があったときに、X が増えると、Y も増えるとか、減るとか、X が増加すると、Y も増加するとか、減少するとかいう傾向をみたり、それが、どの程度、直線的に、増加、減少しているかを、$Y = b + m\cdot X$ と、直線の方程式で近似し（おおまかに表し）、それが、どの程度、実際のデータに近いかを表現する（あらわす数値をあたえる）というようなことです。

Y を X の関数で表す（X を定めると、Y を計算することができる）とも表現され、X を独立変数（independent variable）、Y を従属変数（dependent variable）と呼びます。むろん、X と Y の役割を逆にすることも可能なので、便宜的な名前です。また、統計学では、Y を目的変数（response variable）、X を説明変数（explanatory variable）と呼ぶ呼び方もされます。ただ、これらは、X によって、Y が定まるという、因果関係を表すという考え方が背景にあるのですが、傾向や関係性を見るという観点からは、これらの名前を使うことを避けたほうがよいとも言えますので、ここでは、独立変数、従属変数、説明変数、目的変数という言い方は、できるだけ避けたいと思います。

R では、$b$（Y 切片）は、intercept（切片）として表示され、$m$（直線の傾き）は、（変数　X に関する）slope（傾き）として表示されます。

R を使って、モデルについて表示される、数値の意味も説明したいと思います。数式での表現も書きますが、式を正確に覚えたりするよりも、大まかな意味を理解することを心がけてください。

数理モデルは、非常に多様なだけでなく（主要な）特徴は、分野ごとに必要度が異なることから、一般論として述べることには限界があります。H. ウィッカム（Hadley Wickham, el. al.）の R for Data Science の標準的な教科書でも、第一版には、基本的なことが含まれていましたが、[第二版](https://r4ds.hadley.nz) には、数理モデルは含まれていません。[Tidy Modeling with R](https://www.tmwr.org) を参照するようにとリンクがついています。

## 準備（Setup）


```r
library(tidyverse)
#> ── Attaching core tidyverse packages ──── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.3     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.0
#> ✔ ggplot2   3.4.3     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.2     
#> ── Conflicts ────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(WDI)
library(readxl)
library(tidymodels)
#> ── Attaching packages ────────────────── tidymodels 1.1.1 ──
#> ✔ broom        1.0.5     ✔ rsample      1.2.0
#> ✔ dials        1.2.0     ✔ tune         1.1.2
#> ✔ infer        1.0.5     ✔ workflows    1.1.3
#> ✔ modeldata    1.2.0     ✔ workflowsets 1.0.1
#> ✔ parsnip      1.1.1     ✔ yardstick    1.2.0
#> ✔ recipes      1.0.8     
#> ── Conflicts ───────────────────── tidymodels_conflicts() ──
#> ✖ scales::discard() masks purrr::discard()
#> ✖ dplyr::filter()   masks stats::filter()
#> ✖ recipes::fixed()  masks stringr::fixed()
#> ✖ dplyr::lag()      masks stats::lag()
#> ✖ yardstick::spec() masks readr::spec()
#> ✖ recipes::step()   masks stats::step()
#> • Use suppressPackageStartupMessages() to eliminate package startup messages
```

Tidymodels パッケージを使いますが、これは、Tidyverse と同様に、一つのパッケージではなく、パッケージ群を表します。また、ここでは、ほんの一部しか使いませんが、一応、後々のために、インストールをし、使えるように `library(tidymodels)` で、読み込んでおいてください。興味のあるかたのために、Tidymodels サイトへのリンクを付けておきます。

-   tidymodels: <https://www.tidymodels.org>

## 線形モデル入門

起動時に読み込まれる、datasets パッケージの、iris データを用いて、概要をみてみます。iris には、三種類の、あやめのデータが含まれていますが、ここでは、verginica と versicolor、すなわち、setosa 以外について扱います。


```r
df_iris0 <- as_tibble(datasets::iris) %>% filter(Species != "setosa")
```

二つの散布図を見てみます。一つ目は、X 軸が、花弁幅（はなびらのはば）、Y 軸が、花弁長（はなびらの長さ）、二つ目は、X 軸が、萼幅（がくのはば）、Y 軸が、花弁長（がくの長さ）を表した散布図です。


```r
df_iris0 |> ggplot(aes(Petal.Width, Petal.Length)) + geom_point()
```

![](28-modeling_files/figure-epub3/unnamed-chunk-3-1.png)<!-- -->


```r
df_iris0 |> ggplot(aes(Sepal.Width, Sepal.Length)) + geom_point()
```

![](28-modeling_files/figure-epub3/unnamed-chunk-4-1.png)<!-- -->

どちらも、幅（はなびらの幅や、がくの幅）が大きくなると、長さ（はなびらの長さや、がくの長さ）が大きくなる傾向があるように見えます。それは、なんとなく直感的にも自然ですよね。種類が同じ植物のはなびらや、がくの形は、だいたい同じ（相似形にちかい）と思われるからです。（直感はとてもたいせつです。直感とあわないことがあれば、立ち止まって考えて見るようにしてください。）しかし、はなびらの散布図は、それが明らかにみてとれるだけでなく、ある直線にそって（または直線的に）増加しているように見えます。がくの散布図では、その傾向が明らかではなく（ぼんやりとしていて）、直線にそって増加しているとまでは言えないように見えます。

すこし、違った、見方をする方もおられるかもしれません。定義を明確にすることで、合意ができるように、それを、数値的に表現するのが、線形モデルを使った表現です。まずは、それぞれに、増加傾向をあらわす直線を描いてみましょう。これは、ある一定の方法で描いたもので、歴史的背景から、回帰直線（regression line）と呼ばれすが、いまは、大体、そんなものだと考えてくださって構いません。


```r
df_iris0 |> ggplot(aes(Petal.Width, Petal.Length)) + geom_point() + geom_smooth(method="lm",formula=y~x, se=FALSE)
```

![](28-modeling_files/figure-epub3/unnamed-chunk-5-1.png)<!-- -->


```r
df_iris0 |> ggplot(aes(Sepal.Width, Sepal.Length)) + geom_point() + geom_smooth(method="lm",formula=y~x, se=FALSE)
```

![](28-modeling_files/figure-epub3/unnamed-chunk-6-1.png)<!-- -->

たしかに、この二つの散布図と、直線を見ると、それぞれ（はなびらや、がくの）幅が増加すると長さも増加する傾向にあるようです。そこで、今度は、直線に近い、増加傾向にあると仮定して、適切な直線の方程式を求めてみます。それは、次のようにして求めることができます。

### 線形モデルの例（Linear Models by Examples）

#### Linear Model: Petal.Length \~ Petal.Width

はなびらの長さを、はなびらの幅を変数とする、直線の方程式で近似してみます。


```r
df_iris0 |> lm(Petal.Length ~ Petal.Width, data = _)
#> 
#> Call:
#> lm(formula = Petal.Length ~ Petal.Width, data = df_iris0)
#> 
#> Coefficients:
#> (Intercept)  Petal.Width  
#>       2.224        1.600
```

Call の部分は、「このような（X を Petal.Width として、Y を Petal.Length の一次式、すなわち、$Y = b + m\cdot X$ と表わそうと）線形モデルで考えると」といった、意味です。

Coefficients は、係数の意味です。次に、(Intercept) が、2.224、Petal.Width が 1.600 とありますから、1.600 が 一次式で表したときの Petal.Width の係数で、式で書くと次のようになります。

Formula: $\text{Petal.Length} = 2.224 + 1.600\cdot \text{Petal.Width}$

Petal.Width の範囲が限られていますから、Y 切片は確認できませんが、だいたい見当が付きますし、傾きは、X が 1 大きくなると、Y がどれぐらい大きくなるかという数ですから、だいたい、見当がつきますね。

![](28-modeling_files/figure-epub3/unnamed-chunk-8-1.png)<!-- -->

#### Linear Model: Sepal.Length \~ Sepal.Width

がくの長さを、がくの幅を変数とする、直線の方程式で近似してみます。


```r
df_iris0 |> lm(Sepal.Length ~ Sepal.Width, data = _)
#> 
#> Call:
#> lm(formula = Sepal.Length ~ Sepal.Width, data = df_iris0)
#> 
#> Coefficients:
#> (Intercept)  Sepal.Width  
#>       3.093        1.103
```

式は、次のようになっていることがわかります。

Formula: $\text{Sepal.Length} = 3.093 + 1.103\cdot \text{Sepal.Width}$

下のグラフから、だいたいの、Y 切片や、傾きを読み取って、上の式と比較してください。

![](28-modeling_files/figure-epub3/unnamed-chunk-10-1.png)<!-- -->

#### 決定係数（R squared）

日本語では、決定係数と呼ばれることが多いようですが、R squared の意味を簡単に説明します。

まず、決定係数（R squared）は、0 と 1 の間の値を取ります。モデルの当てはまり具合を表す数とも表現されます。

The coefficient of determination R2 represents the strength of fit of the model.

このモデル（現在の場合は X の関数として、Y の値をおおまかに表現する線形モデル）によって、どのていど、実際の値が決まるかをあらわす一つの指標です。この値が、1 のときは、ピッタリ合致していることを意味し、0 のときは、X の値に依存しない、平均値と、変わらないという意味です。たとえば、はなびらモデルでは、下のようになりますから、68％ 程度決定する、または、適合するという言い方をします。がくモデルの場合には、31% 程度決定する、または、適合するという言い方をします。はなびらモデルのほうが、がくモデルよりもより直線的といいうことを表す数ということになります。

(Multiple) R Squared: a value between 0 and 1, the model's strength. It is a measurement of the model quality. If the value is close to 1, the model quality is high. If it is close to 0, the model quality is low.

Petal.Length \~ Petal.Width: R squared = 0.6779 - 68%


```r
df_iris0 |> lm(Petal.Length ~ Petal.Width, data = _) |> summary()
#> 
#> Call:
#> lm(formula = Petal.Length ~ Petal.Width, data = df_iris0)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -0.9842 -0.3043 -0.1043  0.2407  1.2755 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   2.2240     0.1926   11.55   <2e-16 ***
#> Petal.Width   1.6003     0.1114   14.36   <2e-16 ***
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.4709 on 98 degrees of freedom
#> Multiple R-squared:  0.6779,	Adjusted R-squared:  0.6746 
#> F-statistic: 206.3 on 1 and 98 DF,  p-value: < 2.2e-16
```

Sepal.Length \~ Sepal.Width: R squared = 0.3068 - 31%


```r
df_iris0 |> lm(Sepal.Length ~ Sepal.Width, data =_) |> summary()
#> 
#> Call:
#> lm(formula = Sepal.Length ~ Sepal.Width, data = df_iris0)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -1.0032 -0.3877 -0.0774  0.3200  1.7381 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   3.0934     0.4844   6.387 5.70e-09 ***
#> Sepal.Width   1.1033     0.1675   6.585 2.27e-09 ***
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.5547 on 98 degrees of freedom
#> Multiple R-squared:  0.3068,	Adjusted R-squared:  0.2997 
#> F-statistic: 43.36 on 1 and 98 DF,  p-value: 2.27e-09
```

上のように、summary() 関数をつかうと、Multiple R-squared や、Adjusted R-squared と R squared 値は、出てきますが、現在の場合は、Multiple R-squared が、決定係数だと考えてください。

いまは、Y を、X の関数として表しましたが、X ではなく、X~1~、X~2~、などとたくさんの変数を使って、表し、全体のデータ（観測値）の個数が、あまり多くないときは、Multiple R-squared よりも、Adjusted R-squared のほうが、より適切になってくるばあいはあるので、このように、2つの数が書かれています。

また、決定係数（R squared）は、線形モデル以外にも使えますので、モデルの適合性を表す、たいせつな指標のひとつと理解しておいてください。

summary() には、他にもたくさんの、値が出ています。あとで、それぞれについて、簡単に見ていきたいと思います。

決定係数が1に近いと良い（強い）モデルで、0に近いと悪い（弱い）モデルということになりますが、どの程度ならば、良いモデルかは一概に言えません。分野にもよりますが、0.3 より小さければ、あまりよいモデルだとは言えず、0.7 より大きければ、よいモデルのひとつだと考えても良いのではないかと思います。

上の2つのモデルは、微妙ですが、花びらモデルのほうが、良い（より適合した）モデルだと表現できます。

![](28-modeling_files/figure-epub3/unnamed-chunk-13-1.png)<!-- -->

### 線形モデルの基礎（Linear Model Basics）: y \~ x

R では、線形モデルを次のように定めます。`y~x` は、x の関数で、y を表すという意味です。パイプを使うときは、その下の式のようになります。パイプは原則として、最初の変数として、一つ前の出力が読み込まれますが、`lm(arg1, arg2)` の場合には、`arg2` 2つ目の変数が、データですから、それを表すために、`data = _` (または、%\>% の場合には、そこに、ピリオッド（半角））を書き、そのことを示します。場所指定の '\_' （または '.'） (place holder) と言います。

```         
lm(y~x, data)
```

```         
data |> lm(y~x, data=_) # data = をつけないとエラーになります
```

```         
data %>% lm(y~x, .)
```

y 切片や、傾きが得られます。（y-intercept, and slope: rate of increase or decrease）

モデルのより詳細な情報は、summry() によって得ることができます。パイプを使う場合には、その次のコードとなります。

```         
summary(lm(y~x, data))
```

```         
data |> lm(y~x, .) |> summary()
```

具体的な例から、それぞれの数値がなにを表しているのか見ていきましょう。


```r
df1 <- data.frame(x = c(1,2,3,4), y = c(1,0.5,2, 1.5))
ybar <- mean(df1$y)
mod1 <- lm(y~x, df1)
augment(mod1) |> ggplot() + geom_point(aes(x,y)) + geom_smooth(aes(x,y), formula = y~x, method = "lm", se = FALSE) + geom_hline(yintercept = ybar, linetype="longdash", col = "red") + geom_point(aes(x, ybar), shape=4) + geom_point(aes(x, .fitted), shape =9, size=2) + geom_text(aes(x, ybar, label = paste0("(",x,",",1.25,")")), nudge_y = -0.1, col = "red") + geom_text(aes(x, .fitted, label = paste0("(",x,",",.fitted,")")), nudge_y = -0.1, col = "blue") + geom_text(aes(x, y, label = paste0("(",x,",",y,")")), nudge_y = -0.1) 
```

-   $(x_1, y_1)$, $(x_2,y_2)$, $(x_3, y_3)$, $(x_4, y_4)$: Data points - データの4つの点をあらわす黒点
-   $\bar{y}$: mean of y = $(y_1 + y_2 + y_3 + y_4)/4$. （相加）平均値を表す赤線
-   $\hat{y}_i$: prediction at $x_i$, 線形モデルの一次式で与えられる値
    -   $(x_1, \hat{y}_1)$, $(x_2, \hat{y}_2)$, $(x_3, \hat{y}_3)$, $(x_4, \hat{y}_4)$ are on the regression line. 回帰直線上の◇で表された点
-   $y_1-\hat{y}_1$, $y_2-\hat{y}_2$, $y_2-\hat{y}_2$, $y_2-\hat{y}_2$ are called residues. 実際の値から、モデルでの予測値を引いたもので、残差と呼ばれます

![](28-modeling_files/figure-epub3/unnamed-chunk-15-1.png)<!-- -->

線形モデルの一次式で与えられる値（fitted values）は次のようにしても表示できます。


```r
mod1$fitted.values
#>   1   2   3   4 
#> 0.8 1.1 1.4 1.7
```

#### 決定係数（R Squared）

$SS_{tot}$ は、実際の値から平均値を引いたものを、二乗して足したものです。二乗してあるので、かならず正（正確には非負）になります。

$SS_{res}$ は、実際の値から（この線形）モデルによって予測したあたいを引いたものを、二乗して足したものです。二乗してあるので、かならず正（正確には非負）になります。

$R^2$ は、一番下の式で定義されます。完全に予測が実際の値と一致していると、$SS_{res}$ は、0 になりますから、その場合は、商の分子が 0 で、$R^2$ の値は、1 になります。

線形モデルの、直線の方程式は、直線の中で、$SS_{res}$ が一番小さくなるものを（最小二乗法という方法で）選んであり、平均を通る直線をから計算したものよりは、小さくなるので、商の部分は、1 以下、すなわち、$R^2$ の値は、0 以上 1 以下となります。

$$SS_{tot} = (1-1.25)^2 + (0.5-1.25)^2 + (2-1.25)^2 + (1.5-1.25)^2 = 1.25$$ $$SS_{res} = (1-0.8)^2 + (0.5-1.1)^2 + (2-1.4)^2 + (1.5-1.7)^2 = 0.8$$ $$R^2 = 1 - \frac{SS_{res}}{SS_{tot}} = 1- \frac{0.8}{1.25} = 0.36.$$

実際に、`mod1` の `summary()` から値を取り出す方法をいくつか書いておきます。`glance` は、`tidymodel` に含まれる、パッケージ `broom` の関数で、モデルの概要（summary）を、表（この場合は、tidyverse の標準の tibble）として出力するものです。


```r
summary(mod1)$r.squared
#> [1] 0.36
```


```r
mod1 |> summary() |> glance()
#> # A tibble: 1 × 8
#>   r.squared adj.r.squared sigma statistic p.value    df
#>       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>
#> 1      0.36        0.0400 0.632      1.12     0.4     1
#> # ℹ 2 more variables: df.residual <int>, nobs <dbl>
```


```r
mod1 |> glance() |> pull(r.squared)
#> [1] 0.36
```


```r
mod1 |> glance() |> select(`R Squared` = r.squared)
#> # A tibble: 1 × 1
#>   `R Squared`
#>         <dbl>
#> 1        0.36
```

### モデル概要

一般的な場合に、それぞれの数値を表す数式（Mathematical Formula）と簡単な説明を記します。

-   $x = c(x_1, x_2, \ldots, x_n)$ : X 変数（the X (independent) variable） 例 Petal.Width
-   $y = c(y_1, y_2, \ldots, y_n)$ ：Y 変数（the Y (dependent) variable） 例 Petal.Length
-   $\mbox{pred} = c(\hat{y}_1, \hat{y}_2, \ldots, \hat{y}_n)$ ：モデル予測値（the predicted values by a (linear regression) model）例 $\hat{y}_i = b + m\cdot x_i$

例は、はなびらモデルを使って説明します。


```r
df_iris0 |> lm(Petal.Length ~ Petal.Width, data = _) %>% summary()
#> 
#> Call:
#> lm(formula = Petal.Length ~ Petal.Width, data = df_iris0)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -0.9842 -0.3043 -0.1043  0.2407  1.2755 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   2.2240     0.1926   11.55   <2e-16 ***
#> Petal.Width   1.6003     0.1114   14.36   <2e-16 ***
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.4709 on 98 degrees of freedom
#> Multiple R-squared:  0.6779,	Adjusted R-squared:  0.6746 
#> F-statistic: 206.3 on 1 and 98 DF,  p-value: < 2.2e-16
```

#### Call（適用されたモデル）

使われたモデルの定義式（The function and the parameters used to create the model）

#### Residuals（残差）

残差は、実際の値から、予測値を差し引いた値（Difference between what the model predicted and the actual value of y）：$e_i = y_i - \hat{y}_i$

その、分布の、最小値、第一四分位、中央値、第三四分位、最大値が表示されています。次のようにしても、表示できます。

Tidymodels に含まれる、`broom` パッケージの `augument()` 関数を使うと、予測値 predicted values (pred) または、fitted values は、.fitted 列に、残差 residues は、.resid に追加されます。（他の列については、さしあたって不要ですが、Help などを参照してください。）


```r
df_iris0 |> lm(Petal.Length ~ Petal.Width, data = _) |> augment()
#> # A tibble: 100 × 8
#>    Petal.Length Petal.Width .fitted  .resid   .hat .sigma
#>           <dbl>       <dbl>   <dbl>   <dbl>  <dbl>  <dbl>
#>  1          4.7         1.4    4.46  0.236  0.0143  0.473
#>  2          4.5         1.5    4.62 -0.124  0.0117  0.473
#>  3          4.9         1.5    4.62  0.276  0.0117  0.473
#>  4          4           1.3    4.30 -0.304  0.0179  0.472
#>  5          4.6         1.5    4.62 -0.0244 0.0117  0.473
#>  6          4.5         1.3    4.30  0.196  0.0179  0.473
#>  7          4.7         1.6    4.78 -0.0844 0.0103  0.473
#>  8          3.3         1      3.82 -0.524  0.0356  0.470
#>  9          4.6         1.3    4.30  0.296  0.0179  0.472
#> 10          3.9         1.4    4.46 -0.564  0.0143  0.470
#> # ℹ 90 more rows
#> # ℹ 2 more variables: .cooksd <dbl>, .std.resid <dbl>
```

したがってそれを使えば、Residuals の部分の値は、次のようにして得られます。


```r
df_iris0 |> lm(Petal.Length ~ Petal.Width, data = _) |> augment() |>
  pull(.resid) |> summary()
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#> -0.9843 -0.3043 -0.1043  0.0000  0.2407  1.2755
```

$$
\begin{aligned}
\mbox{$x$ の平均：} mean(x) & = \frac{1}{n}\sum_i x_i \\
\mbox{$y$ の平均：} mean(y) & = \frac{1}{n}\sum_i y_i \\
\mbox{$x$ の分散：} var(x) & = \frac{1}{n}\sum_i(x_i-mean(x))^2 \\
\mbox{$y$ の分散：} var(y) & = \frac{1}{n}\sum_i(y_i-mean(y))^2 \\
\mbox{$x$ と $y$ の共分散：} cov(x) & = \frac{1}{n}\sum_i(x_i-mean(x))(y_i-mean(y)) \\
\mbox{$x$ と $y$ の相関係数：} cor(x) & = \frac{cov(x,y)}{\sqrt{var(x)}\sqrt{var(y)}}\\
\mbox{回帰直線の係数： slope}  &= \frac{cov(x,y)}{var(x)} = \frac{cor(x,y)\sqrt{var(y)}}{\sqrt{var(x)}}\\
\mbox{全平方和 total sum of squares：} &SS_{tot} = \sum_{i}(y_i-mean(y))^2\\
\mbox{残差平方和 residual sum of squares：} &SS_{res} = \sum_{i}(y_i-\mbox{pred}_i)^2 \\ &= \sum_{i}(y_i-\hat{y}_i)^2\\
\mbox{決定係数 R squared：} R^2 & = 1 - \frac{SS_{res}}{SS_{tot}} = cor(x,y)^2
\end{aligned}
$$

#### 自由度修正済み決定係数（Adjusted R Squared）

$$\text{Adjusted }R^2 = 1- \frac{(1-R^2)(n-1)}{n-k-1}$$ $n$: 行数（観測値の数）number of observations, the number of rows

$k$: number of variables used for prediction

#### Coefficients

Tidymodels に含まれる、`broom` パッケージの `tody()` 関数を使うと、係数の部分を表として取り出すことができます。


```r
df_iris0 |> lm(Petal.Length ~ Petal.Width, data = _) |> tidy()
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 (Intercept)     2.22     0.193      11.5 5.54e-20
#> 2 Petal.Width     1.60     0.111      14.4 7.57e-26
```

#### Significant

Tidymodels に含まれる、`broom` パッケージの `glance()` 関数を使うと、残りの値が表示できます。


```r
df_iris0 |> lm(Petal.Length ~ Petal.Width, data = _) |> glance()
#> # A tibble: 1 × 12
#>   r.squared adj.r.squared sigma statistic  p.value    df
#>       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <dbl>
#> 1     0.678         0.675 0.471      206. 7.57e-26     1
#> # ℹ 6 more variables: logLik <dbl>, AIC <dbl>, BIC <dbl>,
#> #   deviance <dbl>, df.residual <int>, nobs <int>
```


```r
df_iris0 %>% select(1:4) %>% cor()
#>              Sepal.Length Sepal.Width Petal.Length
#> Sepal.Length    1.0000000   0.5538548    0.8284787
#> Sepal.Width     0.5538548   1.0000000    0.5198023
#> Petal.Length    0.8284787   0.5198023    1.0000000
#> Petal.Width     0.5937094   0.5662025    0.8233476
#>              Petal.Width
#> Sepal.Length   0.5937094
#> Sepal.Width    0.5662025
#> Petal.Length   0.8233476
#> Petal.Width    1.0000000
```


```r
cormat <- df_iris0 %>% select(1:4) %>% cor()
cormat*cormat
#>              Sepal.Length Sepal.Width Petal.Length
#> Sepal.Length    1.0000000   0.3067552    0.6863769
#> Sepal.Width     0.3067552   1.0000000    0.2701944
#> Petal.Length    0.6863769   0.2701944    1.0000000
#> Petal.Width     0.3524909   0.3205853    0.6779013
#>              Petal.Width
#> Sepal.Length   0.3524909
#> Sepal.Width    0.3205853
#> Petal.Length   0.6779013
#> Petal.Width    1.0000000
```


```r
df_iris <- datasets::iris
```


```r
as_tibble(df_iris) %>% filter(Species == "setosa") %>% select(-5) %>% cor()
#>              Sepal.Length Sepal.Width Petal.Length
#> Sepal.Length    1.0000000   0.7425467    0.2671758
#> Sepal.Width     0.7425467   1.0000000    0.1777000
#> Petal.Length    0.2671758   0.1777000    1.0000000
#> Petal.Width     0.2780984   0.2327520    0.3316300
#>              Petal.Width
#> Sepal.Length   0.2780984
#> Sepal.Width    0.2327520
#> Petal.Length   0.3316300
#> Petal.Width    1.0000000
```


```r
as_tibble(df_iris) %>% filter(Species == "virginica") %>% select(-5) %>% cor()
#>              Sepal.Length Sepal.Width Petal.Length
#> Sepal.Length    1.0000000   0.4572278    0.8642247
#> Sepal.Width     0.4572278   1.0000000    0.4010446
#> Petal.Length    0.8642247   0.4010446    1.0000000
#> Petal.Width     0.2811077   0.5377280    0.3221082
#>              Petal.Width
#> Sepal.Length   0.2811077
#> Sepal.Width    0.5377280
#> Petal.Length   0.3221082
#> Petal.Width    1.0000000
```


```r
as_tibble(df_iris) %>% filter(Species == "versicolor") %>% select(-5) %>% cor()
#>              Sepal.Length Sepal.Width Petal.Length
#> Sepal.Length    1.0000000   0.5259107    0.7540490
#> Sepal.Width     0.5259107   1.0000000    0.5605221
#> Petal.Length    0.7540490   0.5605221    1.0000000
#> Petal.Width     0.5464611   0.6639987    0.7866681
#>              Petal.Width
#> Sepal.Length   0.5464611
#> Sepal.Width    0.6639987
#> Petal.Length   0.7866681
#> Petal.Width    1.0000000
```


```r
as_tibble(df_iris) %>% filter(Species == "virginica") %>% ggplot(aes(Sepal.Length, Petal.Length)) + geom_point() + geom_smooth(method = "lm", formula = y~x, se = FALSE)
```

![](28-modeling_files/figure-epub3/unnamed-chunk-32-1.png)<!-- -->


```r
as_tibble(df_iris) %>% filter(Species == "virginica") %>% lm(Petal.Length ~ Sepal.Length, .) %>% glance() %>% pull(r.squared) %>% sqrt()
#> [1] 0.8642247
```

Correlations of the data suggest the possible strength of linear model y \~ x.


```r
df_iris %>% select(-5) %>% cor()
#>              Sepal.Length Sepal.Width Petal.Length
#> Sepal.Length    1.0000000  -0.1175698    0.8717538
#> Sepal.Width    -0.1175698   1.0000000   -0.4284401
#> Petal.Length    0.8717538  -0.4284401    1.0000000
#> Petal.Width     0.8179411  -0.3661259    0.9628654
#>              Petal.Width
#> Sepal.Length   0.8179411
#> Sepal.Width   -0.3661259
#> Petal.Length   0.9628654
#> Petal.Width    1.0000000
```

## 世界開発指標（WDI）からの例

-   SP.DYN.LE00.IN: Life expectancy at birth, total (years)


```r
wdi_lifeExp <- WDI(indicator = c(lifeExp = "SP.DYN.LE00.IN"))
```




```
#> Rows: 16758 Columns: 5
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr (3): country, iso2c, iso3c
#> dbl (2): year, lifeExp
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
wdi_lifeExp %>% filter(country == "World") %>% drop_na(lifeExp) %>%
  ggplot(aes(year, lifeExp)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
#> `geom_smooth()` using formula = 'y ~ x'
```

![](28-modeling_files/figure-epub3/unnamed-chunk-38-1.png)<!-- -->


```r
wdi_lifeExp %>% lm(lifeExp ~ year, .) %>% summary()
#> 
#> Call:
#> lm(formula = lifeExp ~ year, data = .)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -51.173  -7.150   1.741   7.794  18.782 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -5.383e+02  8.583e+00  -62.71   <2e-16 ***
#> year         3.027e-01  4.312e-03   70.20   <2e-16 ***
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 9.707 on 15864 degrees of freedom
#>   (892 observations deleted due to missingness)
#> Multiple R-squared:  0.237,	Adjusted R-squared:  0.237 
#> F-statistic:  4928 on 1 and 15864 DF,  p-value: < 2.2e-16
```

$$lifeExp \sim -557.4 + 0.3123 \cdot year$$ Each year, life expectancy at birth increases approximately 0.3123 years. R-squared of this model is 0.2392, and the model explains 24%.


```r
wdi_lifeExp %>% filter(country == "World", year >= 1962, year <= 2019) %>% drop_na(lifeExp) %>% lm(lifeExp ~ year, .) %>% summary()
#> 
#> Call:
#> lm(formula = lifeExp ~ year, data = .)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -1.00776 -0.29546 -0.04527  0.37540  0.82117 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -5.537e+02  7.841e+00  -70.62   <2e-16 ***
#> year         3.107e-01  3.939e-03   78.89   <2e-16 ***
#> ---
#> Signif. codes:  
#> 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.5022 on 56 degrees of freedom
#> Multiple R-squared:  0.9911,	Adjusted R-squared:  0.9909 
#> F-statistic:  6224 on 1 and 56 DF,  p-value: < 2.2e-16
```

## BRICs


```r
mod_brics <- wdi_lifeExp %>% filter(country %in% c("Brazil", "Russian Federation", "India", "China")) %>% drop_na(lifeExp) %>% lm(lifeExp ~ year, .) %>% summary()
mod_brics$r.squared
#> [1] 0.5666988
```


```r
wdi_lifeExp %>% filter(country %in% c("Brazil", "Russian Federation", "India", "China")) %>% drop_na(lifeExp) %>%
  ggplot(aes(year, lifeExp)) + geom_point() + geom_smooth(formula = y~x, method = "lm", se = FALSE)
```

![](28-modeling_files/figure-epub3/unnamed-chunk-43-1.png)<!-- -->


```r
wdi_lifeExp %>% filter(country %in% c("Brazil", "Russian Federation", "India", "China")) %>% drop_na(lifeExp) %>%
  ggplot(aes(year, lifeExp, color = country)) + geom_point(aes(shape = country)) + geom_smooth(formula = y~x, method = "lm", se = FALSE)
```

![](28-modeling_files/figure-epub3/unnamed-chunk-44-1.png)<!-- -->

Need to work


```r
country_model <- function(df) {
  lm(lifeExp ~ year, data = df)
}

by_country <- wdi_lifeExp %>% filter(country %in% c("Brazil", "Russian Federation", "India", "China")) %>% drop_na(lifeExp) %>% group_by(country) %>% nest()

by_country <- by_country %>% 
  mutate(model = map(data, country_model))

by_country %>% 
  mutate(tidy = map(model, broom::tidy)) %>% 
  unnest(tidy)

by_country %>% 
  mutate(glance = map(model, broom::glance)) %>% 
  unnest(glance)
```

## Government Expenditure, (% of GDP)


```r
wdi_cache <- read_rds("./data/wdi_cache.RData")
```


```r
WDIsearch("expenditure", "name", cache = wdi_cache) %>% 
  inner_join(WDIsearch("% of GDP", "name", cache = wdi_cache))
#> Joining with `by = join_by(indicator, name)`
#>               indicator
#> 1    GB.XPD.DEFN.GDP.ZS
#> 2     GB.XPD.RSDV.GD.ZS
#> 3     GB.XPD.TOTL.GD.ZS
#> 4    GB.XPD.TOTL.GDP.ZS
#> 5     IE.ICT.TOTL.GD.ZS
#> 6     MS.MIL.XPND.GD.ZS
#> 7        NE.CON.GOVT.ZS
#> 8        NE.CON.PETC.ZS
#> 9        NE.CON.PRVT.ZS
#> 10       NE.CON.TETC.ZS
#> 11       NE.CON.TOTL.ZS
#> 12       NE.DAB.TOTL.ZS
#> 13    NY.GEN.AEDU.GD.ZS
#> 14    SE.XPD.PRIM.PC.ZS
#> 15    SE.XPD.SECO.PC.ZS
#> 16    SE.XPD.TERT.PC.ZS
#> 17    SE.XPD.TOTL.GD.ZS
#> 18    SH.XPD.CHEX.GD.ZS
#> 19    SH.XPD.GHED.GD.ZS
#> 20    SH.XPD.KHEX.GD.ZS
#> 21       SH.XPD.PRIV.ZS
#> 22       SH.XPD.PUBL.ZS
#> 23       SH.XPD.TOTL.ZS
#> 24     UIS.XGDP.0.FSGOV
#> 25     UIS.XGDP.1.FSGOV
#> 26    UIS.XGDP.23.FSGOV
#> 27 UIS.XGDP.2T4.V.FSGOV
#> 28     UIS.XGDP.4.FSGOV
#> 29    UIS.XGDP.56.FSGOV
#>                                                                                                        name
#> 1                                                                            Defense expenditure (% of GDP)
#> 2                                                           Research and development expenditure (% of GDP)
#> 3                                                                             Expenditure, total (% of GDP)
#> 4                                                                              Total expenditure (% of GDP)
#> 5                                           Information and communication technology expenditure (% of GDP)
#> 6                                                                           Military expenditure (% of GDP)
#> 7                                               General government final consumption expenditure (% of GDP)
#> 8                                                  Household final consumption expenditure, etc. (% of GDP)
#> 9                                            Households and NPISHs final consumption expenditure (% of GDP)
#> 10                                                           Final consumption expenditure, etc. (% of GDP)
#> 11                                                                 Final consumption expenditure (% of GDP)
#> 12                                                                    Gross national expenditure (% of GDP)
#> 13                                                        Genuine savings: education expenditure (% of GDP)
#> 14                                        Government expenditure per student, primary (% of GDP per capita)
#> 15                                      Government expenditure per student, secondary (% of GDP per capita)
#> 16                                       Government expenditure per student, tertiary (% of GDP per capita)
#> 17                                                    Government expenditure on education, total (% of GDP)
#> 18                                                                    Current health expenditure (% of GDP)
#> 19                                                Domestic general government health expenditure (% of GDP)
#> 20                                                                    Capital health expenditure (% of GDP)
#> 21                                                                   Health expenditure, private (% of GDP)
#> 22                                                                    Health expenditure, public (% of GDP)
#> 23                                                                     Health expenditure, total (% of GDP)
#> 24                                          Government expenditure on pre-primary education as % of GDP (%)
#> 25                                              Government expenditure on primary education as % of GDP (%)
#> 26                                            Government expenditure on secondary education as % of GDP (%)
#> 27 Government expenditure on secondary and post-secondary non-tertiary vocational education as % of GDP (%)
#> 28                          Government expenditure on post-secondary non-tertiary education as % of GDP (%)
#> 29                                             Government expenditure on tertiary education as % of GDP (%)
```


```r
wdi_cache$series %>% filter(grepl("expenditure", name), grepl("% of GDP", name))
#>               indicator
#> 1    GB.XPD.DEFN.GDP.ZS
#> 2     GB.XPD.RSDV.GD.ZS
#> 3    GB.XPD.TOTL.GDP.ZS
#> 4     IE.ICT.TOTL.GD.ZS
#> 5     MS.MIL.XPND.GD.ZS
#> 6        NE.CON.GOVT.ZS
#> 7        NE.CON.PETC.ZS
#> 8        NE.CON.PRVT.ZS
#> 9        NE.CON.TETC.ZS
#> 10       NE.CON.TOTL.ZS
#> 11       NE.DAB.TOTL.ZS
#> 12    NY.GEN.AEDU.GD.ZS
#> 13    SE.XPD.PRIM.PC.ZS
#> 14    SE.XPD.SECO.PC.ZS
#> 15    SE.XPD.TERT.PC.ZS
#> 16    SE.XPD.TOTL.GD.ZS
#> 17    SH.XPD.CHEX.GD.ZS
#> 18    SH.XPD.GHED.GD.ZS
#> 19    SH.XPD.KHEX.GD.ZS
#> 20       SH.XPD.PRIV.ZS
#> 21       SH.XPD.PUBL.ZS
#> 22       SH.XPD.TOTL.ZS
#> 23     UIS.XGDP.0.FSGOV
#> 24     UIS.XGDP.1.FSGOV
#> 25    UIS.XGDP.23.FSGOV
#> 26 UIS.XGDP.2T4.V.FSGOV
#> 27     UIS.XGDP.4.FSGOV
#> 28    UIS.XGDP.56.FSGOV
#>                                                                                                        name
#> 1                                                                            Defense expenditure (% of GDP)
#> 2                                                           Research and development expenditure (% of GDP)
#> 3                                                                              Total expenditure (% of GDP)
#> 4                                           Information and communication technology expenditure (% of GDP)
#> 5                                                                           Military expenditure (% of GDP)
#> 6                                               General government final consumption expenditure (% of GDP)
#> 7                                                  Household final consumption expenditure, etc. (% of GDP)
#> 8                                            Households and NPISHs final consumption expenditure (% of GDP)
#> 9                                                            Final consumption expenditure, etc. (% of GDP)
#> 10                                                                 Final consumption expenditure (% of GDP)
#> 11                                                                    Gross national expenditure (% of GDP)
#> 12                                                        Genuine savings: education expenditure (% of GDP)
#> 13                                        Government expenditure per student, primary (% of GDP per capita)
#> 14                                      Government expenditure per student, secondary (% of GDP per capita)
#> 15                                       Government expenditure per student, tertiary (% of GDP per capita)
#> 16                                                    Government expenditure on education, total (% of GDP)
#> 17                                                                    Current health expenditure (% of GDP)
#> 18                                                Domestic general government health expenditure (% of GDP)
#> 19                                                                    Capital health expenditure (% of GDP)
#> 20                                                                   Health expenditure, private (% of GDP)
#> 21                                                                    Health expenditure, public (% of GDP)
#> 22                                                                     Health expenditure, total (% of GDP)
#> 23                                          Government expenditure on pre-primary education as % of GDP (%)
#> 24                                              Government expenditure on primary education as % of GDP (%)
#> 25                                            Government expenditure on secondary education as % of GDP (%)
#> 26 Government expenditure on secondary and post-secondary non-tertiary vocational education as % of GDP (%)
#> 27                          Government expenditure on post-secondary non-tertiary education as % of GDP (%)
#> 28                                             Government expenditure on tertiary education as % of GDP (%)
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          description
#> 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
#> 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Gross domestic expenditures on research and development (R&D), expressed as a percent of GDP. They include both capital and current expenditures in the four main sectors: Business enterprise, Government, Higher education and Private non-profit. R&D covers basic research, applied research, and experimental development.
#> 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
#> 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Information and communications technology expenditures include computer hardware (computers, storage devices, printers, and other peripherals); computer software (operating systems, programming tools, utilities, applications, and internal software development); computer services (information technology consulting, computer and network systems integration, Web hosting, data processing services, and other services); and communications services (voice and data communications services) and wired and wireless communications equipment.
#> 5  Military expenditures data from SIPRI are derived from the NATO definition, which includes all current and capital expenditures on the armed forces, including peacekeeping forces; defense ministries and other government agencies engaged in defense projects; paramilitary forces, if these are judged to be trained and equipped for military operations; and military space activities. Such expenditures include military and civil personnel, including retirement pensions of military personnel and social services for personnel; operation and maintenance; procurement; military research and development; and military aid (in the military expenditures of the donor country). Excluded are civil defense and current expenditures for previous military activities, such as for veterans' benefits, demobilization, conversion, and destruction of weapons. This definition cannot be applied for all countries, however, since that would require much more detailed information than is available about what is included in military budgets and off-budget military expenditure items. (For example, military budgets might or might not cover civil defense, reserves and auxiliary forces, police and paramilitary forces, dual-purpose forces such as military and civilian police, military grants in kind, pensions for military personnel, and social security contributions paid by one part of government to another.)
#> 6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               General government final consumption expenditure (formerly general government consumption) includes all government current expenditures for purchases of goods and services (including compensation of employees). It also includes most expenditures on national defense and security, but excludes government military expenditures that are part of government capital formation.
#> 7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Household final consumption expenditure (formerly private consumption) is the market value of all goods and services, including durable products (such as cars, washing machines, and home computers), purchased by households. It excludes purchases of dwellings but includes imputed rent for owner-occupied dwellings. It also includes payments and fees to governments to obtain permits and licenses. Here, household consumption expenditure includes the expenditures of nonprofit institutions serving households, even when reported separately by the country. This item also includes any statistical discrepancy in the use of resources relative to the supply of resources.
#> 8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Household final consumption expenditure (formerly private consumption) is the market value of all goods and services, including durable products (such as cars, washing machines, and home computers), purchased by households. It excludes purchases of dwellings but includes imputed rent for owner-occupied dwellings. It also includes payments and fees to governments to obtain permits and licenses. Here, household consumption expenditure includes the expenditures of nonprofit institutions serving households, even when reported separately by the country. This item also includes any statistical discrepancy in the use of resources relative to the supply of resources.
#> 9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Final consumption expenditure (formerly total consumption) is the sum of household final consumption expenditure (private consumption) and general government final consumption expenditure (general government consumption). This estimate includes any statistical discrepancy in the use of resources relative to the supply of resources.
#> 10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Final consumption expenditure (formerly total consumption) is the sum of household final consumption expenditure (private consumption) and general government final consumption expenditure (general government consumption). This estimate includes any statistical discrepancy in the use of resources relative to the supply of resources.
#> 11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Gross national expenditure (formerly domestic absorption) is the sum of household final consumption expenditure (formerly private consumption), general government final consumption expenditure (formerly general government consumption), and gross capital formation (formerly gross domestic investment).
#> 12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
#> 13                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Government expenditure per student is the average general government expenditure (current, capital, and transfers) per student in the given level of education, expressed as a percentage of GDP per capita.
#> 14                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Government expenditure per student is the average general government expenditure (current, capital, and transfers) per student in the given level of education, expressed as a percentage of GDP per capita.
#> 15                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Government expenditure per student is the average general government expenditure (current, capital, and transfers) per student in the given level of education, expressed as a percentage of GDP per capita.
#> 16                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            General government expenditure on education (current, capital, and transfers) is expressed as a percentage of GDP. It includes expenditure funded by transfers from international sources to government. General government usually refers to local, regional and central governments.
#> 17                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Level of current health expenditure expressed as a percentage of GDP.  Estimates of current health expenditures include healthcare goods and services consumed during each year. This indicator does not include capital health expenditures such as buildings, machinery, IT and stocks of vaccines for emergency or outbreaks.
#> 18                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Public expenditure on health from domestic sources as a share of the economy as measured by GDP.
#> 19                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  Level of capital investments on health expressed as a percentage of GDP.  Capital health investments include health infrastructure (buildings, machinery, IT) and stocks of vaccines for emergency or outbreaks.
#> 20                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      Private health expenditure includes direct household (out-of-pocket) spending, private insurance, charitable donations, and direct service payments by private corporations.
#> 21                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Public health expenditure consists of recurrent and capital spending from government (central and local) budgets, external borrowings and grants (including donations from international agencies and nongovernmental organizations), and social (or compulsory) health insurance funds.
#> 22                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Total health expenditure is the sum of public and private health expenditure. It covers the provision of health services (preventive and curative), family planning activities, nutrition activities, and emergency aid designated for health but does not include provision of water and sanitation.
#> 23                                                                                                                                                                                         Total general (local, regional and central) government expenditure on pre-primary education (current, capital, and transfers), expressed as a percentage of GDP. It includes expenditure funded by transfers from international sources to government. Divide total government expenditure for a given level of education (ex. primary, secondary, or all levels combined) by the GDP, and multiply by 100. A higher percentage of GDP spent on education shows a higher government priority for education, but also a higher capacity of the government to raise revenues for public spending, in relation to the size of the country's economy. When interpreting this indicator however, one should keep in mind in some countries, the private sector and/or households may fund a higher proportion of total funding for education, thus making government expenditure appear lower than in other countries. Limitations: In some instances data on total public expenditure on education refers only to the Ministry of Education, excluding other ministries which may also spend a part of their budget on educational activities. For more information, consult the UNESCO Institute of Statistics website: http://www.uis.unesco.org/Education/
#> 24                                                                                                                                                                                             Total general (local, regional and central) government expenditure on primary education (current, capital, and transfers), expressed as a percentage of GDP. It includes expenditure funded by transfers from international sources to government. Divide total government expenditure for a given level of education (ex. primary, secondary, or all levels combined) by the GDP, and multiply by 100. A higher percentage of GDP spent on education shows a higher government priority for education, but also a higher capacity of the government to raise revenues for public spending, in relation to the size of the country's economy. When interpreting this indicator however, one should keep in mind in some countries, the private sector and/or households may fund a higher proportion of total funding for education, thus making government expenditure appear lower than in other countries. Limitations: In some instances data on total public expenditure on education refers only to the Ministry of Education, excluding other ministries which may also spend a part of their budget on educational activities. For more information, consult the UNESCO Institute of Statistics website: http://www.uis.unesco.org/Education/
#> 25                                                                                                                                                                                           Total general (local, regional and central) government expenditure on secondary education (current, capital, and transfers), expressed as a percentage of GDP. It includes expenditure funded by transfers from international sources to government. Divide total government expenditure for a given level of education (ex. primary, secondary, or all levels combined) by the GDP, and multiply by 100. A higher percentage of GDP spent on education shows a higher government priority for education, but also a higher capacity of the government to raise revenues for public spending, in relation to the size of the country's economy. When interpreting this indicator however, one should keep in mind in some countries, the private sector and/or households may fund a higher proportion of total funding for education, thus making government expenditure appear lower than in other countries. Limitations: In some instances data on total public expenditure on education refers only to the Ministry of Education, excluding other ministries which may also spend a part of their budget on educational activities. For more information, consult the UNESCO Institute of Statistics website: http://www.uis.unesco.org/Education/
#> 26                                                                                                                                                Total general (local, regional and central) government expenditure on secondary and post-secondary non-tertiary vocational education (current, capital, and transfers), expressed as a percentage of GDP. It includes expenditure funded by transfers from international sources to government. Divide total government expenditure for a given level of education (ex. primary, secondary, or all levels combined) by the GDP, and multiply by 100. A higher percentage of GDP spent on education shows a higher government priority for education, but also a higher capacity of the government to raise revenues for public spending, in relation to the size of the country's economy. When interpreting this indicator however, one should keep in mind in some countries, the private sector and/or households may fund a higher proportion of total funding for education, thus making government expenditure appear lower than in other countries. Limitations: In some instances data on total public expenditure on education refers only to the Ministry of Education, excluding other ministries which may also spend a part of their budget on educational activities. For more information, consult the UNESCO Institute of Statistics website: http://www.uis.unesco.org/Education/
#> 27                                                                                                                                                                         Total general (local, regional and central) government expenditure on post-secondary non-tertiary education (current, capital, and transfers), expressed as a percentage of GDP. It includes expenditure funded by transfers from international sources to government. Divide total government expenditure for a given level of education (ex. primary, secondary, or all levels combined) by the GDP, and multiply by 100. A higher percentage of GDP spent on education shows a higher government priority for education, but also a higher capacity of the government to raise revenues for public spending, in relation to the size of the country's economy. When interpreting this indicator however, one should keep in mind in some countries, the private sector and/or households may fund a higher proportion of total funding for education, thus making government expenditure appear lower than in other countries. Limitations: In some instances data on total public expenditure on education refers only to the Ministry of Education, excluding other ministries which may also spend a part of their budget on educational activities. For more information, consult the UNESCO Institute of Statistics website: http://www.uis.unesco.org/Education/
#> 28                                                                                                                                                                                            Total general (local, regional and central) government expenditure on tertiary education (current, capital, and transfers), expressed as a percentage of GDP. It includes expenditure funded by transfers from international sources to government. Divide total government expenditure for a given level of education (ex. primary, secondary, or all levels combined) by the GDP, and multiply by 100. A higher percentage of GDP spent on education shows a higher government priority for education, but also a higher capacity of the government to raise revenues for public spending, in relation to the size of the country's economy. When interpreting this indicator however, one should keep in mind in some countries, the private sector and/or households may fund a higher proportion of total funding for education, thus making government expenditure appear lower than in other countries. Limitations: In some instances data on total public expenditure on education refers only to the Ministry of Education, excluding other ministries which may also spend a part of their budget on educational activities. For more information, consult the UNESCO Institute of Statistics website: http://www.uis.unesco.org/Education/
#>                                sourceDatabase
#> 1                       WDI Database Archives
#> 2                World Development Indicators
#> 3                       WDI Database Archives
#> 4               Africa Development Indicators
#> 5                World Development Indicators
#> 6                World Development Indicators
#> 7                       WDI Database Archives
#> 8                World Development Indicators
#> 9                       WDI Database Archives
#> 10               World Development Indicators
#> 11               World Development Indicators
#> 12                      WDI Database Archives
#> 13               World Development Indicators
#> 14               World Development Indicators
#> 15               World Development Indicators
#> 16               World Development Indicators
#> 17               World Development Indicators
#> 18               World Development Indicators
#> 19 Health Nutrition and Population Statistics
#> 20                      WDI Database Archives
#> 21                      WDI Database Archives
#> 22                      WDI Database Archives
#> 23                       Education Statistics
#> 24                       Education Statistics
#> 25                       Education Statistics
#> 26                       Education Statistics
#> 27                       Education Statistics
#> 28                       Education Statistics
#>                                                                                                                               sourceOrganization
#> 1                                                                                                                                               
#> 2  UNESCO Institute for Statistics (UIS). UIS.Stat Bulk Data Download Service. Accessed October 24, 2022. https://apiportal.uis.unesco.org/bdds.
#> 3                                                                                                                                               
#> 4                   World Information Technology and Services Alliance, Digital Planet: The Global Information Economy, and Global Insight, Inc.
#> 5                         Stockholm International Peace Research Institute (SIPRI), Yearbook: Armaments, Disarmament and International Security.
#> 6                                                                      World Bank national accounts data, and OECD National Accounts data files.
#> 7                                                                      World Bank national accounts data, and OECD National Accounts data files.
#> 8                                                                      World Bank national accounts data, and OECD National Accounts data files.
#> 9                                                                      World Bank national accounts data, and OECD National Accounts data files.
#> 10                                                                     World Bank national accounts data, and OECD National Accounts data files.
#> 11                                                                     World Bank national accounts data, and OECD National Accounts data files.
#> 12                                                                                                                                              
#> 13                                                           UNESCO Institute for Statistics (http://uis.unesco.org/). Data as of February 2020.
#> 14                                                           UNESCO Institute for Statistics (http://uis.unesco.org/). Data as of February 2020.
#> 15                                                           UNESCO Institute for Statistics (http://uis.unesco.org/). Data as of February 2020.
#> 16 UNESCO Institute for Statistics (UIS). UIS.Stat Bulk Data Download Service. Accessed October 24, 2022. https://apiportal.uis.unesco.org/bdds.
#> 17  World Health Organization Global Health Expenditure database (http://apps.who.int/nha/database). The data was retrieved on January 30, 2022.
#> 18  World Health Organization Global Health Expenditure database (http://apps.who.int/nha/database). The data was retrieved on January 30, 2022.
#> 19  World Health Organization Global Health Expenditure database (http://apps.who.int/nha/database). The data was retrieved on January 30, 2022.
#> 20              World Health Organization Global Health Expenditure database (see http://apps.who.int/nha/database for the most recent updates).
#> 21              World Health Organization Global Health Expenditure database (see http://apps.who.int/nha/database for the most recent updates).
#> 22              World Health Organization Global Health Expenditure database (see http://apps.who.int/nha/database for the most recent updates).
#> 23                                                                                                               UNESCO Institute for Statistics
#> 24                                                                                                               UNESCO Institute for Statistics
#> 25                                                                                                               UNESCO Institute for Statistics
#> 26                                                                                                               UNESCO Institute for Statistics
#> 27                                                                                                               UNESCO Institute for Statistics
#> 28                                                                                                               UNESCO Institute for Statistics
```

-   NY.GDP.PCAP.KD: GDP per capita (constant 2015 US\$)

-   SP.DYN.LE00.IN: Life expectancy at birth, total (years)

-   SP.POP.TOTL: Population, total

-   GB.XPD.RSDV.GD.ZS: Research and development expenditure (% of GDP) - 2

-   MS.MIL.XPND.GD.ZS: Military expenditure (% of GDP) - 6

-   SE.XPD.TOTL.GD.ZS: Government expenditure on education, total (% of GDP)


```r
wdi_world <- WDI(country = "all", indicator = c(gdpPcap = "NY.GDP.PCAP.KD", lifeExp = "SP.DYN.LE00.IN", pop = "SP.POP.TOTL", research = "GB.XPD.RSDV.GD.ZS", military = "MS.MIL.XPND.GD.ZS", education = "SE.XPD.TOTL.GD.ZS"), 1990, extra = TRUE, cache = wdi_cache)
```




```
#> Rows: 8778 Columns: 18
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (9): year, gdpPcap, lifeExp, pop, research, militar...
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
wdi_world
#> # A tibble: 8,778 × 18
#>    country     iso2c iso3c  year status lastupdated gdpPcap
#>    <chr>       <chr> <chr> <dbl> <lgl>  <date>        <dbl>
#>  1 Afghanistan AF    AFG    1990 NA     2023-07-25      NA 
#>  2 Afghanistan AF    AFG    1991 NA     2023-07-25      NA 
#>  3 Afghanistan AF    AFG    1993 NA     2023-07-25      NA 
#>  4 Afghanistan AF    AFG    2015 NA     2023-07-25     592.
#>  5 Afghanistan AF    AFG    1999 NA     2023-07-25      NA 
#>  6 Afghanistan AF    AFG    1992 NA     2023-07-25      NA 
#>  7 Afghanistan AF    AFG    1996 NA     2023-07-25      NA 
#>  8 Afghanistan AF    AFG    1997 NA     2023-07-25      NA 
#>  9 Afghanistan AF    AFG    2002 NA     2023-07-25     360.
#> 10 Afghanistan AF    AFG    2013 NA     2023-07-25     608.
#> # ℹ 8,768 more rows
#> # ℹ 11 more variables: lifeExp <dbl>, pop <dbl>,
#> #   research <dbl>, military <dbl>, education <dbl>,
#> #   region <chr>, capital <chr>, longitude <dbl>,
#> #   latitude <dbl>, income <chr>, lending <chr>
```

SE.XPD.TOTL.GB.ZS: Government expenditure on education, total (% of government expenditure) SE.XPD.TOTL.GD.ZS: Government expenditure on education, total (% of GDP) SE.XPD.PRIM.PC.ZS: Government expenditure per student, primary (% of GDP per capita) MS.MIL.XPND.ZS: Military expenditure (% of general government expenditure) SE.XPD.TERT.ZS: Expenditure on tertiary education (% of government expenditure on education)


```r
mod_e <- lm(lifeExp ~ education, wdi_world); mod_e
#> 
#> Call:
#> lm(formula = lifeExp ~ education, data = wdi_world)
#> 
#> Coefficients:
#> (Intercept)    education  
#>     66.7431       0.7654
```


```r
wdi_world %>% ggplot(aes(education, lifeExp)) + geom_point() + geom_smooth(formula = y ~ x, method = "lm", se=FALSE)
#> Warning: Removed 4030 rows containing non-finite values
#> (`stat_smooth()`).
#> Warning: Removed 4030 rows containing missing values
#> (`geom_point()`).
```

![](28-modeling_files/figure-epub3/unnamed-chunk-54-1.png)<!-- -->


```r
wdi_world %>% filter(income != "Aggregates") %>% drop_na(education, lifeExp) %>% ggplot(aes(education, lifeExp)) + geom_point() + geom_smooth(formula = y ~ x, method = "lm", se=FALSE)
```

![](28-modeling_files/figure-epub3/unnamed-chunk-55-1.png)<!-- -->


```r
wdi_world_el <- wdi_world %>% select(country, year, education, lifeExp, gdpPcap, pop, research, military, region, income) %>% filter(income != "Aggregates") %>% drop_na(education, lifeExp)
```


```r
wdi_world_el %>% ggplot(aes(education)) + geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
```

![](28-modeling_files/figure-epub3/unnamed-chunk-57-1.png)<!-- -->


```r
wdi_world_el %>% filter(year==2020) %>% ggplot(aes(x = income, y = education, fill = income)) + geom_boxplot()
```

![](28-modeling_files/figure-epub3/unnamed-chunk-58-1.png)<!-- -->


```r
wdi_world_el %>% filter(year==2020) %>% arrange(desc(education))
#> # A tibble: 156 × 10
#>    country    year education lifeExp gdpPcap    pop research
#>    <chr>     <dbl>     <dbl>   <dbl>   <dbl>  <dbl>    <dbl>
#>  1 Marshall…  2020     13.6     65.0   5041. 4.34e4   NA    
#>  2 Solomon …  2020     12.8     70.2   2080. 6.91e5   NA    
#>  3 Bolivia    2020      9.84    64.5   2920. 1.19e7   NA    
#>  4 Namibia    2020      9.45    62.8   4152. 2.49e6   NA    
#>  5 Sierra L…  2020      8.81    59.8    608. 8.23e6   NA    
#>  6 Botswana   2020      8.74    65.6   5811. 2.55e6   NA    
#>  7 Saudi Ar…  2020      7.81    76.2  18857. 3.60e7    0.522
#>  8 Iceland    2020      7.72    83.1  52442. 3.66e5    2.47 
#>  9 Lesotho    2020      7.67    54.7    969. 2.25e6   NA    
#> 10 Cabo Ver…  2020      7.58    74.8   2950. 5.83e5   NA    
#> # ℹ 146 more rows
#> # ℹ 3 more variables: military <dbl>, region <chr>,
#> #   income <chr>
```


```r
wdi_world_el %>% filter(year==2020) %>% arrange(desc(education))
#> # A tibble: 156 × 10
#>    country    year education lifeExp gdpPcap    pop research
#>    <chr>     <dbl>     <dbl>   <dbl>   <dbl>  <dbl>    <dbl>
#>  1 Marshall…  2020     13.6     65.0   5041. 4.34e4   NA    
#>  2 Solomon …  2020     12.8     70.2   2080. 6.91e5   NA    
#>  3 Bolivia    2020      9.84    64.5   2920. 1.19e7   NA    
#>  4 Namibia    2020      9.45    62.8   4152. 2.49e6   NA    
#>  5 Sierra L…  2020      8.81    59.8    608. 8.23e6   NA    
#>  6 Botswana   2020      8.74    65.6   5811. 2.55e6   NA    
#>  7 Saudi Ar…  2020      7.81    76.2  18857. 3.60e7    0.522
#>  8 Iceland    2020      7.72    83.1  52442. 3.66e5    2.47 
#>  9 Lesotho    2020      7.67    54.7    969. 2.25e6   NA    
#> 10 Cabo Ver…  2020      7.58    74.8   2950. 5.83e5   NA    
#> # ℹ 146 more rows
#> # ℹ 3 more variables: military <dbl>, region <chr>,
#> #   income <chr>
```


```r
wdi_world_el %>% filter(year==2020) %>% lm(gdpPcap ~ education, .)
#> 
#> Call:
#> lm(formula = gdpPcap ~ education, data = .)
#> 
#> Coefficients:
#> (Intercept)    education  
#>     10568.8        940.2
```


```r
wdi_world_el %>% filter(year==2020) %>% lm(gdpPcap ~ education, .) %>% glance()
#> # A tibble: 1 × 12
#>   r.squared adj.r.squared  sigma statistic p.value    df
#>       <dbl>         <dbl>  <dbl>     <dbl>   <dbl> <dbl>
#> 1   0.00815       0.00166 20342.      1.26   0.264     1
#> # ℹ 6 more variables: logLik <dbl>, AIC <dbl>, BIC <dbl>,
#> #   deviance <dbl>, df.residual <int>, nobs <int>
```


```r
wdi_world_el %>% lm(lifeExp ~ education + research + military, .) %>% glance()
#> # A tibble: 1 × 12
#>   r.squared adj.r.squared sigma statistic   p.value    df
#>       <dbl>         <dbl> <dbl>     <dbl>     <dbl> <dbl>
#> 1     0.346         0.345  5.25      269. 2.26e-140     3
#> # ℹ 6 more variables: logLik <dbl>, AIC <dbl>, BIC <dbl>,
#> #   deviance <dbl>, df.residual <int>, nobs <int>
```


```r
wdi_world_el %>% lm(lifeExp ~ education + research + military, .) %>% tidy()
#> # A tibble: 4 × 5
#>   term        estimate std.error statistic   p.value
#>   <chr>          <dbl>     <dbl>     <dbl>     <dbl>
#> 1 (Intercept)  70.2       0.489    143.    0        
#> 2 education     0.0767    0.0966     0.794 4.27e-  1
#> 3 research      3.84      0.146     26.4   7.42e-127
#> 4 military     -0.0683    0.102     -0.669 5.04e-  1
```

$$lifeExp \sim 70.22 + 0.08\cdot education + 3.84 \cdot research - 0.07 \cdot military$$


```r
wdi_world_el %>% lm(gdpPcap ~ education + research + military, .) %>% tidy()
#> # A tibble: 4 × 5
#>   term        estimate std.error statistic   p.value
#>   <chr>          <dbl>     <dbl>     <dbl>     <dbl>
#> 1 (Intercept)    1061.     1310.     0.810 4.18e-  1
#> 2 education      1332.      259.     5.15  3.01e-  7
#> 3 research      12783.      390.    32.8   4.69e-179
#> 4 military       -964.      273.    -3.53  4.35e-  4
```


```r
wdi_world_el %>% lm(gdpPcap ~ education + research + military, .) %>% glance()
#> # A tibble: 1 × 12
#>   r.squared adj.r.squared  sigma statistic   p.value    df
#>       <dbl>         <dbl>  <dbl>     <dbl>     <dbl> <dbl>
#> 1     0.477         0.476 14036.      464. 3.75e-214     3
#> # ℹ 6 more variables: logLik <dbl>, AIC <dbl>, BIC <dbl>,
#> #   deviance <dbl>, df.residual <int>, nobs <int>
```

$$gdpPcap \sim 1077 + 1024\cdot education + 12792 \cdot research - 967 \cdot military$$


```r
mod_r <- lm(lifeExp ~ research, wdi_world); mod_e
#> 
#> Call:
#> lm(formula = lifeExp ~ education, data = wdi_world)
#> 
#> Coefficients:
#> (Intercept)    education  
#>     66.7431       0.7654
```

## 数理モデルに関する参考文献

-   Tidy Modeling with R：tidymodel パッケージ群の教科書
    -   <https://www.tmwr.org>
-   Tidymodels パッケージ群
    -   <https://www.tidymodels.org>
    -   broom: <https://cran.r-project.org/web/packages/broom/index.html>
    -   Introduction to broom: <https://cran.r-project.org/web/packages/broom/vignettes/broom.html>

### モデル概要に現れる数値について

-   r-statistics.co by Selva Prabhakaran:
    -   <http://r-statistics.co/Linear-Regression.html>
-   Meaning Behind Each Section of Summary()
    -   <https://www.learnbymarketing.com/tutorials/explaining-the-lm-summary-in-r/>
