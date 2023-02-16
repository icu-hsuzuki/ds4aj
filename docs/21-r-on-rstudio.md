# (PART) PART II BASICS {-}
# R on R Studio {#ronrstudio}



## はじめに

R Studio で R を使うことを始めましょう。

このページの一番下に、簡単な解説ビデオがついています。

## R と R Studio

> R is a free software environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows and MacOS. https://www.r-project.org

> R は、無償で提供されている、統計解析とグラフを描写する環境です。Windows、MacOS や、Linux で利用することが可能です。



> RStudio is an integrated development environment (IDE) for R and Python. It includes a console, syntax-highlighting editor that supports direct code execution, and tools for plotting, history, debugging, and workspace management. RStudio is available in open source and commercial editions and runs on the desktop (Windows, Mac, and Linux).　https://posit.co/products/open-source/rstudio/

> RStudio は、R と Python のための、総合開発環境です。RStudio には、プログラムを実行したり、制御やジョブ管理のための、コンソール（console）、コードを書いたり、実行したりする、文書の編集をする、エディター（Editor）とともに、グラフを表示したり、履歴や、プログラムを修正するなどのための、さまざまなツールが付属しています。RStudio はオープンソースで提供され、Windows、Mac および、Linux で利用可能で、有償版のサービスと無償版を提供しています。



R は、統計解析のためのシステムで、R Studio は、R（および Python）を利用するための、総合開発環境です。そこで、「R Studio で R を利用する」という表現をします。


## R と R Studio のインストール

R と R Studio をインストールします。

両方とも、インストールすることが必要です。

### R のインストール

https://cloud.r-project.org

上のリンクから、Windows、macOS または、Linux を選択して、インストールしてください。

macOS の場合は、M1, M2 など、最近の Apple Silicon の CPU で動くコンピュータか、以前の、Intel の CPU で動くものか、選択してください。Mac の左上の、りんごマークの、このコンピュータについてから、確認できます。 

不明の場合は、「R のインストール」と検索してみてください。

### R Studio の インストール

http://www.rstudio.com/download

上のリンクから、Windows 10/11 または、macOS 11+ を 選択してください。これら以外の、古いシステムのコンピュータの場合は、 下のサイトから、探してください。

https://docs.posit.co/previous-versions/

不明の場合は、「RStudio のインストール」と検索してみてください。

## プロジェクト - Project

RStudio で R を利用する場合には、プロジェクトを作成することを強く勧めます。

1. まず、R Studio を起動します。

2. 上のメニューの、File から、New Project を選択します。New Directory（新しいディレクトリー）を選択し、プロジェクトを作成する Directory を決めて、名前をつけます。その名前が、プロジェクト名になります。

  - Directory（フォルダー）を指定してその名前をつけて、プロジェクトを作成します。
  - Directory が階層に分かれているときは、どこに作成するかを選択してから、名前をつけて、作成します。
  
3. 一旦、R Studio を終了してみましょう。

4. プロジェクトの起動には、いくつかの方法があります。

  - まず、R Studio を起動。一つしかプロジェクトがない場合は、そのプロジェクトが起動すると思います、。上に、プロジェクト名が掲載されていれば、問題ありません。
  - File から、Open Project を選択し、起動したい、プロジェクトの Directory（フォルダー）を選択して起動します。
  - File から、Recent Project（最近使ったプロジェクト）を選択すると、プロジェクト名が表示されますから、選択すると起動することができます。
  - コンピュータのプロジェクト入っているディレクトリー（フォルダー）をさがし、そこに、プロジェクト名.Rproj とあるものを見つけて、それを開くと、そのプロジェクトが起動します。
  
5. 作業後は、保存しますかと聞かれますから、保存して終了してください。
  

## コンソールで実行 - Run in Console

プログラム（コード）の実行は、いくつかの方法がありますが、一番、基本的な、コンソール（Console）での実行にすいて、説明します。Console は、R Studio の左下にあります。（左の枠が一つになっているかもしれません。その一番左のタブが Console です。選択されていない場合は、Console を選択してください。）

### 最初の四つ

下の、四つを、一つずつ、一番下の、> マークの次に書き（または、コピー・ペーストして）Return または、Enter キーを押してください。実行結果が、その下に出ます。最後の、`plot(cars)` は、`cars` というデータの、散布図が右下の、Plots タブに表示されます。

* `head(cars)`
* `str(cars)`
* `summary(cars)`
* `plot(cars)`

エラーが表示されたら、もう一度、スペルを確認して、入力してみてください。

次のような、結果が表示されると思います。簡単な説明をつけます。


```r
head(cars)
#>   speed dist
#> 1     4    2
#> 2     4   10
#> 3     7    4
#> 4     7   22
#> 5     8   16
#> 6     9   10
```

`head(cars)` は、`cars` という、R に付属している、データの、最初（頭 head）の6行を、表示します。


```r
str(cars)
#> 'data.frame':	50 obs. of  2 variables:
#>  $ speed: num  4 4 7 7 8 9 10 10 10 11 ...
#>  $ dist : num  2 10 4 22 16 10 18 26 34 17 ...
```

