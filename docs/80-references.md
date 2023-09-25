# 参考文献 {#references}

参考文献とともに、おすすめのサイトなどについても、個人的に、学ばせせていただあいたものを中心に書いていきます。

## 教科書

すでに何度かご紹介していますが、Tidyverse の中心的開発者でもある、Hadley Wickham 等の書いた、次の本に勝るものは、ないと個人的には考えています。

R for Data Science（r4ds と略）: <https://r4ds.hadley.nz>

詳細はリンク先をみていたければと思いますが、これを書いている段階で、第二版（2e）がちょうど出版、公開されました。わたしは、第一版で最初勉強し、この文書を準備し始めた頃には、第二版の暫定版が公開されていましたから、そちらは、全てではありませんが、読ませていただき、参考にさせていただきました。多くの部分が、この本に則っています。

第一版も、bookdown パッケージで書かれていますが、この書が、bookdown で書かれ、公開されたことから、他のさまざまな、データサイエンスの教科書も、たとえば、bookdown の Archive のようなところに公開されて、活用されてきたことが、R のデータサイエンスへの利用が、飛躍的に進んだ原因であると同時に、RMarkdown や、bookdown の開発と相まって、このような、Public Domain での出版が進んだ原因だと、個人的には確信しており、個人ではなく、RStudio Co.（現在は、Posit Co.）という会社組織で進んで行ったことが、安定度も含めて、大きな意味があったと思っています。その意味でも、世界を変えた一冊だと考えています。

一つだけコメントさせていただければ、印刷体だけでなく、Public Domain での出版ということで、プロの翻訳家が手を出さず、日本語訳が出なかったことが、日本での知名度が上がらなかった原因であるとも思います。しかし、Web Browser（ホームページ閲覧ソフト）の自動翻訳技術も飛躍的に進歩し（今後ますます進歩するでしょうから）、Web 上に公開することで、このような技術書は、絶対的ではないという状況になったことも、大きな変化かなと考えています。そのような学び方の改革をもご紹介し、その橋渡しができればと願って始めたのがこの文書のプロジェクトでもあります。

### 練習問題

R for Data Science のもう一つの特徴は、同時に、練習問題集も、早いうちから公開されたことです。learnr というパッケージを使い、対話型（interactive）な練習問題が、Primers（入門書）として、Posit Primers（最初は、RStudio Primers）として開発されたことです。採点など、試験などとして使うことを考えると、まだ、完全とは言えませんが、学びのためには、十分の質のものだと思います。

r4ds のあとに書かれているものは、教科書の対応する章ですが、これは、第一版のもので、第二版では、必ずしも対応していませんが、残しておくことにしました。ここにリストされたものがすべて完成したのは、2022年の終わり頃かと思います。簡単に、日本語の表題を、なるべく本書の表題と近い名前にして添えておきます。

本書では、1から4と、7 に重点を置いています。

#### **Posit Primers <https://posit.cloud/learn/primers>**

1.  R と Tidyverse の基礎：The Basics -- r4ds: Explore, I

