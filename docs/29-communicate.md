# 情報共有（Communicate） {#communicate}

## はじめに

データサイエンスでは、再現性（reproducibility）や、プログラムの文書化（literate programming）が大切で、そのために、記録をとり、RMarkdown を活用することをすでに述べました。

ここでは、データサイエンスを通して得た情報・発見を共有するためのレポートや、スライドなどの作成についてまとめておきます。基本的には、RMarkdown を中心として書きます。

また、Quarto の活用についても、書きます。

## R Markdown について

すでに、RMarkdown の章で、簡単な使い方を紹介しました。また、この文書も含め、共有している、Posit Cloud のファイルなどで、RMarkdown についてある程度理解しておられると思います。

最初には、RNotebook という、RMarkdown の一つの形式について紹介しました。まず、RStudio で、メニューから File の New File を選択すると、上から順に、Quarto Document、Quarto Presentation、R Notebook、R Markdown と表示されます。Quarto は、新しい形式で、新しく機能も追加されている途中で、R Markdown と共通の機能が使えますので、まずは、R Markdown の説明をし、あとから Quarto について紹介します。

## レポートとスライド

### RNotebook/RMarkdown

メニューから、File の New File から RNotebook を選択すると、一番上の部分（YAML と呼びます）には、

```         
---
title: "R Notebook"
output: html_notebook
---
```

とあります。この三つのダッシュの部分、YAML が、RMarkdown の設定部分で、この場合には、title と output とあり、output には、html_notebook とあります。YAML は、書き方の規則が正確に決まっています。字下げの規則もありますので、簡単には変更できますせんが、title の 引用符の間に、タイトルを入れて、文書を書き始めます。

RMarkdown を選択すると、Document （文書）が選択されている初期設定窓が出て、そこにTitle（文書タイトル）と、Author（著者名）を入力するようになっており、右の枠には、HTML、PDF、Word と表示されます。HTML を選択したまま、Title（ここでは「文書名」）と Author（ここでは「あなたの名前」） を入力すると、YAML は次のようになっていると思います。

```         
---
title: "文書名"
author: "あなたの名前"
date: "2023-12-04"
output: html_document
---
```

ここで、RNotebook で、HTML 出力をした場合と、RMarkdown の HTML 出力の場合の違いを簡単に説明しておきます。

初期設定窓からは、Presentation（スライド）、Shiny、From Template と選択できます。Shiny は、Web アプリのようなものです。スライドについては、あとから説明しますが、いろいろと試してみるのもよいと思います。

#### Visual Editor

RStudio には、左上に、Source と Visual という Editor（エディター）の選択ができます。Visual Editor（ビジュアル・エディタ） は、2021年末に登場したものですが、HTML や、MD といったスクリプト言語をご存知の方は、別ですが、Visual Editor の方が楽だと思います。

#### メニュー

Visual ボタンの右からは、B（太字）、*I*（斜字）、6つのレベルの表題、箇条書き、番号付き箇条書き、リンク、画像挿入ボタンがあり、その右には、Format（形式選択メニュー）、Insert（挿入メニュー）があり、高機能ではありませんが、直感的に、編集が可能になっています。

その一つ上の行でも、いくつかの機能が選択できるようになっていますが、RNotebook の場合には、Preview と表示され、RMarkdown の場合は、knit と表示されているボタンがあり、その右には、出力設定のためのギアマーク、そして、C マークの Code Chunk（コードチャンク）のボタン、その右には、Run ボタンなどがあります。

Preview ボタンを押すと、HTML ファイルが生成されます。別ウインドウに表示されるかと思いますが、Preview ボタンの右のギアマーク（の右の三角マーク）から、Preview in Viewer Pane を選択すると右下の Viewer に表示されます。

#### Code Chunk

