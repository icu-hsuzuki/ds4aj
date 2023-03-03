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

<img src="81-japanese_files/figure-html/unnamed-chunk-3-1.png" width="672" />


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


```r
ggplot(df_iris, aes(x = `葉長`, y = `葉幅`, col = `種別`)) +
  geom_point() + labs(title = "散布図", x = "葉長", y = "葉幅")
```

<img src="81-japanese_files/figure-html/unnamed-chunk-5-1.png" width="672" />


## 備考：

実は、一番難しいのが、PDF の作成だと思いますが、一応、上のものも、PDF を作成することが可能です。
下のリンクのファイルを、いろいろな、形式で、出力してみてください。R Notebook と、PDF に出力したもののリンクを付けておきます。

* [R Notebook](https://ds-sl.github.io/intro2r/Rmarkdown-J.nb.html)
  - 右上の Code ボタンから、Rmd ファイルも取得できます。
* [PDF](https://ds-sl.github.io/intro2r/Rmarkdown-J.pdf)

## 参考：日本語の表示について

> 日本語が適切に表示されない！？

簡単ではなく、未解決の部分が何かなどを含め、わたしも十分理解できているか不明であるが、理解できていると思われる範囲で、備忘録のように記す。

R を使うという場合に限っても、R Studio IDE を使う場合、RStudio Cloud を使う場合、Google colab を使う場合、他のプラットフォームで使う場合で違ってくると思われる。一応、上にあげた、三種類のプラットフォームで確かめられるものについて書いていく。上に書いた以外に、R Studio IDE を、Windows 上で使う場合と、Mac 上で使う場合（Mac のシステムは Unix 系であるが、さまざまな Linux ）でも、状況が異なる。そこで、場合分けをして書いていくほうが安全であるが、それは、極力避け、どれにでも適用可能な方法を模索しながら書いていこうと思っている。個人的に、日常的に分断を避ける努力をすることが大切だとおもっていることも背景にある。さらに、ソフトウェア開発者は、むろん、そのような差異を理解して、どの環境でも、可能なように設計することを心がけていると思われるし、そのようなものが、R Project の正規のパッケージとして採用されていくべきだとも考えているので、多少、理想も入っているが、これを基本として書いていこうと思う。十分なチェックができていないものもあるので、不具合などは、ぜひ、お知らせ願いたい。この文章も少しずつ、改善していければと思う。

通常、日本語、中国語、韓国語などが適切に表示できない場合は、文字のエンコーディング（Encoding: どのような情報として記録されているか）と、フォントの問題、さらに、システムがこれらをどう処理しているかの問題があると思われる。しかし、R の利用者として考えると、文字化けが起きたり、適切に文字が表示されないのは、以下の三つに分けられるように思われる。

1. データファイルなどを読み込んだときに適切に表示されない
2. 図の中のタイトルなどが、適切に表示されない
3. R Markdown の出力において、適切に表示されない


### データファイルの読み込み


- tidyverse に含まれる readr には、guess_encoding が含まれており、一般的には、たとえば、
	- read_csv("./data/file_name.csv")  とすると、一番可能性の高いエンコーディングで読み込まれる。
- 使い方：guess_encoding(file, n_max = 10000, threshold = 0.2) とあり、10000行で推測されたエンコーディング、または、確率を計算することを Default にしている。Help によると、すべての行をチェックする場合は、n_max =  -1 とすることが書かれている。
- これで問題がない場合が多い。他の、readr 関数も同様である。
- なお、read_csv などにも、guess_max = min(1000, n_max) も含まれるが、これは、column type を決めるためのものである。
- read.csv() など、base R では、fileEncoding = "", encoding = "unknown" がオプションに含まれていたので、指定して読み込むことが通常であった。


### 図の中のテキスト

- 基本的には、図の表示の前にlibrary(showtext); font_add_google('Noto Sans'); showtext_auto() となっていれば、これ以降の図は、Google Fonts 'Noto Sans' が使われ、表示されるはずである。
- 二種類以上のフォントを使い分けたいときは、名前をつけて、それを family = name で指定する。
	- showtext: Using Fonts More Easily in R Graphs 参照。

### R Markdown の出力

- PDF 作成における問題が最後まで残っていたが、最近は、showtext Package で解決しているようである。設定については、図の中のテキストの場合と同じ。

:::{.rmdcaution}
**注意：** 現在のところ、環境によるのかもしれないが、「・」と、伸ばし棒「ー」が、適切に表示できない。
:::

### 参考としたもの

#### showtext: Using Fonts More Easily in R Graphs

- https://CRAN.R-project.org/package=showtext
	- https://cran.r-project.org/web/packages/showtext/readme/README.html
	- showtext: Using Fonts More Easily in R Graphs: 
		- https://cran.r-project.org/web/packages/showtext/vignettes/introduction.html
		- https://fonts.google.com

#### sysfonts: Loading Fonts into R

- https://CRAN.R-project.org/package=sysfonts
	- https://cran.r-project.org/web/packages/sysfonts/sysfonts.pdf


#### foods4all: Examples of Graphs

- https://foods4all.github.io/examples/examples_of_graphs.html
	- 77.2 Japanese Environments 日本語環境（昔の記事：Last Updated: 2020-04-22）
