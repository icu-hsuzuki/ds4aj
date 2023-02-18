# (PART) PART III INSTITUTIONAL DATA {-}
# World Bank {#worldbank}



## World Development Indicator (WDI)

パッケージ と `tidyverse` と `WDI` を使いますから、下のコードによって、ロードします。


```r
library(tidyverse)
#> ── Attaching packages ─────────────────── tidyverse 1.3.2 ──
#> ✔ ggplot2 3.4.1     ✔ purrr   1.0.1
#> ✔ tibble  3.1.8     ✔ dplyr   1.1.0
#> ✔ tidyr   1.3.0     ✔ stringr 1.5.0
#> ✔ readr   2.1.4     ✔ forcats 1.0.0
#> ── Conflicts ────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
library(WDI)
```

まず、三つの例を見てみましょう。なにをしているかわかりますか。考えて見てください。


```r
WDI(country = "all", indicator = c(gdp = "NY.GDP.MKTP.CD"),
    extra=TRUE) %>% drop_na(gdp) %>%
  filter(year==max(year), income !="Aggregates") %>% 
  drop_na(region) %>% arrange(desc(gdp))
```




```
#> Rows: 16492 Columns: 13
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (4): year, gdp, longitude, latitude
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 196 × 13
#>    country       iso2c iso3c  year     gdp status lastupda…¹
#>    <chr>         <chr> <chr> <dbl>   <dbl> <lgl>  <date>    
#>  1 United States US    USA    2021 2.33e13 NA     2022-12-22
#>  2 China         CN    CHN    2021 1.77e13 NA     2022-12-22
#>  3 Japan         JP    JPN    2021 4.94e12 NA     2022-12-22
#>  4 Germany       DE    DEU    2021 4.26e12 NA     2022-12-22
#>  5 India         IN    IND    2021 3.18e12 NA     2022-12-22
#>  6 United Kingd… GB    GBR    2021 3.13e12 NA     2022-12-22
#>  7 France        FR    FRA    2021 2.96e12 NA     2022-12-22
#>  8 Italy         IT    ITA    2021 2.11e12 NA     2022-12-22
#>  9 Canada        CA    CAN    2021 1.99e12 NA     2022-12-22
#> 10 Korea, Rep.   KR    KOR    2021 1.81e12 NA     2022-12-22
#> # … with 186 more rows, 6 more variables: region <chr>,
#> #   capital <chr>, longitude <dbl>, latitude <dbl>,
#> #   income <chr>, lending <chr>, and abbreviated variable
#> #   name ¹​lastupdated
```



```r
WDI(country = c("CN","GB","JP","IN","US","DE"), indicator = c(gdp = "NY.GDP.MKTP.CD"), extra=TRUE) %>% drop_na(gdp) %>% 
  ggplot(aes(year, gdp, col = country)) + geom_line() +
  labs(title = "WDI NY.GDP.MKTP.CD: gdp")
```




```
#> Rows: 372 Columns: 13
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (4): year, gdp, longitude, latitude
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

<img src="31-worldbank_files/figure-html/unnamed-chunk-8-1.png" width="672" />


```r
WDI(country = c("CN","IN","JP","US"), 
    indicator = c(gdp_growth_rate = "NY.GDP.MKTP.KD.ZG"), extra=TRUE) %>%
  drop_na(gdp_growth_rate) %>% 
  ggplot(aes(year, gdp_growth_rate, col = country)) + geom_line() +
  labs(title = paste("WDI NY.GDP.MKTP.KD.ZG: gdp growth rate"))
```




```
#> Rows: 248 Columns: 13
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (4): year, gdp_growth_rate, longitude, latitude
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

<img src="31-worldbank_files/figure-html/unnamed-chunk-11-1.png" width="672" />

まず、世界の国々の、GDP（gross domestic product 国内総生産）のデータを、取得して、2021年の GDP を大きな順に並べています。

値は、たとえば、$2.331508e+13$ のように書かれていますが、これは、科学的記法と呼ばれるもので、$2.331508 \times 10^{13}$ を意味しています。約23兆ドルです。

次に、3兆ドル以上の、６カ国を選択し、その、iso2c と呼ばれるコードを使って、それらの国のデータをもう一度取得し、年次変化をあらわすグラフを描いています。

さらにその中から、４カ国を選んで、今度は、GDP の年次変化率を描いています。単位は、パーセントです。

これは、ひとつの例ですが、ここで使われているのが、WDI World Development Indicator というもので、世界銀行が、いくつかの指標を定めて、編纂しているものです。

### 指標 Indicators (WDI)

上の例では、次の二つの指標のコード Indicator Code (WDI Code) が使われました。

-   NY.GDP.MKTP.CD: GDP (current US\$)
-   NY.GDP.MKTP.KD.ZG: GDP growth (annual %)

### 指標 WDI (World Development Indicators)

> The World Development Indicators is a compilation of relevant, high-quality, and internationally comparable statistics about global development and the fight against poverty. The database contains 1,400 time series indicators for 217 economies and more than 40 country groups, with data for many indicators going back more than 50 years.

> WDIは、世界の開発状況と、貧困との戦いに関する、適切で上質、かつ、国際的に比較可能な時系列の統計データを編纂したものです。このデータベースは、217の経済と40以上の国グループについて1,400の時系列指標を含み、指標のデータの多くは50年以上前に遡ることができます。

-   世界銀行（World Bank）: <https://www.worldbank.org>
-   World Bank Open Data: <https://data.worldbank.org>
    -   Country / Indicator \> Featured & All \> Details
