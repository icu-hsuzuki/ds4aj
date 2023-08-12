# (PART) PART I PUBLIC DATA {-}
# Public Data {#publicdata-site}



まずは、パブリックデータを見てみましょう。大きな機関のパグリックデータには、ダッシュボード（dashboard）と呼ばれている、パラメタを変更して、そのグラフを描くなどの機能が付いているものもあります。

## オープンデータ

### [Open Government Data Toolkit](http://opendatatoolkit.worldbank.org): [Open Data Defined](http://opendatatoolkit.worldbank.org/en/essentials.html)

The term **Open Data** has a very precise meaning. Data or content is open if anyone is free to use, re-use or redistribute it, subject at most to measures that preserve provenance and openness.

1. The data must be _legally open_, which means they must be placed in the public domain or under liberal terms of use with minimal restrictions.
2. The data must be _technically open_, which means they must be published in electronic formats that are machine readable and non-proprietary, so that anyone can access and use the data using common, freely available software tools. Data must also be publicly available and accessible on a public server, without password or firewall restrictions. To make Open Data easier to find, most organizations create and manage Open Data catalogs.

オープンデータの定義

1. オープンデータという言葉は、非常に正確な意味を持っています。データまたはコンテンツは、誰でも自由に使用、再利用、再配布でき、せいぜい出所とオープン性を維持するための措置に従うだけであればオープンです。

2. データは法的にオープンでなければなりません。つまり、パブリックドメインに置かれるか、最小限の制限で自由な使用条件のもとに置かれなければなりません。
データは技術的にオープンでなければならない。つまり、誰でも自由に使える一般的なソフトウェアツールを使ってデータにアクセスし利用できるように、機械可読で非専有の電子フォーマットで公開されていなければならない。また、データは一般に公開され、パスワードやファイアウォールによる制限を受けずに、公共のサーバーでアクセスできなければなりません。オープンデータを見つけやすくするために、ほとんどの組織がオープンデータカタログを作成し管理しています。

## 日本から世界を見る

