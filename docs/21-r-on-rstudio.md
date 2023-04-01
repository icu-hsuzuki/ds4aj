# (PART) PART II BASICS {-}
# R Studio で R {#ronrstudio}

## はじめに

この章では、R と R Studio をインストールし、正常に動作しているかを、確認することを目標とします。実際の、使い方は、次の章以下で、述べます。

また、Posit Cloud など、R Studio 以外で、R を使う方法も、最後に述べます。特に、Posit Cloud は、R Studio で R を利用するときには、同様のことが使える、Cloud 環境ですので、R と R Studio のインストールに成功した場合も、利用方法を確認してください。

確認の段階で、エラーが出てしまった場合の解決方法も、下に書きますが、まずは、Posit Cloud など、他の方法でR を使えるようにし、時間のあるときに、解決を試みてください。

## R と R Studio

> R is a free software environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows and MacOS. https://www.r-project.org

> R は、無償で提供されている、統計解析とグラフを描写する環境です。Windows、MacOS や、Linux で利用することが可能です。

> RStudio is an integrated development environment (IDE) for R and Python. It includes a console, syntax-highlighting editor that supports direct code execution, and tools for plotting, history, debugging, and workspace management. RStudio is available in open source and commercial editions and runs on the desktop (Windows, Mac, and Linux).　https://posit.co/products/open-source/rstudio/

> RStudio は、R と Python のための、総合開発環境です。RStudio には、プログラムを実行したり、制御やジョブ管理のための、コンソール（console）、コードを書いたり、実行したりする、文書の編集をする、エディター（Editor）とともに、グラフを表示したり、履歴や、プログラムを修正するなどのための、さまざまなツールが付属しています。RStudio はオープンソースで提供され、Windows、Mac および、Linux で利用可能で、有償版のサービスと無償版を提供しています。

R は、統計解析のためのシステムで、R Studio は、R（および Python）を利用するための、総合開発環境です。そこで、「R Studio で R を利用する」という表現をします。

## R と R Studio のインストール

R と R Studio をインストールします。

両方とも、インストールすることが必要です。

今後のために、動作確認を、RNotebook を使って行います。

:::{.rmdcaution}
**注意**

以下は、自分のコンピュータ、すなわち、管理者権限があるコンピュータにインストールすることを前提に書きます。

家族で、コンピュータを共有していて、管理者権限がない場合は、管理者権限のあるかたに、R と RStudio をインストールしてもらってください。そうすれば、そのコンピュータの他のアカウントでも利用することができます。