この中に、コードを書くのですが、右上にギアマークと、下向きの三角と、右向きの三角があります。コードチャンクに名前をつけたり、メッセージの表示・非表示、注意（Warnings）の表示・非表示の切り替えなど、さらには、コードを表示する・しない、実行する・しないなども、選択できるようになっています。詳しくは、下に、Chunk Option とありますから、その[リンク先](https://yihui.org/knitr/options/)をみてください。

Code Chunk の一番右の、右向き三角を押すと、コードが実行されます。それより上のコードチャンスに、たとえば、library(tidyverse) などの設定があり、それを実行していないと、エラーになる場合もありますから、一番上から実行するというときには、下向きの三角印を押します。

チャンクに書き込むには二通りの書き方があります。上のように、{r} の中に書く方法と、そとに出す方法です。どちらも、その下にある出力になります。eval = FALSE ですから、実行はせず、コードだけが表示されます。chunk-label などは省略可能ですが、書いておくと、エラーが出た時に、どのコードチャンクかがわかりやすいという利点があります。チャンクオプションについては、[リンク](https://yihui.org/knitr/options/)を参照してください。

````md
```{r, chunk-label, eval = FALSE, echo = TRUE}
plot(cars)
```
````

````md
```{r}
#| chunk-label, eval = FALSE, 
#| echo = TRUE

plot(cars)
```
````


```r
plot(cars)
```


#### PDF への出力

RNotebook でも、RMarkdown でも、初期設定では、HTML 文書が生成されますが、RNotebook では、Preview ボタン、RMarkdown では、knit ボタンの右にある、三角を押すと、そこから、PDF と Word が選択できるようになっています。RNotebook の場合には、HTML も選択できます。

PDF を選択すれば、PDF に出力されるはずですが、初期設定が必要です。RStudio で R の中の動作確認をみていただくのがよいと思います。

ただ、フォントの都合で、日本語が正しく表示されない場合があります。その時は、下の YAML を参照してください。

#### Word への出力

文書にエラーがなければ、knit ボタン、または、Preview ボタンの右の三角から Word を選べば、Word ファイルが生成されます。

また、テンプレートを使って、次のようにすることも可能です。テンプレートは、一度、knit を使って、生成した、docx ファイルの、スタイルを編集したものを、template.docx として、Project フォルダの文書の同じところに入れてください。

```         
---
 word_document:
    reference_docx: "template.docx"
---
```

### スライド

Presentation につかう、スライドも、いろいろな形式が使えます。 しかし、共通に、一つだけ、重要な点があります。

それは、ページおくりです。Heading 2 のところで、ページが変わります。または、三つのダッシュで、次のページにいくことも可能です。

詳細は下の参考文献をご覧ください。

#### PowerPoint への出力

Word と同様にテンプレートを使って次のようにすることも可能です。

```         
---
  powerpoint_presentation:
    reference_doc: my-styles.pptx
---
```

R Markdown いくつかの Output

```         
---
title: "Testing R Markdown Formats"
author: "ID Your Name"
header-includes:
  - \usepackage{xeCJK}
  - \setCJKmainfont{ipaexm.ttf}
  - \setCJKsansfont{ipaexg.ttf}
  - \setCJKmonofont{ipaexg.ttf}
output:
  html_notebook: default
  html_document: default
  pdf_document: default
    latex_engine: xelatex
  word_document: default
  powerpoint_presentation: default
  ioslides_presentation: default
---
```

<https://ds-sl.github.io/intro2r/Rmarkdown-J.html>

### Tips（ちょっとしたこと 覚書）

### Tables（表）

-   HTML 文書で、Table（表）の表示の仕方、Code Chunk 毎に変更：default, kable, tibble, paged：[参照リンク](https://github.com/rstudio/rmarkdown/issues/1403)

    -   df_print: paged　# under html_document in YAML

    -   paged.print=TRUE \# in code chunk option

    -   paged.print=FALSE \# in code chunk option

    -   knitr::kable(ggplot2::diamonds[1:10, ]) \# kable output

## Quarto について

リンク：<https://quarto.org>

Document（文書）、HTML を選択すると、YAML は次のようになっています。

```         
---
title: "Untitled"
format: html
editor: visual
---
```

初期設定画面で Author（著者名）を入れることも可能です。editor: visual となっていますから、最初から、Visual Editor が開いています。しかし、Source を押せば、Source Editor に変更することも可能です。

あとは、ほとんど、RMarkdown の場合と同じですが、多少違う部分もありますので、上のリンクを参照してください。

Presentation（スライド）では、Reveal JS（HTML）、Beamer（PDF）、PowerPoint（Microsoft PowerPoint または、OpenOffice）いくつか選択ができますが、あとから変更することもできますので、最初は、Reveal JS で、あとから、発表にあったものに変更するのでもよいと思います。

## 参考文献

-   R Markdown クックブック：<https://gedevan-aleksizde.github.io/rmarkdown-cookbook/>

    -   英語版：<https://bookdown.org/yihui/rmarkdown-cookbook/>

-   R Markdown: The Definitive Guide: <https://bookdown.org/yihui/rmarkdown/>
