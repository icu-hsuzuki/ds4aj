# IT ツール {#tools}

> いくつかの便利なツールについて紹介します。

## Git と GitHub

Git は バージョン管理システムで、GitHub はそれを、活用し、かつ他のメンバーと協力して開発など、さまざまな活動をするためのサイトです。公開が基本となっています。非公開にすることも可能ですが、公開することで、世界中のひとたちと協力していくことが可能になりますので、その利点も学んでいただければと思います。

### 概要

RStudio で R を使っている場合、Git-GitHub-RStudio の連携で使うことをお勧めします。しかし、これらは、三つとも、まったく異なるものですから、簡単な概要を書いておくことにします。

#### Git

これは、ファイルのバージョン（更新履歴）の管理システムで、単独で機能します。他の、プログラムなどに関係しない、他の文書ファイルであっても、バージョンを管理する場合に活用できます。特に、テキスト・ファイルの場合には、どこがどう改訂されているかを確認することもできます。また、基本的には、Unix の Shell プログラムで動作させるのが一般的です。Mac は、Unix システムの上に構築されているため、最初から、ユーティリティ（Utility）> ターミナル（Terminal）で、Shell コマンドが利用可能になっていますが、Windows の場合には、bash と呼ばれる Shell プログラムをインストールすることをお勧めします。Windows システムについてよくご存知の方は、他の方法を使っていただいて構いませんが、Git のインストールの時に、Git bash を選択して、簡単に インストールできますし、Unix システムの基本を理解するチャンスでもあり、Mac とも同じ環境で説明できますから、ここでは、そちらを使います。Shell コマンドは、R Studio の中のターミナルを使って、利用することも可能です。（注：Windows のコマンド・プロンプト、または、パワー・シェルをお使いの方は、利用環境が変化する可能性がありますから、そのまま使われる方が良いかもしれません。）

基本的なコマンドとしては、以下のものがあります。いまは、このようなものがある程度に、眺めておいてください。

* `git init`: 特定のディレクトリ（フォルダ）で バージョン管理を始める時に使います。
* `git status`: 現在の状況を確認するときに使います。
* `git diff file_name`: ファイルへの変更を確認します。
* `git log`: 過去の commit による履歴を確認する時に使います。
* `git add file_name`: ステージングという中間的な場所に登録します。
* `git commit -m "log message here"`: ステージングにあるものを、確定させます。引用符で囲まれた短いコメントを加えます。50文字が上限です。
* `git help`: Help のリストが表示されます。
  - 例：`git help init` などと入力すると、説明を見ることができます。

#### Git Hub

Git でバージョン管理されているディレクトリ（フォルダ）の状態を示す、クラウドサービスです。更新されている、状態を確認するとともに、変更履歴なども確認できます。また、Git Hub サービスを利用して、ファイルを公開、共有することも可能です。Pages サイトを利用することで、ホームページとして HTML ファイルなどを公開することもできるため、レポートを公開したり、この電子書籍のように、`bookdown` パッケージを利用して作成したものを、インターネット上に公開することも可能です。

お気付きかと思いますが、この電子書籍も、リンクされている、他の文書も、URL（アドレス）をみると、GitHub になっていますし、パッケージや、データなども、GitHub へのリンクが示されている割合が、非常に高いと思います。

最初に、Git で管理されている、ディレクトリ（フォルダ）（これを、ローカル・リポジトリと言います）と、GitHub 内のリポジトリ（リモート・リポジトリまはたアップストリーム・リポジトリと言います。ここでは、リモート・リポジトリと呼ぶことにします）を結びつけるステップが必要です。

#### RStudio 連携

コマンドライン（シェル）で行う作業や、ローカル・リポジトリを、リモート・リポジトリに結びつける作業を、RStudio の中で行うことが可能です。

### はじめかた