ある制約がかかるとメッセージが出ますが、管理者権限なしで、インストールすることも可能です。特別の事情があり、管理者権限なしで、インストールする場合は、[こちら](https://icu-hsuzuki.github.io/myds/techmemo.html#%E9%9D%9E%E7%AE%A1%E7%90%86%E8%80%85%E3%81%A8%E3%81%97%E3%81%A6-r-%E3%81%A8-rstudio-%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)を参照してください。
:::

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

### 動作確認

動作確認のための、一連の流れを書き、その下に、問題が起こった場合の対処を書きます。

R Studio はこれまでも使っていたが、R Notebook は使ったことがないという方も、同様の確認をしてください。

1. RStudio を立ち上げます。
2. 上のメニューの File から、New Project を選択します。
3. Project の名前を（test とか、firstproject など）つけて、Create ボタンを押します。
4. 上のメニューの File から、New File の R Notebook を選択します。
    * Package が必要なので、Install するかと聞かれますから、インストールを選んでください。
5. File から、Save as を選んで、名前を（test0, rnotebook など）とつけ、Preview ボタンを押すと、内容が現れます。
6. Preview ボタンの右の、三角印を押すと、Knit PDF と現れますから、それを選択
    * すでに、TeX というシステムを使っておられる方は、PDF が作成されますが、それ以外の方は、なにやらメッセージが出て、TeX システムが無いと出ると思います。
    * 左下の、Console タブに、`tinytex::install_tinytex()` をコピーして、入力し、Enter または、Return キーを押します。
    * もう一度、Kit PDF を（今度は、Preview ボタンが、Knit となっていると思います。その右の三角から Knit PDF  を選択し）押します。

この一連の作業で、最後に、PDF が現れれば、動作確認終了です。

### トラブルシューティング

4 または、6 でエラーが出る場合があると思います。

* 4で、パッケージをたくさんインストールしますが、この段階で、エラーが出る場合があります。そのときは、まず、RStudio の上のメニューの、Tools の一番下の、Global Options を開き、左のメニューから、Packages を選び、Primary CRAN Repository を Change として、CRAN mirror から、Japan: The Institute of Statistical Mathematics, Tokyo を選択してください^[理由は不明ですが、特定のミラーサイトが理由ではなく、https を能動的に設定することで解決が図れるのかなと思います。]。

  - 解決しない場合は、下の囲みの中を読んでください。Windows の、OneDrive 関連の問題の可能性が高いかと思います。
  
* 6で、エラーが出た場合には、Windows の OneDrive の問題、または、日本語アカウント名の問題の可能性が高いと思います。その場合は、下の囲みの中を読んでください。

:::{.rmdcaution}
**Windows 日本語アカウント名の場合の不具合について:** 
Windows の日本語システムで、アカウント名に日本語を使っておられる方、または、OneDrive を使っていて、Documents（書類）ディレクトリーのすべてをバックアップしておられる方は、ファイルを作成したり、パッケージをインストールするときに、問題が発生する可能性があります。`Sys.getenv('HOME')` と、`Sys.getenv('R_LIBS_USER')` をそれぞれ、コピーして、RStudio 左下の窓枠の Console タブに、ペーストして、エンターして、???? や、カタカナ、漢字が現れなければ、問題ありません。`Sys.getenv()` とすれば、すべての環境変数を確認することもできます^[エクスプローラからユーザ（`C:\Users`）を見ると漢字になっているかどうかの確認ができます。]。

カタカナや漢字のユーザネームを使っている場合は、RMarkdown で、文書を作成し、PDF で出力するときには、問題が起こります。解決方法は下に書きます。

OneDrive で、ドキュメントフォルダ全体のバックアップをとっている場合も、問題が起こる可能性がありますが、一般的には書けませんので、困ったときは、下に書く方法を参照してください。
:::

#### R および RStudio やパッケージでのインストールの問題

Windows で、インストール時、または、その後の、パッケージのインストールや、PDF の作成で問題が起こった場合の対処法を書きます。

実際には、さまざまな理由がありますから、以下の方法では対処できないかもしれません。まず、エラーメッセージを丁寧に見ることが大切ですが、簡単には理解できない場合が多いかと思います。そこで、まず、試してみる方法を以下に書きます。

##### R および RStudio のアンインストール

* **Windows**: 設定から、アプリを選び、アンインストール（削除）したいものを選択して、実行。
* **Mac**: アプリケーションから、アプリをみつけ、ゴミ箱へ。

:::{.rmdnote}
上記の方法で、残ってしまうものがあります。それは、環境変数 Path の設定です。

Mac は、システムのベースにあるのは、Linux などと同じ、Unix なので、アプリケーションの、ユーティリティ（Utilities）から、Terminal を立ち上げ、
`echo $PATH` とすると、確認できます。RStudio の左下の窓枠にも Terminal があり、そこからでも、同じように確認できます。

Windows の場合は、対応するものには、コマンド・プロンプト（Command Prompt）と、パワーシェル（PowerShell）があります。PowerShell: `echo $Env:Path` とすれば、表示できます。

Windows の場合、「設定」から、「環境変数の編集」を検索して、選択すると、Path を見ることができます。上の枠が、ユーザの環境変数、下の枠が、システム環境変数です。ユーザの環境変数の中の、Path（他には、TEMP, TMP もあるかと思います。）をコピーしておくと良いでしょう。Path をダブルクリックして、編集することも可能です。
:::

##### 別のアカウントを作成してインストール

Windows に、もう一つ、アカウントを作成します。

1. [スタート] $>$ [設定] $>$ [アカウント] の順に選択し、[ファミリとその他のユーザー] を選択し、[アカウントの追加] から作成します。

2. どのようにサインインしますかと出ますから、下にある、「このユーザーのサインイン
情報がありません」を選択します。[次へ]

3. つぎに、アカウントを作成しましょうでますから、特に、なにも入力せず、「Microsoft ア
カウントを持たないユーザーを追加する」を選択します。[次へ]

4. アカウント設定、名前とパスワード、名前は、ローマ字と数字で作成。パスワードは２回入れる。アカウントの名前と、パスワードは記録しておくこと。

5. そのあとに、三つの質問とその答えを記録する。これも、おぼられるものにするか、記録すること。

6. アカウントが作成されるが、そのアカウントを選択すると、「アカウントの種類の変更」が選択できるので、「管理者」に変更。[OK] をクリックして終了。

アカウント名をローマ字にします。、そちらから、インストールしてください。元の日本語アカウントとファイルを共有したいときは、共有ディレクトリーにコピーしてください。[次へ]



#### RMarkdown で PDF を作成するときの注意

アカウントに漢字やカタカナが入っていると、PDF が作成できません。対処方法は、RMarkdown の項に書きます。

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
  
## クラウド - Posit Cloud

RStudio Cloudは、誰でもオンラインでデータサイエンスを行い、共有し、教え、学ぶことができる、軽量でクラウドベースのソリューションです。2022年11月に、会社名が、RStuio から Posit に変更になったこともあり、Posit Cloud となっていますが、まだ、RStudio Cloud と表示されている箇所もあります。

### クラウドサービス　How to Start Posit Cloud

まず、サインアップして、使ってください。一ヶ月の利用時間の限度など、設定されていますが、どこからでも、インターネットにつながっていれば使えるので、わたしは、いつくかアカウントを持って、活用しています。

1. [Posit Cloud](https://posit.cloud/) にアクセスします。Go to https://posit.cloud/
2. Get Started または、右上から、Sign UP を選択します。Sign Up: top right
3. Email address or Google account
4. New Project: Project Name

:::{.rmdnote}
**特徴：制限など（Key Features）**

* プロジェクト数の上限は50。Up to 50 projects total
* 共有スペースは一つのみ（5人までのメンバーが10個のプロジェクトまで共有できます） 1 shared space (5 members and 10 projects max)
* コンピュータ時間としては月間最大25時間^[右の`i`マークを押すと詳細な条件を確認できます。]。25 compute hours per month
* 各プロジェクトについて最大 1GB のRAM（Read Access Memory）。Up to 1 GB RAM per project
* 各プロジェクトについて 1 CPU。Up to 1 CPU per project
* 背後で実行する作業は1時間が上限。Up to 1 hour background execution time
:::

大学で課題などに取り組むと、まず、月間25時間の制限に引っかかり、次のようなメッセージが表示されます。

:::{.rmdcaution}
Your account exceeded its compute hour limit. You can continue to open projects in your account until _such and such time_, or until you have used at total of 40 compute hours. After that you will be unable to open projects in space owned by your account until your next usage period begins on _such and such day_.
:::

わたしは、このようなメッセージが出たら、重要度にもよりますが、まずは、プロジェクトをダウンロードし、いつても、自分のコンピュータで使えるようにしてから、他の、アカウントに引っ越して、作業を続けています。その方法を追記しておきます。

:::{.rmdtips}
0. プロジェクトのダウンロード：自分のコンピュータに R と R Studio が使える場合は、必要なプロジェクトをダンロードします。ダウンロードするには、左上の3本線から、自分の Workspace にもどり、プロジェクトの右についている、ダウンロードボタンを押します。これは、プロジェクトとして、RStudio から開くことができます。（If you have installed R Studio and R on your computer, From the three lines on the top left, go back to your workspace.
Then there is a download button on the right of your project. You can open it on your computer.）

**他のアカウントとの共有：**

1. 異なる電子メールアドレスで別の Posit Cloud アカウントを作成します。（create another Posit Cloud account with another email address.）
2. 使っていたプロジェクトを開き、右上のギアマークから、Change Access を、`You` から、`everyone` に変更します。（In your current project, open the gear mark on the top right, and change access from `You` to `everyone`.）
3. 使っていたプロジェクトのアカウント名の隣にある、三つの点が丸で囲まれているものを選び、`Share Link ` を、別のアカウントを作成したアドレスに送ります。（In your currentproject, next to your account name, there is a circle with three dots. Share the link and send the email to another account.）
4. 使っていた、元のアカウントからログアウトし、新しいアカウントを開き、送られてきたアドレスクリック、またはコードを入れると、使っていたプロジェクトが開き、Temporary Copy と出ます。編集して使いたい時は、それを Permanent Copy にすると、新しいアカウントで編集し、使うことができます。（Then, you can get an access code to your current project. Log out from the existing account, log in to your new account, and then use the link.
Then you can see the temporary file containing everything in your old account and use it for a permanent project.)
:::

## 追記

R Studio または、RStudio Cloud（Posit Cloud） 以外で、R を使われる方のために、少しだけ書いておきます。個人的には、[Google colab](https://colab.research.google.com) と、[Cocalc](https://cocalc.com) を利用しています。

Google colab は、Google アカウントの作成、Cocalc は、Cocalc アカウントの作成、または、Google アカウントか、GitHub アカウントのリンクが必要です。

Google アカウントをお持ちの方は多いと思うので、Google colab について、最低限のことのみ、書いておきます。

### Google colab で R

基本的に、`python` 開発環境として構築されているものですが、R でも使うことができます。

1. Google アカウントにログインします。
2. [ここ](https://colab.research.google.com/#create=true&language=r) をクリックして起動します。
3. 一番上に、ノートブック名が `Untitled0.ipynb` などと表示されますから、適当に変更します。
4. ＋コード、＋テキスト　とあり、最初のコードの１行が表示されていますから、たとえば、`head(cars)` と入れて、左の三角を押します。すると、最初だけ少し時間がかかりますが、その下に結果がでます。
5. 次に、上や、最後の行の直下に、表示される、＋コード、＋テキスト をクリックして、あたらしい、コード・チャンクか、テキスト・チャンクを書き入れていきます。
6. `tidyverse` などは、すでにインストールされていますが、使いたいときは、`library(tidyverse)` とし、インストールされていないときは、`install.packages("WDI")` などとします。

ノートを、保存、印刷、ダウンロードなど可能です。

フォルダーを作成して、外部ファイルを読み込んだり、書き出したりすることも可能です。

#### 参考にしたもの

* [How to use R in Google Colab:](https://towardsdatascience.com/how-to-use-r-in-google-colab-b6e02d736497)

