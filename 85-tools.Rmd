# IT ツール {#tools}

> いくつかの便利なツールについて紹介します。

## Git と GitHub

Git は バージョン管理システムで、GitHub はそれを、活用し、かつ他のメンバーと協力して開発など、さまざまな活動をするためのサイトです。公開が基本となっています。非公開にすることも可能ですが、公開することで、世界中のひとたちと協力していくことが可能になりますからので、その利点も学んでいただければと思います。

### 概要

RStudio で R を使っている場合、Git-GitHub-RStudio の連携で使うことをお勧めします。しかし、これらは、三つとも、まったく異なるものですから、簡単な概要を書いておくことにします。

#### Git

これは、バージョンを管理システムで、単独で機能します。他の、プログラムなどに関係しない、他のファイルであっても、バージョンを管理する場合に活用できます。また、基本的には、Unix の Shell プログラムで動作させるのが一般的です。Mac では、最初から、Utility> Terminal で、Shell コマンドが利用可能になっていますが、Windows の場合には、bash と呼ばれる Shell プログラムをインストールすることをお勧めします。Windows システムについてよくご存知の方は、他の方法を使っていただいて構いませんが、Git の孫ストールの時に、Git bash を選択して、簡単に インストールできますし、Mac とも同じ環境で説明できますから、ここでは、そちらを使います。

基本的なコマンドとしては、以下のものがあります。

* `git init`: 特定のディレクトリ（フォルダ）で バージョン管理を始める時に使います。
* `git status`: 現在の状況を確認するときに使います。
* `git diff file_name`: ファイルへの変更を確認します。
* `git log`: 過去の commit による履歴を確認する時に使います。
* `git add file_name`: ステージングという中間的な場所に登録します。
* `git commit -m "log message here"`: ステージングにあるものを、確定させます。引用符で囲まれた短いコメントを加えます。50文字が上限です。

#### Git Hub

Git でバージョン管理されているディレクトリ（フォルダ）の状態を示す、クラウドサービスです。更新されている、状態を確認するとともに、変更履歴なども確認できます。また、Git Hub サービスを利用して、ファイルを公開、共有することも可能です。Pages サイトを利用することで、ホームページとして HTML ファイルなどを公開することも可能です。

最初に、Git で管理されている、ディレクトリ（フォルダ）（これを、ローカル・リポジトリと言います）と、GitHub 内のリポジトリ（リモート・リポジトリと言います）を結びつけるステップが必要です。

#### RStudio 連携

コマンドライン（シェル）で行う作業や、ローカル・リポジトリを、リモート・リポジトリに結びつける作業を、RStudio の中で行うことが可能です。

### はじめかた

1. Git のインストール
  - Windows と Mac で異なりますので注意が必要です。
  - Windows の場合は、[git-scm](https://git-scm.com/download/win) にアクセスしてダウンロード、インストールしてください。
    - 設定で、Editor を設定しますが、vi, vim に慣れていない方は、nano を選択することをお勧めします。Windows の command line tool を使っていない方は、Git Bash のインストールを選択してください。最後に、RStudio の設定（Tools > Global Option）で、Terminal　から、Git Bash を選択します。
  - Mac は、最初から、Install されていると思います。Utility>Terminal を開いて、`git --version` とすると、インストールされているバージョンが表示されると思います。
2. GitHub のアカウント取得
  - [GitHub サイト](https://github.com) に、アカウントを作成します。アカウント名は、短く、分かりやすく、覚えやすいものをよく考えて決めてください。Email Address だけで、無償で作成できます。
3. RStudio から、GitHub アカウントに連携する設定を行います。
```
git config --global user.name "Your Name"
git config --global user.mail "your@email.com"
```
4. RStudio の、Tools>Global Option から、Git/SVN を設定します。RSA キーを作成

### GitHub のリポジトリ（Remote Repo）から始める場合

1. GitHub にログインして、リポジトリを作成します。Create a new Repository
2. Code の、Clone から、リンク先のアドレスを入手
3. RStudio から、Version Control を利用して、Project を作成

### 自分のコンピュータのリポジトリ（Local Repo）から始める場合

1. RStudio から新しい、Project を作成
2. GitHub に、新しい、レポジトリを作成して繋げる

### Bookdown パッケージによる、電子書籍の執筆

[bookdown](https://github.com/rstudio/bookdown) を利用して、始める方法を簡単に記します。

Git-GitHub-RStuio の設定は済んでいると仮定して書きます。

#### RStudio での設定

1. 新しい book プロジェクトを始めます、標準設定の `book` と、`bs4_book` を選択できます。このディレクトリ（フォルダ。ローカル・リポジトリと呼びます）の名前をリモート・リポジトリの名前と同じにして、作成します^[異なる名前でも可能ですが、特別な理由がない限り同じにしておいた方が良いでしょう]。
2. Files の、Rename 機能を使って `_book` ディレクトリ（フォルダ）の名前を、`docs` に変更します。
3. `_bookdown.yml` を編集し次の行を加えます（私は２行目に入れています）。  
`output_dir: docs`  
GitHub Pages の機能を使って、公開するための変更です。
4. **\@GitHub:** 新いリポジトリー（リモート・リポジトリと言います）を作成します。ロー角・リポジトリと同じ名前にし、簡単な説明を加えます。
5. 左下の窓枠から、Terminal タブを選択します。  
  5.1. `git init`  
  5.2. `git add README.md`  
  5.3. `git commit -m "first commit"`  
  5.4. `git branch -M main`  
  5.5. `git remote add origin git@github.com:icu-hsuzuki/ds4aj.git`  
    適当に変更します。GitHub のコードから取得可能です。  
  5.6. `git push -u origin main`  
5. Restart R Studio
6. Build Book
7. Git: Commit "first build" > Push
8. **\@GitHub:** Settings から、Pages > main > docs と変更する。

#### 他の PC での作業

1. Login to GitHub account
2. Copy SSH address under Code>Clone
3. Create a new project using Version Control:Git with the SSH address by setting the directory name
4. Edit README.md and test Git Commit and Push


#### 参考にしたもの

* The bookdown book: https://bookdown.org/yihui/bookdown/

* The bookdown package reference site: https://pkgs.rstudio.com/bookdown

* How to create a bookdown book in 5 minutes: https://www.youtube.com/watch?v=m5D-yoH416Y


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

### 参考にしたサイト

* GitHub Docs: [Hellow World](https://docs.github.com/ja/get-started/quickstart/hello-world)
  - 基本的なことがコンパクトにまとまっている GitHub のサイトです。日本語もサポートしています。
* Introduction to Data Science, by Rafael A. Irizarry
  - [Git and GitHub](http://rafalab.dfci.harvard.edu/dsbook/git.html#git)
  - edX の、データサイエンスのコースの教科書に入っています。よく、まとまっていると思います。原語は英語ですが、Google などの翻訳機能を使っても、十分理解することがdけいると思います。