1. Git のインストール
  - Windows と Mac で異なりますので注意が必要です。Mac については、**Mac** と書いてあるところを読んでください。
  - **Windows** の場合は、[git-scm](https://git-scm.com/download/win) にアクセスしてダウンロード、インストールしてください。セットアップ（Setup）で、２箇所、注意点があります、それ以外は、すべて、初期設定のままで変更は必要ありません。
    - Choosing the default editor used by Git: 設定で、エディタ（Editor）を設定しますが、vi, vim に慣れていない方は、nano を選択することをお勧めします。（nano^[GNU nanoは、コンソールウィンドウで動作する小型でフレンドリーなテキストエディタです。(GNU nano is a small and friendly text editor running in the console window.)] は、メニューが下に出るので、それを見て操作することが可能なエディターです。）
    - Adjusting Your Path Environment: Windows の コマンドライン・ツール（command line prompt) を使っていない方は、Git Bash のインストールを選択してください。さらに、Git and optional Unix tools from the Windows Command Prompt を選択することをお勧めしますが、上で書いたように、Windows の コマンド・プロンプトになれておられる方で、それを使い続けたいかたは、Use Git from Git Bash only を選択されるのが良いかもしれません。
    - 最後に、RStudio の設定（Tools > Global Option）で、Terminal　から、Git Bash を選択^[自動的に選択されているかもしれません]し、Tools から、New Terminal を選択^[すでにタブがあればこの作業は不要です]します。
  - **Mac** は、最初から、Install されていると思います。ユーティリティ（Utility）> ターミナル（Terminal）を開いて^[RStudio を既にお使いの方は、左下の窓枠から、Terminal タブを選択できますので、それを使うことも可能です。]、`git --version` とすると、インストールされているバージョンが表示されると思います。バージョンがでない場合には、Install するかと聞かれます。このときに、Git だけをインストールすることも、Xcode という開発環境を同時にインストールすることも可能です。（インストールするように指示が出なければ、App Store からも、インストールできます。もし、そのあとで、git などのコマンドで xcrun: error などとエラーが出たら、`xcode-select --install` としてください。）インストールが終了したら、もう一度、`git --version` と Terminal に入力して、結果を確認してください。
