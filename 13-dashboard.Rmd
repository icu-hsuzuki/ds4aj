# ダッシュボード {#dashboard}

世界銀行のサイトで、ダッシュボードを見ました。また、Google Public Data のように、実際に、様々なグラフを作成できるサイトも見てきました。

ここでは、ダッシュボードを実際に作成することに挑戦します。

まずは、tableau public を使って、簡単なダッシュボードを作成する方法を紹介し、このあとの、サイトの紹介のときに、少しずつ、ダッシュボードを作っていきたいと思います。

わたしも、まだ初心者ですので、みなさんと一緒に学んでいくことができればと願っています。

## tableau public

### Tableau Public について

Tableau は、スタンフォード大学のコンピュータ科学者たちによって、2003年に設立された会社で、データの可視化に特化した BI（Business Intelligence）の分野のサービスを提供しています。2019年に、Salesforce の傘下に入っています。

Tableau Public は、Tableau が提供するサービスの一つで、無償でダッシュボードを作成することができます。しかし、名前が示すように、公開を原則としていますので、オープンデータ、パブリックデータ用と考えてください。他にも、様々な有償サービスを提供しています。有償サービスも、二週間ほどのお試し期間をもっているものもあります。また、有償サービスで作成したダッシュボードでも、見ることができるサービス Tableau Viewer も無償で提供されています。

詳細は、Tableau Public の初心者ガイド [[日本語版リンク](https://www.tableau.com/ja-jp/blog/beginners-guide-tableau-public)] を参照してください。

### 登録

Tableau Public の Desktop 版をダウンロードするにも、オンラインで使うにも、登録が必要です。次の順序で登録を行ってください。

1.  Tableau Public の日本語ページ（Tableau Public にようこそ）にアクセス [[リンク](https://public.tableau.com/app/discover)]

2.  Tableau Public に登録をクリック

    -   名・姓・メールアドレス・パスワードを入力・パスワードの確認

3.  確認メールが届き、それに応答すると、完了します。

4.  登録した情報でログインします。

5.  アクセス場所を Japan にすると、上の、Tableau Public の日本語ページに入ると思います。[[リンク](https://public.tableau.com/app/discover)]

    -   右上をみると、人のマークから、My Profile、Settings、Sign-Out が選択できます。

6.  上の帯の、Create から、Web Authoring と、Download Tableau Desktop Public Edition が選択できるようになっています。Download を選択して、Download Tableau Public を選択します。

7.  First Name（名）・Last Name（姓）・Business Mail（上で入力したメールアドレス）・Country/Region（Japan）とすると、下に、Salesforce の情報を受け取る、情報の他国への共有と出ますから、両方ともチェックをして、次へ進むと、ダウンロードできます。

    -   ダウンロードが始まらなければ、Windows または Mac を選択と出ますから、必要に応じて選択してください。

8.  インストールをします。問題なくできると思います。

あとは、Tableau Public アプリケーションを起動させて使います。他に、上で、Create から、Web Authoring を選択して、Cloud 上で、作成することも可能です。

ただ、個人的な経験としては、途中で、保存すると、公開することになるので、放っておくと、作成したものが消えてしまうこともあるので、なれるまでは、Desktop を使ったほうがよいように思います。あまり、気にせず、Publish するのでも、よいと思います。

なを、ダウンロードすると、ログインしたときに、はいるページが開くかと思いますが、英語版が表示されるかもしれません。その時は、一番下の帯の左はしで、言語を変更できるようになっていますから、そこで [日本語] を選択すれば、日本語になります。

### 無料トレーニングビデオ

Tableau Public の上の、Create の隣の詳細情報を選択すると、入門ビデをがあります。ちょっと早くて、ついていくのが大変かもしれませんが、雰囲気はわかりますから、見てみるのもよいと思います。

このページには、サンプルデータもあり、それを使ったビデオもあります。

YouTube にも、たくさん、ビデオが出ています。

### はじめてのダッシュボード

はじめてのデータサイエンスで使った、WDI の GDP のデータを使います。そこで紹介したように、R の WDI パッケージでダウンロードすることもできますが、ここでは、直接的にサイトからダウンロードして始めます。

1.  NY.GDP.MKTP.CD

### いくつかのダッシュボードを作成してみよう

[リンク](https://public.tableau.com/views/BubbleChartofGDPPerCapandLifeExpectancywithPOP/All?:language=ja-JP&publish=yes&:display_count=n&:origin=viz_share_link)

```{=html}
<iframe src="https://public.tableau.com/views/BubbleChartofGDPPerCapandLifeExpectancywithPOP/All?:language=ja-JP&publish=yes&:display_count=n&:origin=viz_share_link" width="600" height="400" frameBorder="0" scrolling="no"></frame>
```
### 参考

-   Tableau Public Home: [Tableau Public にようこそ](https://public.tableau.com/)
