# IT ツール {#tools}

> いくつかの便利なツールについて紹介します。

## Git と GitHub

Git は バージョン管理システムで、GitHub はそれを、活用し、かつ他のメンバーと協力して開発など、さまざまな活動をするためのサイトです。公開が基本となっています。非公開にすることも可能ですが、公開することで、世界中のひとたちと協力していくことが可能になりますからので、その利点も学んでいただければと思います。

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