-   [World Development Indicators (WDI)](https://datatopics.worldbank.org/world-development-indicators/) :
    -   Themes: Poverty and Inequality, People, Environment, Economy, States and Markets, Global Links
    -   Open Data & DataBank: Explore data, Query database

### 指標 のコード、WDI code を探してみよう

いくつかの探し方があります。まず、ここでは、World Bank のサイトから探す方法を説明しましょう。

ふた通りあります。

1. [World Bank Open Data](https://data.worldbank.org) にいくと、表題の下の検索窓の下に、 Country / Indicator とありますから、Indicator を選択します。すると、そこに、項目のリストが、Featured と All という二つのタブに分かれて出ています。かなり膨大です。それを選択すると、その項目のサイトに行きます。それが、指標のサイトです。図などの、右上に、Details とありますから、それを選択すると、その中に、Indicator が書かれています。
実は、指標のサイトのアドレス（URL）を見ると、そこにも、この Indicator が書かれていることがわかります。

2. [World Development Indicators (WDI)](https://datatopics.worldbank.org/world-development-indicators/) にいくと、下のようなテーマに分かれています。

Themes: Poverty and Inequality, People, Environment, Economy, States and Markets, Global Links

その中から、選択して、スクロールすると、そこに、指標が書かれています。

Indicator, Code, Time coverage, Region coverage, Get data

とあり、Code が、指標のコードです。実は、すべての年や、すべての地域のデータが揃っているわけではないので、この情報を見ておくことはとても重要です。ほとんど、データがない場合もあります。

一番右端の Get data からは、CSV や、データバンク（Data Bank）へのリンクがあります。

それぞれの方法で、上で使った、二つの指標およびそのコードは見つかりましたか。

1 の方法の途中に出てきた、検索窓から検索することも可能です。

### 指標 WDIの例

このあとの、例で使う指標を書いておきます。

* NY.GDP.MKTP.CD: GDP (current US$)
* NY.GDP.DEFL.KD.ZG: Inflation, GDP deflator (annual %)
* SL.UEM.TOTL.NE.ZS: Unemployment, total (% of total labor force) (national estimate)
* CPTOTNSXN: CPI Price, nominal
* SL.TLF.CACT.MA.NE.ZS: Labor force participation rate, male (% of male population ages 15+) (national estimate)
* SL.TLF.CACT.FE.NE.ZS: Labor force participation rate, female (% of male population ages 15+) (national estimate)

### 練習 1. - 調べてみたい WDI 指標とそのコード

いくつか、リストしてみましょう。

## WDI パッケージ

`WDI` パッケージ の使い方を紹介します。

`WDI` パッケージで、データをダウンロードしたり、探したり、詳細情報を得たりできます。

### 指標 WDI 検索

まず、検索です。上で、サイトから調べる方法を紹介しましたが、`WDI` パッケージの、`WDIsearch` でも探すことができます。詳細は、右下の窓枠の Help タブの検索窓に、WDIsearch といれて調べて見てください。ここでは、二種類の検索方法を紹介します。

#### 検索例 1（WDI名）

WDI 名に、ある文字列が含まれているものを検索します。検索文字列は、大文字・小文字は関係ありません。


```r
WDIsearch(string = "gdp", field = "name", short = TRUE, cache = NULL)
#>                        indicator
#> 712               5.51.01.10.gdp
#> 714              6.0.GDP_current
#> 715               6.0.GDP_growth
#> 716                  6.0.GDP_usd
#> 717           6.0.GDPpc_constant
#> 1557           BG.GSR.NFSV.GD.ZS
#> 1558        BG.KAC.FNEI.GD.PP.ZS
#> 1559           BG.KAC.FNEI.GD.ZS
#> 1560        BG.KLT.DINV.GD.PP.ZS
#> 1561           BG.KLT.DINV.GD.ZS
#> 1752           BI.WAG.TOTL.GD.ZS
#> 1772              BM.GSR.MRCH.ZS
#> 1784           BM.KLT.DINV.GD.ZS
#> 1785        BM.KLT.DINV.WD.GD.ZS
#> 1798           BN.CAB.XOKA.GD.ZS
#> 1799          BN.CAB.XOKA.GDP.ZS
#> 1802              BN.CAB.XOTR.ZS
#> 1805              BN.CUR.GDPM.ZS
#> 1811           BN.GSR.FCTY.CD.ZS
#> 1820           BN.KLT.DINV.CD.ZS
#> 1822      BN.KLT.DINV.DRS.GDP.ZS
#> 1828           BN.KLT.PRVT.GD.ZS
#> 1839           BN.TRF.CURR.CD.ZS
#> 1875              BX.GSR.MRCH.ZS
#> 1887        BX.KLT.DINV.DT.GD.ZS
#> 1889        BX.KLT.DINV.WD.GD.ZS
#> 1898         BX.TRF.MGR.DT.GD.ZS
#> 1904        BX.TRF.PWKR.DT.GD.ZS
#> 1905           BX.TRF.PWKR.GD.ZS
#> 2198              CC.ENTX.ENE.ZS
#> 2270              CC.GHG.MEMG.EI
#> 2271              CC.GHG.MEMG.GC
#> 2293                CC.INCP.ALRS
#> 2294                CC.INCP.KRGC
#> 2295                CC.INCP.SPMC
#> 2356              CC.RISK.AST.ZS
#> 2357             CC.RISK.WELL.ZS
#> 2364                CC.SP.EXP.ZS
#> 2401           CM.FIN.INTL.GD.ZS
#> 2404           CM.MKT.LCAP.GD.ZS
#> 2407           CM.MKT.TRAD.GD.ZS
#> 2559        DP.DOD.DECD.CR.BC.Z1
#> 2562        DP.DOD.DECD.CR.CG.Z1
#> 2565        DP.DOD.DECD.CR.FC.Z1
#> 2568        DP.DOD.DECD.CR.GG.Z1
#> 2571        DP.DOD.DECD.CR.NF.Z1
#> 2576        DP.DOD.DECF.CR.BC.Z1
#> 2579        DP.DOD.DECF.CR.CG.Z1
#> 2582        DP.DOD.DECF.CR.FC.Z1
#> 2585        DP.DOD.DECF.CR.GG.Z1
#> 2588        DP.DOD.DECF.CR.NF.Z1
#> 2593        DP.DOD.DECN.CR.BC.Z1
#> 2596        DP.DOD.DECN.CR.CG.Z1
#> 2599        DP.DOD.DECN.CR.FC.Z1
#> 2602        DP.DOD.DECN.CR.GG.Z1
#> 2605        DP.DOD.DECN.CR.NF.Z1
#> 2610        DP.DOD.DECT.CR.BC.Z1
#> 2613        DP.DOD.DECT.CR.CG.Z1
#> 2616        DP.DOD.DECT.CR.FC.Z1
#> 2619        DP.DOD.DECT.CR.GG.Z1
#> 2622        DP.DOD.DECT.CR.NF.Z1
#> 2627        DP.DOD.DECX.CR.BC.Z1
#> 2630        DP.DOD.DECX.CR.CG.Z1
#> 2633        DP.DOD.DECX.CR.FC.Z1
#> 2636        DP.DOD.DECX.CR.GG.Z1
#> 2639        DP.DOD.DECX.CR.NF.Z1
#> 2644        DP.DOD.DLCD.CR.BC.Z1
#> 2647        DP.DOD.DLCD.CR.CG.Z1
#> 2650        DP.DOD.DLCD.CR.FC.Z1
#> 2653        DP.DOD.DLCD.CR.GG.Z1
#> 2656     DP.DOD.DLCD.CR.L1.BC.Z1
#> 2659     DP.DOD.DLCD.CR.L1.CG.Z1
#> 2662     DP.DOD.DLCD.CR.L1.FC.Z1
#> 2665     DP.DOD.DLCD.CR.L1.GG.Z1
#> 2668     DP.DOD.DLCD.CR.L1.NF.Z1
#> 2673     DP.DOD.DLCD.CR.M1.BC.Z1
#> 2676     DP.DOD.DLCD.CR.M1.CG.Z1
#> 2679     DP.DOD.DLCD.CR.M1.FC.Z1
#> 2682     DP.DOD.DLCD.CR.M1.GG.Z1
#> 2685     DP.DOD.DLCD.CR.M1.NF.Z1
#> 2690        DP.DOD.DLCD.CR.NF.Z1
#> 2694        DP.DOD.DLD1.CR.CG.Z1
#> 2696        DP.DOD.DLD1.CR.GG.Z1
#> 2698        DP.DOD.DLD2.CR.CG.Z1
#> 2700        DP.DOD.DLD2.CR.GG.Z1
#> 2702       DP.DOD.DLD2A.CR.CG.Z1
#> 2704       DP.DOD.DLD2A.CR.GG.Z1
#> 2706        DP.DOD.DLD3.CR.CG.Z1
#> 2708        DP.DOD.DLD3.CR.GG.Z1
#> 2710        DP.DOD.DLD4.CR.CG.Z1
#> 2712        DP.DOD.DLD4.CR.GG.Z1
#> 2715        DP.DOD.DLDS.CR.BC.Z1
#> 2718        DP.DOD.DLDS.CR.CG.Z1
#> 2721        DP.DOD.DLDS.CR.FC.Z1
#> 2724        DP.DOD.DLDS.CR.GG.Z1
#> 2727     DP.DOD.DLDS.CR.L1.BC.Z1
#> 2730     DP.DOD.DLDS.CR.L1.CG.Z1
#> 2733     DP.DOD.DLDS.CR.L1.FC.Z1
#> 2736     DP.DOD.DLDS.CR.L1.GG.Z1
#> 2739     DP.DOD.DLDS.CR.L1.NF.Z1
#> 2744     DP.DOD.DLDS.CR.M1.BC.Z1
#> 2747     DP.DOD.DLDS.CR.M1.CG.Z1
#> 2750     DP.DOD.DLDS.CR.M1.FC.Z1
#> 2753     DP.DOD.DLDS.CR.M1.GG.Z1
#> 2756     DP.DOD.DLDS.CR.M1.NF.Z1
#> 2761     DP.DOD.DLDS.CR.MV.BC.Z1
#> 2764     DP.DOD.DLDS.CR.MV.CG.Z1
#> 2767     DP.DOD.DLDS.CR.MV.FC.Z1
#> 2770     DP.DOD.DLDS.CR.MV.GG.Z1
#> 2773     DP.DOD.DLDS.CR.MV.NF.Z1
#> 2778        DP.DOD.DLDS.CR.NF.Z1
#> 2783        DP.DOD.DLIN.CR.BC.Z1
#> 2786        DP.DOD.DLIN.CR.CG.Z1
#> 2789        DP.DOD.DLIN.CR.FC.Z1
#> 2792        DP.DOD.DLIN.CR.GG.Z1
#> 2795     DP.DOD.DLIN.CR.L1.BC.Z1
#> 2798     DP.DOD.DLIN.CR.L1.CG.Z1
#> 2801     DP.DOD.DLIN.CR.L1.FC.Z1
#> 2804     DP.DOD.DLIN.CR.L1.GG.Z1
#> 2807     DP.DOD.DLIN.CR.L1.NF.Z1
#> 2812     DP.DOD.DLIN.CR.M1.BC.Z1
#> 2815     DP.DOD.DLIN.CR.M1.CG.Z1
#> 2818     DP.DOD.DLIN.CR.M1.FC.Z1
#> 2821     DP.DOD.DLIN.CR.M1.GG.Z1
#> 2824     DP.DOD.DLIN.CR.M1.NF.Z1
#> 2829        DP.DOD.DLIN.CR.NF.Z1
#> 2834        DP.DOD.DLLO.CR.BC.Z1
#> 2837        DP.DOD.DLLO.CR.CG.Z1
#> 2840        DP.DOD.DLLO.CR.FC.Z1
#> 2843        DP.DOD.DLLO.CR.GG.Z1
#> 2846     DP.DOD.DLLO.CR.L1.BC.Z1
#> 2849     DP.DOD.DLLO.CR.L1.CG.Z1
#> 2852     DP.DOD.DLLO.CR.L1.FC.Z1
#> 2855     DP.DOD.DLLO.CR.L1.GG.Z1
#> 2858     DP.DOD.DLLO.CR.L1.NF.Z1
#> 2863     DP.DOD.DLLO.CR.M1.BC.Z1
#> 2866     DP.DOD.DLLO.CR.M1.CG.Z1
#> 2869     DP.DOD.DLLO.CR.M1.FC.Z1
#> 2872     DP.DOD.DLLO.CR.M1.GG.Z1
#> 2875     DP.DOD.DLLO.CR.M1.NF.Z1
#> 2880        DP.DOD.DLLO.CR.NF.Z1
#> 2885        DP.DOD.DLOA.CR.BC.Z1
#> 2888        DP.DOD.DLOA.CR.CG.Z1
#> 2891        DP.DOD.DLOA.CR.FC.Z1
#> 2894        DP.DOD.DLOA.CR.GG.Z1
#> 2897     DP.DOD.DLOA.CR.L1.BC.Z1
#> 2900     DP.DOD.DLOA.CR.L1.CG.Z1
#> 2903     DP.DOD.DLOA.CR.L1.FC.Z1
#> 2906     DP.DOD.DLOA.CR.L1.GG.Z1
#> 2909     DP.DOD.DLOA.CR.L1.NF.Z1
#> 2914     DP.DOD.DLOA.CR.M1.BC.Z1
#> 2917     DP.DOD.DLOA.CR.M1.CG.Z1
#> 2920     DP.DOD.DLOA.CR.M1.FC.Z1
#> 2923     DP.DOD.DLOA.CR.M1.GG.Z1
#> 2926     DP.DOD.DLOA.CR.M1.NF.Z1
#> 2931        DP.DOD.DLOA.CR.NF.Z1
#> 2936        DP.DOD.DLSD.CR.BC.Z1
#> 2939        DP.DOD.DLSD.CR.CG.Z1
#> 2942        DP.DOD.DLSD.CR.FC.Z1
#> 2945        DP.DOD.DLSD.CR.GG.Z1
#> 2948     DP.DOD.DLSD.CR.M1.BC.Z1
#> 2951     DP.DOD.DLSD.CR.M1.CG.Z1
#> 2954     DP.DOD.DLSD.CR.M1.FC.Z1
#> 2957     DP.DOD.DLSD.CR.M1.GG.Z1
#> 2960     DP.DOD.DLSD.CR.M1.NF.Z1
#> 2965        DP.DOD.DLSD.CR.NF.Z1
#> 2970        DP.DOD.DLTC.CR.BC.Z1
#> 2973        DP.DOD.DLTC.CR.CG.Z1
#> 2976        DP.DOD.DLTC.CR.FC.Z1
#> 2979        DP.DOD.DLTC.CR.GG.Z1
#> 2982     DP.DOD.DLTC.CR.L1.BC.Z1
#> 2985     DP.DOD.DLTC.CR.L1.CG.Z1
#> 2988     DP.DOD.DLTC.CR.L1.FC.Z1
#> 2991     DP.DOD.DLTC.CR.L1.GG.Z1
#> 2994     DP.DOD.DLTC.CR.L1.NF.Z1
#> 2999     DP.DOD.DLTC.CR.M1.BC.Z1
#> 3002     DP.DOD.DLTC.CR.M1.CG.Z1
#> 3005     DP.DOD.DLTC.CR.M1.FC.Z1
#> 3008     DP.DOD.DLTC.CR.M1.GG.Z1
#> 3011     DP.DOD.DLTC.CR.M1.NF.Z1
#> 3016        DP.DOD.DLTC.CR.NF.Z1
#> 3022        DP.DOD.DSCD.CR.BC.Z1
#> 3025        DP.DOD.DSCD.CR.CG.Z1
#> 3028        DP.DOD.DSCD.CR.FC.Z1
#> 3031        DP.DOD.DSCD.CR.GG.Z1
#> 3034        DP.DOD.DSCD.CR.NF.Z1
#> 3039        DP.DOD.DSDS.CR.BC.Z1
#> 3042        DP.DOD.DSDS.CR.CG.Z1
#> 3045        DP.DOD.DSDS.CR.FC.Z1
#> 3048        DP.DOD.DSDS.CR.GG.Z1
#> 3051        DP.DOD.DSDS.CR.NF.Z1
#> 3056        DP.DOD.DSIN.CR.BC.Z1
#> 3059        DP.DOD.DSIN.CR.CG.Z1
#> 3062        DP.DOD.DSIN.CR.FC.Z1
#> 3065        DP.DOD.DSIN.CR.GG.Z1
#> 3068        DP.DOD.DSIN.CR.NF.Z1
#> 3073        DP.DOD.DSLO.CR.BC.Z1
#> 3076        DP.DOD.DSLO.CR.CG.Z1
#> 3079        DP.DOD.DSLO.CR.FC.Z1
#> 3082        DP.DOD.DSLO.CR.GG.Z1
#> 3085        DP.DOD.DSLO.CR.NF.Z1
#> 3090        DP.DOD.DSOA.CR.BC.Z1
#> 3093        DP.DOD.DSOA.CR.CG.Z1
#> 3096        DP.DOD.DSOA.CR.FC.Z1
#> 3099        DP.DOD.DSOA.CR.GG.Z1
#> 3102        DP.DOD.DSOA.CR.NF.Z1
#> 3107        DP.DOD.DSTC.CR.BC.Z1
#> 3110        DP.DOD.DSTC.CR.CG.Z1
#> 3113        DP.DOD.DSTC.CR.FC.Z1
#> 3116        DP.DOD.DSTC.CR.GG.Z1
#> 3119        DP.DOD.DSTC.CR.NF.Z1
#> 3615             DT.DOD.ALLC.ZSG
#> 3618             DT.DOD.ALLN.ZSG
#> 3773          DT.DOD.DECT.CD.ZSG
#> 5376           DT.ODA.ALLD.GD.ZS
#> 5447             DT.ODA.DACD.ZSG
#> 5452             DT.ODA.MULT.ZSG
#> 5460             DT.ODA.NDAC.ZSG
#> 5466           DT.ODA.ODAT.GD.ZS
#> 5616           DT.TDS.DECT.GD.ZS
#> 5969           EG.EGY.PRIM.PP.KD
#> 5993           EG.GDP.PUSE.KO.87
#> 5994           EG.GDP.PUSE.KO.KD
#> 5995           EG.GDP.PUSE.KO.PP
#> 5996        EG.GDP.PUSE.KO.PP.KD
#> 6004        EG.USE.COMM.GD.PP.KD
#> 6023             EN.ATM.CO2E.GDP
#> 6027        EN.ATM.CO2E.KD.87.GD
#> 6028           EN.ATM.CO2E.KD.GD
#> 6033           EN.ATM.CO2E.PP.GD
#> 6034        EN.ATM.CO2E.PP.GD.KD
#> 6164           ER.GDP.FWTL.M3.KD
#> 6182             EU.EGY.USES.GDP
#> 6236           FB.DPT.INSU.PC.ZS
#> 6589           FD.AST.PRVT.GD.ZS
#> 6595           FI.RES.TOTL.CD.ZS
#> 7389           FM.AST.GOVT.CN.ZS
#> 7398           FM.AST.PRVT.GD.ZS
#> 7407           FM.LBL.BMNY.GD.ZS
#> 7414           FM.LBL.MQMY.GD.ZS
#> 7415          FM.LBL.MQMY.GDP.ZS
#> 7417              FM.LBL.MQMY.XD
#> 7422          FM.LBL.QMNY.GDP.ZS
#> 7423          FM.LBL.SEIG.GDP.ZS
#> 7462           FS.AST.CGOV.GD.ZS
#> 7463           FS.AST.DOMO.GD.ZS
#> 7464           FS.AST.DOMS.GD.ZS
#> 7465              FS.AST.DTOT.ZS
#> 7467           FS.AST.PRVT.GD.ZS
#> 7468          FS.AST.PRVT.GDP.ZS
#> 7469           FS.LBL.LIQU.GD.ZS
#> 7470          FS.LBL.LIQU.GDP.ZS
#> 7471           FS.LBL.QLIQ.GD.ZS
#> 7530           GB.BAL.OVRL.GD.ZS
#> 7531          GB.BAL.OVRL.GDP.ZS
#> 7540           GB.DOD.TOTL.GD.ZS
#> 7541          GB.DOD.TOTL.GDP.ZS
#> 7545           GB.FIN.ABRD.GD.ZS
#> 7546          GB.FIN.ABRD.GDP.ZS
#> 7550           GB.FIN.DOMS.GD.ZS
#> 7551          GB.FIN.DOMS.GDP.ZS
#> 7561           GB.REV.CTOT.GD.ZS
#> 7564          GB.REV.TOTL.GDP.ZS
#> 7566           GB.REV.XAGT.CN.ZS
#> 7569           GB.RVC.TOTL.GD.ZS
#> 7571              GB.SOE.DECT.ZS
#> 7573           GB.SOE.ECON.GD.ZS
#> 7574          GB.SOE.ECON.GDP.ZS
#> 7577           GB.SOE.NFLW.GD.ZS
#> 7578          GB.SOE.NFLW.GDP.ZS
#> 7579           GB.SOE.OVRL.GD.ZS
#> 7605           GB.TAX.TOTL.GD.ZS
#> 7606          GB.TAX.TOTL.GDP.ZS
#> 7624          GB.XPD.DEFN.GDP.ZS
#> 7627           GB.XPD.RSDV.GD.ZS
#> 7630           GB.XPD.TOTL.GD.ZS
#> 7631          GB.XPD.TOTL.GDP.ZS
#> 7638           GC.AST.TOTL.GD.ZS
#> 7641           GC.BAL.CASH.GD.ZS
#> 7646           GC.DOD.TOTL.GD.ZS
#> 7650           GC.FIN.DOMS.GD.ZS
#> 7652           GC.FIN.FRGN.GD.ZS
#> 7654           GC.LBL.TOTL.GD.ZS
#> 7656           GC.NFN.TOTL.GD.ZS
#> 7658           GC.NLD.TOTL.GD.ZS
#> 7669           GC.REV.XGRT.GD.ZS
#> 7684           GC.TAX.TOTL.GD.ZS
#> 7701           GC.XPN.TOTL.GD.ZS
#> 7792                  GFDD.DI.01
#> 7793                  GFDD.DI.02
#> 7794                  GFDD.DI.03
#> 7796                  GFDD.DI.05
#> 7797                  GFDD.DI.06
#> 7798                  GFDD.DI.07
#> 7799                  GFDD.DI.08
#> 7800                  GFDD.DI.09
#> 7801                  GFDD.DI.10
#> 7802                  GFDD.DI.11
#> 7803                  GFDD.DI.12
#> 7804                  GFDD.DI.13
#> 7805                  GFDD.DI.14
#> 7806                  GFDD.DM.01
#> 7807                  GFDD.DM.02
#> 7808                  GFDD.DM.03
#> 7809                  GFDD.DM.04
#> 7810                  GFDD.DM.05
#> 7811                  GFDD.DM.06
#> 7812                  GFDD.DM.07
#> 7813                  GFDD.DM.08
#> 7814                  GFDD.DM.09
#> 7815                  GFDD.DM.10
#> 7816                  GFDD.DM.11
#> 7817                  GFDD.DM.12
#> 7818                  GFDD.DM.13
#> 7821                  GFDD.DM.16
#> 7822                  GFDD.DM.16
#> 7830                  GFDD.EI.08
#> 7837                  GFDD.OI.02
#> 7843                  GFDD.OI.08
#> 7844                  GFDD.OI.09
#> 7848                  GFDD.OI.13
#> 7849                  GFDD.OI.14
#> 7854                  GFDD.OI.17
#> 7855                  GFDD.OI.18
#> 8686           IE.ICT.TOTL.GD.ZS
#> 8959        IS.RRS.GOOD.KM.PP.ZS
#> 8961        IS.RRS.PASG.K2.PP.ZS
#> 9068           IT.TEL.REVN.GD.ZS
#> 10943          MS.MIL.XPND.GD.ZS
#> 10948     NA.GDP.ACC.FB.SNA08.CR
#> 10949     NA.GDP.ACC.FB.SNA08.KR
#> 10950              NA.GDP.AGR.CR
#> 10951              NA.GDP.AGR.KR
#> 10952        NA.GDP.AGR.SNA08.CR
#> 10953        NA.GDP.AGR.SNA08.KR
#> 10954       NA.GDP.BUSS.SNA08.CR
#> 10955       NA.GDP.BUSS.SNA08.KR
#> 10956             NA.GDP.CNST.CR
#> 10957             NA.GDP.CNST.KR
#> 10958       NA.GDP.CNST.SNA08.CR
#> 10959       NA.GDP.CNST.SNA08.KR
#> 10960       NA.GDP.EDUS.SNA08.CR
#> 10961       NA.GDP.EDUS.SNA08.KR
#> 10962   NA.GDP.ELEC.GAS.SNA08.CR
#> 10963   NA.GDP.ELEC.GAS.SNA08.KR
#> 10964           NA.GDP.EXC.OG.CR
#> 10965           NA.GDP.EXC.OG.KR
#> 10966             NA.GDP.FINS.CR
#> 10967             NA.GDP.FINS.KR
#> 10968       NA.GDP.FINS.SNA08.CR
#> 10969       NA.GDP.FINS.SNA08.KR
#> 10970  NA.GDP.HLTH.SOCW.SNA08.CR
#> 10971  NA.GDP.HLTH.SOCW.SNA08.KR
#> 10972           NA.GDP.INC.OG.CR
#> 10973           NA.GDP.INC.OG.KR
#> 10974     NA.GDP.INC.OG.SNA08.CR
#> 10975     NA.GDP.INC.OG.SNA08.KR
#> 10976   NA.GDP.INF.COMM.SNA08.CR
#> 10977   NA.GDP.INF.COMM.SNA08.KR
#> 10978             NA.GDP.MINQ.CR
#> 10979             NA.GDP.MINQ.KR
#> 10980       NA.GDP.MINQ.SNA08.CR
#> 10981       NA.GDP.MINQ.SNA08.KR
#> 10982              NA.GDP.MNF.CR
#> 10983              NA.GDP.MNF.KR
#> 10984        NA.GDP.MNF.SNA08.CR
#> 10985        NA.GDP.MNF.SNA08.KR
#> 10986   NA.GDP.PADM.DEF.SNA08.CR
#> 10987   NA.GDP.PADM.DEF.SNA08.KR
#> 10988       NA.GDP.REST.SNA08.CR
#> 10989       NA.GDP.REST.SNA08.KR
#> 10990         NA.GDP.SRV.OTHR.CR
#> 10991         NA.GDP.SRV.OTHR.KR
#> 10992   NA.GDP.SRV.OTHR.SNA08.CR
#> 10993   NA.GDP.SRV.OTHR.SNA08.KR
#> 10994        NA.GDP.TRAN.COMM.CR
#> 10995        NA.GDP.TRAN.COMM.KR
#> 10996  NA.GDP.TRAN.STOR.SNA08.CR
#> 10997  NA.GDP.TRAN.STOR.SNA08.KR
#> 10998          NA.GDP.TRD.HTL.CR
#> 10999          NA.GDP.TRD.HTL.KR
#> 11000        NA.GDP.TRD.SNA08.CR
#> 11001        NA.GDP.TRD.SNA08.KR
#> 11002              NA.GDP.UTL.CR
#> 11003              NA.GDP.UTL.KR
#> 11004    NA.GDP.WTR.WST.SNA08.CR
#> 11005    NA.GDP.WTR.WST.SNA08.KR
#> 11014             NE.CON.GOVT.ZS
#> 11025             NE.CON.PETC.ZS
#> 11042             NE.CON.PRVT.ZS
#> 11052             NE.CON.TETC.ZS
#> 11060             NE.CON.TOTL.ZG
#> 11061             NE.CON.TOTL.ZS
#> 11071             NE.DAB.TOTL.ZS
#> 11083             NE.EXP.GNFS.ZS
#> 11085         NE.GDI.CON.GOVT.CR
#> 11086   NE.GDI.CON.GOVT.SNA08.CR
#> 11087          NE.GDI.CON.NPI.CR
#> 11088    NE.GDI.CON.NPI.SNA08.CR
#> 11089         NE.GDI.CON.PRVT.CR
#> 11090   NE.GDI.CON.PRVT.SNA08.CR
#> 11091             NE.GDI.EXPT.CR
#> 11092       NE.GDI.EXPT.SNA08.CR
#> 11117             NE.GDI.FPRV.ZS
#> 11122             NE.GDI.FPUB.ZS
#> 11125             NE.GDI.FTOT.CR
#> 11132       NE.GDI.FTOT.SNA08.CR
#> 11133             NE.GDI.FTOT.ZS
#> 11134             NE.GDI.IMPT.CR
#> 11135       NE.GDI.IMPT.SNA08.CR
#> 11136       NE.GDI.INEX.SNA08.CR
#> 11141             NE.GDI.STKB.CR
#> 11145       NE.GDI.STKB.SNA08.CR
#> 11154             NE.GDI.TOTL.CR
#> 11161       NE.GDI.TOTL.SNA08.CR
#> 11162             NE.GDI.TOTL.ZG
#> 11163             NE.GDI.TOTL.ZS
#> 11173             NE.IMP.GNFS.ZS
#> 11174             NE.MRCH.GDP.ZS
#> 11180             NE.RSB.GNFS.ZG
#> 11181             NE.RSB.GNFS.ZS
#> 11184             NE.TRD.GNFS.ZS
#> 11191             NP.AGR.TOTL.ZG
#> 11195             NP.IND.TOTL.ZG
#> 11201             NP.SRV.TOTL.ZG
#> 11209          NV.AGR.PCAP.KD.ZG
#> 11219             NV.AGR.TOTL.ZG
#> 11220             NV.AGR.TOTL.ZS
#> 11240             NV.IND.MANF.ZS
#> 11254             NV.IND.TOTL.ZG
#> 11255             NV.IND.TOTL.ZS
#> 11273             NV.SRV.DISC.CD
#> 11274             NV.SRV.DISC.CN
#> 11275             NV.SRV.DISC.KN
#> 11292             NV.SRV.TETC.ZG
#> 11293             NV.SRV.TETC.ZS
#> 11299             NV.SRV.TOTL.ZS
#> 11388          NY.AGR.SUBS.GD.ZS
#> 11392          NY.GDP.COAL.RT.ZS
#> 11393          NY.GDP.DEFL.87.ZG
#> 11394          NY.GDP.DEFL.KD.ZG
#> 11395       NY.GDP.DEFL.KD.ZG.AD
#> 11396             NY.GDP.DEFL.ZS
#> 11397          NY.GDP.DEFL.ZS.87
#> 11398          NY.GDP.DEFL.ZS.AD
#> 11399             NY.GDP.DISC.CD
#> 11400             NY.GDP.DISC.CN
#> 11401             NY.GDP.DISC.KN
#> 11405          NY.GDP.FCST.KD.87
#> 11407          NY.GDP.FCST.KN.87
#> 11408          NY.GDP.FRST.RT.ZS
#> 11409          NY.GDP.MINR.RT.ZS
#> 11410             NY.GDP.MKTP.CD
#> 11411          NY.GDP.MKTP.CD.XD
#> 11412             NY.GDP.MKTP.CN
#> 11413          NY.GDP.MKTP.CN.AD
#> 11414          NY.GDP.MKTP.CN.XD
#> 11415             NY.GDP.MKTP.IN
#> 11416             NY.GDP.MKTP.KD
#> 11417          NY.GDP.MKTP.KD.87
#> 11418          NY.GDP.MKTP.KD.ZG
#> 11419             NY.GDP.MKTP.KN
#> 11420          NY.GDP.MKTP.KN.87
#> 11421       NY.GDP.MKTP.KN.87.ZG
#> 11422          NY.GDP.MKTP.PP.CD
#> 11423          NY.GDP.MKTP.PP.KD
#> 11424       NY.GDP.MKTP.PP.KD.87
#> 11425             NY.GDP.MKTP.XD
#> 11426           NY.GDP.MKTP.XU.E
#> 11428          NY.GDP.NGAS.RT.ZS
#> 11429             NY.GDP.PCAP.CD
#> 11430             NY.GDP.PCAP.CN
#> 11431             NY.GDP.PCAP.KD
#> 11432          NY.GDP.PCAP.KD.ZG
#> 11433             NY.GDP.PCAP.KN
#> 11434          NY.GDP.PCAP.PP.CD
#> 11435          NY.GDP.PCAP.PP.KD
#> 11436       NY.GDP.PCAP.PP.KD.87
#> 11437       NY.GDP.PCAP.PP.KD.ZG
#> 11438          NY.GDP.PETR.RT.ZS
#> 11439          NY.GDP.TOTL.RT.ZS
#> 11452             NY.GDS.TOTL.ZS
#> 11457          NY.GEN.AEDU.GD.ZS
#> 11458          NY.GEN.DCO2.GD.ZS
#> 11459          NY.GEN.DFOR.GD.ZS
#> 11460          NY.GEN.DKAP.GD.ZS
#> 11461          NY.GEN.DMIN.GD.ZS
#> 11462          NY.GEN.DNGY.GD.ZS
#> 11463          NY.GEN.NDOM.GD.ZS
#> 11464          NY.GEN.SVNG.GD.ZS
#> 11497             NY.GNS.ICTR.ZS
#> 11535               NYGDPMKTPKDZ
#> 11536              NYGDPMKTPSACD
#> 11537              NYGDPMKTPSACN
#> 11538              NYGDPMKTPSAKD
#> 11539              NYGDPMKTPSAKN
#> 11564                 PA.NUS.PPP
#> 11565              PA.NUS.PPP.05
#> 11566             PA.NUS.PPPC.RF
#> 15599              SE.PRM.SATT.2
#> 15663              SE.PRM.TATT.1
#> 15890             SE.XPD.EDUC.ZS
#> 15895         SE.XPD.PRIM.GDP.ZS
#> 15896          SE.XPD.PRIM.PC.ZS
#> 15899         SE.XPD.SECO.GDP.ZS
#> 15900          SE.XPD.SECO.PC.ZS
#> 15904         SE.XPD.TERT.GDP.ZS
#> 15905          SE.XPD.TERT.PC.ZS
#> 15908          SE.XPD.TOTL.GD.ZS
#> 15928          SF.TRN.RAIL.KM.ZS
#> 16886          SH.XPD.CHEX.GD.ZS
#> 16895          SH.XPD.GHED.GD.ZS
#> 16899             SH.XPD.HLTH.ZS
#> 16900          SH.XPD.KHEX.GD.ZS
#> 16912             SH.XPD.PRIV.ZS
#> 16915             SH.XPD.PUBL.ZS
#> 16921             SH.XPD.TOTL.ZS
#> 17073          SL.GDP.PCAP.EM.KD
#> 17074       SL.GDP.PCAP.EM.KD.ZG
#> 17075          SL.GDP.PCAP.EM.XD
#> 17833       TG.VAL.TOTL.GD.PP.ZS
#> 17834          TG.VAL.TOTL.GD.ZS
#> 17835          TG.VAL.TOTL.GG.ZS
#> 20066           UIS.XGDP.0.FSGOV
#> 20067           UIS.XGDP.1.FSGOV
#> 20068           UIS.XGDP.2.FSGOV
#> 20069          UIS.XGDP.23.FSGOV
#> 20070       UIS.XGDP.2T4.V.FSGOV
#> 20071           UIS.XGDP.3.FSGOV
#> 20072           UIS.XGDP.4.FSGOV
#> 20073          UIS.XGDP.56.FSGOV
#> 20123  UIS.XUNIT.GDPCAP.02.FSGOV
#> 20124   UIS.XUNIT.GDPCAP.1.FSGOV
#> 20125    UIS.XUNIT.GDPCAP.1.FSHH
#> 20126   UIS.XUNIT.GDPCAP.2.FSGOV
#> 20127  UIS.XUNIT.GDPCAP.23.FSGOV
#> 20128   UIS.XUNIT.GDPCAP.23.FSHH
#> 20129   UIS.XUNIT.GDPCAP.3.FSGOV
#> 20130 UIS.XUNIT.GDPCAP.5T8.FSGOV
#> 20131  UIS.XUNIT.GDPCAP.5T8.FSHH
#>                                                                                                                                                                            name
#> 712                                                                                                                                                       Per capita GDP growth
#> 714                                                                                                                                                             GDP (current $)
#> 715                                                                                                                                                       GDP growth (annual %)
#> 716                                                                                                                                                       GDP (constant 2005 $)
#> 717                                                                                                                        GDP per capita, PPP (constant 2011 international $) 
#> 1557                                                                                                                                               Trade in services (% of GDP)
#> 1558                                                                                                                                Gross private capital flows (% of GDP, PPP)
#> 1559                                                                                                                                     Gross private capital flows (% of GDP)
#> 1560                                                                                                                            Gross foreign direct investment (% of GDP, PPP)
#> 1561                                                                                                                                 Gross foreign direct investment (% of GDP)
#> 1752                                                                                                                                           Wage bill as a percentage of GDP
#> 1772                                                                                                                           Merchandise imports (BOP): percentage of GDP (%)
#> 1784                                                                                                                         Foreign direct investment, net outflows (% of GDP)
#> 1785                                                                                                                         Foreign direct investment, net outflows (% of GDP)
#> 1798                                                                                                                                         Current account balance (% of GDP)
#> 1799                                                                                                                                         Current account balance (% of GDP)
#> 1802                                                                                                                         Curr. acc. bal. before official transf. (% of GDP)
#> 1805                                                                                                   Current account balance excluding net official capital grants (% of GDP)
#> 1811                                                                                                                                                      Net income (% of GDP)
#> 1820                                                                                                                                       Foreign direct investment (% of GDP)
#> 1822                                                                                                                          Foreign direct investment, net inflows (% of GDP)
#> 1828                                                                                                                                    Private capital flows, total (% of GDP)
#> 1839                                                                                                                                           Net current transfers (% of GDP)
#> 1875                                                                                                                           Merchandise exports (BOP): percentage of GDP (%)
#> 1887                                                                                                                          Foreign direct investment, net inflows (% of GDP)
#> 1889                                                                                                                          Foreign direct investment, net inflows (% of GDP)
#> 1898                                                                                                                                      Migrant remittance inflows (% of GDP)
#> 1904                                                                                                                                  Personal remittances, received (% of GDP)
#> 1905                                                                                                                                  Workers' remittances, receipts (% of GDP)
#> 2198                                                                                                                                        Total energy tax revenue (% of GDP)
#> 2270                                                                                  Macro drivers of GHG emissions growth in the period 2012-2018 - Emission Intensity of GDP
#> 2271                                                                                             Macro drivers of GHG emissions growth in the period 2012-2018 - GDP per capita
#> 2293                                                                           Annual investment needs for coastal protection, by risk strategy (% of GDP) - low risk tolerance
#> 2294                                                                 Annual investment needs for coastal protection, by risk strategy (% of GDP) - constant relative flood risk
#> 2295                                                                           Annual investment needs for coastal protection, by risk strategy (% of GDP) - optimal protection
#> 2356                                                                                                                          Risk to asset (average annual losses as % of GDP)
#> 2357                                                                                                                      Risk to wellbeing (average annual losses as % of GDP)
#> 2364                                                                                                                             Public social protection expenditure (%of GDP)
#> 2401                                                                                                      Financing via international capital markets (gross inflows, % of GDP)
#> 2404                                                                                                              Market capitalization of listed domestic companies (% of GDP)
#> 2407                                                                                                                                      Stocks traded, total value (% of GDP)
#> 2559                                                            Gross PSD, Budgetary Central Gov., All maturities, All instruments, Domestic creditors, Nominal Value, % of GDP
#> 2562                                                                      Gross PSD, Central Gov., All maturities, All instruments, Domestic creditors, Nominal Value, % of GDP
#> 2565                                                            Gross PSD, Financial Public Corp., All maturities, All instruments, Domestic creditors, Nominal Value, % of GDP
#> 2568                                                                      Gross PSD, General Gov., All maturities, All instruments, Domestic creditors, Nominal Value, % of GDP
#> 2571                                                         Gross PSD, Nonfinancial Public Corp., All maturities, All instruments, Domestic creditors, Nominal Value, % of GDP
#> 2576                                                              Gross PSD, Budgetary Central Gov., All maturities, All instruments, Foreign currency, Nominal Value, % of GDP
#> 2579                                                                        Gross PSD, Central Gov., All maturities, All instruments, Foreign currency, Nominal Value, % of GDP
#> 2582                                                              Gross PSD, Financial Public Corp., All maturities, All instruments, Foreign currency, Nominal Value, % of GDP
#> 2585                                                                        Gross PSD, General Gov., All maturities, All instruments, Foreign currency, Nominal Value, % of GDP
#> 2588                                                           Gross PSD, Nonfinancial Public Corp., All maturities, All instruments, Foreign currency, Nominal Value, % of GDP
#> 2593                                                             Gross PSD, Budgetary Central Gov., All maturities, All instruments, Domestic currency, Nominal Value, % of GDP
#> 2596                                                                       Gross PSD, Central Gov., All maturities, All instruments, Domestic currency, Nominal Value, % of GDP
#> 2599                                                             Gross PSD, Financial Public Corp., All maturities, All instruments, Domestic currency, Nominal Value, % of GDP
#> 2602                                                                       Gross PSD, General Gov., All maturities, All instruments, Domestic currency, Nominal Value, % of GDP
#> 2605                                                          Gross PSD, Nonfinancial Public Corp., All maturities, All instruments, Domestic currency, Nominal Value, % of GDP
#> 2610                                                                                Gross PSD, Budgetary Central Gov., All maturities, All instruments, Nominal Value, % of GDP
#> 2613                                                                                          Gross PSD, Central Gov., All maturities, All instruments, Nominal Value, % of GDP
#> 2616                                                                                Gross PSD, Financial Public Corp., All maturities, All instruments, Nominal Value, % of GDP
#> 2619                                                                                          Gross PSD, General Gov., All maturities, All instruments, Nominal Value, % of GDP
#> 2622                                                                             Gross PSD, Nonfinancial Public Corp., All maturities, All instruments, Nominal Value, % of GDP
#> 2627                                                            Gross PSD, Budgetary Central Gov., All maturities, All instruments, External creditors, Nominal Value, % of GDP
#> 2630                                                                      Gross PSD, Central Gov., All maturities, All instruments, External creditors, Nominal Value, % of GDP
#> 2633                                                            Gross PSD, Financial Public Corp., All maturities, All instruments, External creditors, Nominal Value, % of GDP
#> 2636                                                                      Gross PSD, General Gov., All maturities, All instruments, External creditors, Nominal Value, % of GDP
#> 2639                                                         Gross PSD, Nonfinancial Public Corp., All maturities, All instruments, External creditors, Nominal Value, % of GDP
#> 2644                                                                          Gross PSD, Budgetary Central Gov., All maturities, Currency and deposits, Nominal Value, % of GDP
#> 2647                                                                                    Gross PSD, Central Gov., All maturities, Currency and deposits, Nominal Value, % of GDP
#> 2650                                                                          Gross PSD, Financial Public Corp., All maturities, Currency and deposits, Nominal Value, % of GDP
#> 2653                                                                                    Gross PSD, General Gov., All maturities, Currency and deposits, Nominal Value, % of GDP
#> 2656                                         Gross PSD, Budgetary Central Gov., Long-term, With payment due in one year or less, Currency and deposits, Nominal Value, % of GDP
#> 2659                                                   Gross PSD, Central Gov., Long-term, With payment due in one year or less, Currency and deposits, Nominal Value, % of GDP
#> 2662                                         Gross PSD, Financial Public Corp., Long-term, With payment due in one year or less, Currency and deposits, Nominal Value, % of GDP
#> 2665                                                   Gross PSD, General Gov., Long-term, With payment due in one year or less, Currency and deposits, Nominal Value, % of GDP
#> 2668                                      Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in one year or less, Currency and deposits, Nominal Value, % of GDP
#> 2673                                       Gross PSD, Budgetary Central Gov., Long-term, With payment due in more than one year, Currency and deposits, Nominal Value, % of GDP
#> 2676                                                 Gross PSD, Central Gov., Long-term, With payment due in more than one year, Currency and deposits, Nominal Value, % of GDP
#> 2679                                       Gross PSD, Financial Public Corp., Long-term, With payment due in more than one year, Currency and deposits, Nominal Value, % of GDP
#> 2682                                                 Gross PSD, General Gov., Long-term, With payment due in more than one year, Currency and deposits, Nominal Value, % of GDP
#> 2685                                    Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in more than one year, Currency and deposits, Nominal Value, % of GDP
#> 2690                                                                       Gross PSD, Nonfinancial Public Corp., All maturities, Currency and deposits, Nominal Value, % of GDP
#> 2694                                                                               Gross PSD, Central Gov.-D1, All maturities, Debt securities + loans, Nominal Value, % of GDP
#> 2696                                                                               Gross PSD, General Gov.-D1, All maturities, Debt securities + loans, Nominal Value, % of GDP
#> 2698                                                                      Gross PSD, Central Gov.-D2, All maturities, D1+ SDRs + currency and deposits, Nominal Value, % of GDP
#> 2700                                                                      Gross PSD, General Gov.-D2, All maturities, D1+ SDRs + currency and deposits, Nominal Value, % of GDP
#> 2702                                                                          Gross PSD, Central Gov.-D2A, All maturities, D1+ currency and deposits, Maastricht debt, % of GDP
#> 2704                                                                          Gross PSD, General Gov.-D2A, All maturities, D1+ currency and deposits, Maastricht debt, % of GDP
#> 2706                                                                             Gross PSD, Central Gov.-D3, All maturities, D2+other accounts payable, Nominal Value, % of GDP
#> 2708                                                                             Gross PSD, General Gov.-D3, All maturities, D2+other accounts payable, Nominal Value, % of GDP
#> 2710                                                   Gross PSD, Central Gov.-D4, All maturities, D3+insurance, pensions, and standardized guarantees, Nominal Value, % of GDP
#> 2712                                                   Gross PSD, General Gov.-D4, All maturities, D3+insurance, pensions, and standardized guarantees, Nominal Value, % of GDP
#> 2715                                                                                Gross PSD, Budgetary Central Gov., All maturities, Debt securities, Nominal Value, % of GDP
#> 2718                                                                                          Gross PSD, Central Gov., All maturities, Debt securities, Nominal Value, % of GDP
#> 2721                                                                                Gross PSD, Financial Public Corp., All maturities, Debt securities, Nominal Value, % of GDP
#> 2724                                                                                          Gross PSD, General Gov., All maturities, Debt securities, Nominal Value, % of GDP
#> 2727                                               Gross PSD, Budgetary Central Gov., Long-term, With payment due in one year or less, Debt securities, Nominal Value, % of GDP
#> 2730                                                         Gross PSD, Central Gov., Long-term, With payment due in one year or less, Debt securities, Nominal Value, % of GDP
#> 2733                                               Gross PSD, Financial Public Corp., Long-term, With payment due in one year or less, Debt securities, Nominal Value, % of GDP
#> 2736                                                         Gross PSD, General Gov., Long-term, With payment due in one year or less, Debt securities, Nominal Value, % of GDP
#> 2739                                            Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in one year or less, Debt securities, Nominal Value, % of GDP
#> 2744                                             Gross PSD, Budgetary Central Gov., Long-term, With payment due in more than one year, Debt securities, Nominal Value, % of GDP
#> 2747                                                       Gross PSD, Central Gov., Long-term, With payment due in more than one year, Debt securities, Nominal Value, % of GDP
#> 2750                                             Gross PSD, Financial Public Corp., Long-term, With payment due in more than one year, Debt securities, Nominal Value, % of GDP
#> 2753                                                       Gross PSD, General Gov., Long-term, With payment due in more than one year, Debt securities, Nominal Value, % of GDP
#> 2756                                          Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in more than one year, Debt securities, Nominal Value, % of GDP
#> 2761                                                                                 Gross PSD, Budgetary Central Gov., All maturities, Debt Securities, Market value, % of GDP
#> 2764                                                                                           Gross PSD, Central Gov., All maturities, Debt Securities, Market value, % of GDP
#> 2767                                                                                 Gross PSD, Financial Public Corp., All maturities, Debt Securities, Market value, % of GDP
#> 2770                                                                                           Gross PSD, General Gov., All maturities, Debt Securities, Market value, % of GDP
#> 2773                                                                              Gross PSD, Nonfinancial Public Corp., All maturities, Debt Securities, Market value, % of GDP
#> 2778                                                                             Gross PSD, Nonfinancial Public Corp., All maturities, Debt securities, Nominal Value, % of GDP
#> 2783                                        Gross PSD, Budgetary Central Gov., All maturities, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2786                                                  Gross PSD, Central Gov., All maturities, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2789                                        Gross PSD, Financial Public Corp., All maturities, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2792                                                  Gross PSD, General Gov., All maturities, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2795       Gross PSD, Budgetary Central Gov., Long-term, With payment due in one year or less, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2798                 Gross PSD, Central Gov., Long-term, With payment due in one year or less, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2801       Gross PSD, Financial Public Corp., Long-term, With payment due in one year or less, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2804                 Gross PSD, General Gov., Long-term, With payment due in one year or less, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2807    Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in one year or less, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2812     Gross PSD, Budgetary Central Gov., Long-term, With payment due in more than one year, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2815               Gross PSD, Central Gov., Long-term, With payment due in more than one year, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2818     Gross PSD, Financial Public Corp., Long-term, With payment due in more than one year, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2821               Gross PSD, General Gov., Long-term, With payment due in more than one year, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2824  Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in more than one year, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2829                                     Gross PSD, Nonfinancial Public Corp., All maturities, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 2834                                                                                          Gross PSD, Budgetary Central Gov., All maturities, Loans, Nominal Value, % of GDP
#> 2837                                                                                                    Gross PSD, Central Gov., All maturities, Loans, Nominal Value, % of GDP
#> 2840                                                                                          Gross PSD, Financial Public Corp., All maturities, Loans, Nominal Value, % of GDP
#> 2843                                                                                                    Gross PSD, General Gov., All maturities, Loans, Nominal Value, % of GDP
#> 2846                                                         Gross PSD, Budgetary Central Gov., Long-term, With payment due in one year or less, Loans, Nominal Value, % of GDP
#> 2849                                                                   Gross PSD, Central Gov., Long-term, With payment due in one year or less, Loans, Nominal Value, % of GDP
#> 2852                                                         Gross PSD, Financial Public Corp., Long-term, With payment due in one year or less, Loans, Nominal Value, % of GDP
#> 2855                                                                   Gross PSD, General Gov., Long-term, With payment due in one year or less, Loans, Nominal Value, % of GDP
#> 2858                                                      Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in one year or less, Loans, Nominal Value, % of GDP
#> 2863                                                       Gross PSD, Budgetary Central Gov., Long-term, With payment due in more than one year, Loans, Nominal Value, % of GDP
#> 2866                                                                 Gross PSD, Central Gov., Long-term, With payment due in more than one year, Loans, Nominal Value, % of GDP
#> 2869                                                       Gross PSD, Financial Public Corp., Long-term, With payment due in more than one year, Loans, Nominal Value, % of GDP
#> 2872                                                                 Gross PSD, General Gov., Long-term, With payment due in more than one year, Loans, Nominal Value, % of GDP
#> 2875                                                    Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in more than one year, Loans, Nominal Value, % of GDP
#> 2880                                                                                       Gross PSD, Nonfinancial Public Corp., All maturities, Loans, Nominal Value, % of GDP
#> 2885                                                                         Gross PSD, Budgetary Central Gov., All maturities, Other accounts payable, Nominal Value, % of GDP
#> 2888                                                                                   Gross PSD, Central Gov., All maturities, Other accounts payable, Nominal Value, % of GDP
#> 2891                                                                         Gross PSD, Financial Public Corp., All maturities, Other accounts payable, Nominal Value, % of GDP
#> 2894                                                                                   Gross PSD, General Gov., All maturities, Other accounts payable, Nominal Value, % of GDP
#> 2897                                        Gross PSD, Budgetary Central Gov., Long-term, With payment due in one year or less, Other accounts payable, Nominal Value, % of GDP
#> 2900                                                  Gross PSD, Central Gov., Long-term, With payment due in one year or less, Other accounts payable, Nominal Value, % of GDP
#> 2903                                        Gross PSD, Financial Public Corp., Long-term, With payment due in one year or less, Other accounts payable, Nominal Value, % of GDP
#> 2906                                                  Gross PSD, General Gov., Long-term, With payment due in one year or less, Other accounts payable, Nominal Value, % of GDP
#> 2909                                     Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in one year or less, Other accounts payable, Nominal Value, % of GDP
#> 2914                                      Gross PSD, Budgetary Central Gov., Long-term, With payment due in more than one year, Other accounts payable, Nominal Value, % of GDP
#> 2917                                                Gross PSD, Central Gov., Long-term, With payment due in more than one year, Other accounts payable, Nominal Value, % of GDP
#> 2920                                      Gross PSD, Financial Public Corp., Long-term, With payment due in more than one year, Other accounts payable, Nominal Value, % of GDP
#> 2923                                                Gross PSD, General Gov., Long-term, With payment due in more than one year, Other accounts payable, Nominal Value, % of GDP
#> 2926                                   Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in more than one year, Other accounts payable, Nominal Value, % of GDP
#> 2931                                                                      Gross PSD, Nonfinancial Public Corp., All maturities, Other accounts payable, Nominal Value, % of GDP
#> 2936                                                                         Gross PSD, Budgetary Central Gov., All maturities, Special Drawing Rights, Nominal Value, % of GDP
#> 2939                                                                                   Gross PSD, Central Gov., All maturities, Special Drawing Rights, Nominal Value, % of GDP
#> 2942                                                                         Gross PSD, Financial Public Corp., All maturities, Special Drawing Rights, Nominal Value, % of GDP
#> 2945                                                                                   Gross PSD, General Gov., All maturities, Special Drawing Rights, Nominal Value, % of GDP
#> 2948                                      Gross PSD, Budgetary Central Gov., Long-term, With payment due in more than one year, Special Drawing Rights, Nominal Value, % of GDP
#> 2951                                                Gross PSD, Central Gov., Long-term, With payment due in more than one year, Special Drawing Rights, Nominal Value, % of GDP
#> 2954                                      Gross PSD, Financial Public Corp., Long-term, With payment due in more than one year, Special Drawing Rights, Nominal Value, % of GDP
#> 2957                                                Gross PSD, General Gov., Long-term, With payment due in more than one year, Special Drawing Rights, Nominal Value, % of GDP
#> 2960                                   Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in more than one year, Special Drawing Rights, Nominal Value, % of GDP
#> 2965                                                                      Gross PSD, Nonfinancial Public Corp., All maturities, Special Drawing Rights, Nominal Value, % of GDP
#> 2970                                                                                     Gross PSD, Budgetary Central Gov., Long-term, All instruments, Nominal Value, % of GDP
#> 2973                                                                                               Gross PSD, Central Gov., Long-term, All instruments, Nominal Value, % of GDP
#> 2976                                                                                     Gross PSD, Financial Public Corp., Long-term, All instruments, Nominal Value, % of GDP
#> 2979                                                                                               Gross PSD, General Gov., Long-term, All instruments, Nominal Value, % of GDP
#> 2982                                               Gross PSD, Budgetary Central Gov., Long-term, With payment due in one year or less, All instruments, Nominal Value, % of GDP
#> 2985                                                         Gross PSD, Central Gov., Long-term, With payment due in one year or less, All instruments, Nominal Value, % of GDP
#> 2988                                               Gross PSD, Financial Public Corp., Long-term, With payment due in one year or less, All instruments, Nominal Value, % of GDP
#> 2991                                                         Gross PSD, General Gov., Long-term, With payment due in one year or less, All instruments, Nominal Value, % of GDP
#> 2994                                            Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in one year or less, All instruments, Nominal Value, % of GDP
#> 2999                                             Gross PSD, Budgetary Central Gov., Long-term, With payment due in more than one year, All instruments, Nominal Value, % of GDP
#> 3002                                                       Gross PSD, Central Gov., Long-term, With payment due in more than one year, All instruments, Nominal Value, % of GDP
#> 3005                                             Gross PSD, Financial Public Corp., Long-term, With payment due in more than one year, All instruments, Nominal Value, % of GDP
#> 3008                                                       Gross PSD, General Gov., Long-term, With payment due in more than one year, All instruments, Nominal Value, % of GDP
#> 3011                                          Gross PSD, Nonfinancial Public Corp., Long-term, With payment due in more than one year, All instruments, Nominal Value, % of GDP
#> 3016                                                                                  Gross PSD, Nonfinancial Public Corp., Long-term, All instruments, Nominal Value, % of GDP
#> 3022                                                                              Gross PSD, Budgetary Central Gov., Short-term, Currency and deposits, Nominal Value, % of GDP
#> 3025                                                                                        Gross PSD, Central Gov., Short-term, Currency and deposits, Nominal Value, % of GDP
#> 3028                                                                              Gross PSD, Financial Public Corp., Short-term, Currency and deposits, Nominal Value, % of GDP
#> 3031                                                                                        Gross PSD, General Gov., Short-term, Currency and deposits, Nominal Value, % of GDP
#> 3034                                                                           Gross PSD, Nonfinancial Public Corp., Short-term, Currency and deposits, Nominal Value, % of GDP
#> 3039                                                                                    Gross PSD, Budgetary Central Gov., Short-term, Debt securities, Nominal Value, % of GDP
#> 3042                                                                                              Gross PSD, Central Gov., Short-term, Debt securities, Nominal Value, % of GDP
#> 3045                                                                                    Gross PSD, Financial Public Corp., Short-term, Debt securities, Nominal Value, % of GDP
#> 3048                                                                                              Gross PSD, General Gov., Short-term, Debt securities, Nominal Value, % of GDP
#> 3051                                                                                 Gross PSD, Nonfinancial Public Corp., Short-term, Debt securities, Nominal Value, % of GDP
#> 3056                                            Gross PSD, Budgetary Central Gov., Short-term, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 3059                                                      Gross PSD, Central Gov., Short-term, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 3062                                            Gross PSD, Financial Public Corp., Short-term, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 3065                                                      Gross PSD, General Gov., Short-term, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 3068                                         Gross PSD, Nonfinancial Public Corp., Short-term, Insurance, pensions, and standardized guarantee schemes, Nominal Value, % of GDP
#> 3073                                                                                              Gross PSD, Budgetary Central Gov., Short-term, Loans, Nominal Value, % of GDP
#> 3076                                                                                                        Gross PSD, Central Gov., Short-term, Loans, Nominal Value, % of GDP
#> 3079                                                                                              Gross PSD, Financial Public Corp., Short-term, Loans, Nominal Value, % of GDP
#> 3082                                                                                                        Gross PSD, General Gov., Short-term, Loans, Nominal Value, % of GDP
#> 3085                                                                                           Gross PSD, Nonfinancial Public Corp., Short-term, Loans, Nominal Value, % of GDP
#> 3090                                                                             Gross PSD, Budgetary Central Gov., Short-term, Other accounts payable, Nominal Value, % of GDP
#> 3093                                                                                       Gross PSD, Central Gov., Short-term, Other accounts payable, Nominal Value, % of GDP
#> 3096                                                                             Gross PSD, Financial Public Corp., Short-term, Other accounts payable, Nominal Value, % of GDP
#> 3099                                                                                       Gross PSD, General Gov., Short-term, Other accounts payable, Nominal Value, % of GDP
#> 3102                                                                          Gross PSD, Nonfinancial Public Corp., Short-term, Other accounts payable, Nominal Value, % of GDP
#> 3107                                                                                    Gross PSD, Budgetary Central Gov., Short-term, All instruments, Nominal Value, % of GDP
#> 3110                                                                                              Gross PSD, Central Gov., Short-term, All instruments, Nominal Value, % of GDP
#> 3113                                                                                    Gross PSD, Financial Public Corp., Short-term, All instruments, Nominal Value, % of GDP
#> 3116                                                                                              Gross PSD, General Gov., Short-term, All instruments, Nominal Value, % of GDP
#> 3119                                                                                 Gross PSD, Nonfinancial Public Corp., Short-term, All instruments, Nominal Value, % of GDP
#> 3615                                                                                                                               Debt on Concessional terms to GDP (% of GDP)
#> 3618                                                                                                                           Debt on Non-concessional terms to GDP (% of GDP)
#> 3773                                                                                                                    Debt outstanding and disbursed, Total to GDP (% of GDP)
#> 5376                                                                                                                                                Net ODA received (% of GDP)
#> 5447                                                                                                                    Net ODA received from DAC donors (% of recipient's GDP)
#> 5452                                                                                                                       Net ODA received from multilateral donors (% of GDP)
#> 5460                                                                                                                  Net ODA received from non-DAC bilateral donors (% of GDP)
#> 5466                                                                                                                                                Net ODA received (% of GDP)
#> 5616                                                                                                                                              Total debt service (% of GDP)
#> 5969                                                                                                                Energy intensity level of primary energy (MJ/$2017 PPP GDP)
#> 5993                                                                                                             GDP per unit of energy use (1987 US$ per kg of oil equivalent)
#> 5994                                                                                                             GDP per unit of energy use (2000 US$ per kg of oil equivalent)
#> 5995                                                                                                                GDP per unit of energy use (PPP $ per kg of oil equivalent)
#> 5996                                                                                                  GDP per unit of energy use (constant 2017 PPP $ per kg of oil equivalent)
#> 6004                                                                                                       Energy use (kg of oil equivalent) per $1,000 GDP (constant 2017 PPP)
#> 6023                                                                                                                         CO2 emissions, industrial (kg per 1987 US$ of GDP)
#> 6027                                                                                                                         CO2 emissions, industrial (kg per 1987 US$ of GDP)
#> 6028                                                                                                                                     CO2 emissions (kg per 2015 US$ of GDP)
#> 6033                                                                                                                                        CO2 emissions (kg per PPP $ of GDP)
#> 6034                                                                                                                                   CO2 emissions (kg per 2017 PPP $ of GDP)
#> 6164                                                                           Water productivity, total (constant 2015 US$ GDP per cubic meter of total freshwater withdrawal)
#> 6182                                                                                                             GDP per unit of energy use (1987 US$ per kg of oil equivalent)
#> 6236                                                                                                                           Deposit insurance coverage (% of GDP per capita)
#> 6589                                                                                                                      Domestic credit to private sector by banks (% of GDP)
#> 6595                                                                                                                                    Total reserves includes gold (% of GDP)
#> 7389                                                                                                                 Claims on governments and other public entities (% of GDP)
#> 7398                                                                                                                           Monetary Sector credit to private sector (% GDP)
#> 7407                                                                                                                                                     Broad money (% of GDP)
#> 7414                                                                                                                                     Money and quasi money (M2) as % of GDP
#> 7415                                                                                                                                     Money and quasi money (M2) as % of GDP
#> 7417                                                                                                                                          Income velocity of money (GDP/M2)
#> 7422                                                                                                                                        Quasi-liquid liabilities (% of GDP)
#> 7423                                                                                                                                                      Seignorage (% of GDP)
#> 7462                                                                                                                                 Claims on central government, etc. (% GDP)
#> 7463                                                                                                                 Claims on other sectors of the domestic economy (% of GDP)
#> 7464                                                                                                                    Domestic credit provided by financial sector (% of GDP)
#> 7465                                                                                                                      Domestic credit provided by banking sector (% of GDP)
#> 7467                                                                                                                               Domestic credit to private sector (% of GDP)
#> 7468                                                                                                                                        Credit to private sector (% of GDP)
#> 7469                                                                                                                                        Liquid liabilities (M3) as % of GDP
#> 7470                                                                                                                                        Liquid liabilities (M3) as % of GDP
#> 7471                                                                                                                                        Quasi-liquid liabilities (% of GDP)
#> 7530                                                                                                                        Overall budget balance, including grants (% of GDP)
#> 7531                                                                                                                        Overall budget deficit, including grants (% of GDP)
#> 7540                                                                                                                                  Central government debt, total (% of GDP)
#> 7541                                                                                                                                  Central government debt, total (% of GDP)
#> 7545                                                                                                                                           Financing from abroad (% of GDP)
#> 7546                                                                                                                                           Financing from abroad (% of GDP)
#> 7550                                                                                                                                       Domestic financing, total (% of GDP)
#> 7551                                                                                                                                             Domestic finanacing (% of GDP)
#> 7561                                                                                                                               Current revenue, excluding grants (% of GDP)
#> 7564                                                                                                                                                 Current revenue (% of GDP)
#> 7566                                                                                                               Central government revenues, excluding all grants (% of GDP)
#> 7569                                                                                                                               Current revenue, excluding grants (% of GDP)
#> 7571                                                                                                                                               SOE external debt (% of GDP)
#> 7573                                                                                                                      State-owned enterprises, economic activity (% of GDP)
#> 7574                                                                                                                                           SOE economic activity (% of GDP)
#> 7577                                                                                                    State-owned enterprises, net financial flows from government (% of GDP)
#> 7578                                                                                                                         SOE net financial flows from government (% of GDP)
#> 7579                                                                                                       State-owned enterprises, overall balance before transfers (% of GDP)
#> 7605                                                                                                                                                     Tax revenue (% of GDP)
#> 7606                                                                                                                                                     Tax revenue (% of GDP)
#> 7624                                                                                                                                             Defense expenditure (% of GDP)
#> 7627                                                                                                                            Research and development expenditure (% of GDP)
#> 7630                                                                                                                                              Expenditure, total (% of GDP)
#> 7631                                                                                                                                               Total expenditure (% of GDP)
#> 7638                                                                                                                             Net acquisition of financial assets (% of GDP)
#> 7641                                                                                                                                            Cash surplus/deficit (% of GDP)
#> 7646                                                                                                                                  Central government debt, total (% of GDP)
#> 7650                                                                                                                         Net incurrence of liabilities, domestic (% of GDP)
#> 7652                                                                                                                          Net incurrence of liabilities, foreign (% of GDP)
#> 7654                                                                                                                            Net incurrence of liabilities, total (% of GDP)
#> 7656                                                                                                                           Net investment in nonfinancial assets (% of GDP)
#> 7658                                                                                                                             Net lending (+) / net borrowing (-) (% of GDP)
#> 7669                                                                                                                                       Revenue, excluding grants (% of GDP)
#> 7684                                                                                                                                                     Tax revenue (% of GDP)
#> 7701                                                                                                                                                         Expense (% of GDP)
#> 7792                                                                                                                           Private credit by deposit money banks to GDP (%)
#> 7793                                                                                                                                    Deposit money banks'' assets to GDP (%)
#> 7794                                                                                                                          Nonbank financial institutions’ assets to GDP (%)
#> 7796                                                                                                                                              Liquid liabilities to GDP (%)
#> 7797                                                                                                                                             Central bank assets to GDP (%)
#> 7798                                                                                                                                              Mutual fund assets to GDP (%)
#> 7799                                                                                                                                       Financial system deposits to GDP (%)
#> 7800                                                                                                                                   Life insurance premium volume to GDP (%)
#> 7801                                                                                                                               Non-life insurance premium volume to GDP (%)
#> 7802                                                                                                                                        Insurance company assets to GDP (%)
#> 7803                                                                                          Private credit by deposit money banks and other financial institutions to GDP (%)
#> 7804                                                                                                                                             Pension fund assets to GDP (%)
#> 7805                                                                                                                               Domestic credit to private sector (% of GDP)
#> 7806                                                                                                                                     Stock market capitalization to GDP (%)
#> 7807                                                                                                                                 Stock market total value traded to GDP (%)
#> 7808                                                                                                                    Outstanding domestic private debt securities to GDP (%)
#> 7809                                                                                                                     Outstanding domestic public debt securities to GDP (%)
#> 7810                                                                                                               Outstanding international private debt securities to GDP (%)
#> 7811                                                                                                                Outstanding international public debt securities to GDP (%)
#> 7812                                                                                                                                       International debt issues to GDP (%)
#> 7813                                                                                                                              Gross portfolio equity liabilities to GDP (%)
#> 7814                                                                                                                                   Gross portfolio equity assets to GDP (%)
#> 7815                                                                                                                                Gross portfolio debt liabilities to GDP (%)
#> 7816                                                                                                                                     Gross portfolio debt assets to GDP (%)
#> 7817                                                                                                                                 Syndicated loan issuance volume to GDP (%)
#> 7818                                                                                                                                  Corporate bond issuance volume to GDP (%)
#> 7821                                                                                                                   Credit flows by fintech and bigtech companies to GDP (%)
#> 7822                                                                                                                   Credit flows by fintech and bigtech companies to GDP (%)
#> 7830                                                                                                                Credit to government and state-owned enterprises to GDP (%)
#> 7837                                                                                                                                                   Bank deposits to GDP (%)
#> 7843                                                                                                                              Loans from nonresident banks (net) to GDP (%)
#> 7844                                                                                                              Loans from nonresident banks (amounts outstanding) to GDP (%)
#> 7848                                                                                                                                              Remittance inflows to GDP (%)
#> 7849                                                                                                              Consolidated foreign claims of BIS reporting banks to GDP (%)
#> 7854                                                                                                                                           Global leasing volume to GDP (%)
#> 7855                                                                                                                                          Total factoring volume to GDP (%)
#> 8686                                                                                                            Information and communication technology expenditure (% of GDP)
#> 8959                                                                                                              Railways, goods transported (ton-km per PPP $ million of GDP)
#> 8961                                                                                                                          Railways, passenger-km (per PPP $ million of GDP)
#> 9068                                                                                                                                         Telecommunications revenue (% GDP)
#> 10943                                                                                                                                           Military expenditure (% of GDP)
#> 10948                                                                           GDP on Accommodation & Food Beverages Activity Sector (in IDR Million), SNA 2008, Current Price
#> 10949                                                                          GDP on Accommodation & Food Beverages Activity Sector (in IDR Million), SNA 2008, Constant Price
#> 10950                                                                                                                 GDP on Agriculture Sector (in IDR Million), Current Price
#> 10951                                                                                                                GDP on Agriculture Sector (in IDR Million), Constant Price
#> 10952                                                                                 GDP on Agriculture, Forestry & Fisheries Sector (in IDR Million), SNA 2008, Current Price
#> 10953                                                                                GDP on Agriculture, Forestry & Fisheries Sector (in IDR Million), SNA 2008, Constant Price
#> 10954                                                                                                 GDP on Business Services Sector (in IDR Million), SNA 2008, Current Price
#> 10955                                                                                                GDP on Business Services Sector (in IDR Million), SNA 2008, Constant Price
#> 10956                                                                                                                GDP on Construction Sector (in IDR Million), Current Price
#> 10957                                                                                                               GDP on Construction Sector (in IDR Million), Constant Price
#> 10958                                                                                                      GDP on Construction Sector (in IDR Million), SNA 2008, Current Price
#> 10959                                                                                                     GDP on Construction Sector (in IDR Million), SNA 2008, Constant Price
#> 10960                                                                                                GDP on Education Services Sector (in IDR Million), SNA 2008, Current Price
#> 10961                                                                                               GDP on Education Services Sector (in IDR Million), SNA 2008, Constant Price
#> 10962                                                                                          GDP on Electricity & Gas Supply Sector (in IDR Million), SNA 2008, Current Price
#> 10963                                                                                         GDP on Electricity & Gas Supply Sector (in IDR Million), SNA 2008, Constant Price
#> 10964                                                                                                           Total GDP excluding Oil and Gas (in IDR Million), Current Price
#> 10965                                                                                                          Total GDP excluding Oil and Gas (in IDR Million), Constant Price
#> 10966                                                                                                           GDP on Financial Service Sector (in IDR Million), Current Price
#> 10967                                                                                                          GDP on Financial Service Sector (in IDR Million), Constant Price
#> 10968                                                                                    GDP on Financial & Insurance Activity Sector (in IDR Million), SNA 2008, Current Price
#> 10969                                                                                   GDP on Financial & Insurance Activity Sector (in IDR Million), SNA 2008, Constant Price
#> 10970                                                                               GDP on Human Health & Social Work Activity Sector (in IDR Million), SNA 2008, Current Price
#> 10971                                                                              GDP on Human Health & Social Work Activity Sector (in IDR Million), SNA 2008, Constant Price
#> 10972                                                                                                           Total GDP including Oil and Gas (in IDR Million), Current Price
#> 10973                                                                                                          Total GDP including Oil and Gas (in IDR Million), Constant Price
#> 10974                                                                                                 Total GDP including Oil and Gas (in IDR Million), SNA 2008, Current Price
#> 10975                                                                                                Total GDP including Oil and Gas (in IDR Million), SNA 2008, Constant Price
#> 10976                                                                                       GDP on Information & Communication Sector (in IDR Million), SNA 2008, Current Price
#> 10977                                                                                      GDP on Information & Communication Sector (in IDR Million), SNA 2008, Constant Price
#> 10978                                                                                                        GDP on Mining and Quarrying Sector (in IDR Million), Current Price
#> 10979                                                                                                       GDP on Mining and Quarrying Sector (in IDR Million), Constant Price
#> 10980                                                                                                GDP on Mining & Quarrying Sector (in IDR Million), SNA 2008, Current Price
#> 10981                                                                                               GDP on Mining & Quarrying Sector (in IDR Million), SNA 2008, Constant Price
#> 10982                                                                                                               GDP on Manufacturing Sector (in IDR Million), Current Price
#> 10983                                                                                                              GDP on Manufacturing Sector (in IDR Million), Constant Price
#> 10984                                                                                            GDP on Manufacturing Industry Sector (in IDR Million), SNA 2008, Current Price
#> 10985                                                                                           GDP on Manufacturing Industry Sector (in IDR Million), SNA 2008, Constant Price
#> 10986                                                       GDP on Public Administration, Defense & Compulsory Social Security Sector (in IDR Million), SNA 2008, Current Price
#> 10987                                                      GDP on Public Administration, Defense & Compulsory Social Security Sector (in IDR Million), SNA 2008, Constant Price
#> 10988                                                                                                       GDP on Real Estate Sector (in IDR Million), SNA 2008, Current Price
#> 10989                                                                                                      GDP on Real Estate Sector (in IDR Million), SNA 2008, Constant Price
#> 10990                                                                                                               GDP on Other Service Sector (in IDR Million), Current Price
#> 10991                                                                                                              GDP on Other Service Sector (in IDR Million), Constant Price
#> 10992                                                                                                    GDP on Other Services Sector (in IDR Million), SNA 2008, Current Price
#> 10993                                                                                                   GDP on Other Services Sector (in IDR Million), SNA 2008, Constant Price
#> 10994                                                                                        GDP on Transportation and Telecommunication Sector (in IDR Million), Current Price
#> 10995                                                                                       GDP on Transportation and Telecommunication Sector (in IDR Million), Constant Price
#> 10996                                                                                          GDP on Transportation & Storage Sector (in IDR Million), SNA 2008, Current Price
#> 10997                                                                                         GDP on Transportation & Storage Sector (in IDR Million), SNA 2008, Constant Price
#> 10998                                                                                                 GDP on Trade, Hotel and Restaurant Sector (in IDR Million), Current Price
#> 10999                                                                                                GDP on Trade, Hotel and Restaurant Sector (in IDR Million), Constant Price
#> 11000                                                 GDP on Wholesales & Retail Trade, Repair of Motor Vehicles & Motorcycles Sector (in IDR Million), SNA 2008, Current Price
#> 11001                                                GDP on Wholesales & Retail Trade, Repair of Motor Vehicles & Motorcycles Sector (in IDR Million), SNA 2008, Constant Price
#> 11002                                                                                                                   GDP on Utilities Sector (in IDR Million), Current Price
#> 11003                                                                                                                  GDP on Utilities Sector (in IDR Million), Constant Price
#> 11004                                                              GDP on Water Supply, Sewerage, Waste & Recycling Management Sector (in IDR Million), SNA 2008, Current Price
#> 11005                                                             GDP on Water Supply, Sewerage, Waste & Recycling Management Sector (in IDR Million), SNA 2008, Constant Price
#> 11014                                                                                                               General government final consumption expenditure (% of GDP)
#> 11025                                                                                                                  Household final consumption expenditure, etc. (% of GDP)
#> 11042                                                                                                            Households and NPISHs final consumption expenditure (% of GDP)
#> 11052                                                                                                                            Final consumption expenditure, etc. (% of GDP)
#> 11060                                                                                                                      Total consumption: contribution to growth of GDP (%)
#> 11061                                                                                                                                  Final consumption expenditure (% of GDP)
#> 11071                                                                                                                                     Gross national expenditure (% of GDP)
#> 11083                                                                                                                                  Exports of goods and services (% of GDP)
#> 11085                                                                                                        GDP expenditure on general government consumption (in IDR Million)
#> 11086                                                                               GDP expenditure on general government consumption (in IDR Million), SNA 2008, Current Price
#> 11087                                                                                            GDP expenditure on non profit private institution consumption (in IDR Million)
#> 11088                                                                   GDP expenditure on non profit private institution consumption (in IDR Million), SNA 2008, Current Price
#> 11089                                                                                                                   GDP expenditure on private consumption (in IDR Million)
#> 11090                                                                                          GDP expenditure on private consumption (in IDR Million), SNA 2008, Current Price
#> 11091                                                                                                                               GDP expenditure on exports (in IDR Million)
#> 11092                                                                                                      GDP expenditure on exports (in IDR Million), SNA 2008, Current Price
#> 11117                                                                                                                  Gross fixed capital formation, private sector (% of GDP)
#> 11122                                                                                                                                        Gross public investment (% of GDP)
#> 11125                                                                                                         GDP expenditure on gross fixed capital formation (in IDR Million)
#> 11132                                                                                GDP expenditure on gross fixed capital formation (in IDR Million), SNA 2008, Current Price
#> 11133                                                                                                                                  Gross fixed capital formation (% of GDP)
#> 11134                                                                                                                               GDP expenditure on imports (in IDR Million)
#> 11135                                                                                                      GDP expenditure on imports (in IDR Million), SNA 2008, Current Price
#> 11136                                                                                     GDP expenditure on inter-region net exports (in IDR Million), SNA 2008, Current Price
#> 11141                                                                                                                      GDP expenditure on changes in stock (in IDR Million)
#> 11145                                                                                             GDP expenditure on changes in stock (in IDR Million), SNA 2008, Current Price
#> 11154                                                                                                                           Total GDP based on expenditure (in IDR Million)
#> 11161                                                                                                  Total GDP based on expenditure (in IDR Million), SNA 2008, Current Price
#> 11162                                                                                                                     Gross domestic investment: contr. to growth of GDP(%)
#> 11163                                                                                                                                        Gross capital formation (% of GDP)
#> 11173                                                                                                                                  Imports of goods and services (% of GDP)
#> 11174                                                                                                                                        Merchandise trade to GDP ratio (%)
#> 11180                                                                                                                       Resource balance: contribution to growth of GDP (%)
#> 11181                                                                                                                         External balance on goods and services (% of GDP)
#> 11184                                                                                                                                                          Trade (% of GDP)
#> 11191                                                                                                                            Agriculture: contribution to growth of GDP (%)
#> 11195                                                                                                                               Industry: contribution to growth of GDP (%)
#> 11201                                                                                                                               Services: contribution to growth of GDP (%)
#> 11209                                                                                                                          Real agricultural GDP per capita growth rate (%)
#> 11219                                                                                                                                    Real agricultural GDP growth rates (%)
#> 11220                                                                                                                Agriculture, forestry, and fishing, value added (% of GDP)
#> 11240                                                                                                                                     Manufacturing, value added (% of GDP)
#> 11254                                                                                                                               Industry: contribution to growth of GDP (%)
#> 11255                                                                                                                 Industry (including construction), value added (% of GDP)
#> 11273                                                                                                                             Discrepancy in GDP, value added (current US$)
#> 11274                                                                                                                             Discrepancy in GDP, value added (current LCU)
#> 11275                                                                                                                            Discrepancy in GDP, value added (constant LCU)
#> 11292                                                                                                                               Services: contribution to growth of GDP (%)
#> 11293                                                                                                                                    Services, etc., value added (% of GDP)
#> 11299                                                                                                                                          Services, value added (% of GDP)
#> 11388                                                                                                                                  Agricultural support estimate (% of GDP)
#> 11392                                                                                                                                                     Coal rents (% of GDP)
#> 11393                                                                                                                                        Inflation, GDP deflator (annual %)
#> 11394                                                                                                                                        Inflation, GDP deflator (annual %)
#> 11395                                                                                                                         Inflation, GDP deflator: linked series (annual %)
#> 11396                                                                                                                                GDP deflator (base year varies by country)
#> 11397                                                                                                                                                 GDP deflator (1987 = 100)
#> 11398                                                                                                                 GDP deflator: linked series (base year varies by country)
#> 11399                                                                                                                  Discrepancy in expenditure estimate of GDP (current US$)
#> 11400                                                                                                                  Discrepancy in expenditure estimate of GDP (current LCU)
#> 11401                                                                                                                 Discrepancy in expenditure estimate of GDP (constant LCU)
#> 11405                                                                                                                                    GDP at factor cost (constant 1987 US$)
#> 11407                                                                                                                                    GDP at factor cost (constant 1987 LCU)
#> 11408                                                                                                                                                   Forest rents (% of GDP)
#> 11409                                                                                                                                                  Mineral rents (% of GDP)
#> 11410                                                                                                                                                         GDP (current US$)
#> 11411                                                                                                                                GDP deflator, index (2000=100; US$ series)
#> 11412                                                                                                                                                         GDP (current LCU)
#> 11413                                                                                                                                          GDP: linked series (current LCU)
#> 11414                                                                                                                         GDP deflator, period average (LCU index 2000=100)
#> 11415                                                                                                                                                              GDP Deflator
#> 11416                                                                                                                                                   GDP (constant 2015 US$)
#> 11417                                                                                                                                  GDP at market prices (constant 1987 US$)
#> 11418                                                                                                                                                     GDP growth (annual %)
#> 11419                                                                                                                                                        GDP (constant LCU)
#> 11420                                                                                                                                  GDP at market prices (constant 1987 LCU)
#> 11421                                                                                                                                                     GDP growth (annual %)
#> 11422                                                                                                                                        GDP, PPP (current international $)
#> 11423                                                                                                                                  GDP, PPP (constant 2017 international $)
#> 11424                                                                                                                                  GDP, PPP (constant 1987 international $)
#> 11425                                                                                                                                             GDP deflator (1987=100,Index)
#> 11426                                                                                                                    GDP deflator, end period (base year varies by country)
#> 11428                                                                                                                                              Natural gas rents (% of GDP)
#> 11429                                                                                                                                              GDP per capita (current US$)
#> 11430                                                                                                                                              GDP per capita (current LCU)
#> 11431                                                                                                                                        GDP per capita (constant 2015 US$)
#> 11432                                                                                                                                          GDP per capita growth (annual %)
#> 11433                                                                                                                                             GDP per capita (constant LCU)
#> 11434                                                                                                                             GDP per capita, PPP (current international $)
#> 11435                                                                                                                       GDP per capita, PPP (constant 2017 international $)
#> 11436                                                                                                                       GDP per capita, PPP (constant 1987 international $)
#> 11437                                                                                                                                     GDP per capita, PPP annual growth (%)
#> 11438                                                                                                                                                      Oil rents (% of GDP)
#> 11439                                                                                                                                  Total natural resources rents (% of GDP)
#> 11452                                                                                                                                         Gross domestic savings (% of GDP)
#> 11457                                                                                                                         Genuine savings: education expenditure (% of GDP)
#> 11458                                                                                                                         Genuine savings: carbon dioxide damage (% of GDP)
#> 11459                                                                                                                          Genuine savings: net forest depletion (% of GDP)
#> 11460                                                                                                                  Genuine savings: consumption of fixed capital (% of GDP)
#> 11461                                                                                                                             Genuine savings: mineral depletion (% of GDP)
#> 11462                                                                                                                              Genuine savings: energy depletion (% of GDP)
#> 11463                                                                                                                          Genuine savings: net domestic savings (% of GDP)
#> 11464                                                                                                                                       Genuine domestic savings (% of GDP)
#> 11497                                                                                                                                                  Gross savings (% of GDP)
#> 11535                                                                                  Annual percentage growth rate of GDP at market prices based on constant 2010 US Dollars.
#> 11536                                                                                                                                      GDP,current US$,millions,seas. adj.,
#> 11537                                                                                                                                      GDP,current LCU,millions,seas. adj.,
#> 11538                                                                                                                                GDP,constant 2010 US$,millions,seas. adj.,
#> 11539                                                                                                                                GDP,constant 2010 LCU,millions,seas. adj.,
#> 11564                                                                                                                      PPP conversion factor, GDP (LCU per international $)
#> 11565                                                                                                                 2005 PPP conversion factor, GDP (LCU per international $)
#> 11566                                                                                                  Price level ratio of PPP conversion factor (GDP) to market exchange rate
#> 15599                                                                                                          (De Facto) Average principal salary as percent of GDP per capita
#> 15663                                                                                      (De Jure) Average starting public-school teacher salary as percent of GDP per capita
#> 15890                                                                                                                                  Public Expenditure on Education  (% GDP)
#> 15895                                                                                                                          Public spending on education, primary (% of GDP)
#> 15896                                                                                                         Government expenditure per student, primary (% of GDP per capita)
#> 15899                                                                                                                        Public spending on education, secondary (% of GDP)
#> 15900                                                                                                       Government expenditure per student, secondary (% of GDP per capita)
#> 15904                                                                                                                         Public spending on education, tertiary (% of GDP)
#> 15905                                                                                                        Government expenditure per student, tertiary (% of GDP per capita)
#> 15908                                                                                                                     Government expenditure on education, total (% of GDP)
#> 15928                                                                                                                                     Rail traffic (km per million US$ GDP)
#> 16886                                                                                                                                     Current health expenditure (% of GDP)
#> 16895                                                                                                                 Domestic general government health expenditure (% of GDP)
#> 16899                                                                                                                                      Public Expenditure on Health (% GDP)
#> 16900                                                                                                                                     Capital health expenditure (% of GDP)
#> 16912                                                                                                                                    Health expenditure, private (% of GDP)
#> 16915                                                                                                                                     Health expenditure, public (% of GDP)
#> 16921                                                                                                                                      Health expenditure, total (% of GDP)
#> 17073                                                                                                                             GDP per person employed (constant 2017 PPP $)
#> 17074                                                                                                                                 GDP per person employed (annual % growth)
#> 17075                                                                                                                               GDP per person employed, index (1980 = 100)
#> 17833                                                                                                                                                     Trade (% of GDP, PPP)
#> 17834                                                                                                                                              Merchandise trade (% of GDP)
#> 17835                                                                                                                                           Trade in goods (% of goods GDP)
#> 20066                                                                                                           Government expenditure on pre-primary education as % of GDP (%)
#> 20067                                                                                                               Government expenditure on primary education as % of GDP (%)
#> 20068                                                                                            Government expenditure on lower secondary education as a percentage of GDP (%)
#> 20069                                                                                                             Government expenditure on secondary education as % of GDP (%)
#> 20070                                                                  Government expenditure on secondary and post-secondary non-tertiary vocational education as % of GDP (%)
#> 20071                                                                                            Government expenditure on upper secondary education as a percentage of GDP (%)
#> 20072                                                                                           Government expenditure on post-secondary non-tertiary education as % of GDP (%)
#> 20073                                                                                                              Government expenditure on tertiary education as % of GDP (%)
#> 20123                                                                                      Initial government funding per pre-primary student as a percentage of GDP per capita
#> 20124                                                                                          Initial government funding per primary student as a percentage of GDP per capita
#> 20125                                                                                           Initial household funding per primary student as a percentage of GDP per capita
#> 20126                                                                                  Initial government funding per lower secondary student as a percentage of GDP per capita
#> 20127                                                                                        Initial government funding per secondary student as a percentage of GDP per capita
#> 20128                                                                                         Initial household funding per secondary student as a percentage of GDP per capita
#> 20129                                                                                  Initial government funding per upper secondary student as a percentage of GDP per capita
#> 20130                                                                                         Initial government funding per tertiary student as a percentage of GDP per capita
#> 20131                                                                                          Initial household funding per tertiary student as a percentage of GDP per capita
```

なんと、500件以上出てきました。Indicator（指標コード）と、Name（指標名）が列挙されます。すべてに、GDP という文字列が入っていることを確認できると思います。

#### 検索例 2（WDI）

Indicator（指標コード）から、Name（指標名）を検索します。


```r
WDIsearch(string = "NY.GDP.MKTP.CD", field = "indicator", short = TRUE, cache = NULL)
#>               indicator
#> 11410    NY.GDP.MKTP.CD
#> 11411 NY.GDP.MKTP.CD.XD
#>                                             name
#> 11410                          GDP (current US$)
#> 11411 GDP deflator, index (2000=100; US$ series)
```

二件出てきました。
  
#### 練習 2. - 検索（short）

名前で検索（"" の間に、（なるべく簡単な）検索文字列を入れてください。）


```r
WDIsearch(string = "", field = "name", short = TRUE, cache = NULL)
```

Indicator で検索（"" の間に、調べたい indicator を入れてください。）


```r
WDIsearch(string = "", field = "indicator", short = TRUE, cache = NULL)
```

  
#### 詳しい情報を得るには

上では、Indicator（指標コード）と、Name（指標名）だけでしたが、Description（説明） なども得ることができます。

それには、`short = FALSE` とします。

一回一回、World Bank にアクセスして調べるのは、時間もかかりますから、Indicator と、名前などの情報をもったファイルを手元に持っておくことにします。それには、次のようにします。


```r
wdi_cache <- WDIcache()
```

これは、series と、country の二つのデータ・フレームからなっているリストです。

右上の窓枠（pane）から、`wdi_cache` を探して、中身を見てみましょう。三角印や、右から二番目の巻物のようなアイコンをクリックすると中身が見えます。

series には、すべての指標がリストされ、その情報が書かれています。

また、country には、それぞれについて、さまざまな情報が書かれています。これは、とても、たいせつな情報です。国名と、iso2c, iso3c のようなコードもありますし、地域（region）や、その国が、どの income level（収入の階級）に入るかも書かれています。また、国だけではなく、地域など、グループの名称も含まれています。

今後、さまざまに利用していきたいと思います。



  
#### 検索例 3（WDI名）

`short = FALSE` として、検索してみましょう。文字列が入っている、指標名を検索します。


```r
WDIsearch(string = "CPI Price", field = "name", short = FALSE, cache = wdi_cache)
#>         indicator
#> 2586    CPTOTNSXN
#> 2587 CPTOTSAXMZGY
#> 2588    CPTOTSAXN
#> 2589 CPTOTSAXNZGY
#>                                                 name
#> 2586                              CPI Price, nominal
#> 2587 CPI Price, % y-o-y, median weighted, seas. adj.
#> 2588                  CPI Price, nominal, seas. adj.
#> 2589         CPI Price, % y-o-y, nominal, seas. adj.
#>                                                                                                                                                                                                                  description
#> 2586                                                                The consumer price index reflects the change in prices for the average consumer of a constant basket of consumer goods. Data is not seasonally adjusted.
#> 2587                                                                Median inflation rate calculated for geographical aggregates (regions, world, etc) of the annual percent change of the CPI. Data is seasonally adjusted.
#> 2588                                               The consumer price index reflects the change in prices for the average consumer of a constant basket of consumer goods. Data is in nominal terms and seasonally adjusted.
#> 2589 The consumer price index reflects the change in prices for the average consumer of a constant basket of consumer goods. Data is in nominal percentage terms, measured on a year-on-year basis, and seasonally adjusted.
#>               sourceDatabase
#> 2586 Global Economic Monitor
#> 2587 Global Economic Monitor
#> 2588 Global Economic Monitor
#> 2589 Global Economic Monitor
#>                                           sourceOrganization
#> 2586 World Bank staff calculations based on Datastream data.
#> 2587 World Bank staff calculations based on Datastream data.
#> 2588 World Bank staff calculations based on Datastream data.
#> 2589 World Bank staff calculations based on Datastream data.
```

- CPTOTNSXN: CPI Price, nominal
  - The consumer price index reflects the change in prices for the average consumer of a constant basket of consumer goods. Data is not seasonally adjusted.

#### 検索例 4（WDI）

指標コードから、詳細情報を得ます。


```r
WDIsearch(string = "NY.GDP.MKTP.KD.ZG", field = "indicator", short = FALSE, cache = wdi_cache)
#>               indicator                  name
#> 12114 NY.GDP.MKTP.KD.ZG GDP growth (annual %)
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                           description
#> 12114 Annual percentage growth rate of GDP at market prices based on constant local currency. Aggregates are based on constant 2015 prices, expressed in U.S. dollars. GDP is the sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not included in the value of the products. It is calculated without making deductions for depreciation of fabricated assets or for depletion and degradation of natural resources.
#>                     sourceDatabase
#> 12114 World Development Indicators
#>                                                              sourceOrganization
#> 12114 World Bank national accounts data, and OECD National Accounts data files.
```

  
#### 練習 2 - 検索（long w/ cache）

`string` と、`field` を、ふたつとも入れてください。


```r
WDIsearch(string = "", field = "", short = FALSE, cache = wdi_cache)
```


  
### 指標 WDI データのダウンロード

Indicator が決まったら、ダウンロードします。右下の窓枠の Help タブの検索枠に、`WDI` と入れて確認しましょう。 

```
WDI(
  country = "all",
  indicator = "NY.GDP.PCAP.KD",
  start = 1960,
  end = NULL,
  extra = FALSE,
  cache = NULL,
  latest = NULL,
  language = "en"
)
```

上が基本的な用法ですが、`start` 以下は、Default（初期値）が書かれていますから、たいせつなのは、最初の二つ、country と、indicator です。
  
#### ダウンロード例 1-1

country は、初期値も、"all" となっていますから、最も簡単なのは、indicator に、指標コードを入れることです。引用符を忘れずに。


```r
df_gdp1 <- WDI(country = "all", indicator = "NY.GDP.MKTP.CD")
df_gdp1
```


```
#> Rows: 16492 Columns: 5
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr (3): country, iso2c, iso3c
#> dbl (2): year, NY.GDP.MKTP.CD
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 16,492 × 5
#>    country                     iso2c iso3c  year NY.GDP.MK…¹
#>    <chr>                       <chr> <chr> <dbl>       <dbl>
#>  1 Africa Eastern and Southern ZH    AFE    2021     1.08e12
#>  2 Africa Eastern and Southern ZH    AFE    2020     9.27e11
#>  3 Africa Eastern and Southern ZH    AFE    2019     1.00e12
#>  4 Africa Eastern and Southern ZH    AFE    2018     1.01e12
#>  5 Africa Eastern and Southern ZH    AFE    2017     1.02e12
#>  6 Africa Eastern and Southern ZH    AFE    2016     8.83e11
#>  7 Africa Eastern and Southern ZH    AFE    2015     9.25e11
#>  8 Africa Eastern and Southern ZH    AFE    2014     1.00e12
#>  9 Africa Eastern and Southern ZH    AFE    2013     9.83e11
#> 10 Africa Eastern and Southern ZH    AFE    2012     9.73e11
#> # … with 16,482 more rows, and abbreviated variable name
#> #   ¹​NY.GDP.MKTP.CD
```

これでも良いのですが、利用するには、指標コードではわかりにくいので、それを簡単な名前に置き換えて、データを読み込むこができます。

#### ダウンロード例 1-2


```r
df_gdp2 <- WDI(country = "all", indicator = c(gdp = "NY.GDP.MKTP.CD"))
df_gdp2
```


```
#> Rows: 16492 Columns: 5
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr (3): country, iso2c, iso3c
#> dbl (2): year, gdp
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 16,492 × 5
#>    country                     iso2c iso3c  year     gdp
#>    <chr>                       <chr> <chr> <dbl>   <dbl>
#>  1 Africa Eastern and Southern ZH    AFE    2021 1.08e12
#>  2 Africa Eastern and Southern ZH    AFE    2020 9.27e11
#>  3 Africa Eastern and Southern ZH    AFE    2019 1.00e12
#>  4 Africa Eastern and Southern ZH    AFE    2018 1.01e12
#>  5 Africa Eastern and Southern ZH    AFE    2017 1.02e12
#>  6 Africa Eastern and Southern ZH    AFE    2016 8.83e11
#>  7 Africa Eastern and Southern ZH    AFE    2015 9.25e11
#>  8 Africa Eastern and Southern ZH    AFE    2014 1.00e12
#>  9 Africa Eastern and Southern ZH    AFE    2013 9.83e11
#> 10 Africa Eastern and Southern ZH    AFE    2012 9.73e11
#> # … with 16,482 more rows
```
  
#### ダウンロード例 1-3\

今度は、`extra = TRUE` として、読み込みましょう。先ほど、読み込んである、`wdi_cache` を使います。


```r
df_gdp3 <- WDI(country = "all", indicator = c(gdp = "NY.GDP.MKTP.CD"), 
               extra=TRUE, cache=wdi_cache)
df_gdp3
```


```
#> Rows: 16492 Columns: 13
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (4): year, gdp, longitude, latitude
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 16,492 × 13
#>    country     iso2c iso3c  year       gdp status lastupda…¹
#>    <chr>       <chr> <chr> <dbl>     <dbl> <lgl>  <date>    
#>  1 Afghanistan AF    AFG    2021   1.48e10 NA     2022-12-22
#>  2 Afghanistan AF    AFG    2020   2.01e10 NA     2022-12-22
#>  3 Afghanistan AF    AFG    2019   1.89e10 NA     2022-12-22
#>  4 Afghanistan AF    AFG    2018   1.84e10 NA     2022-12-22
#>  5 Afghanistan AF    AFG    2017   1.89e10 NA     2022-12-22
#>  6 Afghanistan AF    AFG    2016   1.80e10 NA     2022-12-22
#>  7 Afghanistan AF    AFG    2015   2.00e10 NA     2022-12-22
#>  8 Afghanistan AF    AFG    2014   2.06e10 NA     2022-12-22
#>  9 Afghanistan AF    AFG    2013   2.06e10 NA     2022-12-22
#> 10 Afghanistan AF    AFG    2012   2.02e10 NA     2022-12-22
#> # … with 16,482 more rows, 6 more variables: region <chr>,
#> #   capital <chr>, longitude <dbl>, latitude <dbl>,
#> #   income <chr>, lending <chr>, and abbreviated variable
#> #   name ¹​lastupdated
```
右上の三角印を使って、どのような詳細情報が付加されたか見て見ましょう。どんなことがわかりますか。

#### ダウンロード例 1-4

国名を指定します。`WDI` では、iso2c コードを使って、国名を指定します。上で見たように、Envoronment から、`wdi_cache` を選択すると、国名と、iso2c コード両方を見ることができました。iso2c や、iso3c は、よく使われるので、web 検索でも簡単にみつけることができます。最初に紹介した例ですから、どの国かはわかりますね、


```r
df_gdp4 <- WDI(country = c("CN","GB","JP","IN","US","DE"), 
               indicator = c(gdp = "NY.GDP.MKTP.CD"), extra=TRUE, cache=wdi_cache)
df_gdp4
```


```
#> Rows: 372 Columns: 13
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (4): year, gdp, longitude, latitude
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 372 × 13
#>    country iso2c iso3c  year     gdp status lastupdated
#>    <chr>   <chr> <chr> <dbl>   <dbl> <lgl>  <date>     
#>  1 China   CN    CHN    2021 1.77e13 NA     2022-12-22 
#>  2 China   CN    CHN    2020 1.47e13 NA     2022-12-22 
#>  3 China   CN    CHN    2019 1.43e13 NA     2022-12-22 
#>  4 China   CN    CHN    2018 1.39e13 NA     2022-12-22 
#>  5 China   CN    CHN    2017 1.23e13 NA     2022-12-22 
#>  6 China   CN    CHN    2016 1.12e13 NA     2022-12-22 
#>  7 China   CN    CHN    2015 1.11e13 NA     2022-12-22 
#>  8 China   CN    CHN    2014 1.05e13 NA     2022-12-22 
#>  9 China   CN    CHN    2013 9.57e12 NA     2022-12-22 
#> 10 China   CN    CHN    2012 8.53e12 NA     2022-12-22 
#> # … with 362 more rows, and 6 more variables: region <chr>,
#> #   capital <chr>, longitude <dbl>, latitude <dbl>,
#> #   income <chr>, lending <chr>
```

#### ダウンロード例 2-1

二つの、指標コードを使って、同時に読み込むこともできます。そのときは、`c()` (combine) を使います。

* NY.GDP.DEFL.KD.ZG: Inflation, GDP deflator (annual %)
* CPTOTNSXN: CPI Price, nominal


```r
df_gdp21 <- WDI(country = "all", 
                indicator = c(gdp_deflator = "NY.GDP.DEFL.KD.ZG", 
                              cpi_price = "CPTOTNSXN"), 
                extra=TRUE, cache=wdi_cache)
df_gdp21
```


```
#> Rows: 23972 Columns: 14
#> ── Column specification ────────────────────────────────────
#> Delimiter: ","
#> chr  (7): country, iso2c, iso3c, region, capital, income...
#> dbl  (5): year, gdp_deflator, cpi_price, longitude, lati...
#> lgl  (1): status
#> date (1): lastupdated
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 23,972 × 14
#>    country       iso2c iso3c  year status lastupda…¹ gdp_d…²
#>    <chr>         <chr> <chr> <dbl> <lgl>  <date>       <dbl>
#>  1 Advanced Eco… AME   <NA>   1987 NA     2020-07-27      NA
#>  2 Advanced Eco… AME   <NA>   1988 NA     2020-07-27      NA
#>  3 Advanced Eco… AME   <NA>   1989 NA     2020-07-27      NA
#>  4 Advanced Eco… AME   <NA>   1990 NA     2020-07-27      NA
#>  5 Advanced Eco… AME   <NA>   1991 NA     2020-07-27      NA
#>  6 Advanced Eco… AME   <NA>   1992 NA     2020-07-27      NA
#>  7 Advanced Eco… AME   <NA>   1993 NA     2020-07-27      NA
#>  8 Advanced Eco… AME   <NA>   1994 NA     2020-07-27      NA
#>  9 Advanced Eco… AME   <NA>   1995 NA     2020-07-27      NA
#> 10 Advanced Eco… AME   <NA>   1996 NA     2020-07-27      NA
#> # … with 23,962 more rows, 7 more variables:
#> #   cpi_price <dbl>, region <chr>, capital <chr>,
#> #   longitude <dbl>, latitude <dbl>, income <chr>,
#> #   lending <chr>, and abbreviated variable names
#> #   ¹​lastupdated, ²​gdp_deflator
```

NA (not available) つまり、データがないものが多いことがわかります。もう少し、データをよく見て見ましょう。



```r
str(df_gdp21)
#> spc_tbl_ [23,972 × 14] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
#>  $ country     : chr [1:23972] "Advanced Economies" "Advanced Economies" "Advanced Economies" "Advanced Economies" ...
#>  $ iso2c       : chr [1:23972] "AME" "AME" "AME" "AME" ...
#>  $ iso3c       : chr [1:23972] NA NA NA NA ...
#>  $ year        : num [1:23972] 1987 1988 1989 1990 1991 ...
#>  $ status      : logi [1:23972] NA NA NA NA NA NA ...
#>  $ lastupdated : Date[1:23972], format: "2020-07-27" ...
#>  $ gdp_deflator: num [1:23972] NA NA NA NA NA NA NA NA NA NA ...
#>  $ cpi_price   : num [1:23972] 58.7 60.5 63 66 69.1 ...
#>  $ region      : chr [1:23972] NA NA NA NA ...
#>  $ capital     : chr [1:23972] NA NA NA NA ...
#>  $ longitude   : num [1:23972] NA NA NA NA NA NA NA NA NA NA ...
#>  $ latitude    : num [1:23972] NA NA NA NA NA NA NA NA NA NA ...
#>  $ income      : chr [1:23972] NA NA NA NA ...
#>  $ lending     : chr [1:23972] NA NA NA NA ...
#>  - attr(*, "spec")=
#>   .. cols(
#>   ..   country = col_character(),
#>   ..   iso2c = col_character(),
#>   ..   iso3c = col_character(),
#>   ..   year = col_double(),
#>   ..   status = col_logical(),
#>   ..   lastupdated = col_date(format = ""),
#>   ..   gdp_deflator = col_double(),
#>   ..   cpi_price = col_double(),
#>   ..   region = col_character(),
#>   ..   capital = col_character(),
#>   ..   longitude = col_double(),
#>   ..   latitude = col_double(),
#>   ..   income = col_character(),
#>   ..   lending = col_character()
#>   .. )
#>  - attr(*, "problems")=<externalptr>
```


```r
summary(df_gdp21)
#>    country             iso2c              iso3c          
#>  Length:23972       Length:23972       Length:23972      
#>  Class :character   Class :character   Class :character  
#>  Mode  :character   Mode  :character   Mode  :character  
#>                                                          
#>                                                          
#>                                                          
#>                                                          
#>       year       status         lastupdated        
#>  Min.   :1960   Mode:logical   Min.   :2020-07-27  
#>  1st Qu.:1982   NA's:23972     1st Qu.:2020-07-27  
#>  Median :1996                  Median :2022-12-22  
#>  Mean   :1995                  Mean   :2022-03-23  
#>  3rd Qu.:2009                  3rd Qu.:2022-12-22  
#>  Max.   :2021                  Max.   :2022-12-22  
#>                                                    
#>   gdp_deflator         cpi_price         region         
#>  Min.   :  -98.704   Min.   :  0.00   Length:23972      
#>  1st Qu.:    2.317   1st Qu.: 55.95   Class :character  
#>  Median :    5.273   Median : 83.28   Mode  :character  
#>  Mean   :   25.308   Mean   : 84.18                     
#>  3rd Qu.:   10.411   3rd Qu.:108.75                     
#>  Max.   :26765.858   Max.   :551.25                     
#>  NA's   :11616       NA's   :18410                      
#>    capital            longitude          latitude      
#>  Length:23972       Min.   :-175.22   Min.   :-41.286  
#>  Class :character   1st Qu.: -15.18   1st Qu.:  4.174  
#>  Mode  :character   Median :  19.26   Median : 17.300  
#>                     Mean   :  19.14   Mean   : 18.889  
#>                     3rd Qu.:  50.53   3rd Qu.: 40.050  
#>                     Max.   : 179.09   Max.   : 64.184  
#>                     NA's   :10890     NA's   :10890    
#>     income            lending         
#>  Length:23972       Length:23972      
#>  Class :character   Class :character  
#>  Mode  :character   Mode  :character  
#>                                       
#>                                       
#>                                       
#> 
```

どんなことが分かりましたか。

右上の窓枠の、Environment でも `df_gdp21` を見てみましょう。

## 可視化 Visualization

グラフ（Chart）を描いて視覚化します。ここでは、年ごとの変化をみる、折れ線グラフだけを描いて見ます。

### グラフ 1

`x = year`, `y = gdp` の、`x=`, `y=` は省略してあります。`col=country` は、国ごとに、グループにして、色分けをします。`col` は、`color` としても `colour` としても、問題ありません。
`

```r
df_gdp4 %>% ggplot(aes(year, gdp, col=country)) + geom_line()
#> Warning: Removed 10 rows containing missing values
#> (`geom_line()`).
```

<img src="31-worldbank_files/figure-html/unnamed-chunk-39-1.png" width="672" />

Warning として、missing values があると出ています。どこかは、分かりませんが、図を書くときですから、`y` に対応する、`gdp` の値がないものと思われます。

### グラフ 2

`drop_na(gdp)` で、`gdp` の値が、NA であるものを削除します。また、`labs` で、図にタイトルをつけます。


```r
df_gdp4 %>% drop_na(gdp) %>% 
  ggplot(aes(year, gdp, col=country)) + geom_line() +
  labs(title = "WDI - NY.GDP.MKTP.CD: gdp")
```

<img src="31-worldbank_files/figure-html/unnamed-chunk-40-1.png" width="672" />

### テンプレート Templates

下に、テンプレートをつけます。コピーして、指標コードや、略称、国などを、それぞれ置き換えて、試して見てください。少し、複雑な変形をしていますが、少しずつ説明します。

#### 一つの国についての、一つの指標（WDI）と、その略称から、折線グラフを作成

Line Plot with one indicator with abbreviation and one country


```r
chosen_indicator <- "SL.UEM.TOTL.NE.ZS"
short_name <- "unemployment"
chosen_country <- "United States"
WDI(country = "all", indicator = c(short_name = chosen_indicator), extra=TRUE, cache=wdi_cache) %>%
  filter(country == chosen_country) %>% 
  ggplot(aes(year, short_name)) + geom_line() +
  labs(title = paste("WDI ", chosen_indicator, ": ", short_name, " - ", chosen_country),
       y = short_name)
```

#### 一つの国についての、一つの指標（WDI）から、折線グラフを作成

Line Plot with one indicator and one country


```r
chosen_indicator <- "SL.UEM.TOTL.NE.ZS"
chosen_country <- "United States"
WDI(country = "all", indicator = c(chosen_indicator = chosen_indicator), 
    extra=TRUE, cache=wdi_cache) %>%
  filter(country == chosen_country) %>% 
  ggplot(aes(year, chosen_indicator)) + geom_line() +
  labs(title = paste("WDI ", chosen_indicator, " - ", chosen_country), 
       y = chosen_indicator)
```

#### いくつかの国についての、一つの指標（WDI）と、その略称から、折線グラフを作成

Line Plot with one indicator with abbreviation and several countries


```r
chosen_indicator <- "SL.UEM.TOTL.NE.ZS"
short_name <- "unemployment"
chosen_countries <- c("United States","United Kingdom", "Japan")
WDI(country = "all", indicator = c(short_name = chosen_indicator), extra=TRUE, cache=wdi_cache) %>% drop_na(short_name) %>% 
  filter(country %in% chosen_countries) %>% 
  ggplot(aes(year, short_name, col = country)) + geom_line() +
  labs(title = paste("WDI ", chosen_indicator, ": ", short_name), y = short_name)
```


#### 一つの国についての、二つの指標（WDI）と、その略称から、折線グラフを作成

Line Plot with two indicators with abbreviation and one country


```r
chosen_indicator_1 <- "NY.GDP.DEFL.KD.ZG"
short_name_1 <- "gdp_deflator"
chosen_indicator_2 <- "CPTOTSAXNZGY"
short_name_2 <- "cpi_price"
chosen_country <- "United States"
WDI(country = "all", indicator = c(short_name_1 = chosen_indicator_1, short_name_2 = chosen_indicator_2), extra=TRUE, cache=wdi_cache) %>% 
  filter(country == chosen_country) %>% 
  pivot_longer(c(short_name_1, short_name_2), names_to = "class", values_to = "value") %>% drop_na(value) %>%
  ggplot(aes(year, value, col = class)) + geom_line() +
  labs(title = paste("WDI ", chosen_indicator_1, ": ", short_name_1, "\n", chosen_indicator_2, ": ", short_name_2, " - ", chosen_country)) +
  scale_color_manual(labels = c(short_name_1, short_name_2), values = scales::hue_pal()(2))
```


```r
chosen_indicator_1 <- "SL.TLF.CACT.MA.NE.ZS"
short_name_1 <- "male"
chosen_indicator_2 <- "SL.TLF.CACT.FE.NE.ZS"
short_name_2 <- "female"
chosen_country <- "United States"
WDI(country = "all", indicator = c(short_name_1 = chosen_indicator_1, short_name_2 = chosen_indicator_2), extra=TRUE, cache=wdi_cache) %>% 
  filter(country == chosen_country) %>% 
  pivot_longer(c(short_name_1, short_name_2), names_to = "class", values_to = "value") %>% drop_na(value) %>%
  ggplot(aes(year, value, col = class)) + geom_line() +
  labs(title = paste("WDI ", chosen_indicator_1, ": ", short_name_1, "\n", chosen_indicator_2, ": ", short_name_2, " - ", chosen_country)) +
  scale_color_manual(labels = c(short_name_1, short_name_2), values = scales::hue_pal()(2))
```

#### いくつかの国についての、二つの指標（WDI）と、その略称から、折線グラフを作成

Line Plot with two indicators with abbreviation and several countries


```r
chosen_indicator_1 <- "NY.GDP.DEFL.KD.ZG"
short_name_1 <- "gdp_deflator"
chosen_indicator_2 <- "CPTOTSAXNZGY"
short_name_2 <- "cpi_price"
chosen_countries <- c("United States", "France", "Japan")
WDI(country = "all", indicator = c(short_name_1 = chosen_indicator_1, short_name_2 = chosen_indicator_2), extra=TRUE, cache=wdi_cache) %>% 
  filter(country %in% chosen_countries) %>% 
  pivot_longer(c(short_name_1, short_name_2), names_to = "class", values_to = "value") %>% drop_na(value) %>%
  ggplot(aes(year, value, linetype = class, col = country)) + geom_line() +
  labs(title = paste("WDI ", chosen_indicator_1, ": ", short_name_1, "\n", chosen_indicator_2, ": ", short_name_2)) +
  scale_linetype_manual(labels = c(short_name_1, short_name_2), values = c("solid", "dashed"))
```



```r
chosen_indicator_1 <- "SL.TLF.CACT.MA.NE.ZS"
short_name_1 <- "male"
chosen_indicator_2 <- "SL.TLF.CACT.FE.NE.ZS"
short_name_2 <- "female"
chosen_countries <- c("United States", "France", "Japan")
WDI(country = "all", indicator = c(short_name_1 = chosen_indicator_1, short_name_2 = chosen_indicator_2), extra=TRUE, cache=wdi_cache) %>% 
  filter(country %in% chosen_countries) %>% 
  pivot_longer(c(short_name_1, short_name_2), names_to = "class", values_to = "value") %>% drop_na(value) %>%
  ggplot(aes(year, value, linetype = class, col = country)) + geom_line() +
  labs(title = paste("WDI ", chosen_indicator_1, ": ", short_name_1, "\n", chosen_indicator_2, ": ", short_name_2)) +
  scale_linetype_manual(labels = c(short_name_1, short_name_2), values = c("solid", "dashed"))
```

## 課題　Assignment

上のテンプレートをコピーして、下に貼り付け、指標 `indicator` と、略称 `short_name` と、いくつかの国名 `chosen_countries` を、入れ替えて、試してみてください。

