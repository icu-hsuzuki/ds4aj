# R Markdown {#rmarkdown}

## Reproducible and Literate Programming

データサイエンスは、サイエンス（科学）ということばもついていますが、特に、根拠に基づいた（evidence based）とか、データに基づいた（data based）ということばを使うときには、なおさら、再現可能性（reproducibility）や、コードの内容の説明などのコミュニケーションにも注力する必要があります。このことを心がけて、データサイエンスを学んでいきましょう。

表題にある、"Reproducible and Literate Programming" は、Reproducible （再現可能）かつ、Literate　な（理解できるように記述した）Program（プログラム・コード）を共有することをたいせつにしましょうということです。

### 目的、問いなど

プロジェクトの目的、問いなどは、途中で変わっていくこともありますが、その都度に、メモをしておくと良いでしょう。

### データについて

どのようなデータをどのように取得してきたかを、記録し、伝えられるようにすることが、必要です。データを取得するときから、取得方法や、それを伝える方法にも常に気をつけましょう。

### コードについて

どのようなコードでそのグラフ（chart）などが得られたかも、単にコードを記述するだけでなく、それぞれの部分に、説明を付与することも有効です。

### グラフについて

視覚化（visualization）は、とても有効です。そこで、見て理解したこと、観察したこと（observations）などは、簡単でも構いませんから、必ず、記録しておきましょう。

### まとめ：R Markdown の目的

まさに、このようなことを可能にするのが、R Markdown です。少しずつ学んでいきましょう。

## 準備：パッケージのインストール

Rパッケージは、Rの拡張機能で、コード、データ、ドキュメントを標準化されたコレクション形式で含んでおり、標準的なものは、R Studio の Top Bar の Tool > Install Packages からインストールできます。

* `tidyverse`
* `rmarkdown`
* `tinytex`

インストールを複数回しても問題はありませんが、インストールされているかどうかは、Packages タブから確認することができます。

インストールは一回だけ。ときどき、Tools > Check for Package Update をつかって、Update しておくと良いでしょう。


## R Notebook

R Markdownはデータサイエンスのためのオーサリングフレームワーク。

コード（プログラム）とその実行結果、を記録・表示し、高品質のレポートの作成を可能にします。

R Notebook は、独立してインタラクティブに実行できるチャンクを持つR Markdownドキュメントの一つの形式で、入力のすぐ下に出力が表示することができます。

1. File > New File > R Notebook
2. Save with a file name, say, test-notebook
3. Preview by [Preview] button
4. Run Code Chunk plot(cars) and then Preview again.

## 日本語のテンプレート

下のリンクを開き、右上の Code ボタンから、Download Rmd を選択すると、ダウンロードできますから、ダインロードしたものを、プロジェクト・フォールダーに移動またはコピーしてください。ダウンロードできないときは、Ctrl を押しながら、Download Rmd をクリックすると、Save As で保存できると思います。ブラウザーによって仕様が異なりますから、適切な方法を選んでください。

* https://ds-sl.github.io/intro2r/RNotebook-J.nb.html
* https://ds-sl.github.io/intro2r/Rmarkdown-J.nb.html

Windows でも、Mac でも提供されている、Google Chrome の場合には、Code ボタンから、ダンロードされるはずです。

RNotebook の新しいファイルを作成し、下のサイトを表示させて、コピー・ペーストで、書き換えることも可能です。

* https://ds-sl.github.io/intro2r/RNotebook-J.html
* https://ds-sl.github.io/intro2r/Rmarkdown-J.html


## R Markdown いくつかの Output
```
---
title: "Testing R Markdown Formats"
author: "ID Your Name"
header-includes:
  - \usepackage{ctex}
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

**PDFでエラー？** コンソールで `tinytex::install_tinytex()`

* TeX システムがインストールされている場合は不要

エラーの例を書いておきます。`tinytex::install_tinytex()` おらず、他の TeX システムもインストールしていない環境で、上に引用した、`RNotebook-J` から、PDF を作成したときに生じたエラーです。ここに

```
If you are not sure, you may install TinyTeX in R: tinytex::install_tinytex()
```

「よくわからない場合は、RでTinyTeXをインストールすることもできます: `tinytex::install_tinytex()`」

と書いてあります。

**エラーメッセージの例**

```
processing file: RNotebook-J.Rmd