以下では、世界銀行の、世界開発指標を利用するが、他にも、[UNdata](https://data.un.org)、[OECD data](https://data.oecd.org)、[WID](https://wid.world)、[Eurostat](https://ec.europa.eu/eurostat)、[Our World in Data](https://ourworldindata.org) なども、同様の、ダッシュボードを備えており、データの提供もしている。日本では、[e-Stat](https://www.e-stat.go.jp/)、[ダッシュボード](https://dashboard.e-stat.go.jp)

* 日本のデータはどうでしょうか。

## 世界銀行（World Bank）

* World Bank: https://www.worldbank.org
* [Who we are](https://www.worldbank.org/en/who-we-are):
  - To end extreme poverty: By reducing the share of the global population that lives in extreme poverty to 3 percent by 2030.
  - To promote shared prosperity: By increasing the incomes of the poorest 40 percent of people in every country. 
* World Bank Open Data: https://data.worldbank.org
  - Data Bank, World Development Indicators, etc.
  


### 世界開発指数（World Development Indicator (WDI)）

* [World Development Indicators (WDI)](https://datatopics.worldbank.org/world-development-indicators/) : the World Bank’s premier compilation of cross-country comparable data on development; 1400 time series indicators
  - Themes: Poverty and Inequality, People, Environment, Economy, States and Markets, Global Links
  - Open Data & DataBank: Explore data, Query database
  - Bulk Download: Excel, CSV
  - API Documentation


### World Bank: WDI - World Development Indicaters

* 世界銀行（World Bank）: https://www.worldbank.org
* [世界銀行について（Who we are）](https://www.worldbank.org/en/who-we-are):
  - 極度の貧困状態の削減（To end extreme poverty）: 2030年までに、極度の貧困状態にある世界人口の割合を3%に削減する。By reducing the share of the global population that lives in extreme poverty to 3 percent by 2030.
  - 繁栄を共に享受（To promote shared prosperity）: すべての国の最貧困層の40％の人々の所得を増加させることによって共栄を促進。By increasing the incomes of the poorest 40 percent of people in every country. 
* 世界銀行オープンデータ（World Bank Open Data）: https://data.worldbank.org
  - Data Bank, World Development Indicators, etc.
  
日本について：https://data.worldbank.org/country/japan?view=chart

### 世界開発指標（World Development Indicator）

* [World Development Indicators (WDI)](https://datatopics.worldbank.org/world-development-indicators/) : 世界銀行が開発に関する各国間比較可能なデータの集大成である1400の時系列指標（the World Bank’s premier compilation of cross-country comparable data on development; 1400 time series indicators）
  - テーマ別（Themes）: 貧困と格差、人間、環境、経済、国家と市場、グローバルリンク集（Poverty and Inequality, People, Environment, Economy, States and Markets, Global Links）
  - オープンデータとデータバンク（Open Data & DataBank）: Explore data, Query database
  - Bulk Download: Excel, CSV
  - API Documentation




### 例

#### GDP per capita (constant 2015 US$)

実質GDP（2015年を基準にしたもの）を、総人口で割った値。アメリカ合衆国、英国、ドイツ、フランス、日本、中国、日本、ロシア、ウクライナの2021年における比較棒グラフ - [リンク](https://data.worldbank.org/indicator/NY.GDP.PCAP.KD?locations=JP-GB-RU-FR-CN-US-UA-DE&start=2021&end=2021&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2021&indicators=NY.GDP.PCAP.KD&locations=JP-GB-RU-FR-CN-US-UA-DE&start=2021&view=bar" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

年次変化を示す折線グラフ - 

<iframe src="https://data.worldbank.org/share/widget?end=2021&indicators=NY.GDP.PCAP.KD&locations=JP-GB-RU-FR-CN-US-UA-DE&start=1960&view=chart" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

#### Central government debt, total (% of GDP)

2020年の政府の負債（GDP の百分率）- [リンク](https://data.worldbank.org/indicator/GC.DOD.TOTL.GD.ZS?locations=JP-GB-RU-FR-CN-US-UA-DE&start=2020&end=2020&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2020&indicators=GC.DOD.TOTL.GD.ZS&locations=JP-GB-RU-FR-CN-US-UA-DE&start=2020&view=bar" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

政府の負債（GDP の百分率）の年次変化を示す折線グラフ
<iframe src="https://data.worldbank.org/share/widget?indicators=GC.DOD.TOTL.GD.ZS&locations=JP-GB-RU-FR-CN-US-UA-DE" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

#### CO2 emissions (metric tons per capita)

CO2 排出量 (1 人あたりのメートル トン) - [リンク](https://data.worldbank.org/indicator/EN.ATM.CO2E.PC?locations=JP-GB-RU-FR-CN-US-UA-DE&start=2019&end=2019&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2019&indicators=EN.ATM.CO2E.PC&locations=JP-GB-RU-FR-CN-US-UA-DE&start=2019&view=bar" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

CO2 排出量 (1 人あたりのメートル トン) の年次変化の折線グラフ

<iframe src="https://data.worldbank.org/share/widget?end=2019&indicators=EN.ATM.CO2E.PC&locations=JP-GB-RU-FR-CN-US-UA-DE&start=1990&view=chart" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

#### Military expenditure (% of GDP)

2021年の軍事費 (GDP の %) - [リンク](https://data.worldbank.org/indicator/MS.MIL.XPND.GD.ZS?locations=JP-GB-RU-FR-CN-UA&start=2021&end=2021&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2021&indicators=MS.MIL.XPND.GD.ZS&locations=JP-GB-RU-FR-CN-UA&start=2021&view=bar" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

軍事費 (GDP の %) の年次変化

<iframe src="https://data.worldbank.org/share/widget?indicators=MS.MIL.XPND.GD.ZS&locations=JP-GB-RU-FR-UA-KR-DE&view=chart" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

#### Military expenditure (current USD)

2021年の軍事費 (現在の米ドル)  

<iframe src="https://data.worldbank.org/share/widget?end=2021&indicators=MS.MIL.XPND.CD&locations=JP-GB-RU-FR-CN-UA&start=2021&view=bar" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

軍事費の年次変化

<iframe src="https://data.worldbank.org/share/widget?indicators=MS.MIL.XPND.CD&locations=JP-GB-RU-FR-UA-KR-DE&view=chart" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

#### Proportion of seats held by women in natinal parliaments (%)

2021年、国会で女性が占める議席の割合 (%) - [リンク](https://data.worldbank.org/indicator/SG.GEN.PARL.ZS?locations=JP-GB-RU-FR-CN-US-UA-DE&start=2021&end=2021&view=bar)

<iframe src="https://data.worldbank.org/share/widget?end=2021&indicators=SG.GEN.PARL.ZS&locations=JP-GB-RU-FR-CN-US-UA-DE&start=2021&view=bar" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

国会で女性が占める議席の割合 (%) の年次変化

<iframe src="https://data.worldbank.org/share/widget?indicators=SG.GEN.PARL.ZS&locations=JP-GB-RU-FR-CN-US-UA-DE" width='450' height='300' frameBorder='0' scrolling="no" ></iframe>

## さまざまな国際機関のパブリックデータ

世界銀行以外にも、それぞれの機関がデータを提供しています。どれも、少しずつ使いやすくなってきています。少しずつ、いくつかのデータベースに、アクセスして、できれば、API の利用の仕方も、習得して、データを調べることに少しずつ慣れていっていただければと思います。

下のリストは、私が個人的に、何度か使ったことのある、データベースです。他にも、たくさんのデータベースがありますので、ぜひ、調べてみてください。

* 国際連合　[UNdata](https://data.un.org)
* 経済協力開発機構　[OECD data](https://data.oecd.org)、
* 世界格差データベース（World Inequality Database）[WID](https://wid.world)、
* 欧州連合の統計局　[Eurostat](https://ec.europa.eu/eurostat)、
* データで見る私たちの世界　[Our World in Data](https://ourworldindata.org)

なども、同様の、ダッシュボードを備えており、データの提供もしている。

<p>
日本では、

* [e-Stat](https://www.e-stat.go.jp/)：政府統計の総合窓口 - 統計で見る日本
* [ダッシュボード](https://dashboard.e-stat.go.jp)：対話型形式でのデータの視覚化

## 持続的開発目標（SDGs） データ

* 世界銀行：https://databank.worldbank.org/source/sustainable-development-goals-(sdgs)
* 国連：https://unstats.un.org/sdgs/dataportal/database
* データで見る私たちの世界：Our World in Data SGD Tracker: https://sdg-tracker.org/
* SDG Index: https://dashboards.sdgindex.org/map

## 世界のさまざまな課題から見る

## OECD

OECD Data: https://data.oecd.org/

## UN Data

UNdata: https://data.un.org

## Our World in Data

owid: https://ourworldindata.org/

## Eurostat

eurostat: https://ec.europa.eu/eurostat