`str(cars)` は、`cars` という、R に付属している、データの構造（structure）を表示します。`data.frame` とありますが、これは、矩形になったデータ（各列の長さがおなじ）の一番簡単なクラスの名前で、2変数、それぞれが、50 個の数値データ（numerical data） からなっていることがわかります。

head(cars)` では、縦に表示されていたものが、横に表示されています。`$speed`、`$dist` とありますが、`cars$speed`, `cars$dist` は、`cars` データの、それぞれの列を意味します。


```r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```
`cars` データの概要（summary）が表示されます。各列（変数）について、最小値（Minimum）、小さい方から、4分の1を切り捨てたときの最小の値（1st Quadrant）、中央値（Median）、平均（Mean）、大きい方から、4分の1を切り捨てたときの最大の値（3rd Quadrant）、最大値（Maximum）が表示されます。


```r
plot(cars)
```

<img src="21-r-on-rstudio_files/figure-html/unnamed-chunk-5-1.png" width="672" />

### アサインメント、ヘルプ

コンソールで次のそれぞれを、試してみてください。

* `df <- cars`

`df` に、`cars` をアサインします。すなわち、`df` が、`cars` の内容に置き換わります。`cars` はデータですが、データを含む、オブジェクトの名前を設定するためにも使います。オブジェクト名は。英文字から始まれば、かなりの自由度がありますが、わたしは、英文字と数字と `_`（underscore） 程度しか使わないようにしています。


* `head(df)`

`head(df)` は、`head(cars)` と同じ出力が得られます。

* `View(cars)`

左上の、窓枠が開き、`cars` の内容が表示されます。列名のところには、三角形も表示され、それを用いると、大きい順、小さい順などに、並び替えることも可能です。

* `?cars`

右下の、窓枠の　Help タブに、`cars` の情報が表示されます。Help タブにある、虫眼鏡がついた、検索窓（search window）に、`cars` といれても、同じ結果が得られます。
内容を確認してください。

一番上には `cars {datasets}` とありますが、これは、`datasets` というパッケージの、`cars` だという意味です。そこで、`datasets` を調べてみましょう。

* `?datasets`

"The R Datasets Package" だと書かれていて、さらに、

This package contains a variety of datasets. For a complete list, use library(help = "datasets").

さまざまなデータが含まれています。全てのリストをみるには、`library(help = "datasets")` を使ってください。

とありますから、`library(help = "datasets")` をコンソールに入力してみてください。

* `library(help = "datasets")`

左上の窓枠に、リストが表示されます。古いデータばかりですが、例として使うには、十分すぎるぐらいの、数のデータがあります。これらは、Toy Data（おもちゃのデータ）と呼ばれることもあります。

`cars` も見つかりましたか。


### おすすめ

コンピュータのシステムが、日本語であると、R の言語も日本語になっているはずです。そこで、エラーが発生すると、一部、日本語で表示されます。しかし、ネット上などで、そのエラーの対応を検索するときは、英語のエラーメッセージで検索した方が、解決方法が得られる可能性が高いので、わたしは、英語に設定しています。英語にするには、Console で次のようにします。

言語を英語に設定：`Sys.setenv(LANG = "en")`

RStudio を終了して、もう一度起動すると、日本語に戻っていると思います。ですから、作業の最初、または、エラーが出たら、変更することをお勧めします。

日本語に戻したいときは、次のようにします。

言語を日本語に設定：`Sys.setenv(LANG = "ja")`

さまざまな Help なども、すべて日本語で表示されれば日本語を使うのは有効かもしれませんが、すくなくとも、現在は、そうではないので、上に説明したことから、英語に設定することをお勧めします。

### 練習

1. `head(cars, 10L)` は何が出力されますか。`head(cars, n=10L)` と同じですか。
2. `?head` または、Help の検索窓に `head` と入力して、説明を見てみてください。`head(cars, n=10L)` などについて、書いてありましたか。他には、どのようなことが分かりましたか。
3. `datasets` のデータのいくつかについて、そのデータの help や、`head`, `str`, `summary` などを使ってみてください。これらで表示できない場合はありますか。データについては、最初に、これら、三つを試してみることをお勧めします。わかったことをメモしておくと良いでしょう。`datasets` のリストをみるには、`library(help = "datasets")` でしたね。

## RStudio について

RStudio は多くの機能を持っています。

### 四つの窓枠とタブ Four Panes and Tabs

* Top Left: Source Editor
* Top Right: Environment, History, etc.
* Bottom Left: Console, Terminal, Render, Background Jobs
* Bottom Right: Files, Plots, Packages, Help, Viewer, Presentation

## R Script 実行記録

* In RStudio (create Project in RStudio) choose File > New File > R Script
* Choose File > Save As, save with a name; e.g. {file names} (.R will be added automatically)
* To run a code: at the cursor press Ctrl+Shift+Enter (Win) or Cmd+Shift+Enter (Mac).

### Tips

* Top Manu: Help > Keyboard Short Cut Help contains many shortcuts.
* Bottom Right Pane: Check the files by selecting the Files tab.


## パッケージ - Packages

> R packages are extensions to the R statistical programming language containing code, data, and documentation in a standardised collection format that can be installed by users of R using Tool > Install Packages in the top menu bar of R Studio. https://en.wikipedia.org/wiki/R_package

> Rパッケージは、Rの拡張機能で、コード、データ、ドキュメントを標準化されたコレクション形式で含んでおり、標準的なものは、R Studio の Top Bar の Tool > Install Packages からインストールできます。

### パッケージのインストール

いずれ使いますので、まずは、三つのパッケージをインストールしてみましょう。

* `tidyverse`
* `rmarkdown`
* `tinytex`

インストール方法はいくつかあります。

一つ目は、上のメニューバーの Tool から、Install Packages ... を選択します。そして、パッケージーズにインストールしたい、パッケージ名を入力します。そのパッケージ名が下にも出れば、Install ボタンを押してください。入力した名前の下にパッケージ名が出ない場合は、スペルが間違っている可能性がありますから、確認して、入れ直してください。

Console に、`install.packages("tidyverse")` などと表示され、たくさんメッセージが出ます。終了すると、> のマークがでます。

二つ目は、`install.packages("tidyverse")` のような書式で書いて、Console に入れる方法です。

三つ目は、右下の窓枠の Packages のタブにある、Install というボタンを押す方法です。すると、一番目の方法に、戻り、パッケージ名を入力できるようになります。

この Packages タブにある、ものが、すでに、インストールされているパッケージです。そのなかで、`base` や、`datasets` などいくつかに、チェックがついていると思いますが、それらは、ロードされていて、いつでも、使える状態になっていることを意味しています。ロードは、たとえば、`library(tidyverse)` のようにしますが、それは、いずれもう一度説明します。

インストールは一回だけ。ときどき、Tools > Check for Package Update をつかって、Update しておくと良いでしょう。

### 備考

Package によっては、Source から Compile するかと聞いてくる場合があります。どちらでも、良いのですが、特に、問題が起こっていなければ、No でよいと思います。コンピュータにあった形でインストールすることが必要な場合は、Yes とします。

同じパッケージをもう一度、インストールしたり、または、関連するパッケージがあるような場合、R をリスタートするかと聞いてくることがあります。特に問題が起こらなければ、No で構いません。ただ、エラーが起こって、それに関連して、特別なパッケージをインストールする必要がある場合がありますが、そのときは、Yes としてください。

## クラウド - Posit Cloud

RStudio Cloudは、誰でもオンラインでデータサイエンスを行い、共有し、教え、学ぶことができる、軽量でクラウドベースのソリューションです。

### クラウドサービス　How to Start Posit Cloud

まず、サインアップして、使ってください。一ヶ月の利用時間の限度など、設定されていますが、どこからでも、インターネットにつながっていれば使えるので、わたしは、いつくかアカウントを持って、活用しています。

1. Go to https://posit.cloud/
2. Sign Up: top right
3. Email address or Google account
4. New Project: Project Name


## 練習問題 Posit Primers 

Posit Primers https://posit.cloud/learn/primers

教科書 ["R for Data Science"](https://r4ds.had.co.nz) は、`tidyverse` パッケージを中心に、データサイエンスについて解説したものですが、Posit Primers は、演習問題をしながら、教科書の内容を理解できるように構成されています。

### 最初の演習　The Basics – r4ds: Explore, I

* [Visualization Basics](https://rstudio.cloud/learn/primers/1.1)
* [Programming Basics](https://rstudio.cloud/learn/primers/1.2)

ぜひこれら二つの演習問題を、トライしてください。解説を読んでいただけでは、データサイエンスは身につきません。

## 参考文献 References

一番目は、すでに紹介した、教科書です。二番目は、この文書を作成している、Bookdown というパッケージのサイトですが、そこに、たくさんの本が、無償で公開されています。素晴らしい本がたくさん含まれています。

* R For Data Science, by H. Wickham: https://r4ds.had.co.nz
  - Introduction: https://r4ds.had.co.nz/explore-intro.html#explore-intro
* Bookdown: https://bookdown.org, [Archive](https://bookdown.org/home/archive/)

下の一番目は、R 入門を、２時限の講義でしたときのものです。二番目と三番目は、講義で使ったものを、まとめたものです。教科書のようには、できていませんが、参考になる部分もあるかと思いますので、紹介しておきます。

* [Introducton to R](https://ds-sl.github.io/intro2r/intro2r.nb.html)
* [Data Analysis for Researchers 2022](https://icu-hsuzuki.github.io/da4r2022/)
* [Data Analysis for Researchers 2021](https://icu-hsuzuki.github.io/da4r2021/)

## YouTube Video - getstarted

<iframe width="560" height="315" src="https://www.youtube.com/embed/9uQmMZoG74g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

* ファイル：https://ds-sl.github.io/intro2r/getstarted.html