2. GitHub のアカウント取得
  - [GitHub サイト](https://github.com) に、アカウントを作成します。アカウント名は、短く、分かりやすく、覚えやすいものをよく考えて決めてください。Email Address だけで、無償で作成できます。
3. RStudio の 左下の窓枠のTerminal タブ^[Terminal がない場合は、Tools > Terminal > New Terminal とすると表示されます。]から、GitHub アカウントに連携する設定を行います。
下の２行を、１行ずつ、コピーして、Terminal に入力してください。
```
git config --global user.name "Your Name" # GitHub の User Name
git config --global user.email "your@email.com" # GitHub に登録したメールアドレス
```
4. RStudio の、Tools > Global Opton の、Git/SVN タブを開き、Git Executable とあるところに、Git 実行プログラムのある場所を入れます。
  - **Windows** の場合は、`C:/Program Files/Git/bin/git.exe` だと思いますが、Browse ボタンから確認してください。
  - **Mac** の場合は、`/usr/bin/git` になるかと思いますが、Browse ボタンから確認してください。
5. その下に、Create RSA key とありますから、それを押し、Create ボタンを押しててください^[Passphrase (optional) と出ますが、無視してくださって構いません。]。すると、View RSA key から、暗号キーも確認できます。（この作業は、Terminal から、`ssh-keygen -t rsa` として作成することも可能です。この作業で、`~/.ssh/` 内に、SSH キーが記述されたファイルが作成されます。）
6. GitHub アカウントで公開鍵を利用できるようにします。まず、RStudio の方で作成した、RSA key （Tools の、Global Option の Git/SVN）の下にある view を押すと見ることができ、上に、書いてあるように、そこに出てきたものを、コピーします。次に、GitHubにログインし、右上のアイコンの右の三角から、設定（Setting）を選択し、SSH公開鍵（SSH and GPG Keys）を選択します。新しい公開鍵を追加（New SSH Key）を選択すると、SSH  キーを貼り付けることができます。（リポジトリの左上にある、アカウント名をクリックし現れるダッシュボードの左上の大きなアイコンをクリックしても「アカウント設定」が現れ、SSH and GPG Keysを見つけることができると思います。）

（なお、RStudio ではなく、Terminal からコピーするときは、Unix では、`pbcopy < ~/.ssh/id_rsa.pub` などとします。Windows の場合は、`pbcopy` が使えない可能性があるので、そのときは、Terminal から、Git Bash を使い、`use < ~/.ssh/id_rsa.pub` とします。Terminal に慣れておられない方には、上に紹介した、RStudio からコピーする方が簡便かと思います。）
7. これで設定終了ですので、R Studio を再起動させてください。


### GitHub にあるリモート・リポジトリ（Remote Repo）から始める場合

1. GitHub にログインして、既存のリポジトリを開きます。
2. Code の、Clone から、リンク先のアドレスを入手。https と SSH を選べますが、SSH を選び、コピーします。
3. RStudio から、New Project とし、Version Control を選択し、ディレクトリーを決めたら、上でコピーした、ものを、貼り付けて、Project を作成します。

この手続きで、リモート・リポジトリのファイルがすべて、RStudio のプロジェクトに入ります。

実はこの手続きで、公開されている、他のリポジトリも取り込むことができます。ただし、編集して、改訂していくには、自分のリポジトリに、繋ぐことになります。そのときは、次の項目を見てください。

### 自分のコンピュータのリポジトリ（Local Repo）から始める場合

1. RStudio から新しい、プロジェクト（Project） を作成 `test0` としておきましょう。
2. GitHub に、新しい、レポジトリを作成して繋げる
  - 自分の GitHub アカウントに、新しい、レポジトリをプロジェクトと同じ名前 `test0` で作成します。同じ名前でなくてもかまわないのですが、関連がしやすいので、同じ名前がお勧めです。
  - Quick Setup というページが表示されますから、その、下の Set up in Desktop or  の右から、https と SSH を選べますが、SSH を選び、コピーします。
  - プロジェクトの中の 左下の窓枠の、Terminal から次を実行します。
```
echo "# Project test0" >> README.md # REAME の表題を書きます。
git init
git add README.md
git commit -m "First commit. README.md"
git branch -M main
git remote add origin `git@github.com:icu-hsuzuki/test0.git`
# わたしのアカウントの場合には、コピーしたものを貼り付けると、上のようになります。
git push -u origin main
```

再起動すると、プロジェクトの右上の窓枠に、Git と表示されていると思います。開いて、いくつかファイル名があれば、これを選択し、Commit ボタンを押し、短い message を書いて、Commit とし、そのあとで、Push ボタンを押してください。 `HEAD -> main` と表示されれば、OK です。

### GitHub Pages について

GitHub は、Web 上のサービスですが、たとえ、リポジトリーの中に、HTML ファイルなどが存在しても、ブラウザーで表示させることはできません。公開する方法として、わたしは、以下のようにしています。

公開しブラウザーで読めるようにしたいファイルを、`docs` という ディレクトリに入れます。Setting を選択し、左の帯から、Pages を選び、Branch を、`main`、`/docs` として、Save します。すると、docs に入っているファイルは、リンクを指定すれば、ブラウザーで、見ることができます。

リンクは、まず、リポジトリーの右上の、About の右のギアマークから、Use your GitHub Pages website に、チェックを入れると、URL が表示されますから、その URL に続けて、ファイル名を加えたものが、そのファイルの、リンクとなります。

### Bookdown パッケージによる、電子書籍の執筆

[bookdown](https://github.com/rstudio/bookdown) を利用して、始める方法を簡単に記します。

Git-GitHub-RStuio の設定は済んでいると仮定して書きます。また、Bookdown を利用するには、`bookdown` パッケージのインストールが必要です。RStudio の Tools から、Install Packages を選択して、インストールしてください。また、`bs4_book` スタイルを利用する場合は、RStudio などのバージョンによっては、`bslib` と `downlit` も、インストールする必要があるようです。

以下では、R Studio で新しい、プロジェクトとして始める場合と、テンプレート・リポジトリ を使う方法を説明します。

#### RStudio での設定

1. 新しい book プロジェクトを始めます、標準設定の `book` と、`bs4_book` を選択できます。このディレクトリ（フォルダ。ローカル・リポジトリと呼びます）の名前をリモート・リポジトリの名前と同じにして、作成します^[異なる名前でも可能ですが、特別な理由がない限り同じにしておいた方が良いでしょう]。
2. Files の、Rename 機能を使って `_book` ディレクトリ（フォルダ）の名前を、`docs` に変更します。
3. `_bookdown.yml` を編集し次の行を加えます（私は２行目に入れています）。  
`output_dir: docs`  
GitHub Pages の機能を使って、公開するための変更です。
4. **\@GitHub:** 新いリポジトリー（リモート・リポジトリと言います）を作成します。ローカル・リポジトリと同じ名前にし、簡単な説明を加えます。
5. 左下の窓枠から、Terminal タブを選択します。 以下は例です。`git remote add origin` のところは、適当に変更してください。
```
echo "# ds-book" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:icu-hsuzuki/ds4aj.git # 変更
git push -u origin main
```
5. RStudio を一旦終了し、もう一度、そのプロジェクトを立ち上げると、右上の窓枠に、Git タブが表示されるはずです。
6. Build から、Build Book ボタンを利用すれば、作成されます。
7. Git タブから: Commit "first build" とし、 Push をします。
8. **\@GitHub:** Settings から、Pages > main > docs と変更すると、公開されます。
9. Code に戻り、About の右のギアマークから、



##### 他の PC での作業

1. Login to GitHub account
2. Copy SSH address under Code>Clone
3. Create a new project using Version Control:Git with the SSH address by setting the directory name
4. Edit README.md and test Git Commit and Push

#### テンプレートを利用する方法

##### bookdown-demo

[`bookdown` の電子書籍（bookdown: Authoring Books and Technical Documents with R Markdown）](https://bookdown.org/yihui/bookdown/) の、はじめてみよう（Get started）から、GitHub リポジトリー [rstudio/bookdown-demo](https://github.com/rstudio/bookdown-demo) にリンクがついています。

1. 自分の、GitHub アカウントに、ログインします。
2. [rstudio/bookdown-demo](https://github.com/rstudio/bookdown-demo) にアクセスし、Use this template から、create a new repository を選択します。
3. 自分のアカウントの中に、コピーされたリポジトリーがつくられます。
4. 上で説明した「GitHub にあるリモート・リポジトリ（Remote Repo）から始める場合」を利用してください。

よくできているテンプレートです。しかし、このままでは、公開されません。[bookdown: Authoring Books and Technical Documents with R Markdown](https://bookdown.org/yihui/bookdown/) には、いくつかの公開方法が書かれていますから、参照してください。

##### `jtr13/bookdown-template`

YouTube ビデオ [5分間で、bookdown の本を作成する方法（How to create a bookdown book in 5 minutes）](https://www.youtube.com/watch?v=m5D-yoH416Y) で紹介されているものです。

1. 自分の、GitHub アカウントに、ログインします。
2. [jtr13/bookdown-template](https://github.com/jtr13/bookdown-template) にアクセスし、Use this template から、create a new repository を選択します。
3. 自分のアカウントの中に、コピーされたリポジトリーがつくられます。
4. 上で説明した「GitHub にあるリモート・リポジトリ（Remote Repo）から始める場合」を利用してください。

ビデオの中では、簡単に、GitHub Pages（GitHub のホームページサービス）に、公開する方法が説明されています。最も、大切な部分は、テンプレートがコピーされた、自分のリポジトリの Settings から、Pages を選び、Branch を main > docs とする部分です。このようにすることで、公開されます。上の、「GitHub Pages」で説明していることと同じです。

##### 日本語テンプレート

`bs4_book` スタイルでの、簡単な、日本語テンプレートを作成しました。

1. 自分の、GitHub アカウントに、ログインします。
2. [icu-hsuzuki/bs4_book_template](https://github.com/icu-hsuzuki/bs4_book_template) にアクセスし、Use this template から、create a new repository を選択します。
3. 自分のアカウントの中に、コピーされたリポジトリーがつくられます。
4. 上で説明した「GitHub にあるリモート・リポジトリ（Remote Repo）から始める場合」を利用してください。

まだ、不十分ですが、少しずつ、改訂していきます。
使い方は、リポジトリの README に、注意点などは、最後の章 Bookdown に書いておく予定です。

### 大きなファイルに関すること

100M 未満のファイルだけを利用するのがよいですが、それより大きいものを、GitHub に挙げようとして、問題が起こることがあります。その対処法を書いておきます。

個人的には、大きなデータや、本などを、Build して、100M 以上の、非常に大きな、TeX 関連のファイルができることがありました。

備忘録も含めて、書いておきます。

#### 大きなファイルの取り除きかた

下のサイトからの引用です。非常に分かりやすく書かれています。Terminal で作業を行いますが、いま、Add した場合と、いくつか、前のステップで、Add した場合で、対応の方法が異なります。

- [Tutorial: Removing Large Files from Git](https://medium.com/analytics-vidhya/tutorial-removing-large-files-from-git-78dbf4cf83a) 
	- Scenario 1: The Large File Was Just Added in the Most Recent Commit
		- git rm --cached big_file_name
		- git commit --amend -C HEAD
	- Scenario 2: The Large File Was Committed Prior to The Most Recent Commit
		- Locating the Last “Good” Commit: git log --oneline
		- Initiate a Rebase Between the Last “Good” Commit and the Current Commit: git rebase -i 8464da4
		- This will open up a file in your Git editor (in my case, Vim), that looks something like this:
			- pick -> edit
		- git rm --cached csv_building_damage_assessment.csv
		- git commit --amend -C HEAD
		
### 複数のコンピュータから利用する方法

わたしも、いくつかのコンピュータから、同じGitHub アカウントにアクセスして作業しています。

同じSSHキーを、複数のコンピュータで利用することも可能です。特に、コンピュータの更新時に、移行する場合は、元の環境をそのまま使うことも可能で便利です。

ただし、基本的には、それぞれのコンピュータで別々のSSHキーを使用するのがお勧めです。問題が発生した時に、個別のコンピュータの課題として解決することができます。

（たとえば、RSA 形式で作成した）複数の SSH キーを使用するときは、GitHub アカウントに公開鍵を追加する必要があります。

GitHub アカウントに別の公開鍵を追加するには、GitHubにログインし、右上のアイコンの右の三角から、設定（Setting）を選択し、SSH公開鍵（SSH and GPG Keys）を選択します。新しい公開鍵を追加（New SSH Key）を選択すると、SSH  キーを貼り付けることができます。（リポジトリの左上にある、アカウント名をクリックし現れるダッシュボードの左上の大きなアイコンをクリックしても「アカウント設定」が現れ、SSH and GPG Keysを見つけることができると思います。）

コピーを貼り付ける時には、RStudio の、Global Option の、Git/SVN タブから、View public key を見ると、コピーできるようになっています。

Terminal からコピーするときは、Unix では、`pbcopy < ~/.ssh/id_rsa.pub` などとします。Windows の場合は、`pbcopy` が使えない可能性があるので、そのときは、Terminal から、Git Bash を使い、`use < ~/.ssh/id_rsa.pub` とします。Terminal に慣れておられない方には、上に紹介した、RStudio からコピーする方が簡便かと思います。

SSH キーの最後には、コンピュータ名とコンピュータのアカウント名などが入っていると思います。

この設定をすれば、どちらのマシンからでもSSH経由でGithubリポジトリにアクセスできるようになります。


### 複数のアカウントを一つのコンピュータから利用する方法

わたしも複数のGitHub アカウントを利用しています。

- ~/.ssh 内に 複数（例では三つ）、ssh-keygen -t rsa  でファイル作成
	- id_rsa , id_sub1_rsa, id_sub2_rsa
- 上の複数のコンピュータから利用する時に説明してあるように、SSH キーを GitHub に登録
- ~/.ssh 内の config ファイル（~/.ssh/config）を編集　(nano などを利用)
- ~/.gitconfig, ~/.gitconfig_sub1, ~/.gitconfig_sub2 を作成

詳しくは、参考にしたサイトを参照してください。

### 共同作業をする場合

以下では、本の共同編集を想定して、書きます。

1. 編集に関わる全員が、それぞれ、GitHub アカウントを作成します。

2. リポジトリを Fork： 共同編集する本のレポジトリにいき、フォークします。フォークすることで、編集者のリポジトリに、コピーが作成され、大元のリポジトリの変更を依頼することができます。

3. リポジトリをクローン: 編集者のコンピュータにフォークして得られたリポジトリを、クローンします。

4. 編集: 編集者のコンピュータで編集を行います。

5. 編集結果をコミット : 編集者のコンピュータで編集した後に、簡単な説明を書いて、コミットします。

6. 編集結果をプッシュ : フォークした GitHub の自分のリポジトリに、プッシュします。

7. プル依頼を作成 : 大元のリポジトリで、編集の内容を簡単に記述して、プルリクエストをします。

8. 編集結果の確認 : 大元の、リポジトリの所有者は、編集結果を確認し、承認する場合は、main に、統合します。

9. 変更の同期: 編集者は、承認された、大元のリポジトリを、フォークした自分のリポジトリに、同期させます。


### 参考にしたサイト

#### Git - GitHub - RStudio 関連

* [git -- everything is local](https://git-scm.com/about)
  - About、Documentation など
* GitHub Docs: [Hellow World](https://docs.github.com/ja/get-started/quickstart/hello-world)
  - 基本的なことがコンパクトにまとまっている GitHub のサイトです。日本語もサポートしています。
* Introduction to Data Science, by Rafael A. Irizarry
  - [Git and GitHub](http://rafalab.dfci.harvard.edu/dsbook/git.html#git)
  - edX の、データサイエンスのコースの教科書に入っています。よく、まとまっていると思います。原語は英語ですが、Google などの翻訳機能を使っても、十分理解することができると思います。Git と GitHub の概要から、Bookdown パッケージによる、電子書籍の執筆の前までは、基本的に、この教科書を参考にしていますが、それぞれのステップでの、スクリーンショットもたくさん掲載されており、確認がしやすいようになっています。

#### Bookdown 関連

* The bookdown book: https://bookdown.org/yihui/bookdown/

* The bookdown package reference site: https://pkgs.rstudio.com/bookdown

* How to create a bookdown book in 5 minutes: https://www.youtube.com/watch?v=m5D-yoH416Y

#### 複数アカウント・複数のキー関連

* [Using the same github account from multiple PCs](https://serverfault.com/questions/206907/using-the-same-github-account-from-multiple-pcs)
* [複数のGitHubアカウントを使い分けたい時の設定方法とTips](https://zenn.dev/taichifukumoto/articles/how-to-use-multiple-github-accounts)
* [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)


