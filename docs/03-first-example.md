# 最初のデータ {#first-example}

データを分析するときには、大体次のような手順をとります。

1. 準備 Setup
2. データを取得 Import data
3. データ構造の確認 View data
4. 必要なら整形 Transform data
5. 視覚化 Visualize data
6. データを理解 Understand data

いろいろな視覚化を行い、そのデータからさまざまなことを理解する部分が中心だと思います。

## R のパッケージを活用

まず、この電子書籍の中心をなす、R を使った分析の一つの例を、見て行きたいと思います。一つ一つのコード（コンピュータ・プログラム）の説明は、後に回すとして、どのようなものなのか、雰囲気を味わっていただきたいと思います。

### 準備 Setup

まず、世界銀行（World Bank）の、世界開発指標（WDI: World Development Indicators）の一つの、GDP について、みてみましょう。GDP にも何種類かの尺度があるのですが、次のものを見てみます。

* NY.GDP.MKTP.CD: GDP (current US$)

NY.GDP.MKTP.CD は、データコードと言われるもので、世界開発指標（WDI）には、一つづつ決まっています。

これらの、WDI データコードの探し方なども、この書で少しずつ説明していきます。興味のある方は、[World Development Indicators](https://datatopics.worldbank.org/world-development-indicators/) のサイトの下にある、Data Themes（テーマ）からテーマを選択し、下にスクロールすると、Code をみることができます。ちなみに、ここで利用する NY.GDP.MKTP.CD: GDP (current US$) は、テーマの Economy（経済）を選択し、下にスクロールすると、一番上にあるものです。

英語は苦手という方は、ブラウザー（Edge, Google Chrome, Safari など）の翻訳機能を使うのも良いでしょう。ただ、そのページの対話型の機能（interactive function）を利用するときは、翻訳機能をOFF にする必要がある場合もありますので、覚えておいてください。

R には、WDI のデータを取得する R のツール（パッケージ）`WDI` がありますから、それを使います。また、データを取り扱うために基本的なツール（パッケージ）`tidyverse` を使います。これらの使い方などは、あとから、説明します。


```r
library(tidyverse)
#> ── Attaching core tidyverse packages ──── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.2     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.0
#> ✔ ggplot2   3.4.2     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.1     
#> ── Conflicts ────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(WDI)
```

### データ取得 Import data

いよいよ、データを取得します。それを、`df_gdp` と名前をつけます。


```r
df_gdp <- WDI(country = "all", 
              indicator = c(gdp = "NY.GDP.MKTP.CD"), 
              extra = TRUE)
```



### データ構造の確認


```r
head(df_gdp)
#> # A tibble: 6 × 13
#>   country     iso2c iso3c  year       gdp status lastupdated
#>   <chr>       <chr> <chr> <dbl>     <dbl> <lgl>  <date>     
#> 1 Afghanistan AF    AFG    2015   2.00e10 NA     2022-12-22 
#> 2 Afghanistan AF    AFG    2011   1.82e10 NA     2022-12-22 
#> 3 Afghanistan AF    AFG    2014   2.06e10 NA     2022-12-22 
#> 4 Afghanistan AF    AFG    2013   2.06e10 NA     2022-12-22 
#> 5 Afghanistan AF    AFG    2012   2.02e10 NA     2022-12-22 
#> 6 Afghanistan AF    AFG    2007   9.72e 9 NA     2022-12-22 
#> # ℹ 6 more variables: region <chr>, capital <chr>,
#> #   longitude <dbl>, latitude <dbl>, income <chr>,
#> #   lending <chr>
```


```r
df_gdp %>% glimpse()
#> Rows: 16,492
#> Columns: 13
#> $ country     <chr> "Afghanistan", "Afghanistan", "Afghani…
#> $ iso2c       <chr> "AF", "AF", "AF", "AF", "AF", "AF", "A…
#> $ iso3c       <chr> "AFG", "AFG", "AFG", "AFG", "AFG", "AF…
#> $ year        <dbl> 2015, 2011, 2014, 2013, 2012, 2007, 20…
#> $ gdp         <dbl> 19998156214, 18190410821, 20550582747,…
#> $ status      <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
#> $ lastupdated <date> 2022-12-22, 2022-12-22, 2022-12-22, 2…
#> $ region      <chr> "South Asia", "South Asia", "South Asi…
#> $ capital     <chr> "Kabul", "Kabul", "Kabul", "Kabul", "K…
#> $ longitude   <dbl> 69.1761, 69.1761, 69.1761, 69.1761, 69…
#> $ latitude    <dbl> 34.5228, 34.5228, 34.5228, 34.5228, 34…
#> $ income      <chr> "Low income", "Low income", "Low incom…
#> $ lending     <chr> "IDA", "IDA", "IDA", "IDA", "IDA", "ID…
```

概要 (`summary(df_gdp)`) からもある程度わかります。


```r
df_gdp %>% summary()
#>    country             iso2c              iso3c          
#>  Length:16492       Length:16492       Length:16492      
#>  Class :character   Class :character   Class :character  
#>  Mode  :character   Mode  :character   Mode  :character  
#>                                                          
#>                                                          
#>                                                          
#>                                                          
#>       year           gdp             status       
#>  Min.   :1960   Min.   :8.824e+06   Mode:logical  
#>  1st Qu.:1975   1st Qu.:2.441e+09   NA's:16492    
#>  Median :1990   Median :1.784e+10                 
#>  Mean   :1990   Mean   :1.162e+12                 
#>  3rd Qu.:2006   3rd Qu.:2.158e+11                 
#>  Max.   :2021   Max.   :9.651e+13                 
#>                 NA's   :3343                      
#>   lastupdated            region            capital         
#>  Min.   :2022-12-22   Length:16492       Length:16492      
#>  1st Qu.:2022-12-22   Class :character   Class :character  
#>  Median :2022-12-22   Mode  :character   Mode  :character  
#>  Mean   :2022-12-22                                        
#>  3rd Qu.:2022-12-22                                        
#>  Max.   :2022-12-22                                        
#>                                                            
#>    longitude          latitude          income         
#>  Min.   :-175.22   Min.   :-41.286   Length:16492      
#>  1st Qu.: -15.18   1st Qu.:  4.174   Class :character  
#>  Median :  19.54   Median : 17.277   Mode  :character  
#>  Mean   :  19.16   Mean   : 18.740                     
#>  3rd Qu.:  50.53   3rd Qu.: 39.715                     
#>  Max.   : 179.09   Max.   : 64.184                     
#>  NA's   :3472      NA's   :3472                        
#>    lending         
#>  Length:16492      
#>  Class :character  
#>  Mode  :character  
#>                    
#>                    
#>                    
#> 
```

国のリストをみてみましょう。


```r
df_gdp %>% distinct(country) %>% pull()
#>   [1] "Afghanistan"                                         
#>   [2] "Africa Eastern and Southern"                         
#>   [3] "Africa Western and Central"                          
#>   [4] "Albania"                                             
#>   [5] "Algeria"                                             
#>   [6] "American Samoa"                                      
#>   [7] "Andorra"                                             
#>   [8] "Angola"                                              
#>   [9] "Antigua and Barbuda"                                 
#>  [10] "Arab World"                                          
#>  [11] "Argentina"                                           
#>  [12] "Armenia"                                             
#>  [13] "Aruba"                                               
#>  [14] "Australia"                                           
#>  [15] "Austria"                                             
#>  [16] "Azerbaijan"                                          
#>  [17] "Bahamas, The"                                        
#>  [18] "Bahrain"                                             
#>  [19] "Bangladesh"                                          
#>  [20] "Barbados"                                            
#>  [21] "Belarus"                                             
#>  [22] "Belgium"                                             
#>  [23] "Belize"                                              
#>  [24] "Benin"                                               
#>  [25] "Bermuda"                                             
#>  [26] "Bhutan"                                              
#>  [27] "Bolivia"                                             
#>  [28] "Bosnia and Herzegovina"                              
#>  [29] "Botswana"                                            
#>  [30] "Brazil"                                              
#>  [31] "British Virgin Islands"                              
#>  [32] "Brunei Darussalam"                                   
#>  [33] "Bulgaria"                                            
#>  [34] "Burkina Faso"                                        
#>  [35] "Burundi"                                             
#>  [36] "Cabo Verde"                                          
#>  [37] "Cambodia"                                            
#>  [38] "Cameroon"                                            
#>  [39] "Canada"                                              
#>  [40] "Caribbean small states"                              
#>  [41] "Cayman Islands"                                      
#>  [42] "Central African Republic"                            
#>  [43] "Central Europe and the Baltics"                      
#>  [44] "Chad"                                                
#>  [45] "Channel Islands"                                     
#>  [46] "Chile"                                               
#>  [47] "China"                                               
#>  [48] "Colombia"                                            
#>  [49] "Comoros"                                             
#>  [50] "Congo, Dem. Rep."                                    
#>  [51] "Congo, Rep."                                         
#>  [52] "Costa Rica"                                          
#>  [53] "Cote d'Ivoire"                                       
#>  [54] "Croatia"                                             
#>  [55] "Cuba"                                                
#>  [56] "Curacao"                                             
#>  [57] "Cyprus"                                              
#>  [58] "Czechia"                                             
#>  [59] "Denmark"                                             
#>  [60] "Djibouti"                                            
#>  [61] "Dominica"                                            
#>  [62] "Dominican Republic"                                  
#>  [63] "Early-demographic dividend"                          
#>  [64] "East Asia & Pacific"                                 
#>  [65] "East Asia & Pacific (excluding high income)"         
#>  [66] "East Asia & Pacific (IDA & IBRD countries)"          
#>  [67] "Ecuador"                                             
#>  [68] "Egypt, Arab Rep."                                    
#>  [69] "El Salvador"                                         
#>  [70] "Equatorial Guinea"                                   
#>  [71] "Eritrea"                                             
#>  [72] "Estonia"                                             
#>  [73] "Eswatini"                                            
#>  [74] "Ethiopia"                                            
#>  [75] "Euro area"                                           
#>  [76] "Europe & Central Asia"                               
#>  [77] "Europe & Central Asia (excluding high income)"       
#>  [78] "Europe & Central Asia (IDA & IBRD countries)"        
#>  [79] "European Union"                                      
#>  [80] "Faroe Islands"                                       
#>  [81] "Fiji"                                                
#>  [82] "Finland"                                             
#>  [83] "Fragile and conflict affected situations"            
#>  [84] "France"                                              
#>  [85] "French Polynesia"                                    
#>  [86] "Gabon"                                               
#>  [87] "Gambia, The"                                         
#>  [88] "Georgia"                                             
#>  [89] "Germany"                                             
#>  [90] "Ghana"                                               
#>  [91] "Gibraltar"                                           
#>  [92] "Greece"                                              
#>  [93] "Greenland"                                           
#>  [94] "Grenada"                                             
#>  [95] "Guam"                                                
#>  [96] "Guatemala"                                           
#>  [97] "Guinea"                                              
#>  [98] "Guinea-Bissau"                                       
#>  [99] "Guyana"                                              
#> [100] "Haiti"                                               
#> [101] "Heavily indebted poor countries (HIPC)"              
#> [102] "High income"                                         
#> [103] "Honduras"                                            
#> [104] "Hong Kong SAR, China"                                
#> [105] "Hungary"                                             
#> [106] "IBRD only"                                           
#> [107] "Iceland"                                             
#> [108] "IDA & IBRD total"                                    
#> [109] "IDA blend"                                           
#> [110] "IDA only"                                            
#> [111] "IDA total"                                           
#> [112] "India"                                               
#> [113] "Indonesia"                                           
#> [114] "Iran, Islamic Rep."                                  
#> [115] "Iraq"                                                
#> [116] "Ireland"                                             
#> [117] "Isle of Man"                                         
#> [118] "Israel"                                              
#> [119] "Italy"                                               
#> [120] "Jamaica"                                             
#> [121] "Japan"                                               
#> [122] "Jordan"                                              
#> [123] "Kazakhstan"                                          
#> [124] "Kenya"                                               
#> [125] "Kiribati"                                            
#> [126] "Korea, Dem. People's Rep."                           
#> [127] "Korea, Rep."                                         
#> [128] "Kosovo"                                              
#> [129] "Kuwait"                                              
#> [130] "Kyrgyz Republic"                                     
#> [131] "Lao PDR"                                             
#> [132] "Late-demographic dividend"                           
#> [133] "Latin America & Caribbean"                           
#> [134] "Latin America & Caribbean (excluding high income)"   
#> [135] "Latin America & the Caribbean (IDA & IBRD countries)"
#> [136] "Latvia"                                              
#> [137] "Least developed countries: UN classification"        
#> [138] "Lebanon"                                             
#> [139] "Lesotho"                                             
#> [140] "Liberia"                                             
#> [141] "Libya"                                               
#> [142] "Liechtenstein"                                       
#> [143] "Lithuania"                                           
#> [144] "Low & middle income"                                 
#> [145] "Low income"                                          
#> [146] "Lower middle income"                                 
#> [147] "Luxembourg"                                          
#> [148] "Macao SAR, China"                                    
#> [149] "Madagascar"                                          
#> [150] "Malawi"                                              
#> [151] "Malaysia"                                            
#> [152] "Maldives"                                            
#> [153] "Mali"                                                
#> [154] "Malta"                                               
#> [155] "Marshall Islands"                                    
#> [156] "Mauritania"                                          
#> [157] "Mauritius"                                           
#> [158] "Mexico"                                              
#> [159] "Micronesia, Fed. Sts."                               
#> [160] "Middle East & North Africa"                          
#> [161] "Middle East & North Africa (excluding high income)"  
#> [162] "Middle East & North Africa (IDA & IBRD countries)"   
#> [163] "Middle income"                                       
#> [164] "Moldova"                                             
#> [165] "Monaco"                                              
#> [166] "Mongolia"                                            
#> [167] "Montenegro"                                          
#> [168] "Morocco"                                             
#> [169] "Mozambique"                                          
#> [170] "Myanmar"                                             
#> [171] "Namibia"                                             
#> [172] "Nauru"                                               
#> [173] "Nepal"                                               
#> [174] "Netherlands"                                         
#> [175] "New Caledonia"                                       
#> [176] "New Zealand"                                         
#> [177] "Nicaragua"                                           
#> [178] "Niger"                                               
#> [179] "Nigeria"                                             
#> [180] "North America"                                       
#> [181] "North Macedonia"                                     
#> [182] "Northern Mariana Islands"                            
#> [183] "Norway"                                              
#> [184] "Not classified"                                      
#> [185] "OECD members"                                        
#> [186] "Oman"                                                
#> [187] "Other small states"                                  
#> [188] "Pacific island small states"                         
#> [189] "Pakistan"                                            
#> [190] "Palau"                                               
#> [191] "Panama"                                              
#> [192] "Papua New Guinea"                                    
#> [193] "Paraguay"                                            
#> [194] "Peru"                                                
#> [195] "Philippines"                                         
#> [196] "Poland"                                              
#> [197] "Portugal"                                            
#> [198] "Post-demographic dividend"                           
#> [199] "Pre-demographic dividend"                            
#> [200] "Puerto Rico"                                         
#> [201] "Qatar"                                               
#> [202] "Romania"                                             
#> [203] "Russian Federation"                                  
#> [204] "Rwanda"                                              
#> [205] "Samoa"                                               
#> [206] "San Marino"                                          
#> [207] "Sao Tome and Principe"                               
#> [208] "Saudi Arabia"                                        
#> [209] "Senegal"                                             
#> [210] "Serbia"                                              
#> [211] "Seychelles"                                          
#> [212] "Sierra Leone"                                        
#> [213] "Singapore"                                           
#> [214] "Sint Maarten (Dutch part)"                           
#> [215] "Slovak Republic"                                     
#> [216] "Slovenia"                                            
#> [217] "Small states"                                        
#> [218] "Solomon Islands"                                     
#> [219] "Somalia"                                             
#> [220] "South Africa"                                        
#> [221] "South Asia"                                          
#> [222] "South Asia (IDA & IBRD)"                             
#> [223] "South Sudan"                                         
#> [224] "Spain"                                               
#> [225] "Sri Lanka"                                           
#> [226] "St. Kitts and Nevis"                                 
#> [227] "St. Lucia"                                           
#> [228] "St. Martin (French part)"                            
#> [229] "St. Vincent and the Grenadines"                      
#> [230] "Sub-Saharan Africa"                                  
#> [231] "Sub-Saharan Africa (excluding high income)"          
#> [232] "Sub-Saharan Africa (IDA & IBRD countries)"           
#> [233] "Sudan"                                               
#> [234] "Suriname"                                            
#> [235] "Sweden"                                              
#> [236] "Switzerland"                                         
#> [237] "Syrian Arab Republic"                                
#> [238] "Tajikistan"                                          
#> [239] "Tanzania"                                            
#> [240] "Thailand"                                            
#> [241] "Timor-Leste"                                         
#> [242] "Togo"                                                
#> [243] "Tonga"                                               
#> [244] "Trinidad and Tobago"                                 
#> [245] "Tunisia"                                             
#> [246] "Turkiye"                                             
#> [247] "Turkmenistan"                                        
#> [248] "Turks and Caicos Islands"                            
#> [249] "Tuvalu"                                              
#> [250] "Uganda"                                              
#> [251] "Ukraine"                                             
#> [252] "United Arab Emirates"                                
#> [253] "United Kingdom"                                      
#> [254] "United States"                                       
#> [255] "Upper middle income"                                 
#> [256] "Uruguay"                                             
#> [257] "Uzbekistan"                                          
#> [258] "Vanuatu"                                             
#> [259] "Venezuela, RB"                                       
#> [260] "Vietnam"                                             
#> [261] "Virgin Islands (U.S.)"                               
#> [262] "West Bank and Gaza"                                  
#> [263] "World"                                               
#> [264] "Yemen, Rep."                                         
#> [265] "Zambia"                                              
#> [266] "Zimbabwe"
```

### 必要なら整形 Transform data

変数が多いので、日本の部分だけみてみます。


```r
df_gdp %>% filter(country == "Japan")
#> # A tibble: 62 × 13
#>    country iso2c iso3c  year     gdp status lastupdated
#>    <chr>   <chr> <chr> <dbl>   <dbl> <lgl>  <date>     
#>  1 Japan   JP    JPN    2021 4.94e12 NA     2022-12-22 
#>  2 Japan   JP    JPN    2020 5.04e12 NA     2022-12-22 
#>  3 Japan   JP    JPN    2019 5.12e12 NA     2022-12-22 
#>  4 Japan   JP    JPN    2018 5.04e12 NA     2022-12-22 
#>  5 Japan   JP    JPN    2017 4.93e12 NA     2022-12-22 
#>  6 Japan   JP    JPN    2016 5.00e12 NA     2022-12-22 
#>  7 Japan   JP    JPN    2015 4.44e12 NA     2022-12-22 
#>  8 Japan   JP    JPN    2014 4.90e12 NA     2022-12-22 
#>  9 Japan   JP    JPN    2013 5.21e12 NA     2022-12-22 
#> 10 Japan   JP    JPN    2012 6.27e12 NA     2022-12-22 
#> # ℹ 52 more rows
#> # ℹ 6 more variables: region <chr>, capital <chr>,
#> #   longitude <dbl>, latitude <dbl>, income <chr>,
#> #   lending <chr>
```

たとえば、gdp のところに、4.940878e+12	とあるのは、Scientific notation と言われるもので、
$$4.940878 \times 10^{12} = 4,940,887,800,000$$
を意味します。最初に current US$ と、書いてあるように、現在の USD に換算した数値です。


### 視覚化 data visualization

日本のGDP の経年変化を折線グラフ（line graph）でみてみましょう。


```r
df_gdp %>% filter(country == "Japan") %>%
  ggplot(aes(x = year, y = gdp)) + geom_line()
```

<img src="03-first-example_files/figure-html/unnamed-chunk-9-1.png" width="672" />

### データを理解 Understand data

視覚化によって見えてくることがいくつもありますね。どんなことがわかりますか。気づいたことをあげてみましょう。

### さらなる分析


```r
df_gdp %>% drop_na(gdp) %>% ggplot(aes(x = year)) + geom_bar()
```

<img src="03-first-example_files/figure-html/unnamed-chunk-10-1.png" width="672" />

最新の2021年のデータはすべてあるわけではなさそうですが、大きい順に並べてみましょう。


```r
df_gdp %>% filter(year == 2021) %>% drop_na(gdp) %>% arrange(desc(gdp))
#> # A tibble: 245 × 13
#>    country      iso2c iso3c  year     gdp status lastupdated
#>    <chr>        <chr> <chr> <dbl>   <dbl> <lgl>  <date>     
#>  1 World        1W    WLD    2021 9.65e13 NA     2022-12-22 
#>  2 High income  XD    <NA>   2021 5.98e13 NA     2022-12-22 
#>  3 OECD members OE    OED    2021 5.83e13 NA     2022-12-22 
#>  4 Post-demogr… V4    PST    2021 5.50e13 NA     2022-12-22 
#>  5 IDA & IBRD … ZT    IBT    2021 3.80e13 NA     2022-12-22 
#>  6 Low & middl… XO    LMY    2021 3.64e13 NA     2022-12-22 
#>  7 Middle inco… XP    MIC    2021 3.58e13 NA     2022-12-22 
#>  8 IBRD only    XF    IBD    2021 3.55e13 NA     2022-12-22 
#>  9 East Asia &… Z4    EAS    2021 3.09e13 NA     2022-12-22 
#> 10 Upper middl… XT    <NA>   2021 2.71e13 NA     2022-12-22 
#> # ℹ 235 more rows
#> # ℹ 6 more variables: region <chr>, capital <chr>,
#> #   longitude <dbl>, latitude <dbl>, income <chr>,
#> #   lending <chr>
```

国以外のグループでも数値があるようですから、国だけを選んでみます。それには、region のところの Aggregates 以外を選択します。


```r
df_gdp %>% filter(year == 2021, region != "Aggregates") %>% 
  drop_na(gdp) %>% arrange(desc(gdp))
#> # A tibble: 196 × 13
#>    country      iso2c iso3c  year     gdp status lastupdated
#>    <chr>        <chr> <chr> <dbl>   <dbl> <lgl>  <date>     
#>  1 United Stat… US    USA    2021 2.33e13 NA     2022-12-22 
#>  2 China        CN    CHN    2021 1.77e13 NA     2022-12-22 
#>  3 Japan        JP    JPN    2021 4.94e12 NA     2022-12-22 
#>  4 Germany      DE    DEU    2021 4.26e12 NA     2022-12-22 
#>  5 India        IN    IND    2021 3.18e12 NA     2022-12-22 
#>  6 United King… GB    GBR    2021 3.13e12 NA     2022-12-22 
#>  7 France       FR    FRA    2021 2.96e12 NA     2022-12-22 
#>  8 Italy        IT    ITA    2021 2.11e12 NA     2022-12-22 
#>  9 Canada       CA    CAN    2021 1.99e12 NA     2022-12-22 
#> 10 Korea, Rep.  KR    KOR    2021 1.81e12 NA     2022-12-22 
#> # ℹ 186 more rows
#> # ℹ 6 more variables: region <chr>, capital <chr>,
#> #   longitude <dbl>, latitude <dbl>, income <chr>,
#> #   lending <chr>
```

グラフではありませんが、これも一つの視覚化とも考えられないことはありません。

上位7カ国のGDP の推移を書いてみましょう。


```r
df_gdp %>% filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR")) %>%
  ggplot(aes(x = year, y = gdp, col = iso2c)) + geom_line()
#> Warning: Removed 10 rows containing missing values
#> (`geom_line()`).
```

<img src="03-first-example_files/figure-html/unnamed-chunk-13-1.png" width="672" />

ここからも幾つかのことがわかるかと思います。気づいたことを書いてみましょう。



```r
df_gdp %>% 
  filter(region != "Aggregates") %>% 
  drop_na(gdp) %>% 
  group_by(year) %>% 
  mutate(gdp_ratio = gdp/sum(gdp)) %>%
  ungroup() %>%
  filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR"))  %>%
  ggplot(aes(x = year, y = gdp_ratio, fill = iso2c)) + geom_area() + geom_line(col = "black", position = "stack", linewidth = 0.3) + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))
```

<img src="03-first-example_files/figure-html/unnamed-chunk-14-1.png" width="672" />

これは、上から、iso2c の アルファベットの順番になっていますが、少し変更すると下のようになります。


```r
df_gdp %>% 
  filter(region != "Aggregates") %>% 
  drop_na(gdp) %>% 
  group_by(year) %>% 
  mutate(gdp_ratio = gdp/sum(gdp)) %>%
  ungroup() %>%
  filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR"))  %>%
  mutate(iso2co = factor(iso2c, levels = c("IN", "CN", "FR", "GB", "DE", "JP", "US"))) %>%
  ggplot(aes(x = year, y = gdp_ratio, fill = iso2co)) + geom_area() + geom_line(col = "black", position = "stack", linewidth = 0.3) + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))
```

<img src="03-first-example_files/figure-html/unnamed-chunk-15-1.png" width="672" />

これらは、世界全体の GPT における割合です。主要国で、60%〜70% を占めていることがわかりますが、それぞれの国や、幾つかの国の影響力でしょうかも、ある程度みることができるように見えます。

いろいろなことが見えてくるように思います。

GDP が大きな国と、小さな国があるのはわかりますが、それは、どのように分布しているのでしょうか。


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year == 2021) %>%
  ggplot(aes(gdp)) + geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
