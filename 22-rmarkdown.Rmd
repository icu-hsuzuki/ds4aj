# R Markdown {#rmarkdown}

## 最初の一歩 Let's get started! {-}

1. 準備：パッケージのインストール
2. R Notebook
3. 日本語のテンプレート
4. R Markdown いくつかの Output
5. R Script 実行記録
6. パッケージ - Packages

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

## YouTube Video - rmarkdown

<iframe width="560" height="315" src="https://www.youtube.com/embed/-E_XLf15YHs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

