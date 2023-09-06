# 世界銀行（World Bank） {#worldbank-site}

## 概要

世界銀行は、貧困削減と持続的成長の実現に向けて、途上国政府に対し融資、技術協力、政策助言を提供する国際開発金融機関です。2030年までに極度の貧困をなくし、各国の下位40パーセントの人々の所得を引き上げて繁栄の共有を促進するという2つの目標を掲げています。

世界銀行の[サイト](https://www.worldbank.org/en/home)を見てみると、下の方にはグラフも出ており、さまざまな統計データを提供することに力を入れていることがわかります。

すでに、世界開発指標については、簡単に説明しました。ここでは、世界銀行のサイトの中のデータについて、見ていくとともに、ダッシュボード（dashboard）の活用、データの取得方法や、API （Application Program Interface）を用いて、R でデータを検索したり、取得するパッケージの紹介を簡単にします。

## データベース

### 三つのサイト

-   [世界銀行オープンデータ](https://data.worldbank.org)
-   [データカタログ](https://datacatalog.worldbank.org/home)
-   [世界開発指標（WDI）](https://datatopics.worldbank.org/world-development-indicators/)

一つ一つみていきましょう。

英語を読むことが苦手な場合は、ブラウザー（Google Chrome, Edge, Safari などのホームページ閲覧ソフト）の自動翻訳機能を使うのも良いでしょう。しかし、自動翻訳機能を利用していると、リンク先に飛べなかったり、いくつかの機能が使えないこともありますので、正常に機能しないときは、自動翻訳機能を一旦 OFF にして利用してください。

### [世界銀行オープンデータ](https://data.worldbank.org)

世界銀行のオープンデータ全体にアクセスできるサイトです。上の検索窓の下に、Country（国）と Indicators（指標）と書いてあります。

その下には、いくつかのグラフや、最近のニュースやトピックが書かれており、さらにその下には、More Resources（さらに...）といくつかの項目があります。Open Data Catalog、Data Bank、などと共に、World Development Indicators もあります。このWorld Development Indicators (WDI) を選択すると、上の三つのサイトの三番目に飛びます。また、Data Bank を選択すると、三つのサイトの二番目に飛びます。

最初に書いた、Country（国）と Indicators（指標）から説明しましょう。

#### [国別サイト](https://data.worldbank.org/country)

Country（国別）のサイトを選択すると、国のリストが出てきます。

J のところに、Japan（日本）がありますから、選択してみてください。日本のさまざまな指標とグラフが出てきます。

Indicator（指標）、Most Recent Values（直近の値）、Trend（傾向）が表示されます。指標をクリックすると、大きなグラフが出てきます。その指標のサイトですから、そこで、その指標についての他の国の状況などを確認することができます。そこでは、選択した指標と似た指標が選択できたり、もっと詳しいことを調べるデータバンク（Data Bank）へのリンクもあります。このサイトから、データをダウンロードすることもできるようになっています。

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

### [オープンデータカタログ（Open Data Catalog）](https://datacatalog.worldbank.org/home)

> The Data Catalog is designed to make World Bank's development data easy to find, download, use, and share. It includes data from the World Bank's [microdata](https://microdata.worldbank.org/), [finances](http://finances.worldbank.org/) and [energy data](https://energydata.info/) platforms, as well as datasets from the [open data catalog.](https://data.worldbank.org/) There are different ways to access and download datasets.
>
> データカタログは、世界銀行で編纂した開発に関するデータを簡単に検索、ダウンロード、使用、共有できるように設計されています。これには、世界銀行の[マイクロデータ](https://microdata.worldbank.org/)、[財務](http://finances.worldbank.org/)、[エネルギーデータ](https://energydata.info/)プラットフォームからのデータ、および[オープンデータカタログ](https://data.worldbank.org/)からのデータセットが含まれています。データセットにアクセスしてダウンロードするには、さまざまな方法があります。

世界銀行（World Bank）で編纂したり、他の機関から提供を受けたデータがリストされています。

一番上には、Search Box（検索窓）があり、その下には、Featured （特徴的な、またはお薦め）とあり、いくつものトピックが並んでいます。右に、スクロールするとさらにいくつものトピックを見ることができます。その中にも、上で述べた 世界開発指標（WDI）もありますし、Covid-19 （コロナウイルス感染症）関連のデータもあります。

それぞれの、トピックに、関連のデータがリストされています。

### 世界銀行（World Bank）

このページの最初にも書きましたが、簡単にまとめておきましょう。

-   世界銀行（World Bank）: <https://www.worldbank.org>
-   [世界銀行について（Who we are）](https://www.worldbank.org/en/who-we-are):
    -   極度の貧困状態の削減（To end extreme poverty）: 2030年までに、極度の貧困状態にある世界人口の割合を3%に削減する。By reducing the share of the global population that lives in extreme poverty to 3 percent by 2030.
    -   繁栄を共に享受（To promote shared prosperity）: すべての国の最貧困層の40％の人々の所得を増加させることによって共栄を促進。By increasing the incomes of the poorest 40 percent of people in every country.
-   世界銀行オープンデータ（World Bank Open Data）: <https://data.worldbank.org>
    -   Data Bank, World Development Indicators, etc.

日本について：<https://data.worldbank.org/country/japan?view=chart>

### 世界開発指標（World Development Indicator）

すでに紹介しましたが、簡単にまとめておきます。

-   [World Development Indicators (WDI)](https://datatopics.worldbank.org/world-development-indicators/) : 世界銀行が開発に関する各国間比較可能なデータの集大成である1400の時系列指標（the World Bank's premier compilation of cross-country comparable data on development; 1400 time series indicators）
    -   テーマ別（Themes）: 貧困と格差、人間、環境、経済、国家と市場、グローバルリンク集（Poverty and Inequality, People, Environment, Economy, States and Markets, Global Links）
    -   オープンデータとデータバンク（Open Data & DataBank）: Explore data, Query database
    -   すべてのデータおよびメタデータを Excel または CSV 形式で、一括してダウンロードすることもできるようになっています。Bulk Download:
    -   コンピュータを使って読み込む場合のデータの仕様が書かれています。API（Application Program Interface）Documentation

1400ものデータがありますから、すべてのデータやメタデータをダウンロードすれば、すぐ、データを調べることができるわけではありません。基本的なことをおく必要がありますね。上にもリンクのある、データカタログから、世界開発指標（World Development Indicators）を選択すると、次のサイトに[リンク](https://datacatalog.worldbank.org/search/dataset/0037712/World-Development-Indicators)がついています。

このページからは、Databank（ダッシュボード）へのリンクなどの他、Excel ファイルや、CSV ファイルで、メタデータを取得することもできるようになっています。WDI 全部のリストもここで見ることができます。このファイルから探すのが最適とは言えませんが、そのようなファイルを持っておくことは便利です。

## ダッシュボード（Dashboard）

世界銀行のダッシュボードには二種類あります。一つは、それぞれの指標についてのダッシュボード、もう一つは、データバンク（DataBank）です。

### World Bank アカウント

ダッシュボードは、リンクにアクセスすれば、アカウントなどを作成せず、すぐに使えます。しかし、ダッシュボードを使って、グラフを作成したり、自分用の、データを作成したりした場合には、その結果を、保存をしたり、リンク（iframe 形式）を、文書に埋め込んだりする必要を感じる場合があります。その場合には、一般用アカウントを作成する必要があります。この[サイト](https://login.worldbankgroup.org/worldbankgroupb2c.onmicrosoft.com/b2c_1_wbg-solexternal_sisu/oauth2/v2.0/authorize?client_id=7077d845-b099-4fca-9f1b-8fcaade1524c&scope=openid%20profile%20offline_access&redirect_uri=https%3A%2F%2Fpip.worldbank.org%2Fsol%2F&client-request-id=a3010f0e-81e7-45c4-b519-d8e044d3a89b&response_mode=fragment&response_type=code&x-client-SKU=msal.js.browser&x-client-VER=2.34.0&client_info=1&code_challenge=Ome3V78SVvRRXZvJ3DjMvKDuE5CE-N59RHOY09WJ_LY&code_challenge_method=S256&nonce=0a59c36f-97dd-4369-a233-544b6a6393eb&state=eyJpZCI6Ijc3M2MxM2MzLTg5OTItNDEwMS05MmJkLWYyZThmZDQwNjdlZiIsIm1ldGEiOnsiaW50ZXJhY3Rpb25UeXBlIjoicmVkaXJlY3QifX0%3D)の Sign Up から、アカウントを作成してください。

### 指標毎のダッシュボード

はじめてのデータサイエンスで使った、GDP (Current US\$)、データコード NY.GDP.MKTP.CD についてみてみましょう。

いくつかの方法があります。

1.  [世界銀行オープンデータ](https://data.worldbank.org) から、指標（Indicator）を選択し、その中の Economy & Growth（経済と成長）の中から、[GDP (current US\$)](https://data.worldbank.org/indicator/NY.GDP.MKTP.CD?view=chart) を選択すると、ダッシュボードが現れ、世界の GPD の推移のグラフが表示されます。
2.  [世界銀行オープンデータ](https://data.worldbank.org) から、国（Country）を選択し、例えば、J から、Japan を選択し、Economics（経済）の指標の [GDP (current US\$)](#0) を選択すると、ダッシュボードが現れ、日本の GDP の推移のグラフが表示されます。指標によっては、上の、Theme（テーマ）や、Topic（トピック）から選ぶ必要がある場合もあります。
3.  [世界開発指標（WDI）](https://datatopics.worldbank.org/world-development-indicators/)の Data Theme（テーマ）の中の、ECONOMY（経済） の中から、[GDP (current US\$)](https://data.worldbank.org/indicator/NY.GDP.MKTP.CD?view=chart) を選択すると、ダッシュボードが現れ、世界の GPD の推移のグラフが表示されます。
4.  もし、WDI コード（この場合は、NY.GDP.MKTP.CD）を知っていれば、このコードを、[世界銀行オープンデータ](https://data.worldbank.org) の検索窓に入れて検索すると、上のダッシュボードのページが表示されます。

最初は、選択した指標について、世界か、日本など選択した国の、折れ線グラフ（Line Graph）が表示されていると思います。そして、下の方に、国のリストがあり、その一番下には、地域のリストが続いています[^12-worldbank-site-1]。また、Line （折れ線グラフ）と書いた右には、Bar（棒グラフ）と、Map（地図）とあります。

[^12-worldbank-site-1]: アルファベットの昇順になっていますが、そのリストの Country（国）の右にある ⌃型のマークを押すと⌵に変わり、降順になります。

その右には、Also Show （追加）とあり、Aggregates（総合）、Same Region（同じ地域）、Similar Values（近い値）、Highest Values（最高値）、Lowest Values（最小値）を表示することもできます。表示しないときは、None を選択します。

その右には、Share（共有）と、Details（詳細）があります。詳細には、その指標についての、詳しい説明があります。すべてを理解することはできないかもしれませんが、翻訳機能も使って、確認しておくことをお勧めします。詳細には、データコードも書かれています。記録しておくと、次に同じ指標のデータを探すときに便利です。共有からは、Web Page や、SNS に埋め込む、iframe link を取得することができます。

右の方の帯には、関連する指標がリストされ、さらに、Download（ダウンロード）、Data Bank（データバンク）、WDI Tables （統計表）へのリンクがあります。

#### 使い方

具体例としては、GDP（Current US\$）の世界（World）のグラフが表示されているとします。上の検索窓に GDP（Current US\$）と入っていると思います。

-   国や地域の追加

    -   英語で入力しますから、グラフの下の、国や地域名のところから、追加したい、国や地域名を選んで、書き出しておいてください。一つずつ追加するときは、コピーするのも良いかもしれません。

    -   日本をグラフに追加するときは、Japan ですから、検索窓に、Japan と入れて**少し待ちます**。すると、窓の下に、Japan が表示されますから、それを選択（クリック）します。すると、日本のグラフに変わります。India も加えてください。次に、検索窓に、United と入力すると、United Kingdom, United States, United Arab Emirates が表示されますから、United Kingdom を選択してください。Japan, India, United Kingdom の三つの国のグラフが同時に表示されます。これによって、いくつかの国のその指標における経年変化を比較することができます。

    -   いろいろな国や地域を加えてみてください。たとえば、GDP を指標として、United States を加えると、United States の GDP の値が大きいため、他の国のグラフは下の方に重なり合うようになります。Afghanistan を加えると、ある年以前のデータがなかったり、値がとても小さいために、X 軸に張り付くようになってしまったりします。みやすいグラフを表示するには、どのようなものの比較をするかも重要になってくることがわかると思います。

    -   追加した国や地域を消すのは、単にその国名の、右に表示される x マークを選択すれば良いですし、Delete キーでも消去できます。

    -   実は、Japan など一つの国を加えてからあとは、下の国名などのリストから、追加したい国を選択すると、追加されていきます。検索窓に入れるよりも簡単だと思います。

-   Also Show の活用

    -   上に書いたように、Aggregates（総合）、Same Region（同じ地域）、Similar Values（近い値）、Highest Values（最高値）、Lowest Values（最小値）を追加できます。たとえば、Japan（日本）だけを残しておいて、Same Region を選択すると、いくつかの国の値が、薄く表示されます。地域名をみると、これは、East Asia & Pacific（東アジアと太平洋地域）であることが推測されます。

    -   そこで、East Asia & Pasific を選択すると、その地域の総計の値が追加されます。

#### データダウンロード

R のパッケージを用いたデータのダウンロードについてはあとから述べますが、指標毎のダッシュボードの右の帯のダウンロードからも、データをダウンロードすることができます。

CSV（Comma Separated Values）、XML（Extensible Markup Language）、EXCEL（Micosoft Excel Spreadsheet） と三つの形式でデータを取得できます。それぞれ、R などで読み込むことができます。ただし、CSV と、XML は、Zip 形式の圧縮ファイルになっています。EXCEL は、三つのシート（Data, Metadata - Countries, Metadata - Indicators）が一つの、ブックになっています。Metadata（メタデータ）は、データのデータで、データについての情報が収められています。

### データバンク（DataBank）

上で説明した指標毎のダッシュボードの右の帯からも、データバンクのダッシュボードが開きますが、[世界銀行オープンデータ](https://data.worldbank.org) の下にある、データバンクを選択すると、リストが表示されます。ここで、ある程度選択してから、ダッシュボードを表示させることもできます。一番上に、World Development Indicators（世界開発指標）がありますから、選択してください。あとから、他のものに変更することも可能です。

表が表示され、左の方に、Variables（変数）、Layout（レイアウト）、Styles（形式）、Save（保存）、Share（共有）、Embed（埋め込み） とあり、右上には、Table（表）、Chart（グラフ）、Map（地図）、Metadata（メタデータ） とあり、その下には、Preview（表示）などとなっていると思います。

膨大なデータを選択し、形式を整えて、ダウンロードしたり、グラフを表示したりすることができます。

#### 例1

まずは、一つ目の例として、GDP (Current US\$) の値を大きい方から国順に並べてみましょう。

1.  Variable の Database で、World Development Indicators を選択します。

2.  Countries では、上に、All、Countries、Aggregates とありますから、Countries を選択します。

3.  一番左のチェックボックス Select All（すべて選択）を選びます。これで国が全部選択されました。現在ですと、Selected 217 と出ています。

4.  Series は、いくつか選択されている可能性がありますから、X マークを選択して、まずは、全部選択を解除し、次に、GDP (current US\$) にチェックを入れます。Selected 1 となっていることを確認してください。

5.  Time の一番左のチェックボックスから、Select All にしてください。現在では、Selected 63 と表示されました。

6.  右の方に、Selections have been modified ... （選択が変更されました ...）と出ますので、Apply Changes（変更を適用）を選びます。

7.  上の Layout タブを選択し、Time を Column（列）、Country を Row（行）、Series を Page（ページに指定します）

ここまでで、Table に、GDP (current US\$) についての表が表示されていることを確認してください。

これを書いている時点では、2022年が最も新しいデータで、2022 の年のところをクリックすると、最初は、国名のアルファベット順になっていると思いますが、それが、その指標の値の、昇順、降順に変更できます。ここでは、GDP が大きな値の順に並べたいので、降順にします。

10位までの国は、United States, China, Japan, Germany, India, United Kingdom, France, Russian Federation, Canada, Italy となっているかと思います。

<iframe frameBorder="no" src="https://databank.worldbank.org/embed/GDP—current-US$/id/66aaa928?ti=y&amp;ds=n&amp;dd=y&amp;tb=y&amp;sh=y&amp;dw=y&amp;pr=y&amp;inf=y&amp;zm=y&amp;md=y&amp;navigator=n&amp;theme=darkGrey&amp;bdrClr=rgb(68,68,68)&amp;bdrStyle=solid&amp;bdrWidth=0px&amp;title=Arial;14px;true;false;rgb(68,68,68);justify&amp;exptypes=Excel,CSV,TabbedTxt" width="500" height="425">

</iframe>

#### 例2

2022年の値で、10位までの国を選択して、折れ線グラフや、棒グラフなどを書いてみましょう。

1.  Variables の Countries の X で選択を解除し、上の10カ国を選んでください。
2.  右の方に、Selections have been modified ... （選択が変更されました ...）と出ますので、Apply Changes（変更を適用）を選びます。すると表が10カ国のものに変わります。
3.  上の、Styles を選択し、Chat Type & Style で、Line（折れ線グラフ）を選択すると、しばらくして、10カ国の、折れ線グラフを表示させることができます。色も変更することも可能です。
4.  Chat Type & Style で Horizontal Bar を選択し、Layout で、

<iframe frameBorder="no" src="https://databank.worldbank.org/embed/Line-graph-of-GDP-of-top-10-countries/id/ff8c5a74?ti=y&amp;ds=n&amp;dd=y&amp;tb=y&amp;sh=y&amp;dw=y&amp;pr=y&amp;inf=y&amp;zm=y&amp;md=y&amp;navigator=n&amp;theme=darkGrey&amp;bdrClr=rgb(68,68,68)&amp;bdrStyle=solid&amp;bdrWidth=0px&amp;title=Arial;14px;true;false;rgb(68,68,68);justify&amp;exptypes=Excel,CSV,TabbedTxt" width="500" height="425">

</iframe>

以下では、変数（Variables）の選び方と、グラフ（Chart）について簡単に説明します。

#### 変数（Variables）

Database、Country、Series、Time とあり、それぞれの右に、Available と Selected とあります。

どのデータベースについて、国を選択し、系列を選び、期間を選択するという形式になっています。

Database の左の三角印を選択すると、データベース名が確認できます。現在は、World Development Indicators が選択されています。ここで、他のデータベースに変更することも可能ですが、まずは、そのままにしましょう。

次は、Countries（国）です。All、Countries、Aggregates と一番上にあります。国だけを表示するか、地域やグループを表示するか、すべてを表示するかを選択できます。

簡単のために、まずは、Countries（国）を選択しましょう。

国がいくつか選択されている場合もありますから、X マークをクリックして、すべて選択を消去し、国を選んでみましょう。GDP のところで経験したように、GDP の多い方から、United States、China、Japan、Germany、India、United Kingdom、France を選択してみましょう。

#### GDP per capita (constant 2015 US\$)

実質GDP（2015年を基準にしたもの）を、総人口で割った値。アメリカ合衆国、英国、ドイツ、フランス、日本、中国、日本、ロシア、ウクライナの2021年における比較棒グラフ - [リンク](https://data.worldbank.org/indicator/NY.GDP.PCAP.KD?locations=JP-GB-RU-FR-CN-US-UA-DE&start=2021&end=2021&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2021&amp;indicators=NY.GDP.PCAP.KD&amp;locations=JP-GB-RU-FR-CN-US-UA-DE&amp;start=2021&amp;view=bar" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

年次変化を示す折線グラフ -

<iframe src="https://data.worldbank.org/share/widget?end=2021&amp;indicators=NY.GDP.PCAP.KD&amp;locations=JP-GB-RU-FR-CN-US-UA-DE&amp;start=1960&amp;view=chart" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

#### Central government debt, total (% of GDP)

2020年の政府の負債（GDP の百分率）- [リンク](https://data.worldbank.org/indicator/GC.DOD.TOTL.GD.ZS?locations=JP-GB-RU-FR-CN-US-UA-DE&start=2020&end=2020&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2020&amp;indicators=GC.DOD.TOTL.GD.ZS&amp;locations=JP-GB-RU-FR-CN-US-UA-DE&amp;start=2020&amp;view=bar" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

政府の負債（GDP の百分率）の年次変化を示す折線グラフ <iframe src="https://data.worldbank.org/share/widget?indicators=GC.DOD.TOTL.GD.ZS&locations=JP-GB-RU-FR-CN-US-UA-DE" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

#### CO2 emissions (metric tons per capita)

CO2 排出量 (1 人あたりのメートル トン) - [リンク](https://data.worldbank.org/indicator/EN.ATM.CO2E.PC?locations=JP-GB-RU-FR-CN-US-UA-DE&start=2019&end=2019&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2019&amp;indicators=EN.ATM.CO2E.PC&amp;locations=JP-GB-RU-FR-CN-US-UA-DE&amp;start=2019&amp;view=bar" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

CO2 排出量 (1 人あたりのメートル トン) の年次変化の折線グラフ

<iframe src="https://data.worldbank.org/share/widget?end=2019&amp;indicators=EN.ATM.CO2E.PC&amp;locations=JP-GB-RU-FR-CN-US-UA-DE&amp;start=1990&amp;view=chart" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

#### Military expenditure (% of GDP)

2021年の軍事費 (GDP の %) - [リンク](https://data.worldbank.org/indicator/MS.MIL.XPND.GD.ZS?locations=JP-GB-RU-FR-CN-UA&start=2021&end=2021&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2021&amp;indicators=MS.MIL.XPND.GD.ZS&amp;locations=JP-GB-RU-FR-CN-UA&amp;start=2021&amp;view=bar" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

軍事費 (GDP の %) の年次変化

<iframe src="https://data.worldbank.org/share/widget?indicators=MS.MIL.XPND.GD.ZS&amp;locations=JP-GB-RU-FR-UA-KR-DE&amp;view=chart" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

#### Military expenditure (current USD)

2021年の軍事費 (現在の米ドル)

<iframe src="https://data.worldbank.org/share/widget?end=2021&amp;indicators=MS.MIL.XPND.CD&amp;locations=JP-GB-RU-FR-CN-UA&amp;start=2021&amp;view=bar" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

軍事費の年次変化

<iframe src="https://data.worldbank.org/share/widget?indicators=MS.MIL.XPND.CD&amp;locations=JP-GB-RU-FR-UA-KR-DE&amp;view=chart" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

#### Proportion of seats held by women in natinal parliaments (%)

2021年、国会で女性が占める議席の割合 (%) - [リンク](https://data.worldbank.org/indicator/SG.GEN.PARL.ZS?locations=JP-GB-RU-FR-CN-US-UA-DE&start=2021&end=2021&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2021&amp;indicators=SG.GEN.PARL.ZS&amp;locations=JP-GB-RU-FR-CN-US-UA-DE&amp;start=2021&amp;view=bar" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

国会で女性が占める議席の割合 (%) の年次変化

<iframe src="https://data.worldbank.org/share/widget?indicators=SG.GEN.PARL.ZS&amp;locations=JP-GB-RU-FR-CN-US-UA-DE" width="450" height="300" frameBorder="0" scrolling="no">

</iframe>

### 世界のさまざまな課題から見る

## API

世界銀行（World Bank）の API を利用した R のパッケージを二つ紹介します。

### WDI

Search and download data from over 40 databases hosted by the World Bank, including the World Development Indicators ('WDI'), International Debt Statistics, Doing Business, Human Capital Index, and Sub-national Poverty indicators.

世界開発指標(「WDI」)、国際債務統計、Doing Business、人的資本指数、準国家貧困指標など、世界銀行が主催する40以上のデータベースからデータを検索してダウンロードします。

-   R のパッケージサイト：[https://CRAN.R-project.org/package=WDI](https://cran.r-project.org/package=WDI)

-   資料（Materials）：<https://cran.r-project.org/web/packages/WDI/readme/README.html>

-   マニュアル（Manual）：<https://cran.r-project.org/web/packages/WDI/WDI.pdf>

-   使い方の例：<https://vincentarelbundock.github.io/WDI/>

### wbstats

Programmatic Access to Data and Statistics from the World Bank API

世界銀行APIからのデータと統計へのプログラムによるアクセス

-   R のパッケージサイト：[https://CRAN.R-project.org/package=wbstats](https://cran.r-project.org/package=wbstats)

-   資料（Materials）： [README](https://cran.r-project.org/web/packages/wbstats/readme/README.html)

-   マニュアル（Manual）：<https://cran.r-project.org/web/packages/wbstats/wbstats.pdf>

-   使い方の例（Vignette）：<https://cran.r-project.org/web/packages/wbstats/vignettes/wbstats.html>

## Google Analytics

<https://www.google.co.jp/publicdata/directory?hl=en_US&dl=en_US#!>