```

<img src="03-first-example_files/figure-html/unnamed-chunk-16-1.png" width="672" />

小さいところに集中していることがわかりますが、対数軸をとってみます。


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year == 2021) %>%
  ggplot(aes(gdp)) + geom_histogram() + scale_x_log10()
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
```

<img src="03-first-example_files/figure-html/unnamed-chunk-17-1.png" width="672" />

これは、2021年のデータですが、変化を見ることもできるでしょうか。


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year %in% c(1961, 1971, 1981, 1991, 2001, 2011, 2021)) %>%
  ggplot(aes(gdp, fill = factor(year))) + geom_density(alpha = 0.4) + scale_x_log10()
```

<img src="03-first-example_files/figure-html/unnamed-chunk-18-1.png" width="672" />


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year %in% c(1971, 1981, 1991, 2001, 2011, 2021)) %>%
  ggplot(aes(gdp, fill = factor(year))) + 
  geom_density() + scale_x_log10() + facet_wrap(~year)
```

<img src="03-first-example_files/figure-html/unnamed-chunk-19-1.png" width="672" />

いくつかのグループごとに分布をみてみることも可能です。それには、Boxplot が有効です。


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(region != "Aggregates") %>%
  drop_na(region) %>%
  filter(year %in% c(2021)) %>%
  ggplot(aes(gdp, region, fill = region)) + 
  geom_boxplot() + scale_x_log10() + labs(y = "") + 
  theme(legend.position = "none")
