# 道具箱 {#toolbox}

## 基本的な関数

### 現在の状態を知る

1.  R.Version(), R.version, R.version.string: R のバージョンの情報を出力します

    -   `R.Version()` : は、list 形式で詳細を出力します

    -   `R.version`: は、テキスト形式で詳細を出力します（括弧付きではありません）

    -   `R.version.string` : は、テキストで、たとえば、"R version 4.3.0 (2023-04-21)" などと出力します。基本的には、この情報で十分です。

2.  `Sys.getenv()` : 環境変数の値を返します

    -   ほとんどの基本的なシステム環境変数を出力します。

    -   EDITOR, HOME, LANG, LOGNAME, PAGER, PATH, USER などなど

3.  `getwd()`: 現在の R の絶対パスを出力します

    -   Project を設定しているときは、Project のパスを基準としています

4.  `data()`: 読み込んでいる（使用可能な）データのリストを出力します

5.  `ls()`: 現在のオブジェクトのリストを、文字列ベクトルとして出力します

    -   Environment タブからも確認できます

6.  `tidyverse_packages()` : tidyverse パッケージ群のパッケージ全体を表示します。

7.  `tidyverse_conflicts()`: tidyverse パッケージ群とぶつかっていて使えなくしている機能を表示します。

    -   library(tidyverse) でも表示されますが、その後、読み込んだパッケージとの衝突情報も表示します。

8.  `tidyverse_deps()`: tidyverse パッケージの依存情報を表示します

9.  `tidyverse_update()`: tidyverse の更新情報を表示します。何を 更新すべきかを教えてくれます。

## 論理値のあつかい

## 数値 numbers

## 文字列 stringr

## 正規表現 greg

## 日付 lubridate

## ファクター factor

## 関数 functions

## プログラミング purrr

## ホームページからの読み込み rvest

## API の活用
