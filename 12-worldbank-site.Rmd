# 世界銀行（World Bank） {#worldbank-site}

## 概要

世界銀行は、貧困削減と持続的成長の実現に向けて、途上国政府に対し融資、技術協力、政策助言を提供する国際開発金融機関です。2030年までに極度の貧困をなくし、各国の下位40パーセントの人々の所得を引き上げて繁栄の共有を促進するという2つの目標を掲げています。

世界銀行の[サイト](https://www.worldbank.org/en/home)を見てみると、下の方にはグラフも出ており、さまざまな統計データを提供することに力を入れていることがわかります。

-   World Bank: <https://www.worldbank.org>
-   [Who we are](https://www.worldbank.org/en/who-we-are):
    -   To end extreme poverty: By reducing the share of the global population that lives in extreme poverty to 3 percent by 2030.
    -   To promote shared prosperity: By increasing the incomes of the poorest 40 percent of people in every country.
-   World Bank Open Data: <https://data.worldbank.org>
    -   Data Bank, World Development Indicators, etc.

### 世界開発指数（World Development Indicator (WDI)）

-   [World Development Indicators (WDI)](https://datatopics.worldbank.org/world-development-indicators/) : the World Bank's premier compilation of cross-country comparable data on development; 1400 time series indicators
    -   Themes: Poverty and Inequality, People, Environment, Economy, States and Markets, Global Links
    -   Open Data & DataBank: Explore data, Query database
    -   Bulk Download: Excel, CSV
    -   API Documentation

## データベース

## 三つのサイト

-   [世界銀行オープンデータ](https://data.worldbank.org)
-   [データカタログ](https://datacatalog.worldbank.org/home)
-   [世界開発指標（WDI）](https://datatopics.worldbank.org/world-development-indicators/)

三つのサイトのリンクを書きました。一つ一つみていきましょう。

まず、英語を読むことが苦手な場合は、ブラウザー（Google Chrome, Edge, Safari などのホームページ閲覧ソフト）の自動翻訳機能を使うのも良いでしょう。しかし、自動翻訳機能を利用していると、リンク先に飛べなかったり、いくつかの機能が使えないこともありますので、正常に機能しないときは、自動翻訳機能を一旦 OFF にして利用してください。

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

### [オープンデータカタログ（Open Data Catalog）](https://datacatalog.worldbank.org/home)

> The Data Catalog is designed to make World Bank's development data easy to find, download, use, and share. It includes data from the World Bank's [microdata](https://microdata.worldbank.org/), [finances](http://finances.worldbank.org/) and [energy data](https://energydata.info/) platforms, as well as datasets from the [open data catalog.](https://data.worldbank.org/) There are different ways to access and download datasets.
>
> データカタログは、世界銀行で編纂した開発に関するデータを簡単に検索、ダウンロード、使用、共有できるように設計されています。これには、世界銀行の[マイクロデータ](https://microdata.worldbank.org/)、[財務](http://finances.worldbank.org/)、[エネルギーデータ](https://energydata.info/)プラットフォームからのデータ、および[オープンデータカタログ](https://data.worldbank.org/)からのデータセットが含まれています。データセットにアクセスしてダウンロードするには、さまざまな方法があります。

世界銀行（World Bank）で編纂したり、他の機関から提供を受けたデータがリストされています。

一番上には、Search Box（検索窓）があり、その下には、Featured （特徴的な、またはお薦め）とあり、いくつものトピックが並んでいます。右に、スクロールするとさらにいくつものトピックを見ることができます。その中にも、上で述べた 世界開発指標（WDI）もありますし、Covid-19 （コロナウイルス感染症）関連のデータもあります。

それぞれの、トピックに、関連のデータがリストされています。

### [世界開発指標（WDI）](https://datatopics.worldbank.org/world-development-indicators/)

また、オープンデータについて、世界銀行は、厳密な定義をしています。

### World Bank: WDI - World Development Indicaters

-   世界銀行（World Bank）: <https://www.worldbank.org>
-   [世界銀行について（Who we are）](https://www.worldbank.org/en/who-we-are):
    -   極度の貧困状態の削減（To end extreme poverty）: 2030年までに、極度の貧困状態にある世界人口の割合を3%に削減する。By reducing the share of the global population that lives in extreme poverty to 3 percent by 2030.
    -   繁栄を共に享受（To promote shared prosperity）: すべての国の最貧困層の40％の人々の所得を増加させることによって共栄を促進。By increasing the incomes of the poorest 40 percent of people in every country.
-   世界銀行オープンデータ（World Bank Open Data）: <https://data.worldbank.org>
    -   Data Bank, World Development Indicators, etc.

日本について：<https://data.worldbank.org/country/japan?view=chart>

### 世界開発指標（World Development Indicator）

-   [World Development Indicators (WDI)](https://datatopics.worldbank.org/world-development-indicators/) : 世界銀行が開発に関する各国間比較可能なデータの集大成である1400の時系列指標（the World Bank's premier compilation of cross-country comparable data on development; 1400 time series indicators）
    -   テーマ別（Themes）: 貧困と格差、人間、環境、経済、国家と市場、グローバルリンク集（Poverty and Inequality, People, Environment, Economy, States and Markets, Global Links）
    -   オープンデータとデータバンク（Open Data & DataBank）: Explore data, Query database
    -   Bulk Download: Excel, CSV
    -   API Documentation

## ダッシュボード

### 使い方

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

## さまざまな国際機関のパブリックデータ

世界銀行以外にも、それぞれの機関がデータを提供しています。どれも、少しずつ使いやすくなってきています。少しずつ、いくつかのデータベースに、アクセスして、できれば、API の利用の仕方も、習得して、データを調べることに少しずつ慣れていっていただければと思います。

下のリストは、私が個人的に、何度か使ったことのある、データベースです。他にも、たくさんのデータベースがありますので、ぜひ、調べてみてください。

-   国際連合　[UNdata](https://data.un.org)
-   経済協力開発機構　[OECD data](https://data.oecd.org)、
-   世界格差データベース（World Inequality Database）[WID](https://wid.world)、
-   欧州連合の統計局　[Eurostat](https://ec.europa.eu/eurostat)、
-   データで見る私たちの世界　[Our World in Data](https://ourworldindata.org)

なども、同様の、ダッシュボードを備えており、データの提供もしている。

<p>

日本では、

-   [e-Stat](https://www.e-stat.go.jp/)：政府統計の総合窓口 - 統計で見る日本
-   [ダッシュボード](https://dashboard.e-stat.go.jp)：対話型形式でのデータの視覚化

## 持続的開発目標（SDGs） データ

-   世界銀行：[https://databank.worldbank.org/source/sustainable-development-goals-(sdgs)](https://databank.worldbank.org/source/sustainable-development-goals-(sdgs)){.uri}
-   国連：<https://unstats.un.org/sdgs/dataportal/database>
-   データで見る私たちの世界：Our World in Data SGD Tracker: <https://sdg-tracker.org/>
-   SDG Index: <https://dashboards.sdgindex.org/map>

### 世界のさまざまな課題から見る

## API