```

<img src="03-first-example_files/figure-html/unnamed-chunk-20-1.png" width="672" />


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(region != "Aggregates") %>%
  drop_na(income) %>%
  filter(year %in% c(2021)) %>%
  mutate(level = factor(income, c("High income", "Upper middle income", "Lower middle income", "Low income"))) %>%
  ggplot(aes(gdp, level, fill = income)) + 
  geom_boxplot() + scale_x_log10() + labs(y = "") + 
  theme(legend.position = "none")
```

<img src="03-first-example_files/figure-html/unnamed-chunk-21-1.png" width="672" />

これからも、いろいろなことがわかりますね。

地図で、国の income level をみてみましょう。


```r
library(maps)
map_world <- map_data('world')
map_gdp <- map_world %>% 
  mutate(iso2c = iso.alpha(region, n=2)) %>% 
  mutate(map_region = region) %>% select(-region) %>% 
  left_join(df_gdp, by = "iso2c") 
#> Warning in left_join(., df_gdp, by = "iso2c"): Detected an unexpected many-to-many relationship between
#> `x` and `y`.
#> ℹ Row 1 of `x` matches multiple rows in `y`.
#> ℹ Row 745 of `y` matches multiple rows in `x`.
#> ℹ If a many-to-many relationship is expected, set
#>   `relationship = "many-to-many"` to silence this warning.
head(map_gdp)
#>        long    lat group order subregion iso2c map_region
#> 1 -69.89912 12.452     1     1      <NA>    AW      Aruba
#> 2 -69.89912 12.452     1     1      <NA>    AW      Aruba
#> 3 -69.89912 12.452     1     1      <NA>    AW      Aruba
#> 4 -69.89912 12.452     1     1      <NA>    AW      Aruba
#> 5 -69.89912 12.452     1     1      <NA>    AW      Aruba
#> 6 -69.89912 12.452     1     1      <NA>    AW      Aruba
#>   country iso3c year        gdp status lastupdated
#> 1   Aruba   ABW 1964         NA     NA  2022-12-22
#> 2   Aruba   ABW 1963         NA     NA  2022-12-22
#> 3   Aruba   ABW 1961         NA     NA  2022-12-22
#> 4   Aruba   ABW 1960         NA     NA  2022-12-22
#> 5   Aruba   ABW 2000 1873184358     NA  2022-12-22
#> 6   Aruba   ABW 1962         NA     NA  2022-12-22
#>                      region    capital longitude latitude
#> 1 Latin America & Caribbean Oranjestad  -70.0167  12.5167
#> 2 Latin America & Caribbean Oranjestad  -70.0167  12.5167
#> 3 Latin America & Caribbean Oranjestad  -70.0167  12.5167
#> 4 Latin America & Caribbean Oranjestad  -70.0167  12.5167
#> 5 Latin America & Caribbean Oranjestad  -70.0167  12.5167
#> 6 Latin America & Caribbean Oranjestad  -70.0167  12.5167
#>        income        lending
#> 1 High income Not classified
#> 2 High income Not classified
#> 3 High income Not classified
#> 4 High income Not classified
#> 5 High income Not classified
#> 6 High income Not classified
```


