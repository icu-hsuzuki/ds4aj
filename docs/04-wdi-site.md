# 世界開発指標とオープンデータ {#wdi-site}

最初の例として紹介した、[はじめてのデータサイエンス](https://icu-hsuzuki.github.io/ds4aj/first-example.html#first-example)では、世界銀行（World Bank）の 世界開発指標（WDI）のひとつである、GDP（Gross Domestic Product 国内総生産）のデータを使いました。「データサイエンスをはじめましょう」では、世界開発指標をこれからも、頻繁に活用しますので、世界開発指標が、どのようなものか確認しておきましょう。

また、世界開発指標に代表されるオープンデータによって誰でも世界の課題を知り、向き合うことができるようになっています。そのオープンデータには、どのようなものなのかも、見ていきたいと思います。

## 世界開発指標（WDI）

世界開発指標は、貧困撲滅と開発援助とに取り組んでいる金融機関である世界銀行が提供している、オープンデータの一つで、世界銀行は、他にも、たくさんのデータを提供しています。

世界開発指標は、英語では、World Development Indicators（WDI）と呼びますので、以下、省略形の WDI を使います。

### 概要

まず、簡単に概要を述べておきましょう。

[World Development Indicators (WDI)](https://datatopics.worldbank.org/world-development-indicators/) は、世界銀行が開発に関する各国間比較可能なデータの集大成である1400の時系列指標（the World Bank's premier compilation of cross-country comparable data on development; 1400 time series indicators）からなっており、それらは、テーマ別にも分類されています。

また、さまざまな形式（CSV, Excel など）で、データを検索し、ダウンロードできるように整理されており、さらに、API （Application Program Interface：アプリケーションのプログラムを使ってデータを利用するための仕様）も整備されており、「データサイエンスをはじめましょう」で利用する コンピュータ言語 R でも、簡単に、検索やデータのダウンロードが可能なパッケージが提供されています。

### 三つの入り口

-   [世界開発指標（WDI）](https://datatopics.worldbank.org/world-development-indicators/) （World Development Indicators）
-   [世界銀行オープンデータ](https://data.worldbank.org) （World Bank Open Data）
-   [世界開発指標（WDI）の統計表](http://wdi.worldbank.org/tables) （World Development Indicators Statistical Tables）

三つのサイトのリンクを書きました。一つ一つみていきましょう。

まず、英語を読むことが苦手な場合は、ブラウザー（Google Chrome, Edge, Safari などのホームページ閲覧ソフト）の自動翻訳機能を使うのも良いでしょう。しかし、自動翻訳機能を利用していると、リンク先に飛べなかったり、いくつかの機能が使えないこともありますので、正常に機能しないときは、自動翻訳機能を一旦 OFF にして利用してください。

### [世界開発指標（WDI）](https://datatopics.worldbank.org/world-development-indicators/)

まずは、この[サイト](https://datatopics.worldbank.org/world-development-indicators/)がお薦めです。上の方に以下のように書かれています。

> The World Development Indicators is a compilation of relevant, high-quality, and internationally comparable statistics about global development and the fight against poverty. The database contains 1,400 time series indicators for 217 economies and more than 40 country groups, with data for many indicators going back more than 50 years.
>
> 世界開発指標は、世界的な開発と、貧困との闘いに関連する、高品質で、国際的に比較可能な統計をまとめたものです。データベースには、217の経済と40以上の国グループの1,400の時系列指標が含まれており、多くの指標のデータは50年以上前にさかのぼることができます。

この文章の下には、テーマ別のアイコンがあり、そこから、それぞれのテーマについてみていくことができるようになっています。さらにその下には、最近のニュースやお薦めの記事などが掲載されています。

#### [テーマ](https://datatopics.worldbank.org/world-development-indicators/)（さまざまなトピック・課題）

1.  貧困と不平等（Poverty and Inequality）：貧困、繁栄、消費、所得分配
2.  人々（People）：人口動態、教育、労働、健康、ジェンダー
3.  環境（Environment）：農業、気候変動、エネルギー、生物多様性、水、衛生
4.  経済（Economy）：成長、経済構造、所得と貯蓄、貿易、労働生産性
5.  国家と市場（States and Markets）：ビジネス、株式市場、軍事、通信、輸送、テクノロジー
6.  グローバルリンク（Global Links）：債務、貿易、援助への依存、難民、観光、移住

#### それぞれのテーマについて

一つテーマを選んで中身をみてみましょう。テーマを選んで、中身をみてみると、一番上に、最近のトピックなどが書かれ、次に、そのテーマについての概要や課題が書かれています。データの集め方や、どのように標準化するかなどについての説明もあります。

その下に、注目の指標（Featured Indicators）として、主要な WDI の指標のリストがあり、さらにその下には、データについての説明などが書かれています。

#### 注目の指標（Featured Indicators）

この指標も、いくつかのグループに分けられていますが、それぞれの指標には、以下のような情報があります。

-   Indicator 指標の名称

    -   マウスを当てると、より詳しい概要をみることができます。

-   Code 指標コード

    -   R の WDI パッケージなど、API を利用して、データを取得するときに必要なコードです。

    -   このコードをクリックすると、World（世界）に関する、この指標のデータをグラフが表示されます。世界に対応するデーががない場合もあります。

-   Time coverage	どの程度の期間のデータがあるかの概要

    -   1960年から10年刻みでデータがどの程度あるかを確認することができます。

-   Region coverage 地域ごとのデータの収集状況の概要

    -   ラテンアメリカ、南アジア、サハラ砂漠以南のアフリカ、ヨーロッパと中央アジア、中東と北アフリカ、東アジアと太平洋諸国、北アメリカごとに、データがどの程度揃っているかを確認することができます。

-   Get data データの取得

    -   API、XLS、CSV、DataBank とあり、データを、取得するための情報や、Excel、コンマで区切られてテキストデータが取得可能で、また、DataBank では、World Bank のデータの、表や、グラフ、地図、各データの情報などを調べることができます。この DataBank の利用については、別の項で説明します。

#### 備考

はじめてのデータサイエンスで利用した、GDP の指標は、テーマから経済（Economy）を選択すると、Featured Indicator （注目の指標）の一番上にあります。まずは、GDP について、上に書いた、Indicator、Code、Time Coverage、Region Coverage、GetData を確認してみることをお勧めします。

このサイトにあるのは、基本的な指標だけです。すべての指標についての情報を得るときには、この次とその次の項目を見てください。しかし、全体では、1400も指標があり、何をみたらよいか、かえって混乱してしまうかもしれません。まずは、このような基本的なデータで、使い方を把握してから、興味のあるデータを調べるのが良いのではないかと思います。

WDI は、すべての年、すべての国についてデータがあるわけではありません。前もって、期間や、地域ごとにどの程度データがあるかを見ておくことはとても有効です。

それぞれの指標についての概要や特定の国についての情報は、次の項目から見ることも可能ですこのページに掲載されている指標で興味をもったものについて、指標の名称や指標コードをコピー・ペーストなどで、記録しておくことをお勧めします。

### [世界銀行オープンデータ](https://data.worldbank.org)

世界銀行のオープンデータ全体にアクセスできるサイトです。上の検索窓の下に、Country（国）と Indicators（指標）と書いてあります。

その下には、いくつかのグラフや、最近のニュースやトピックが書かれており、さらにその下には、More Resources（さらに...）といくつかの項目があります。Open Data Catalog、Data Bank、などと共に、World Development Indicators もあります。このWorld Development Indicators (WDI) を選択すると、上の三つのサイトの三番目に飛びます。また、Data Bank を選択すると、三つのサイトの二番目に飛びます。

最初に書いた、Country（国）と Indicators（指標）から説明しましょう。

#### [国別サイト](https://data.worldbank.org/country)

Country（国別）のサイトを選択すると、国のリストが出てきます。

J のところに、Japan（日本）がありますから、選択してみてください。日本のさまざまな指標とグラフが出てきます。

Indicator（指標）、Most Recent Values（直近の値）、Trend（傾向）が表示されます。指標をクリックすると、大きなグラフが出てきます。その指標のサイトですから、そこで、その指標についての他の国の状況などを確認することができます。そこでは、選択した指標と似た指標が選択できたり、もっと詳しいことをしらべるデータバンク（Data Bank）へのリンクもあります。このサイトから、データをダウンロードすることもできるようになっています。

また、国別サイトの右の方には、地域など、グループに分けてある帯もあります。その一番下には、World （世界）もありますから、世界全体について見てみたり、収入の階級に分けたサイトの指標を見ることもできるようになっています。

#### [指標別サイト](https://data.worldbank.org/indicator)

Indicators（指標）を選択すると、トピックに分けて、指標が並んでいます。

よく見ると、一番上に、Featured Indicators（特徴的な指標） と、All Indicators（すべての指標） とあり、最初に開いているのは、特徴的な指標の方であることがわかります。すべての指標の方を開けると、よりたくさんの指標を見ることができます。

トピックは、以下のものに分かれています。

-   Agriculture & Rural Development 農業と農村開発
-   Aid Effectiveness 援助の有効性
-   Climate Change 気候変動
-   Economy & Growth 経済と成長
-   Education 教育
-   Energy & Mining エネルギーと鉱業
-   Environment 環境
-   External Debt 対外債務
-   Financial Sector 金融セクター
-   Gender 性別
-   Health 健康
-   Infrastructure インフラ
-   Poverty 貧困
-   Private Sector 民間部門
-   Public Sector 公共部門
-   Science & Technology 科学技術
-   Social Development 社会開発
-   Social Protection & Labor 社会的保護と労働
-   Trade 貿易
-   Urban Development 都市開発

それぞれの指標を選択すると、グラフが表示される画面が出てきます。それは、上で国別のところから選択したものと同じです。

GDP を調べるときには、NY.GDP.MKTP.CD という、コードを指定して、データを取得しました。この、Indicator Code （WDI コード）は、Details (詳細) を見ると、その指標の概要とともに、書いてあります。 そのデータコードは、そのページの上の URL にも表示されています。

はじめてのデータサイエンスでは、WDI という R のパッケージを使って、データを読み込みました。そのときに必要だったのが、この Indicator Code でした。あとで、詳しく調べてみたい指標がありましたら、その、WDIコード（Indicator Code）を、あとで、使えるように、メモなどに貼り付けて（Copy-Paste）おくことを、お勧めします。

### ダッシュボード・データの取得・データコード

さまざまな国際機関では、データを、Excel 形式や、CSV (Comma Separated Values）形式などで、提供する以外に、ダッシュボード形式で、グラフを生成するなどして、データを視覚化をある程度できるようにしています。さらに、コンピュータのアプリケーションでデータを直接取得できるように、API (Application Program Interface) を提供しています。

世界開発指標（WDI）は、これらを、すべて統一した形で提供しているために、非常に使いやすいデータベースになっています。また、上にリストしているように、1400余のさまざまなデータを提供しているために、最初に調べてみることをお勧めするデータベースです。

分析を考えると、Excel や、CSV でダウンロードして、それから、データを読み込むよりも、R で直接データを取得する方が、便利ですので、このコースでは、その方法を、説明しています。

データを探すことも、R の中ですることが可能ですが、データベースに慣れるためにも、WDI のホームページから、トピックを選択して、データを探し、説明も調べて、取得したいデータ・コードを調べることも非常に有効です。

いろいろなトピックに、どのような指標があるか調べて、興味のある、データ・コードをリストしてください。データの名前も同時に、記録しておくと良いでしょう。

## 課題

世界開発指標（WDI）の、データで、調べてみたい データコードをいくつか見つけて、書き出してください。

## オープンデータ（Open Data）

また、オープンデータについて、世界銀行は、厳密な定義をしています。

### オープンデータの定義（[Open Data Defined](http://opendatatoolkit.worldbank.org/en/essentials.html)）

オープンデータという言葉は、厳密な意味を持っています。データまたはコンテンツは、出所が明示されオープンという性質が維持されれば、誰でも自由に利用、再利用、再配布できるものを言います。

1.  データは法的にオープンでなければなりません。つまり、パブリックドメインに置かれ、最小限の制限で自由に使用できなければなりません。

2.  データは技術的にオープンでなければなりません。つまり、誰でも自由に使える一般的なソフトウェアツールを使ってデータにアクセスし、機械で読み取ることが可読な電子フォーマットで提供されていなければならなりません。パスワードやファイアウォールによる制限を受けずに、公共のサーバーで、だれでもアクセスできなければなりません。また、オープンデータを見つけやすくするために、さまざまな組織がオープンデータカタログを作成し管理してく必要があります。

<center><font size="3">データはだれのものでしょうか? パブリックデータのパブリックとは？</font></center>