“C:/Program Files/RStudio/bin/quarto/bin/tools/pandoc” +RTS -K512m -RTS RNotebook-J.knit.md –to latex –from markdown+autolink_bare_uris+tex_math_single_backslash –output RNotebook-J.tex –lua-filter “C:000117x-library\4.2.lua” –lua-filter “C:000117x-library\4.2-div.lua” –embed-resources –standalone –highlight-style tango –pdf-engine pdflatex –variable graphics –variable “geometry:margin=1in” output file: RNotebook-J.knit.md

Error: LaTeX failed to compile RNotebook-J.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. In addition: Warning message: In system2(…, stdout = if (use_file_stdout()) f1 else FALSE, stderr = f2) : ‘“pdflatex”’ not found Execution halted

No LaTeX installation detected (LaTeX is required to create PDF output). You should install a LaTeX distribution for your platform: https://www.latex-project.org/get/

If you are not sure, you may install TinyTeX in R: tinytex::install_tinytex()

Otherwise consider MiKTeX on Windows - http://miktex.org

MacTeX on macOS - https://tug.org/mactex/ (NOTE: Download with Safari rather than Chrome strongly recommended)

Linux: Use system package manager
```

## YouTube Video - rmarkdown

<iframe width="560" height="315" src="https://www.youtube.com/embed/-E_XLf15YHs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

### RMarkdown で PDF を作成するときの注意

RMarkdown では、`tinytex` パッケージというとても素晴らしいものが提供されています。これは、TeXLive というシステムを扱うためのものですが、LiveTeX 全体は、3GB 程度ありますが、非常に小さなファイルで、必要なものだけ、導入できるようになっています。

\TeX システムを、使われる方は、TeXLive が、インストールされているかと思いますので、それを使うことが狩野樹になっています。

一応、TeXLive がインストールされていて、そのあとに、TinyTeX をインストールしようとすると、拒否されますが、インストール、アンインストールなどをしていると、Path も変更になるため、問題が起こり、PDF が作成できなくなる場合もあります。

その場合の対処も含めて、下に書きます。

アカウントに漢字やカタカナが入っていると、PDF が作成できません。

#### `tinytex` によるインストール方法

* tinytex::install_tinytex(dir = "C:/TTeX") 
* 環境変数の設定：
  - `Path=C:\**UserName**\AppData\Local\Microsoft\WindowsApps;C:\TTeX\bin\windows`
  - UserName の部分は、ご自分のユーザネームに変更　\ は日本語システムでは、¥ と表示されているかもしれません。

:::{.rmdnote}

これで解決しない場合は、Windows に、もう一つ、アカウントを作成し^[[スタート] > [設定] > [アカウント] の順に選択し、[ファミリとその他のユーザー] を選択し、[アカウントの追加] から作成。]、アカウント名を英語にして、そちらから、インストールしてください。元の日本語アカウントとファイルを共有したいときは、共有ディレクトリーにコピーしてください。

すべての状況は確認できませんので、ここまでとします^[元のアカウントから、利用したり、Home を変更したりなど、いろいろな方法で、解決することも可能ですが、自信がない場合には、上の方法で、別のアカウントから、利用してください。]。Chat GPT に確認したやりとりは、[ここ](https://icu-hsuzuki.github.io/ds_education/chatgpt.html#chatgpt)にあります。自分で確認をして、HOME の変更などをしてみても良いですが、問題が生じた時に、サポートできませんから、一般的な方法としては、書かないことにします。

注：矢内勇生さんの[サイト](https://yukiyanai.github.io/jp/resources/docs/install-R_windows.pdf)には、詳細な説明があります。
:::