-   視覚化の基礎：[Visualization Basics](https://rstudio.cloud/learn/primers/1.1)

-   プログラミング基礎：[Programming Basics](https://rstudio.cloud/learn/primers/1.2)

2.  データの変形：Work with Data -- r4ds: Wrangle, I

-   表の形式 Tibble：[Working with Tibbles](https://rstudio.cloud/learn/primers/2.1)

-   dplyr によるデータの抽出：[Isolating Data with dplyr](https://rstudio.cloud/learn/primers/2.2)

-   dplyr によるデータの変形：[Deriving Information with dplyr](https://rstudio.cloud/learn/primers/2.3)

3.  データの視覚化：Visualize Data -- r4ds: Explore, II

-   探索的データ分析：[Exploratory Data Analysis](https://rstudio.cloud/learn/primers/3.1)

-   棒グラフ：[Bar Charts](https://rstudio.cloud/learn/primers/3.2)

-   度数分布：[Histograms](https://rstudio.cloud/learn/primers/3.3)

-   箱ひげ図：[Boxplots and Counts](https://rstudio.cloud/learn/primers/3.4)

-   散布図：[Scatterplots](https://rstudio.cloud/learn/primers/3.5)

-   折れ線グラフと地図：[Line plots and maps](https://rstudio.cloud/learn/primers/3.6)

-   点データの重なり：[Overplotting](https://rstudio.cloud/learn/primers/3.7)

-   さまざまな調整：[Customize plots](https://rstudio.cloud/learn/primers/3.8)

4.  Tidy Your Data -- r4ds: Wrangle, II

-   データ表の行と列の交換：[Reshape Data - a bit old](#0)

-   行または列の結合と分離：[Separate and Unite](#0)

-   二つのデータ表の結合：[Join Data Sets](https://rstudio.cloud/learn/primers/4.3)

5.  プログラミング：Iterate -- r4ds: Program

-   繰り返し処理入門：[Introduction to Iteration](https://rstudio.cloud/learn/primers/5.1)

-   同時変換：[Map](https://rstudio.cloud/learn/primers/5.2)

-   表などの同時変換：[Map Shortcut](https://rstudio.cloud/learn/primers/5.3)

-   ヴェクトルの変換応用：[Multiple Vectors](https://rstudio.cloud/learn/primers/5.3)

-   応用編：[List Columns](https://rstudio.cloud/learn/primers/5.4)

6.  関数の活用：Write Functions -- r4ds: Program

-   関数の基礎：[Function Basics](https://rstudio.cloud/learn/primers/6.1)

-   関数の書き方：[How to Write a Function](https://rstudio.cloud/learn/primers/6.2)

-   引数の対応：[Argument Matching](https://rstudio.cloud/learn/primers/6.3)

-   環境と適用範囲：[Environments and Scoping](https://rstudio.cloud/learn/primers/6.4)

-   条件分岐：[Control Flow](https://rstudio.cloud/learn/primers/6.5)

-   複雑な条件分岐：[Advanced Control Flow](https://rstudio.cloud/learn/primers/6.6)

-   R によける再帰型プログラム：[Loops in R](https://rstudio.cloud/learn/primers/6.7)

7.  再現可能性を重視したレポート：Report Reproductively -- r4ds: Communicate

-   ビデオや説明へのリンク：[Link to Videos and Explanations](https://rmarkdown.rstudio.com/lesson-1.html?_ga=2.215340127.979535829.1639794069-1104332695.1639233659)

8.  対話型アプリの作成：[Build Interactive Web Apps](https://shiny.rstudio.com/tutorial/?_ga=2.149795838.979535829.1639794069-1104332695.1639233659)

## MOOCs などのオンラインコース

わたしは、MOOCs（massive open online courses）がちょうど始まった 2012年ごろ、その10年前ぐらいに、スタートした、OCW（open courseware）を勉強していたこともあり、MOOCs のコースをかなり最初の段階からいくつか、視聴していました。

データサイエンスで人気があったのは coursera でホストしていた、Johns Hopkins University が提供する、10コースからなる、JHU Data Science というコースト、edX でホストしていた、Harvard University が提供する、9コースからなる Data Science。

下にリンクと、そのコースを下にした、オンラインなど容易に手に入ると思われる教科書へのリンクをつけておきます。

-   edX: HarvardX [Data Science](https://www.edx.org/professional-certificate/harvardx-data-science) - 9 courses. Textbook:

    -   ["Introduction to Data Science"](https://leanpub.com/datasciencebook) by Rafael A. Irizarry.

    -   [Free Online Book](http://rafalab.dfci.harvard.edu/dsbook/) by Rafael A. Irizarry.

-   coursera: [JHU Data Science](https://www.coursera.org/specializations/jhu-data-science) - 10 courses. List of Companion Books:

    -   ["R Programming for Data Science"](https://leanpub.com/rprogramming?utm_source=DST2&utm_medium=Reading&utm_campaign=DST2) by Roger Peng.

    -   [Free Online Book](https://bookdown.org/rdpeng/rprogdatascience/) by Roger Peng.

    -   ["Exploratory Data Analysis with R"](https://leanpub.com/exdata?utm_source=DST2&utm_medium=Reading&utm_campaign=DST2) by Roger Peng.

    -   [Free online Book](https://bookdown.org/rdpeng/exdata/) by Roger Peng.

    -   ["Report Writing for Data Science in R"](https://leanpub.com/reportwriting?utm_source=DST2&utm_medium=Reading&utm_campaign=DST2) by Roger Peng

    -   ["Statistical Inference for Data Science"](https://leanpub.com/LittleInferenceBook) by Brian Caffo

    -   ["Regression Modeling for Data Science in R"](https://leanpub.com/regmods) by Brian Caffo

どちらも、素晴らしいコースだと思いますが、個人的には、edX Harvard X のものは、アカデミック（学問的・学際的）で、coursera の方は、技術的（コンピュータ科学）のような印象を受けました。

いまでは、Data Science と検索すれば、膨大なコースが見つかりますが、個人的には、Data Science というものに、実際に触れた最初がこのにコースだったので、影響されていると思います。

また、2018年ごろからでしょうか、会社組織で、データサイエンス教育のようなものを提供するところが、続々と出てきました。DataCamp や、DataQuest などなど、たくさんあります。

MOOCs の方は、受講証明書を必要とせず、各単元の最後のテストの評価が必要なければ、基本的に無償で受けられますが、DataCamp などは、大体、最初の一コースだけ無償で、そのあとは有償になっているかと思います。

有償のコースで、アドバイスをもらったりなど、指導してもらえたり、わからないところの質問をなんでも聞けるというのは、とてもよいと思いますが、オンライン上のコミュニティでも、かなり無償でサポートが得られますし、最近では、AI による、サポートもどんどん進化していますから、個人的には、AI が家庭教師についてくれるような世界へと進んでいくのではないか、そして、基本的な部分は、それで十分ではないかと思います。

## その他の参考書

個人的に、読んだもの、参考にしたものもいくつもありますが、あとは、必要に応じて、参照していただくのがよいと思います。日本語のものは、少ないですが、英語のものであっても、自動翻訳なども上手に使えば、問題なく読めると思います。

上でも書いた、Bookdown サイトと、そこにリンクされている、Archives のリンクをつけておきます。膨大な、電子書籍がリンクされていますが、それは、そこに投稿するシステムも完備しているからでもあります。みなさんも、電子書籍を書いてみませんか。

BOOKDOWN: <https://bookdown.org>

Archive Page: <https://bookdown.org/home/archive/>

日本語で書かれたものも、数は多くありませんが、いくつかあります。

## 統計関連

統計学についてほとんど書きませんでした。必要ではないという意味では全くありません。しかし、データサイエンスというと、まず、数学、そして、統計学を勉強して、コンピュータプログラミングも勉強してはじめて、始められるのですよね。というような声には、抗（あらが）って、書いてきました。最初から、これらで苦しまなくても、必要になった時に、少しずつ勉強していけばよいと考えているからです。

ひとつ一つステップを踏んで学んでいくよりも、まずは、データに慣れること、グラフをみて、問いを持つこと、そして、さらに、他のグラフを見ること。そう考えると、問いを持ちながら、視覚化を通して、データから特徴を読み取り、さらに問いを深めて、次の視点から、またデータを見ていくことが、何よりも大切だと考えているからです。

そのあとで、統計を勉強してみよう。プログラミングや、コンピュータサイエンスを勉強してみよう、数理モデルについて、もう少し深く知りたい、もう少し、基本的な数学も学び直してみたいとなれば、個人的にはとても嬉しいです。

### CRAN

最後の方に、R 本体をホストし、保持してださっている、CRAN（The Comprehensive R Archive Network）をあげるのは、非常に失礼だと思いますが、CRAN にも、基本的な文書はあります。

マニュアル（The R Manuals）：<https://cran.r-project.org>

（左の帯の Documentation の中の Manuals）

さまざまなものがリストされています。この下の方に、Contributed という項があり、そこから、Contributed Documentation という項目にリンクがあります。

（左の帯の Documentation の中の Contributed）

ここに、日本語のものも掲載されています。わたしは、全部読んだわけではありませんが、間瀬茂さんのものは、統計解析の道具として R を使う場合には、非常に有効だと思います。

-   **R 入門：An Introduction to R** ([PDF](https://cran.r-project.org/doc/contrib/manuals-jp/R-intro-170.jp.pdf))

-   **R 言語定義：The R language definition** ([PDF](https://cran.r-project.org/doc/contrib/manuals-jp/R-lang.jp.v110.pdf))

-   **R の拡張を書く：Writing R Extensions** ([PDF](https://cran.r-project.org/doc/contrib/manuals-jp/R-exts.jp.pdf))

-   **R のデータ取り込み／出力：R Data Import/Export** ([PDF](https://cran.r-project.org/doc/contrib/manuals-jp/R-data-jp.v15.pdf))

-   **R のインストールと管理：R Installation and Administration** ([PDF](https://cran.r-project.org/doc/contrib/manuals-jp/R-admin-jp.v15.pdf))

-   **R 基本統計関数マニュアル：R Statistical Function Help Pages** ([PDF](https://cran.r-project.org/doc/contrib/manuals-jp/Mase-Rstatman.pdf), 404 pages, 2009-06-05)

### その他のオンライン文書

-   BellCurve 統計WEB：<https://bellcurve.jp/statistics/>

    -   統計用語集：<https://bellcurve.jp/statistics/glossary/initial/a/>

## 経済学を学ぶ人のために

わたしは、まったく、経済学を学んだことがありませんから、適切な、アドヴァイスはできませんが、一般的な教科書として次のものがあるようです。計量経済学の教科書については、データセットも、R のパッケージとして出ているようです。

-   *Introductory Econometrics: A Modern Approach, 7e* by Jeffrey M. Wooldridge

    -   R Package woodridge

        -   wooldridge: 115 Data Sets from "Introductory Econometrics: A Modern Approach, 7e" by Jeffrey M. Wooldridge

        -   [https://CRAN.R-project.org/package=wooldridge](https://cran.r-project.org/package=wooldridge)

-   *Principles of Macroeconomics* by Gregory Mankiw et al (2014)

    -   R Package priceR

        -   Functions to aid in micro and macro economic analysis and handling of price and currency data. Includes extraction of relevant inflation and exchange rate data from World Bank API, data cleaning/parsing, and standardisation. Inflation adjustment calculations as found in Principles of Macroeconomics by Gregory Mankiw et al (2014). Current and historical end of day exchange rates for 171 currencies from the European Central Bank Statistical Data Warehouse (2020) 

        -   [https://CRAN.R-project.org/package=priceR](https://cran.r-project.org/package=priceR)

-   *Macroeconomics by N. Gregory Mankiw*