```r
map_gdp %>% mutate(income_level = factor(income, levels = c("High income", "Upper middle income", "Lower middle income", "Low income", "Not classified", NA))) %>%
  ggplot() +
  geom_map(aes(long, lat, map_id = map_region, fill = income_level), map = map_world, col = "black", size = 0.1) 
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2
#> 3.4.0.
#> ℹ Please use `linewidth` instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where
#> this warning was generated.
#> Warning in geom_map(aes(long, lat, map_id = map_region,
#> fill = income_level), : Ignoring unknown aesthetics: x and
#> y
```

<img src="03-first-example_files/figure-html/unnamed-chunk-23-1.png" width="672" />


```r
map_gdp %>% mutate(income_level = factor(income, levels = c("High income", "Upper middle income", "Lower middle income", "Low income", "Not classified", NA))) %>%
  filter(year == 2021) %>%
  ggplot() +
  geom_map(aes(long, lat, map_id = map_region, fill = gdp), map = map_world, col = "black", size = 0.1) 
#> Warning in geom_map(aes(long, lat, map_id = map_region,
#> fill = gdp), map = map_world, : Ignoring unknown
#> aesthetics: x and y
```

<img src="03-first-example_files/figure-html/unnamed-chunk-24-1.png" width="672" />
## 練習

それぞれのグラフから、わかったこと、問いなどを書いてください。

# コードの簡単な説明

## コードの取得、折れ線グラフ

いずれ、一つ一つのステップついて学びますが、まずは、データの取得と、７カ国の GDP の経年変化のグラフのコードの説明を、ChatGPT にしてもらいましょう。

> 質問：R のコードで、tidyverse と WDI を使って、GDP の分析をしますが、次のコードを、R の初心者にも理解できるように、ステップごとに説明してください。

```
df_gdp <- WDI(country = "all",
indicator = c(gdp = "NY.GDP.MKTP.CD"),
extra = TRUE)

df_gdp %>% filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR")) %>%
ggplot(aes(x = year, y = gdp, col = iso2c)) + geom_line()
```

**ChatGPT**

このコードは、世界銀行の経済指標データベースであるワールド・データ・アトラス（WDI）から、GDP（国内総生産）に関するデータを取得し、Tidyverseパッケージを使用して分析するものです。以下に、コードの各ステップを説明します。

以下のように、WDIパッケージをインストールしてロードします。このパッケージには、世界銀行のWDIデータベースにアクセスするために必要な機能が含まれています。

```
install.packages("WDI")
library(WDI)
```

WDI関数を使用して、国別のGDPデータを取得します。この関数の引数には、国、指標（ここではGDP）、および `extra = TRUE`を設定して、年度別のGDPデータも取得します。

```
df_gdp <- WDI(country = "all", 
              indicator = c(gdp = "NY.GDP.MKTP.CD"), 
              extra = TRUE)
```

取得したデータのうち、アメリカ、中国、日本、ドイツ、インド、イギリス、フランスの7か国のみを抽出します。iso2cは、2文字のISOコードで国を表しています。

```
df_gdp %>% filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR"))
```

ggplot関数を使用して、GDPの年次データをプロットします。x軸には年、y軸にはGDP、色には国を設定し、geom_line関数を使用して折れ線グラフを描画します。

```
df_gdp %>% filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR")) %>%
  ggplot(aes(x = year, y = gdp, col = iso2c)) + geom_line()
```

これにより、アメリカ、中国、日本、ドイツ、インド、イギリス、フランスのGDPの年次推移を比較する折れ線グラフが作成されます。




