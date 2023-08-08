# はじめてのデータサイエンス {#first-example}

## データサイエンスの実際

データから情報を得るときには、大体次のような手順をとります。

1.  準備 Setup
2.  データを取得 Import data
3.  データ構造の確認 View data
4.  必要に応じて整形 Transform data
5.  視覚化 Visualize data
6.  データを理解 Understand data
7.  レポートなどにまとめる Communicate data

![](https://d33wubrfki0l68.cloudfront.net/795c039ba2520455d833b4034befc8cf360a70ba/558a5/diagrams/data-science-explore.png)

[はじめに](https://icu-hsuzuki.github.io/ds4aj/introduction.html#introduction)に書きましたが、基本的には、問いをもちデータを取得し、視覚化などを通して、データを理解し、さらに問いを深めるサイクルが、データサイエンスの核だと思います。

> R を使った分析の一つの例を、見て行きます。一つ一つのコード（コンピュータ・プログラム）の簡単な説明は、加えますが、あまりそれに捉われず、データサイエンスとは何かを考えながら、雰囲気を味わってください。

## R のパッケージを活用

### 準備 Setup

世界銀行（World Bank）の、世界開発指標（WDI: World Development Indicators）の一つの、GDP（Gross Domestic Product 国内総生産）のデータから始めます。GDP にも何種類かの尺度がありますが、次のものを見てみます。

-   NY.GDP.MKTP.CD: GDP (current US\$)[^03-first-example-1]

[^03-first-example-1]: GDP（Gross Domestic Product）とは、ある国のある期間（通常は1年）における、その国で生産されたすべての最終財・サービスの市場価値の総額を指します。これは国内総生産とも呼ばれます。GDPは、その国の経済力や活力を測る指標の1つとして広く用いられています。WDIのGDP (Current USD)は、各国のGDPを米ドルで表したものであり、通貨の価値が異なっても比較可能な形で国際比較ができます。ただし、GDPはあくまで市場価格を基準としているため、非市場活動や自然災害などの影響を受ける場合がある点に注意が必要です。
  
NY.GDP.MKTP.CD は、データコードと言われるもので、世界開発指標（WDI）には、一つづつ決まっています。

[World Development Indicators](https://datatopics.worldbank.org/world-development-indicators/) のサイトの下にある、Data Themes（テーマ）からテーマを選択し、下にスクロールすると、Code をみることができます。ちなみに、ここで利用する NY.GDP.MKTP.CD: GDP (current US\$) は、テーマの Economy（経済）の、一番上にあります。

経済用語の英語はよく知らないという方は、ブラウザー（Edge, Google Chrome, Safari など）の翻訳機能を使うのも良いでしょう。ただ、そのページの対話型の機能（interactive function）を利用するときは、翻訳機能をOFF にする必要がある場合もありますので、注意してください。

エラーメッセージを調べるときなどに、英語のほうが情報がたくさん得られますから、言語を、英語に変更しておきます。

R には、WDI のデータを取得する R のツール（パッケージ）`WDI` がありますから、それを使います。また、データを取り扱うための基本的なツール（パッケージ）`tidyverse` を使いますので、次のコードで、これらを読み込みます。


```r
Sys.setenv(LANG = "en")
library(tidyverse)
#> -- Attaching core tidyverse packages ---- tidyverse 2.0.0 --
#> v dplyr     1.1.2     v readr     2.1.4
#> v forcats   1.0.0     v stringr   1.5.0
#> v ggplot2   3.4.2     v tibble    3.2.1
#> v lubridate 1.9.2     v tidyr     1.3.0
#> v purrr     1.0.1     
#> -- Conflicts ---------------------- tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
#> i Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(WDI)
```

データを保存する場所を作成しておくことをお勧めします。保存しておくときは、このディレクトリを使います。


```r
dir.create("./data")
```

### データ取得 Import data

データを取得します。少し時間がかかります。取得したデータに、`df_gdp` などと、わかりやすい名前をつけます。`df` は `data frame` の略で、R で標準的なデータの形式です。


```r
df_gdp <- WDI(country = "all", 
              indicator = c(gdp = "NY.GDP.MKTP.CD"), 
              extra = TRUE)
```

このコードで、全ての国の GDP を取得できます。GDP の値は、`NY.GDP.MKTP.CD` という名前の列にありますが、覚えやすいように、gdp という名前に変更しておきます。`extra = TRUE` とすることによって、それぞれの国についての情報などが追加されます。

### データ構造の確認

最初の数行だけを見るには、`head(df_dgp)` とします。


```r
head(df_gdp)
#>       country iso2c iso3c year        gdp status
#> 1 Afghanistan    AF   AFG 1963  751111191       
#> 2 Afghanistan    AF   AFG 1962  546666678       
#> 3 Afghanistan    AF   AFG 1961  548888896       
#> 4 Afghanistan    AF   AFG 1960  537777811       
#> 5 Afghanistan    AF   AFG 2003 4539496563       
#> 6 Afghanistan    AF   AFG 2002 3854235264       
#>   lastupdated     region capital longitude latitude
#> 1  2023-07-25 South Asia   Kabul   69.1761  34.5228
#> 2  2023-07-25 South Asia   Kabul   69.1761  34.5228
#> 3  2023-07-25 South Asia   Kabul   69.1761  34.5228
#> 4  2023-07-25 South Asia   Kabul   69.1761  34.5228
#> 5  2023-07-25 South Asia   Kabul   69.1761  34.5228
#> 6  2023-07-25 South Asia   Kabul   69.1761  34.5228
#>       income lending
#> 1 Low income     IDA
#> 2 Low income     IDA
#> 3 Low income     IDA
#> 4 Low income     IDA
#> 5 Low income     IDA
#> 6 Low income     IDA
```

データの構造を見るときには、`str(df_gdp)` もよく使われます。今度は、列が縦に並んで表示されます。


```r
str(df_gdp)
#> 'data.frame':	16758 obs. of  13 variables:
#>  $ country    : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
#>  $ iso2c      : chr  "AF" "AF" "AF" "AF" ...
#>  $ iso3c      : chr  "AFG" "AFG" "AFG" "AFG" ...
#>  $ year       : int  1963 1962 1961 1960 2003 2002 2001 2000 1995 1994 ...
#>  $ gdp        : num  7.51e+08 5.47e+08 5.49e+08 5.38e+08 4.54e+09 ...
#>   ..- attr(*, "label")= chr "GDP (current US$)"
#>  $ status     : chr  "" "" "" "" ...
#>  $ lastupdated: chr  "2023-07-25" "2023-07-25" "2023-07-25" "2023-07-25" ...
#>  $ region     : chr  "South Asia" "South Asia" "South Asia" "South Asia" ...
#>  $ capital    : chr  "Kabul" "Kabul" "Kabul" "Kabul" ...
#>  $ longitude  : chr  "69.1761" "69.1761" "69.1761" "69.1761" ...
#>  $ latitude   : chr  "34.5228" "34.5228" "34.5228" "34.5228" ...
#>  $ income     : chr  "Low income" "Low income" "Low income" "Low income" ...
#>  $ lending    : chr  "IDA" "IDA" "IDA" "IDA" ...
```

概要 (`summary(df_gdp)`) からもある程度わかります。


```r
summary(df_gdp) 
#>    country             iso2c              iso3c          
#>  Length:16758       Length:16758       Length:16758      
#>  Class :character   Class :character   Class :character  
#>  Mode  :character   Mode  :character   Mode  :character  
#>                                                          
#>                                                          
#>                                                          
#>                                                          
#>       year           gdp               status         
#>  Min.   :1960   Min.   :8.825e+06   Length:16758      
#>  1st Qu.:1975   1st Qu.:2.523e+09   Class :character  
#>  Median :1991   Median :1.843e+10   Mode  :character  
#>  Mean   :1991   Mean   :1.207e+12                     
#>  3rd Qu.:2007   3rd Qu.:2.244e+11                     
#>  Max.   :2022   Max.   :1.006e+14                     
#>                 NA's   :3393                          
#>  lastupdated           region            capital         
#>  Length:16758       Length:16758       Length:16758      
#>  Class :character   Class :character   Class :character  
#>  Mode  :character   Mode  :character   Mode  :character  
#>                                                          
#>                                                          
#>                                                          
#>                                                          
#>   longitude           latitude            income         
#>  Length:16758       Length:16758       Length:16758      
#>  Class :character   Class :character   Class :character  
#>  Mode  :character   Mode  :character   Mode  :character  
#>                                                          
#>                                                          
#>                                                          
#>                                                          
#>    lending         
#>  Length:16758      
#>  Class :character  
#>  Mode  :character  
#>                    
#>                    
#>                    
#> 
```

国のリストをみてみましょう。とても長いリストの中には、地域名も含まれています。


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

今回は下のように、`%>%`（パイプと呼びます） で繋げてコードを書きました。

```         
df_gdp %>% distinct(country) %>% pull()
```

最初は、データ、その中の、異なる国を選択して、書き出してくださいというものです。

これは、

```         
pull(distinct(df_gdp, country))
```

と同じです。どんどん、かっこの中に入れ子になって複雑になるので、一つ一つのステップを、順に書いたものが、最初のものになります。

```         
df_gdp %>% head()
df_gdp %>% str()
```

なども可能です。かっこの中に最初に入るものが直前のもの、ここでは、データになっています。

### 必要に応じて整形 Transform data

変数が多いので、日本の部分だけ `filter` を使って選択します。country が Japan と一致する場合のみを選択するときは、`==` を使います。数値ではないので、引用符をつけます。半角を使ってください。


```r
df_gdp %>% filter(country == "Japan")
#>    country iso2c iso3c year          gdp status lastupdated
#> 1    Japan    JP   JPN 2022 4.231141e+12         2023-07-25
#> 2    Japan    JP   JPN 2021 5.005537e+12         2023-07-25
#> 3    Japan    JP   JPN 2020 5.048790e+12         2023-07-25
#> 4    Japan    JP   JPN 2019 5.117994e+12         2023-07-25
#> 5    Japan    JP   JPN 2018 5.040881e+12         2023-07-25
#> 6    Japan    JP   JPN 2017 4.930837e+12         2023-07-25
#> 7    Japan    JP   JPN 2016 5.003678e+12         2023-07-25
#> 8    Japan    JP   JPN 2015 4.444931e+12         2023-07-25
#> 9    Japan    JP   JPN 2014 4.896994e+12         2023-07-25
#> 10   Japan    JP   JPN 2013 5.212328e+12         2023-07-25
#> 11   Japan    JP   JPN 2012 6.272363e+12         2023-07-25
#> 12   Japan    JP   JPN 2011 6.233147e+12         2023-07-25
#> 13   Japan    JP   JPN 2010 5.759072e+12         2023-07-25
#> 14   Japan    JP   JPN 2009 5.289494e+12         2023-07-25
#> 15   Japan    JP   JPN 2008 5.106679e+12         2023-07-25
#> 16   Japan    JP   JPN 2007 4.579750e+12         2023-07-25
#> 17   Japan    JP   JPN 2006 4.601663e+12         2023-07-25
#> 18   Japan    JP   JPN 2005 4.831467e+12         2023-07-25
#> 19   Japan    JP   JPN 2004 4.893116e+12         2023-07-25
#> 20   Japan    JP   JPN 2003 4.519563e+12         2023-07-25
#> 21   Japan    JP   JPN 2002 4.182845e+12         2023-07-25
#> 22   Japan    JP   JPN 2001 4.374710e+12         2023-07-25
#> 23   Japan    JP   JPN 2000 4.968359e+12         2023-07-25
#> 24   Japan    JP   JPN 1999 4.635982e+12         2023-07-25
#> 25   Japan    JP   JPN 1998 4.098363e+12         2023-07-25
#> 26   Japan    JP   JPN 1997 4.492450e+12         2023-07-25
#> 27   Japan    JP   JPN 1996 4.923393e+12         2023-07-25
#> 28   Japan    JP   JPN 1995 5.545565e+12         2023-07-25
#> 29   Japan    JP   JPN 1994 4.998797e+12         2023-07-25
#> 30   Japan    JP   JPN 1993 4.454144e+12         2023-07-25
#> 31   Japan    JP   JPN 1992 3.908808e+12         2023-07-25
#> 32   Japan    JP   JPN 1991 3.584421e+12         2023-07-25
#> 33   Japan    JP   JPN 1990 3.132818e+12         2023-07-25
#> 34   Japan    JP   JPN 1989 3.054914e+12         2023-07-25
#> 35   Japan    JP   JPN 1988 3.071684e+12         2023-07-25
#> 36   Japan    JP   JPN 1987 2.532809e+12         2023-07-25
#> 37   Japan    JP   JPN 1986 2.078953e+12         2023-07-25
#> 38   Japan    JP   JPN 1985 1.398893e+12         2023-07-25
#> 39   Japan    JP   JPN 1984 1.318382e+12         2023-07-25
#> 40   Japan    JP   JPN 1983 1.243324e+12         2023-07-25
#> 41   Japan    JP   JPN 1982 1.134518e+12         2023-07-25
#> 42   Japan    JP   JPN 1981 1.218989e+12         2023-07-25
#> 43   Japan    JP   JPN 1980 1.105386e+12         2023-07-25
#> 44   Japan    JP   JPN 1979 1.055012e+12         2023-07-25
#> 45   Japan    JP   JPN 1978 1.013612e+12         2023-07-25
#> 46   Japan    JP   JPN 1977 7.214118e+11         2023-07-25
#> 47   Japan    JP   JPN 1976 5.861619e+11         2023-07-25
#> 48   Japan    JP   JPN 1975 5.215419e+11         2023-07-25
#> 49   Japan    JP   JPN 1974 4.796260e+11         2023-07-25
#> 50   Japan    JP   JPN 1973 4.320827e+11         2023-07-25
#> 51   Japan    JP   JPN 1972 3.180313e+11         2023-07-25
#> 52   Japan    JP   JPN 1971 2.401518e+11         2023-07-25
#> 53   Japan    JP   JPN 1970 2.126092e+11         2023-07-25
#> 54   Japan    JP   JPN 1969 1.722042e+11         2023-07-25
#> 55   Japan    JP   JPN 1968 1.466011e+11         2023-07-25
#> 56   Japan    JP   JPN 1967 1.237819e+11         2023-07-25
#> 57   Japan    JP   JPN 1966 1.056281e+11         2023-07-25
#> 58   Japan    JP   JPN 1965 9.095028e+10         2023-07-25
#> 59   Japan    JP   JPN 1964 8.174901e+10         2023-07-25
#> 60   Japan    JP   JPN 1963 6.949813e+10         2023-07-25
#> 61   Japan    JP   JPN 1962 6.072302e+10         2023-07-25
#> 62   Japan    JP   JPN 1961 5.350862e+10         2023-07-25
#> 63   Japan    JP   JPN 1960 4.430734e+10         2023-07-25
#>                 region capital longitude latitude
#> 1  East Asia & Pacific   Tokyo    139.77    35.67
#> 2  East Asia & Pacific   Tokyo    139.77    35.67
#> 3  East Asia & Pacific   Tokyo    139.77    35.67
#> 4  East Asia & Pacific   Tokyo    139.77    35.67
#> 5  East Asia & Pacific   Tokyo    139.77    35.67
#> 6  East Asia & Pacific   Tokyo    139.77    35.67
#> 7  East Asia & Pacific   Tokyo    139.77    35.67
#> 8  East Asia & Pacific   Tokyo    139.77    35.67
#> 9  East Asia & Pacific   Tokyo    139.77    35.67
#> 10 East Asia & Pacific   Tokyo    139.77    35.67
#> 11 East Asia & Pacific   Tokyo    139.77    35.67
#> 12 East Asia & Pacific   Tokyo    139.77    35.67
#> 13 East Asia & Pacific   Tokyo    139.77    35.67
#> 14 East Asia & Pacific   Tokyo    139.77    35.67
#> 15 East Asia & Pacific   Tokyo    139.77    35.67
#> 16 East Asia & Pacific   Tokyo    139.77    35.67
#> 17 East Asia & Pacific   Tokyo    139.77    35.67
#> 18 East Asia & Pacific   Tokyo    139.77    35.67
#> 19 East Asia & Pacific   Tokyo    139.77    35.67
#> 20 East Asia & Pacific   Tokyo    139.77    35.67
#> 21 East Asia & Pacific   Tokyo    139.77    35.67
#> 22 East Asia & Pacific   Tokyo    139.77    35.67
#> 23 East Asia & Pacific   Tokyo    139.77    35.67
#> 24 East Asia & Pacific   Tokyo    139.77    35.67
#> 25 East Asia & Pacific   Tokyo    139.77    35.67
#> 26 East Asia & Pacific   Tokyo    139.77    35.67
#> 27 East Asia & Pacific   Tokyo    139.77    35.67
#> 28 East Asia & Pacific   Tokyo    139.77    35.67
#> 29 East Asia & Pacific   Tokyo    139.77    35.67
#> 30 East Asia & Pacific   Tokyo    139.77    35.67
#> 31 East Asia & Pacific   Tokyo    139.77    35.67
#> 32 East Asia & Pacific   Tokyo    139.77    35.67
#> 33 East Asia & Pacific   Tokyo    139.77    35.67
#> 34 East Asia & Pacific   Tokyo    139.77    35.67
#> 35 East Asia & Pacific   Tokyo    139.77    35.67
#> 36 East Asia & Pacific   Tokyo    139.77    35.67
#> 37 East Asia & Pacific   Tokyo    139.77    35.67
#> 38 East Asia & Pacific   Tokyo    139.77    35.67
#> 39 East Asia & Pacific   Tokyo    139.77    35.67
#> 40 East Asia & Pacific   Tokyo    139.77    35.67
#> 41 East Asia & Pacific   Tokyo    139.77    35.67
#> 42 East Asia & Pacific   Tokyo    139.77    35.67
#> 43 East Asia & Pacific   Tokyo    139.77    35.67
#> 44 East Asia & Pacific   Tokyo    139.77    35.67
#> 45 East Asia & Pacific   Tokyo    139.77    35.67
#> 46 East Asia & Pacific   Tokyo    139.77    35.67
#> 47 East Asia & Pacific   Tokyo    139.77    35.67
#> 48 East Asia & Pacific   Tokyo    139.77    35.67
#> 49 East Asia & Pacific   Tokyo    139.77    35.67
#> 50 East Asia & Pacific   Tokyo    139.77    35.67
#> 51 East Asia & Pacific   Tokyo    139.77    35.67
#> 52 East Asia & Pacific   Tokyo    139.77    35.67
#> 53 East Asia & Pacific   Tokyo    139.77    35.67
#> 54 East Asia & Pacific   Tokyo    139.77    35.67
#> 55 East Asia & Pacific   Tokyo    139.77    35.67
#> 56 East Asia & Pacific   Tokyo    139.77    35.67
#> 57 East Asia & Pacific   Tokyo    139.77    35.67
#> 58 East Asia & Pacific   Tokyo    139.77    35.67
#> 59 East Asia & Pacific   Tokyo    139.77    35.67
#> 60 East Asia & Pacific   Tokyo    139.77    35.67
#> 61 East Asia & Pacific   Tokyo    139.77    35.67
#> 62 East Asia & Pacific   Tokyo    139.77    35.67
#> 63 East Asia & Pacific   Tokyo    139.77    35.67
#>         income        lending
#> 1  High income Not classified
#> 2  High income Not classified
#> 3  High income Not classified
#> 4  High income Not classified
#> 5  High income Not classified
#> 6  High income Not classified
#> 7  High income Not classified
#> 8  High income Not classified
#> 9  High income Not classified
#> 10 High income Not classified
#> 11 High income Not classified
#> 12 High income Not classified
#> 13 High income Not classified
#> 14 High income Not classified
#> 15 High income Not classified
#> 16 High income Not classified
#> 17 High income Not classified
#> 18 High income Not classified
#> 19 High income Not classified
#> 20 High income Not classified
#> 21 High income Not classified
#> 22 High income Not classified
#> 23 High income Not classified
#> 24 High income Not classified
#> 25 High income Not classified
#> 26 High income Not classified
#> 27 High income Not classified
#> 28 High income Not classified
#> 29 High income Not classified
#> 30 High income Not classified
#> 31 High income Not classified
#> 32 High income Not classified
#> 33 High income Not classified
#> 34 High income Not classified
#> 35 High income Not classified
#> 36 High income Not classified
#> 37 High income Not classified
#> 38 High income Not classified
#> 39 High income Not classified
#> 40 High income Not classified
#> 41 High income Not classified
#> 42 High income Not classified
#> 43 High income Not classified
#> 44 High income Not classified
#> 45 High income Not classified
#> 46 High income Not classified
#> 47 High income Not classified
#> 48 High income Not classified
#> 49 High income Not classified
#> 50 High income Not classified
#> 51 High income Not classified
#> 52 High income Not classified
#> 53 High income Not classified
#> 54 High income Not classified
#> 55 High income Not classified
#> 56 High income Not classified
#> 57 High income Not classified
#> 58 High income Not classified
#> 59 High income Not classified
#> 60 High income Not classified
#> 61 High income Not classified
#> 62 High income Not classified
#> 63 High income Not classified
```


```r
df_gdp %>% filter(country == "Japan") %>% head(2)
#>   country iso2c iso3c year          gdp status lastupdated
#> 1   Japan    JP   JPN 2022 4.231141e+12         2023-07-25
#> 2   Japan    JP   JPN 2021 5.005537e+12         2023-07-25
#>                region capital longitude latitude
#> 1 East Asia & Pacific   Tokyo    139.77    35.67
#> 2 East Asia & Pacific   Tokyo    139.77    35.67
#>        income        lending
#> 1 High income Not classified
#> 2 High income Not classified
```

２行目の、gdp の、4.940878e+12 は、Scientific notation と言われるもので、 $$4.940878 \times 10^{12} = 4,940,887,800,000$$ を意味します。`e+3` は千（thousand）、`e+6` は百万（million）、`e+9` は、10億（billion）、`e+12` は、兆（trillion）ですから、日本の、2021 年の GDP は、約5兆ドルとなります。

### 視覚化 data visualization

#### Fig 1. 日本のGDP の経年変化を折線グラフ（line graph）


```r
df_gdp %>% filter(country == "Japan") %>%
  ggplot(aes(x = year, y = gdp)) + geom_line()
```

![](03-first-example_files/figure-latex/unnamed-chunk-10-1.pdf)<!-- --> 

```         
df_gdp %>% filter(country == "Japan") %>%
  ggplot(aes(x = year, y = gdp)) + geom_line()
```

日本を選択したときに、それに名前をつけておいて、それを使うこともできますが、名前がどんどん増えるので、それに続けて、コードを書いていく方法をとっています。

`ggplot(aes(x = year, y = gdp)) + geom_line()`

の部分が、グラフを描く部分で、「x 軸を、year、y 軸を、gdp として、それを、折線グラフで描いてください」というコードです。

Warning: [38;5;238mRemoved 1 row containing missing values

と表示されています。値がない年があることを言っています。2022年のデータがないことがわかっていますから、最初から削除してこくことも可能です。

### データの理解 Understand data

視覚化によって見えてくることがいくつもありますね。どんなことがわかりますか。気づいたこと（observation）をあげてみましょう。

コードを描くことではなく、この部分が、データサイエンスの核の部分です。気づいたことを列挙してみましょう。

### さまざまな視覚化

#### Fig 2. 各年ごとのデータの数

`summary(df_gdp)` で、データ自体は、1960年から2022年までのようですが、日本も、2022年のデータはありませんでしたから、年によって、どの程度データがあるか、調べてみます。


```r
df_gdp %>% drop_na(gdp) %>% ggplot(aes(x = year)) + geom_bar()
```

![](03-first-example_files/figure-latex/unnamed-chunk-11-1.pdf)<!-- --> 

```         
df_gdp %>% drop_na(gdp) %>% ggplot(aes(x = year)) + geom_bar()
```

バー・グラフを使いますが、`gdp` の値が、欠損値（NA: not available）のデータを削除してから、グラフを描きます。

#### 2021年のGDPの降順での表示（１）

最新の2021年のデータはすべてあるわけではなさそうですが、`gdp` の値が大きい順に並べてみましょう。


```r
df_gdp %>% filter(year == 2021) %>% drop_na(gdp) %>% arrange(desc(gdp))
#>                                                  country
#> 1                                                  World
#> 2                                            High income
#> 3                                           OECD members
#> 4                              Post-demographic dividend
#> 5                                       IDA & IBRD total
#> 6                                    Low & middle income
#> 7                                          Middle income
#> 8                                              IBRD only
#> 9                                    East Asia & Pacific
#> 10                                   Upper middle income
#> 11                             Late-demographic dividend
#> 12                                         North America
#> 13                                 Europe & Central Asia
#> 14                                         United States
#> 15           East Asia & Pacific (excluding high income)
#> 16            East Asia & Pacific (IDA & IBRD countries)
#> 17                                                 China
#> 18                                        European Union
#> 19                                             Euro area
#> 20                            Early-demographic dividend
#> 21                                   Lower middle income
#> 22                             Latin America & Caribbean
#> 23  Latin America & the Caribbean (IDA & IBRD countries)
#> 24                                                 Japan
#> 25     Latin America & Caribbean (excluding high income)
#> 26          Europe & Central Asia (IDA & IBRD countries)
#> 27                                               Germany
#> 28                                            South Asia
#> 29                               South Asia (IDA & IBRD)
#> 30                            Middle East & North Africa
#> 31         Europe & Central Asia (excluding high income)
#> 32                                                 India
#> 33                                        United Kingdom
#> 34                                                France
#> 35                                            Arab World
#> 36                                             IDA total
#> 37                                                 Italy
#> 38                                                Canada
#> 39                                    Sub-Saharan Africa
#> 40             Sub-Saharan Africa (IDA & IBRD countries)
#> 41            Sub-Saharan Africa (excluding high income)
#> 42                        Central Europe and the Baltics
#> 43                                    Russian Federation
#> 44                                           Korea, Rep.
#> 45              Fragile and conflict affected situations
#> 46                                                Brazil
#> 47                                             Australia
#> 48                                              IDA only
#> 49    Middle East & North Africa (excluding high income)
#> 50     Middle East & North Africa (IDA & IBRD countries)
#> 51                              Pre-demographic dividend
#> 52                                                 Spain
#> 53                                                Mexico
#> 54          Least developed countries: UN classification
#> 55                                             Indonesia
#> 56                                             IDA blend
#> 57                           Africa Eastern and Southern
#> 58                                           Netherlands
#> 59                Heavily indebted poor countries (HIPC)
#> 60                                          Saudi Arabia
#> 61                            Africa Western and Central
#> 62                                               Turkiye
#> 63                                           Switzerland
#> 64                                                Poland
#> 65                                                Sweden
#> 66                                               Belgium
#> 67                                          Small states
#> 68                                              Thailand
#> 69                                               Ireland
#> 70                                                Norway
#> 71                                                Israel
#> 72                                             Argentina
#> 73                                               Austria
#> 74                                            Low income
#> 75                                    Other small states
#> 76                                               Nigeria
#> 77                                      Egypt, Arab Rep.
#> 78                                             Singapore
#> 79                                          South Africa
#> 80                                            Bangladesh
#> 81                                  United Arab Emirates
#> 82                                               Denmark
#> 83                                           Philippines
#> 84                                              Malaysia
#> 85                                  Hong Kong SAR, China
#> 86                                               Vietnam
#> 87                                    Iran, Islamic Rep.
#> 88                                              Pakistan
#> 89                                              Colombia
#> 90                                                 Chile
#> 91                                               Finland
#> 92                                               Romania
#> 93                                               Czechia
#> 94                                           New Zealand
#> 95                                              Portugal
#> 96                                                  Peru
#> 97                                                Greece
#> 98                                                  Iraq
#> 99                                               Ukraine
#> 100                                           Kazakhstan
#> 101                                              Hungary
#> 102                                                Qatar
#> 103                                              Algeria
#> 104                                              Morocco
#> 105                                               Kuwait
#> 106                                      Slovak Republic
#> 107                                             Ethiopia
#> 108                                                Kenya
#> 109                                          Puerto Rico
#> 110                                              Ecuador
#> 111                                   Dominican Republic
#> 112                                            Sri Lanka
#> 113                                                 Oman
#> 114                                            Guatemala
#> 115                                           Luxembourg
#> 116                                             Bulgaria
#> 117                                                Ghana
#> 118                               Caribbean small states
#> 119                                        Cote d'Ivoire
#> 120                                             Tanzania
#> 121                                              Belarus
#> 122                                           Uzbekistan
#> 123                                              Croatia
#> 124                                               Panama
#> 125                                            Lithuania
#> 126                                               Angola
#> 127                                              Myanmar
#> 128                                           Costa Rica
#> 129                                               Serbia
#> 130                                             Slovenia
#> 131                                              Uruguay
#> 132                                     Congo, Dem. Rep.
#> 133                                           Azerbaijan
#> 134                                              Tunisia
#> 135                                             Cameroon
#> 136                                               Jordan
#> 137                                               Uganda
#> 138                                              Bolivia
#> 139                                             Paraguay
#> 140                                                Libya
#> 141                                               Latvia
#> 142                                              Bahrain
#> 143                                              Estonia
#> 144                                                Nepal
#> 145                                                Sudan
#> 146                                     Macao SAR, China
#> 147                                          El Salvador
#> 148                                             Honduras
#> 149                                               Cyprus
#> 150                                             Zimbabwe
#> 151                                              Senegal
#> 152                                             Cambodia
#> 153                                     Papua New Guinea
#> 154                                              Iceland
#> 155                                  Trinidad and Tobago
#> 156                               Bosnia and Herzegovina
#> 157                                              Lebanon
#> 158                                               Zambia
#> 159                                                Haiti
#> 160                                                Gabon
#> 161                                         Burkina Faso
#> 162                                                 Mali
#> 163                                              Lao PDR
#> 164                                             Botswana
#> 165                                              Georgia
#> 166                                   West Bank and Gaza
#> 167                                              Albania
#> 168                                                Malta
#> 169                                                Benin
#> 170                                               Guinea
#> 171                                           Mozambique
#> 172                                             Mongolia
#> 173                                                Niger
#> 174                                              Jamaica
#> 175                                          Afghanistan
#> 176                                           Madagascar
#> 177                                            Nicaragua
#> 178                                    Brunei Darussalam
#> 179                                              Armenia
#> 180                                      North Macedonia
#> 181                                              Moldova
#> 182                                          Congo, Rep.
#> 183                                               Malawi
#> 184                                              Namibia
#> 185                                    Equatorial Guinea
#> 186                                                 Chad
#> 187                                      Channel Islands
#> 188                                         Bahamas, The
#> 189                                            Mauritius
#> 190                                               Rwanda
#> 191                                        New Caledonia
#> 192                                           Mauritania
#> 193                          Pacific island small states
#> 194                                               Kosovo
#> 195                                           Tajikistan
#> 196                                      Kyrgyz Republic
#> 197                                               Monaco
#> 198                                                 Togo
#> 199                                               Guyana
#> 200                                              Somalia
#> 201                                        Liechtenstein
#> 202                                              Bermuda
#> 203                                                 Guam
#> 204                                     French Polynesia
#> 205                                       Cayman Islands
#> 206                                           Montenegro
#> 207                                             Maldives
#> 208                                             Barbados
#> 209                                             Eswatini
#> 210                                                 Fiji
#> 211                                         Sierra Leone
#> 212                                        Faroe Islands
#> 213                                          Timor-Leste
#> 214                                              Liberia
#> 215                                             Djibouti
#> 216                                              Andorra
#> 217                                            Greenland
#> 218                                                Aruba
#> 219                                             Suriname
#> 220                                              Burundi
#> 221                                              Curacao
#> 222                                               Bhutan
#> 223                             Central African Republic
#> 224                                               Belize
#> 225                                              Lesotho
#> 226                                           Cabo Verde
#> 227                                          Gambia, The
#> 228                                           San Marino
#> 229                                            St. Lucia
#> 230                                        Guinea-Bissau
#> 231                                      Solomon Islands
#> 232                                  Antigua and Barbuda
#> 233                            Sint Maarten (Dutch part)
#> 234                                              Comoros
#> 235                                           Seychelles
#> 236                                              Grenada
#> 237                             Turks and Caicos Islands
#> 238                                              Vanuatu
#> 239                       St. Vincent and the Grenadines
#> 240                                  St. Kitts and Nevis
#> 241                                                Samoa
#> 242                                       American Samoa
#> 243                                             Dominica
#> 244                                Sao Tome and Principe
#> 245                                                Tonga
#> 246                                Micronesia, Fed. Sts.
#> 247                                     Marshall Islands
#> 248                                             Kiribati
#> 249                                                Palau
#> 250                                                Nauru
#> 251                                               Tuvalu
#>     iso2c iso3c year          gdp status lastupdated
#> 1      1W   WLD 2021 9.688240e+13         2023-07-25
#> 2      XD       2021 6.001671e+13         2023-07-25
#> 3      OE   OED 2021 5.836393e+13         2023-07-25
#> 4      V4   PST 2021 5.509086e+13         2023-07-25
#> 5      ZT   IBT 2021 3.824618e+13         2023-07-25
#> 6      XO   LMY 2021 3.653729e+13         2023-07-25
#> 7      XP   MIC 2021 3.606615e+13         2023-07-25
#> 8      XF   IBD 2021 3.561558e+13         2023-07-25
#> 9      Z4   EAS 2021 3.109557e+13         2023-07-25
#> 10     XT       2021 2.847514e+13         2023-07-25
#> 11     V3   LTE 2021 2.682750e+13         2023-07-25
#> 12     XU   NAC 2021 2.532369e+13         2023-07-25
#> 13     Z7   ECS 2021 2.515388e+13         2023-07-25
#> 14     US   USA 2021 2.331508e+13         2023-07-25
#> 15     4E   EAP 2021 2.083735e+13         2023-07-25
#> 16     T4   TEA 2021 2.081135e+13         2023-07-25
#> 17     CN   CHN 2021 1.782046e+13         2023-07-25
#> 18     EU   EUU 2021 1.718787e+13         2023-07-25
#> 19     XC   EMU 2021 1.457089e+13         2023-07-25
#> 20     V2   EAR 2021 1.267419e+13         2023-07-25
#> 21     XN       2021 7.592013e+12         2023-07-25
#> 22     ZJ   LCN 2021 5.510524e+12         2023-07-25
#> 23     T2   TLA 2021 5.238234e+12         2023-07-25
#> 24     JP   JPN 2021 5.005537e+12         2023-07-25
#> 25     XJ   LAC 2021 4.624162e+12         2023-07-25
#> 26     T7   TEC 2021 4.615368e+12         2023-07-25
#> 27     DE   DEU 2021 4.259935e+12         2023-07-25
#> 28     8S   SAS 2021 4.062784e+12         2023-07-25
#> 29     T5   TSA 2021 4.062784e+12         2023-07-25
#> 30     ZQ   MEA 2021 3.740993e+12         2023-07-25
#> 31     7E   ECA 2021 3.581678e+12         2023-07-25
#> 32     IN   IND 2021 3.150307e+12         2023-07-25
#> 33     GB   GBR 2021 3.122480e+12         2023-07-25
#> 34     FR   FRA 2021 2.957880e+12         2023-07-25
#> 35     1A   ARB 2021 2.928456e+12         2023-07-25
#> 36     XG   IDA 2021 2.630947e+12         2023-07-25
#> 37     IT   ITA 2021 2.114356e+12         2023-07-25
#> 38     CA   CAN 2021 2.001487e+12         2023-07-25
#> 39     ZG   SSF 2021 1.926458e+12         2023-07-25
#> 40     T6   TSS 2021 1.926458e+12         2023-07-25
#> 41     ZF   SSA 2021 1.925171e+12         2023-07-25
#> 42     B8   CEB 2021 1.905555e+12         2023-07-25
#> 43     RU   RUS 2021 1.836892e+12         2023-07-25
#> 44     KR   KOR 2021 1.810956e+12         2023-07-25
#> 45     F1   FCS 2021 1.782738e+12         2023-07-25
#> 46     BR   BRA 2021 1.649623e+12         2023-07-25
#> 47     AU   AUS 2021 1.552703e+12         2023-07-25
#> 48     XI   IDX 2021 1.534884e+12         2023-07-25
#> 49     XQ   MNA 2021 1.507014e+12         2023-07-25
#> 50     T3   TMN 2021 1.488906e+12         2023-07-25
#> 51     V1   PRE 2021 1.429588e+12         2023-07-25
#> 52     ES   ESP 2021 1.427381e+12         2023-07-25
#> 53     MX   MEX 2021 1.272839e+12         2023-07-25
#> 54     XL   LDC 2021 1.266463e+12         2023-07-25
#> 55     ID   IDN 2021 1.186505e+12         2023-07-25
#> 56     XH   IDB 2021 1.096039e+12         2023-07-25
#> 57     ZH   AFE 2021 1.081998e+12         2023-07-25
#> 58     NL   NLD 2021 1.011799e+12         2023-07-25
#> 59     XE   HPC 2021 8.987718e+11         2023-07-25
#> 60     SA   SAU 2021 8.685859e+11         2023-07-25
#> 61     ZI   AFW 2021 8.444597e+11         2023-07-25
#> 62     TR   TUR 2021 8.190345e+11         2023-07-25
#> 63     CH   CHE 2021 8.006402e+11         2023-07-25
#> 64     PL   POL 2021 6.794419e+11         2023-07-25
#> 65     SE   SWE 2021 6.368562e+11         2023-07-25
#> 66     BE   BEL 2021 5.943520e+11         2023-07-25
#> 67     S1   SST 2021 5.408338e+11         2023-07-25
#> 68     TH   THA 2021 5.055681e+11         2023-07-25
#> 69     IE   IRL 2021 5.041826e+11         2023-07-25
#> 70     NO   NOR 2021 4.902934e+11         2023-07-25
#> 71     IL   ISR 2021 4.885265e+11         2023-07-25
#> 72     AR   ARG 2021 4.872271e+11         2023-07-25
#> 73     AT   AUT 2021 4.803684e+11         2023-07-25
#> 74     XM       2021 4.678769e+11         2023-07-25
#> 75     S4   OSS 2021 4.556851e+11         2023-07-25
#> 76     NG   NGA 2021 4.408336e+11         2023-07-25
#> 77     EG   EGY 2021 4.246718e+11         2023-07-25
#> 78     SG   SGP 2021 4.237970e+11         2023-07-25
#> 79     ZA   ZAF 2021 4.190156e+11         2023-07-25
#> 80     BD   BGD 2021 4.162648e+11         2023-07-25
#> 81     AE   ARE 2021 4.150216e+11         2023-07-25
#> 82     DK   DNK 2021 3.983033e+11         2023-07-25
#> 83     PH   PHL 2021 3.940874e+11         2023-07-25
#> 84     MY   MYS 2021 3.729811e+11         2023-07-25
#> 85     HK   HKG 2021 3.689114e+11         2023-07-25
#> 86     VN   VNM 2021 3.661376e+11         2023-07-25
#> 87     IR   IRN 2021 3.590969e+11         2023-07-25
#> 88     PK   PAK 2021 3.482625e+11         2023-07-25
#> 89     CO   COL 2021 3.185118e+11         2023-07-25
#> 90     CL   CHL 2021 3.167136e+11         2023-07-25
#> 91     FI   FIN 2021 2.963876e+11         2023-07-25
#> 92     RO   ROU 2021 2.854047e+11         2023-07-25
#> 93     CZ   CZE 2021 2.817912e+11         2023-07-25
#> 94     NZ   NZL 2021 2.555517e+11         2023-07-25
#> 95     PT   PRT 2021 2.539828e+11         2023-07-25
#> 96     PE   PER 2021 2.237178e+11         2023-07-25
#> 97     GR   GRC 2021 2.148739e+11         2023-07-25
#> 98     IQ   IRQ 2021 2.076916e+11         2023-07-25
#> 99     UA   UKR 2021 1.997659e+11         2023-07-25
#> 100    KZ   KAZ 2021 1.971123e+11         2023-07-25
#> 101    HU   HUN 2021 1.822754e+11         2023-07-25
#> 102    QA   QAT 2021 1.796771e+11         2023-07-25
#> 103    DZ   DZA 2021 1.634722e+11         2023-07-25
#> 104    MA   MAR 2021 1.428666e+11         2023-07-25
#> 105    KW   KWT 2021 1.367974e+11         2023-07-25
#> 106    SK   SVK 2021 1.186566e+11         2023-07-25
#> 107    ET   ETH 2021 1.112619e+11         2023-07-25
#> 108    KE   KEN 2021 1.097037e+11         2023-07-25
#> 109    PR   PRI 2021 1.063689e+11         2023-07-25
#> 110    EC   ECU 2021 1.061659e+11         2023-07-25
#> 111    DO   DOM 2021 9.424343e+10         2023-07-25
#> 112    LK   LKA 2021 8.849654e+10         2023-07-25
#> 113    OM   OMN 2021 8.819198e+10         2023-07-25
#> 114    GT   GTM 2021 8.605308e+10         2023-07-25
#> 115    LU   LUX 2021 8.550624e+10         2023-07-25
#> 116    BG   BGR 2021 8.406140e+10         2023-07-25
#> 117    GH   GHA 2021 7.915641e+10         2023-07-25
#> 118    S3   CSS 2021 7.567280e+10         2023-07-25
#> 119    CI   CIV 2021 7.181108e+10         2023-07-25
#> 120    TZ   TZA 2021 7.065563e+10         2023-07-25
#> 121    BY   BLR 2021 6.967375e+10         2023-07-25
#> 122    UZ   UZB 2021 6.960061e+10         2023-07-25
#> 123    HR   HRV 2021 6.884367e+10         2023-07-25
#> 124    PA   PAN 2021 6.740674e+10         2023-07-25
#> 125    LT   LTU 2021 6.641499e+10         2023-07-25
#> 126    AO   AGO 2021 6.568544e+10         2023-07-25
#> 127    MM   MMR 2021 6.512477e+10         2023-07-25
#> 128    CR   CRI 2021 6.461648e+10         2023-07-25
#> 129    RS   SRB 2021 6.308202e+10         2023-07-25
#> 130    SI   SVN 2021 6.174859e+10         2023-07-25
#> 131    UY   URY 2021 6.141227e+10         2023-07-25
#> 132    CD   COD 2021 5.535097e+10         2023-07-25
#> 133    AZ   AZE 2021 5.482541e+10         2023-07-25
#> 134    TN   TUN 2021 4.668730e+10         2023-07-25
#> 135    CM   CMR 2021 4.533829e+10         2023-07-25
#> 136    JO   JOR 2021 4.511632e+10         2023-07-25
#> 137    UG   UGA 2021 4.051024e+10         2023-07-25
#> 138    BO   BOL 2021 4.040821e+10         2023-07-25
#> 139    PY   PRY 2021 3.995090e+10         2023-07-25
#> 140    LY   LBY 2021 3.979842e+10         2023-07-25
#> 141    LV   LVA 2021 3.972538e+10         2023-07-25
#> 142    BH   BHR 2021 3.930340e+10         2023-07-25
#> 143    EE   EST 2021 3.719117e+10         2023-07-25
#> 144    NP   NPL 2021 3.692484e+10         2023-07-25
#> 145    SD   SDN 2021 3.422951e+10         2023-07-25
#> 146    MO   MAC 2021 3.012380e+10         2023-07-25
#> 147    SV   SLV 2021 2.945124e+10         2023-07-25
#> 148    HN   HND 2021 2.848872e+10         2023-07-25
#> 149    CY   CYP 2021 2.840806e+10         2023-07-25
#> 150    ZW   ZWE 2021 2.837124e+10         2023-07-25
#> 151    SN   SEN 2021 2.756914e+10         2023-07-25
#> 152    KH   KHM 2021 2.696106e+10         2023-07-25
#> 153    PG   PNG 2021 2.631166e+10         2023-07-25
#> 154    IS   ISL 2021 2.555264e+10         2023-07-25
#> 155    TT   TTO 2021 2.446020e+10         2023-07-25
#> 156    BA   BIH 2021 2.364957e+10         2023-07-25
#> 157    LB   LBN 2021 2.313194e+10         2023-07-25
#> 158    ZM   ZMB 2021 2.214765e+10         2023-07-25
#> 159    HT   HTI 2021 2.087741e+10         2023-07-25
#> 160    GA   GAB 2021 2.021795e+10         2023-07-25
#> 161    BF   BFA 2021 1.973762e+10         2023-07-25
#> 162    ML   MLI 2021 1.930946e+10         2023-07-25
#> 163    LA   LAO 2021 1.882715e+10         2023-07-25
#> 164    BW   BWA 2021 1.873707e+10         2023-07-25
#> 165    GE   GEO 2021 1.862937e+10         2023-07-25
#> 166    PS   PSE 2021 1.810900e+10         2023-07-25
#> 167    AL   ALB 2021 1.793057e+10         2023-07-25
#> 168    MT   MLT 2021 1.774338e+10         2023-07-25
#> 169    BJ   BEN 2021 1.769008e+10         2023-07-25
#> 170    GN   GIN 2021 1.609182e+10         2023-07-25
#> 171    MZ   MOZ 2021 1.577676e+10         2023-07-25
#> 172    MN   MNG 2021 1.528644e+10         2023-07-25
#> 173    NE   NER 2021 1.491500e+10         2023-07-25
#> 174    JM   JAM 2021 1.465759e+10         2023-07-25
#> 175    AF   AFG 2021 1.458314e+10         2023-07-25
#> 176    MG   MDG 2021 1.455475e+10         2023-07-25
#> 177    NI   NIC 2021 1.414585e+10         2023-07-25
#> 178    BN   BRN 2021 1.400650e+10         2023-07-25
#> 179    AM   ARM 2021 1.386141e+10         2023-07-25
#> 180    MK   MKD 2021 1.382505e+10         2023-07-25
#> 181    MD   MDA 2021 1.369223e+10         2023-07-25
#> 182    CG   COG 2021 1.336623e+10         2023-07-25
#> 183    MW   MWI 2021 1.260233e+10         2023-07-25
#> 184    NA   NAM 2021 1.244629e+10         2023-07-25
#> 185    GQ   GNQ 2021 1.226939e+10         2023-07-25
#> 186    TD   TCD 2021 1.177998e+10         2023-07-25
#> 187    JG   CHI 2021 1.173566e+10         2023-07-25
#> 188    BS   BHS 2021 1.152760e+10         2023-07-25
#> 189    MU   MUS 2021 1.147643e+10         2023-07-25
#> 190    RW   RWA 2021 1.105528e+10         2023-07-25
#> 191    NC   NCL 2021 1.007135e+10         2023-07-25
#> 192    MR   MRT 2021 9.996240e+09         2023-07-25
#> 193    S2   PSS 2021 9.475965e+09         2023-07-25
#> 194    XK   XKX 2021 9.412034e+09         2023-07-25
#> 195    TJ   TJK 2021 8.937805e+09         2023-07-25
#> 196    KG   KGZ 2021 8.740682e+09         2023-07-25
#> 197    MC   MCO 2021 8.596157e+09         2023-07-25
#> 198    TG   TGO 2021 8.334047e+09         2023-07-25
#> 199    GY   GUY 2021 8.044499e+09         2023-07-25
#> 200    SO   SOM 2021 7.628000e+09         2023-07-25
#> 201    LI   LIE 2021 7.186429e+09         2023-07-25
#> 202    BM   BMU 2021 7.127200e+09         2023-07-25
#> 203    GU   GUM 2021 6.123000e+09         2023-07-25
#> 204    PF   PYF 2021 6.080359e+09         2023-07-25
#> 205    KY   CYM 2021 6.028374e+09         2023-07-25
#> 206    ME   MNE 2021 5.861431e+09         2023-07-25
#> 207    MV   MDV 2021 5.405557e+09         2023-07-25
#> 208    BB   BRB 2021 4.843800e+09         2023-07-25
#> 209    SZ   SWZ 2021 4.748702e+09         2023-07-25
#> 210    FJ   FJI 2021 4.296235e+09         2023-07-25
#> 211    SL   SLE 2021 4.249235e+09         2023-07-25
#> 212    FO   FRO 2021 3.649879e+09         2023-07-25
#> 213    TL   TLS 2021 3.621222e+09         2023-07-25
#> 214    LR   LBR 2021 3.509000e+09         2023-07-25
#> 215    DJ   DJI 2021 3.372287e+09         2023-07-25
#> 216    AD   AND 2021 3.325145e+09         2023-07-25
#> 217    GL   GRL 2021 3.235816e+09         2023-07-25
#> 218    AW   ABW 2021 3.126019e+09         2023-07-25
#> 219    SR   SUR 2021 2.984706e+09         2023-07-25
#> 220    BI   BDI 2021 2.775799e+09         2023-07-25
#> 221    CW   CUW 2021 2.699612e+09         2023-07-25
#> 222    BT   BTN 2021 2.539551e+09         2023-07-25
#> 223    CF   CAF 2021 2.516498e+09         2023-07-25
#> 224    BZ   BLZ 2021 2.491500e+09         2023-07-25
#> 225    LS   LSO 2021 2.373416e+09         2023-07-25
#> 226    CV   CPV 2021 2.091742e+09         2023-07-25
#> 227    GM   GMB 2021 2.038415e+09         2023-07-25
#> 228    SM   SMR 2021 1.855383e+09         2023-07-25
#> 229    LC   LCA 2021 1.691259e+09         2023-07-25
#> 230    GW   GNB 2021 1.638518e+09         2023-07-25
#> 231    SB   SLB 2021 1.580304e+09         2023-07-25
#> 232    AG   ATG 2021 1.560519e+09         2023-07-25
#> 233    SX   SXM 2021 1.384637e+09         2023-07-25
#> 234    KM   COM 2021 1.296089e+09         2023-07-25
#> 235    SC   SYC 2021 1.286688e+09         2023-07-25
#> 236    GD   GRD 2021 1.122800e+09         2023-07-25
#> 237    TC   TCA 2021 1.044779e+09         2023-07-25
#> 238    VU   VUT 2021 9.716361e+08         2023-07-25
#> 239    VC   VCT 2021 8.722261e+08         2023-07-25
#> 240    KN   KNA 2021 8.608444e+08         2023-07-25
#> 241    WS   WSM 2021 8.438508e+08         2023-07-25
#> 242    AS   ASM 2021 7.090000e+08         2023-07-25
#> 243    DM   DMA 2021 5.552667e+08         2023-07-25
#> 244    ST   STP 2021 5.266538e+08         2023-07-25
#> 245    TO   TON 2021 4.692281e+08         2023-07-25
#> 246    FM   FSM 2021 4.040289e+08         2023-07-25
#> 247    MH   MHL 2021 2.595387e+08         2023-07-25
#> 248    KI   KIR 2021 2.276100e+08         2023-07-25
#> 249    PW   PLW 2021 2.178000e+08         2023-07-25
#> 250    NR   NRU 2021 1.455366e+08         2023-07-25
#> 251    TV   TUV 2021 6.019637e+07         2023-07-25
#>                         region             capital
#> 1                   Aggregates                    
#> 2                         <NA>                <NA>
#> 3                   Aggregates                    
#> 4                   Aggregates                    
#> 5                   Aggregates                    
#> 6                   Aggregates                    
#> 7                   Aggregates                    
#> 8                   Aggregates                    
#> 9                   Aggregates                    
#> 10                        <NA>                <NA>
#> 11                  Aggregates                    
#> 12                  Aggregates                    
#> 13                  Aggregates                    
#> 14               North America     Washington D.C.
#> 15                  Aggregates                    
#> 16                  Aggregates                    
#> 17         East Asia & Pacific             Beijing
#> 18                  Aggregates                    
#> 19                  Aggregates                    
#> 20                  Aggregates                    
#> 21                        <NA>                <NA>
#> 22                        <NA>                <NA>
#> 23                  Aggregates                    
#> 24         East Asia & Pacific               Tokyo
#> 25                  Aggregates                    
#> 26                  Aggregates                    
#> 27       Europe & Central Asia              Berlin
#> 28                  Aggregates                    
#> 29                  Aggregates                    
#> 30                  Aggregates                    
#> 31                  Aggregates                    
#> 32                  South Asia           New Delhi
#> 33       Europe & Central Asia              London
#> 34       Europe & Central Asia               Paris
#> 35                  Aggregates                    
#> 36                  Aggregates                    
#> 37       Europe & Central Asia                Rome
#> 38               North America              Ottawa
#> 39                        <NA>                <NA>
#> 40                  Aggregates                    
#> 41                  Aggregates                    
#> 42                  Aggregates                    
#> 43       Europe & Central Asia              Moscow
#> 44         East Asia & Pacific               Seoul
#> 45                  Aggregates                    
#> 46   Latin America & Caribbean            Brasilia
#> 47         East Asia & Pacific            Canberra
#> 48                  Aggregates                    
#> 49                  Aggregates                    
#> 50                  Aggregates                    
#> 51                  Aggregates                    
#> 52       Europe & Central Asia              Madrid
#> 53   Latin America & Caribbean         Mexico City
#> 54                  Aggregates                    
#> 55         East Asia & Pacific             Jakarta
#> 56                  Aggregates                    
#> 57                  Aggregates                    
#> 58       Europe & Central Asia           Amsterdam
#> 59                  Aggregates                    
#> 60  Middle East & North Africa              Riyadh
#> 61                  Aggregates                    
#> 62       Europe & Central Asia              Ankara
#> 63       Europe & Central Asia                Bern
#> 64       Europe & Central Asia              Warsaw
#> 65       Europe & Central Asia           Stockholm
#> 66       Europe & Central Asia            Brussels
#> 67                  Aggregates                    
#> 68         East Asia & Pacific             Bangkok
#> 69       Europe & Central Asia              Dublin
#> 70       Europe & Central Asia                Oslo
#> 71  Middle East & North Africa                    
#> 72   Latin America & Caribbean        Buenos Aires
#> 73       Europe & Central Asia              Vienna
#> 74                        <NA>                <NA>
#> 75                  Aggregates                    
#> 76          Sub-Saharan Africa               Abuja
#> 77  Middle East & North Africa               Cairo
#> 78         East Asia & Pacific           Singapore
#> 79          Sub-Saharan Africa            Pretoria
#> 80                  South Asia               Dhaka
#> 81  Middle East & North Africa           Abu Dhabi
#> 82       Europe & Central Asia          Copenhagen
#> 83         East Asia & Pacific              Manila
#> 84         East Asia & Pacific        Kuala Lumpur
#> 85         East Asia & Pacific                    
#> 86         East Asia & Pacific               Hanoi
#> 87  Middle East & North Africa              Tehran
#> 88                  South Asia           Islamabad
#> 89   Latin America & Caribbean              Bogota
#> 90   Latin America & Caribbean            Santiago
#> 91       Europe & Central Asia            Helsinki
#> 92       Europe & Central Asia           Bucharest
#> 93                        <NA>                <NA>
#> 94         East Asia & Pacific          Wellington
#> 95       Europe & Central Asia              Lisbon
#> 96   Latin America & Caribbean                Lima
#> 97       Europe & Central Asia              Athens
#> 98  Middle East & North Africa             Baghdad
#> 99       Europe & Central Asia                Kiev
#> 100      Europe & Central Asia              Astana
#> 101      Europe & Central Asia            Budapest
#> 102 Middle East & North Africa                Doha
#> 103 Middle East & North Africa             Algiers
#> 104 Middle East & North Africa               Rabat
#> 105 Middle East & North Africa         Kuwait City
#> 106      Europe & Central Asia          Bratislava
#> 107         Sub-Saharan Africa         Addis Ababa
#> 108         Sub-Saharan Africa             Nairobi
#> 109  Latin America & Caribbean            San Juan
#> 110  Latin America & Caribbean               Quito
#> 111  Latin America & Caribbean       Santo Domingo
#> 112                 South Asia             Colombo
#> 113 Middle East & North Africa              Muscat
#> 114  Latin America & Caribbean      Guatemala City
#> 115      Europe & Central Asia          Luxembourg
#> 116      Europe & Central Asia               Sofia
#> 117         Sub-Saharan Africa               Accra
#> 118                 Aggregates                    
#> 119         Sub-Saharan Africa        Yamoussoukro
#> 120         Sub-Saharan Africa              Dodoma
#> 121      Europe & Central Asia               Minsk
#> 122      Europe & Central Asia            Tashkent
#> 123      Europe & Central Asia              Zagreb
#> 124  Latin America & Caribbean         Panama City
#> 125      Europe & Central Asia             Vilnius
#> 126         Sub-Saharan Africa              Luanda
#> 127        East Asia & Pacific           Naypyidaw
#> 128  Latin America & Caribbean            San Jose
#> 129      Europe & Central Asia            Belgrade
#> 130      Europe & Central Asia           Ljubljana
#> 131  Latin America & Caribbean          Montevideo
#> 132         Sub-Saharan Africa            Kinshasa
#> 133      Europe & Central Asia                Baku
#> 134 Middle East & North Africa               Tunis
#> 135         Sub-Saharan Africa             Yaounde
#> 136 Middle East & North Africa               Amman
#> 137         Sub-Saharan Africa             Kampala
#> 138  Latin America & Caribbean              La Paz
#> 139  Latin America & Caribbean            Asuncion
#> 140 Middle East & North Africa             Tripoli
#> 141      Europe & Central Asia                Riga
#> 142 Middle East & North Africa              Manama
#> 143      Europe & Central Asia             Tallinn
#> 144                 South Asia           Kathmandu
#> 145         Sub-Saharan Africa            Khartoum
#> 146        East Asia & Pacific                    
#> 147  Latin America & Caribbean        San Salvador
#> 148  Latin America & Caribbean         Tegucigalpa
#> 149      Europe & Central Asia             Nicosia
#> 150         Sub-Saharan Africa              Harare
#> 151         Sub-Saharan Africa               Dakar
#> 152        East Asia & Pacific          Phnom Penh
#> 153        East Asia & Pacific        Port Moresby
#> 154      Europe & Central Asia           Reykjavik
#> 155  Latin America & Caribbean       Port-of-Spain
#> 156      Europe & Central Asia            Sarajevo
#> 157 Middle East & North Africa              Beirut
#> 158         Sub-Saharan Africa              Lusaka
#> 159  Latin America & Caribbean      Port-au-Prince
#> 160         Sub-Saharan Africa          Libreville
#> 161         Sub-Saharan Africa         Ouagadougou
#> 162         Sub-Saharan Africa              Bamako
#> 163        East Asia & Pacific           Vientiane
#> 164         Sub-Saharan Africa            Gaborone
#> 165      Europe & Central Asia             Tbilisi
#> 166 Middle East & North Africa                    
#> 167      Europe & Central Asia              Tirane
#> 168 Middle East & North Africa            Valletta
#> 169         Sub-Saharan Africa          Porto-Novo
#> 170         Sub-Saharan Africa             Conakry
#> 171         Sub-Saharan Africa              Maputo
#> 172        East Asia & Pacific         Ulaanbaatar
#> 173         Sub-Saharan Africa              Niamey
#> 174  Latin America & Caribbean            Kingston
#> 175                 South Asia               Kabul
#> 176         Sub-Saharan Africa        Antananarivo
#> 177  Latin America & Caribbean             Managua
#> 178        East Asia & Pacific Bandar Seri Begawan
#> 179      Europe & Central Asia             Yerevan
#> 180      Europe & Central Asia              Skopje
#> 181      Europe & Central Asia            Chisinau
#> 182         Sub-Saharan Africa         Brazzaville
#> 183         Sub-Saharan Africa            Lilongwe
#> 184         Sub-Saharan Africa            Windhoek
#> 185         Sub-Saharan Africa              Malabo
#> 186         Sub-Saharan Africa           N'Djamena
#> 187      Europe & Central Asia                    
#> 188  Latin America & Caribbean              Nassau
#> 189         Sub-Saharan Africa          Port Louis
#> 190         Sub-Saharan Africa              Kigali
#> 191        East Asia & Pacific             Noum'ea
#> 192         Sub-Saharan Africa          Nouakchott
#> 193                 Aggregates                    
#> 194      Europe & Central Asia            Pristina
#> 195      Europe & Central Asia            Dushanbe
#> 196      Europe & Central Asia             Bishkek
#> 197      Europe & Central Asia              Monaco
#> 198         Sub-Saharan Africa                Lome
#> 199  Latin America & Caribbean          Georgetown
#> 200         Sub-Saharan Africa           Mogadishu
#> 201      Europe & Central Asia               Vaduz
#> 202              North America            Hamilton
#> 203        East Asia & Pacific               Agana
#> 204        East Asia & Pacific             Papeete
#> 205  Latin America & Caribbean         George Town
#> 206      Europe & Central Asia           Podgorica
#> 207                 South Asia                Male
#> 208  Latin America & Caribbean          Bridgetown
#> 209         Sub-Saharan Africa             Mbabane
#> 210        East Asia & Pacific                Suva
#> 211         Sub-Saharan Africa            Freetown
#> 212      Europe & Central Asia            Torshavn
#> 213        East Asia & Pacific                Dili
#> 214         Sub-Saharan Africa            Monrovia
#> 215 Middle East & North Africa            Djibouti
#> 216      Europe & Central Asia    Andorra la Vella
#> 217      Europe & Central Asia                Nuuk
#> 218  Latin America & Caribbean          Oranjestad
#> 219  Latin America & Caribbean          Paramaribo
#> 220         Sub-Saharan Africa           Bujumbura
#> 221  Latin America & Caribbean          Willemstad
#> 222                 South Asia             Thimphu
#> 223         Sub-Saharan Africa              Bangui
#> 224  Latin America & Caribbean            Belmopan
#> 225         Sub-Saharan Africa              Maseru
#> 226         Sub-Saharan Africa               Praia
#> 227         Sub-Saharan Africa              Banjul
#> 228      Europe & Central Asia          San Marino
#> 229  Latin America & Caribbean            Castries
#> 230         Sub-Saharan Africa              Bissau
#> 231        East Asia & Pacific             Honiara
#> 232  Latin America & Caribbean        Saint John's
#> 233  Latin America & Caribbean         Philipsburg
#> 234         Sub-Saharan Africa              Moroni
#> 235         Sub-Saharan Africa            Victoria
#> 236  Latin America & Caribbean      Saint George's
#> 237  Latin America & Caribbean          Grand Turk
#> 238        East Asia & Pacific           Port-Vila
#> 239  Latin America & Caribbean           Kingstown
#> 240  Latin America & Caribbean          Basseterre
#> 241        East Asia & Pacific                Apia
#> 242        East Asia & Pacific           Pago Pago
#> 243  Latin America & Caribbean              Roseau
#> 244         Sub-Saharan Africa            Sao Tome
#> 245        East Asia & Pacific          Nuku'alofa
#> 246        East Asia & Pacific             Palikir
#> 247        East Asia & Pacific              Majuro
#> 248        East Asia & Pacific              Tarawa
#> 249        East Asia & Pacific               Koror
#> 250        East Asia & Pacific      Yaren District
#> 251        East Asia & Pacific            Funafuti
#>      longitude   latitude              income
#> 1                                  Aggregates
#> 2         <NA>       <NA>                <NA>
#> 3                                  Aggregates
#> 4                                  Aggregates
#> 5                                  Aggregates
#> 6                                  Aggregates
#> 7                                  Aggregates
#> 8                                  Aggregates
#> 9                                  Aggregates
#> 10        <NA>       <NA>                <NA>
#> 11                                 Aggregates
#> 12                                 Aggregates
#> 13                                 Aggregates
#> 14     -77.032    38.8895         High income
#> 15                                 Aggregates
#> 16                                 Aggregates
#> 17     116.286    40.0495 Upper middle income
#> 18                                 Aggregates
#> 19                                 Aggregates
#> 20                                 Aggregates
#> 21        <NA>       <NA>                <NA>
#> 22        <NA>       <NA>                <NA>
#> 23                                 Aggregates
#> 24      139.77      35.67         High income
#> 25                                 Aggregates
#> 26                                 Aggregates
#> 27     13.4115    52.5235         High income
#> 28                                 Aggregates
#> 29                                 Aggregates
#> 30                                 Aggregates
#> 31                                 Aggregates
#> 32      77.225    28.6353 Lower middle income
#> 33   -0.126236    51.5002         High income
#> 34     2.35097    48.8566         High income
#> 35                                 Aggregates
#> 36                                 Aggregates
#> 37     12.4823    41.8955         High income
#> 38    -75.6919    45.4215         High income
#> 39        <NA>       <NA>                <NA>
#> 40                                 Aggregates
#> 41                                 Aggregates
#> 42                                 Aggregates
#> 43     37.6176    55.7558 Upper middle income
#> 44     126.957    37.5323         High income
#> 45                                 Aggregates
#> 46    -47.9292   -15.7801 Upper middle income
#> 47     149.129    -35.282         High income
#> 48                                 Aggregates
#> 49                                 Aggregates
#> 50                                 Aggregates
#> 51                                 Aggregates
#> 52    -3.70327    40.4167         High income
#> 53    -99.1276     19.427 Upper middle income
#> 54                                 Aggregates
#> 55      106.83   -6.19752 Lower middle income
#> 56                                 Aggregates
#> 57                                 Aggregates
#> 58     4.89095    52.3738         High income
#> 59                                 Aggregates
#> 60     46.6977    24.6748         High income
#> 61                                 Aggregates
#> 62     32.3606    39.7153 Upper middle income
#> 63     7.44821     46.948         High income
#> 64       21.02      52.26         High income
#> 65     18.0645    59.3327         High income
#> 66     4.36761    50.8371         High income
#> 67                                 Aggregates
#> 68     100.521    13.7308 Upper middle income
#> 69    -6.26749    53.3441         High income
#> 70     10.7387    59.9138         High income
#> 71     35.2035    31.7717         High income
#> 72    -58.4173   -34.6118 Upper middle income
#> 73     16.3798    48.2201         High income
#> 74        <NA>       <NA>                <NA>
#> 75                                 Aggregates
#> 76     7.48906    9.05804 Lower middle income
#> 77     31.2461    30.0982 Lower middle income
#> 78      103.85    1.28941         High income
#> 79     28.1871    -25.746 Upper middle income
#> 80     90.4113    23.7055 Lower middle income
#> 81     54.3705    24.4764         High income
#> 82     12.5681    55.6763         High income
#> 83     121.035    14.5515 Lower middle income
#> 84     101.684    3.12433 Upper middle income
#> 85     114.109    22.3964         High income
#> 86     105.825    21.0069 Lower middle income
#> 87     51.4447    35.6878 Lower middle income
#> 88        72.8    30.5167 Lower middle income
#> 89     -74.082    4.60987 Upper middle income
#> 90    -70.6475    -33.475         High income
#> 91     24.9525    60.1608         High income
#> 92     26.0979    44.4479         High income
#> 93        <NA>       <NA>                <NA>
#> 94     174.776   -41.2865         High income
#> 95    -9.13552    38.7072         High income
#> 96    -77.0465   -12.0931 Upper middle income
#> 97     23.7166    37.9792         High income
#> 98      44.394    33.3302 Upper middle income
#> 99     30.5038    50.4536 Lower middle income
#> 100    71.4382    51.1879 Upper middle income
#> 101    19.0408    47.4984         High income
#> 102    51.5082    25.2948         High income
#> 103    3.05097    36.7397 Lower middle income
#> 104    -6.8704    33.9905 Lower middle income
#> 105    47.9824    29.3721         High income
#> 106    17.1073    48.1484         High income
#> 107    38.7468    9.02274          Low income
#> 108    36.8126   -1.27975 Lower middle income
#> 109        -66      18.23         High income
#> 110   -78.5243  -0.229498 Upper middle income
#> 111   -69.8908     18.479 Upper middle income
#> 112    79.8528    6.92148 Lower middle income
#> 113    58.5874    23.6105         High income
#> 114   -90.5328    14.6248 Upper middle income
#> 115     6.1296      49.61         High income
#> 116    23.3238    42.7105 Upper middle income
#> 117   -0.20795    5.57045 Lower middle income
#> 118                                Aggregates
#> 119    -4.0305      5.332 Lower middle income
#> 120    35.7382   -6.17486 Lower middle income
#> 121    27.5766    53.9678 Upper middle income
#> 122     69.269    41.3052 Lower middle income
#> 123    15.9614    45.8069         High income
#> 124   -79.5188    8.99427         High income
#> 125    25.2799    54.6896         High income
#> 126     13.242   -8.81155 Lower middle income
#> 127    95.9562     21.914 Lower middle income
#> 128   -84.0089    9.63701 Upper middle income
#> 129    20.4656    44.8024 Upper middle income
#> 130    14.5044    46.0546         High income
#> 131   -56.0675   -34.8941         High income
#> 132    15.3222     -4.325          Low income
#> 133    49.8932    40.3834 Upper middle income
#> 134      10.21    36.7899 Lower middle income
#> 135    11.5174     3.8721 Lower middle income
#> 136    35.9263    31.9497 Upper middle income
#> 137    32.5729   0.314269          Low income
#> 138   -66.1936   -13.9908 Lower middle income
#> 139   -57.6362   -25.3005 Upper middle income
#> 140    13.1072    32.8578 Upper middle income
#> 141    24.1048    56.9465         High income
#> 142    50.5354    26.1921         High income
#> 143    24.7586    59.4392         High income
#> 144    85.3157    27.6939 Lower middle income
#> 145    32.5363    15.5932          Low income
#> 146     113.55    22.1667         High income
#> 147   -89.2073    13.7034 Lower middle income
#> 148   -87.4667    15.1333 Lower middle income
#> 149    33.3736    35.1676         High income
#> 150    31.0672   -17.8312 Lower middle income
#> 151   -17.4734    14.7247 Lower middle income
#> 152    104.874    11.5556 Lower middle income
#> 153    147.194   -9.47357 Lower middle income
#> 154   -21.8952    64.1353         High income
#> 155   -61.4789    10.6596         High income
#> 156    18.4214    43.8607 Upper middle income
#> 157    35.5134    33.8872 Lower middle income
#> 158    28.2937   -15.3982          Low income
#> 159   -72.3288    18.5392 Lower middle income
#> 160    9.45162    0.38832 Upper middle income
#> 161   -1.53395    12.3605          Low income
#> 162   -7.50034    13.5667          Low income
#> 163    102.177    18.5826 Lower middle income
#> 164    25.9201   -24.6544 Upper middle income
#> 165     44.793      41.71 Upper middle income
#> 166                       Lower middle income
#> 167    19.8172    41.3317 Upper middle income
#> 168    14.5189    35.9042         High income
#> 169     2.6323     6.4779 Lower middle income
#> 170      -13.7    9.51667          Low income
#> 171    32.5713   -25.9664          Low income
#> 172    106.937    47.9129 Lower middle income
#> 173     2.1073     13.514          Low income
#> 174    -76.792    17.9927 Upper middle income
#> 175    69.1761    34.5228          Low income
#> 176    45.7167   -20.4667          Low income
#> 177   -86.2734    12.1475 Lower middle income
#> 178    114.946    4.94199         High income
#> 179     44.509    40.1596 Upper middle income
#> 180    21.4361    42.0024 Upper middle income
#> 181    28.8497    47.0167 Upper middle income
#> 182    15.2662    -4.2767 Lower middle income
#> 183    33.7703   -13.9899          Low income
#> 184    17.0931   -22.5648 Upper middle income
#> 185     8.7741     3.7523 Upper middle income
#> 186    15.0445    12.1048          Low income
#> 187                               High income
#> 188    -77.339    25.0661         High income
#> 189    57.4977   -20.1605 Upper middle income
#> 190    30.0587   -1.95325          Low income
#> 191    166.464   -22.2677         High income
#> 192   -15.9824    18.2367 Lower middle income
#> 193                                Aggregates
#> 194     20.926     42.565 Upper middle income
#> 195    68.7864    38.5878 Lower middle income
#> 196    74.6057    42.8851 Lower middle income
#> 197    7.41891    43.7325         High income
#> 198     1.2255     6.1228          Low income
#> 199   -58.1548    6.80461 Upper middle income
#> 200    45.3254    2.07515          Low income
#> 201    9.52148    47.1411         High income
#> 202    -64.706    32.3293         High income
#> 203    144.794    13.4443         High income
#> 204    -149.57    -17.535         High income
#> 205   -81.3857    19.3022         High income
#> 206    19.2595    42.4602 Upper middle income
#> 207    73.5109     4.1742 Upper middle income
#> 208   -59.6105    13.0935         High income
#> 209    31.4659   -26.5225 Lower middle income
#> 210    178.399   -18.1149 Upper middle income
#> 211   -13.2134     8.4821          Low income
#> 212   -6.91181    61.8926         High income
#> 213    125.567   -8.56667 Lower middle income
#> 214   -10.7957    6.30039          Low income
#> 215    43.1425    11.5806 Lower middle income
#> 216     1.5218    42.5075         High income
#> 217   -51.7214    64.1836         High income
#> 218   -70.0167    12.5167         High income
#> 219   -55.1679     5.8232 Upper middle income
#> 220    29.3639    -3.3784          Low income
#> 221                               High income
#> 222    89.6177    27.5768 Lower middle income
#> 223    21.6407    5.63056          Low income
#> 224   -88.7713    17.2534 Upper middle income
#> 225    27.7167   -29.5208 Lower middle income
#> 226   -23.5087    14.9218 Lower middle income
#> 227   -16.5885    13.4495          Low income
#> 228    12.4486    43.9322         High income
#> 229   -60.9832         14 Upper middle income
#> 230   -15.1804    11.8037          Low income
#> 231    159.949   -9.42676 Lower middle income
#> 232   -61.8456    17.1175         High income
#> 233                               High income
#> 234    43.2418   -11.6986 Lower middle income
#> 235    55.4466    -4.6309         High income
#> 236   -61.7449    12.0653 Upper middle income
#> 237 -71.141389 21.4602778         High income
#> 238    168.321   -17.7404 Lower middle income
#> 239   -61.2653    13.2035 Upper middle income
#> 240   -62.7309       17.3         High income
#> 241   -171.752   -13.8314 Lower middle income
#> 242   -170.691   -14.2846 Upper middle income
#> 243     -61.39    15.2976 Upper middle income
#> 244     6.6071    0.20618 Lower middle income
#> 245   -175.216    -21.136 Upper middle income
#> 246    158.185    6.91771 Lower middle income
#> 247    171.135    7.11046 Upper middle income
#> 248    172.979    1.32905 Lower middle income
#> 249    134.479    7.34194 Upper middle income
#> 250 166.920867    -0.5477         High income
#> 251 179.089567 -8.6314877 Upper middle income
#>            lending
#> 1       Aggregates
#> 2             <NA>
#> 3       Aggregates
#> 4       Aggregates
#> 5       Aggregates
#> 6       Aggregates
#> 7       Aggregates
#> 8       Aggregates
#> 9       Aggregates
#> 10            <NA>
#> 11      Aggregates
#> 12      Aggregates
#> 13      Aggregates
#> 14  Not classified
#> 15      Aggregates
#> 16      Aggregates
#> 17            IBRD
#> 18      Aggregates
#> 19      Aggregates
#> 20      Aggregates
#> 21            <NA>
#> 22            <NA>
#> 23      Aggregates
#> 24  Not classified
#> 25      Aggregates
#> 26      Aggregates
#> 27  Not classified
#> 28      Aggregates
#> 29      Aggregates
#> 30      Aggregates
#> 31      Aggregates
#> 32            IBRD
#> 33  Not classified
#> 34  Not classified
#> 35      Aggregates
#> 36      Aggregates
#> 37  Not classified
#> 38  Not classified
#> 39            <NA>
#> 40      Aggregates
#> 41      Aggregates
#> 42      Aggregates
#> 43            IBRD
#> 44  Not classified
#> 45      Aggregates
#> 46            IBRD
#> 47  Not classified
#> 48      Aggregates
#> 49      Aggregates
#> 50      Aggregates
#> 51      Aggregates
#> 52  Not classified
#> 53            IBRD
#> 54      Aggregates
#> 55            IBRD
#> 56      Aggregates
#> 57      Aggregates
#> 58  Not classified
#> 59      Aggregates
#> 60  Not classified
#> 61      Aggregates
#> 62            IBRD
#> 63  Not classified
#> 64            IBRD
#> 65  Not classified
#> 66  Not classified
#> 67      Aggregates
#> 68            IBRD
#> 69  Not classified
#> 70  Not classified
#> 71  Not classified
#> 72            IBRD
#> 73  Not classified
#> 74            <NA>
#> 75      Aggregates
#> 76           Blend
#> 77            IBRD
#> 78  Not classified
#> 79            IBRD
#> 80             IDA
#> 81  Not classified
#> 82  Not classified
#> 83            IBRD
#> 84            IBRD
#> 85  Not classified
#> 86            IBRD
#> 87            IBRD
#> 88           Blend
#> 89            IBRD
#> 90            IBRD
#> 91  Not classified
#> 92            IBRD
#> 93            <NA>
#> 94  Not classified
#> 95  Not classified
#> 96            IBRD
#> 97  Not classified
#> 98            IBRD
#> 99            IBRD
#> 100           IBRD
#> 101 Not classified
#> 102 Not classified
#> 103           IBRD
#> 104           IBRD
#> 105 Not classified
#> 106 Not classified
#> 107            IDA
#> 108          Blend
#> 109 Not classified
#> 110           IBRD
#> 111           IBRD
#> 112           IBRD
#> 113 Not classified
#> 114           IBRD
#> 115 Not classified
#> 116           IBRD
#> 117            IDA
#> 118     Aggregates
#> 119            IDA
#> 120            IDA
#> 121           IBRD
#> 122          Blend
#> 123           IBRD
#> 124           IBRD
#> 125 Not classified
#> 126           IBRD
#> 127            IDA
#> 128           IBRD
#> 129           IBRD
#> 130 Not classified
#> 131           IBRD
#> 132            IDA
#> 133           IBRD
#> 134           IBRD
#> 135          Blend
#> 136           IBRD
#> 137            IDA
#> 138           IBRD
#> 139           IBRD
#> 140           IBRD
#> 141 Not classified
#> 142 Not classified
#> 143 Not classified
#> 144            IDA
#> 145            IDA
#> 146 Not classified
#> 147           IBRD
#> 148            IDA
#> 149 Not classified
#> 150          Blend
#> 151            IDA
#> 152            IDA
#> 153          Blend
#> 154 Not classified
#> 155           IBRD
#> 156           IBRD
#> 157           IBRD
#> 158            IDA
#> 159            IDA
#> 160           IBRD
#> 161            IDA
#> 162            IDA
#> 163            IDA
#> 164           IBRD
#> 165           IBRD
#> 166 Not classified
#> 167           IBRD
#> 168 Not classified
#> 169            IDA
#> 170            IDA
#> 171            IDA
#> 172           IBRD
#> 173            IDA
#> 174           IBRD
#> 175            IDA
#> 176            IDA
#> 177            IDA
#> 178 Not classified
#> 179           IBRD
#> 180           IBRD
#> 181           IBRD
#> 182          Blend
#> 183            IDA
#> 184           IBRD
#> 185           IBRD
#> 186            IDA
#> 187 Not classified
#> 188 Not classified
#> 189           IBRD
#> 190            IDA
#> 191 Not classified
#> 192            IDA
#> 193     Aggregates
#> 194            IDA
#> 195            IDA
#> 196            IDA
#> 197 Not classified
#> 198            IDA
#> 199            IDA
#> 200            IDA
#> 201 Not classified
#> 202 Not classified
#> 203 Not classified
#> 204 Not classified
#> 205 Not classified
#> 206           IBRD
#> 207            IDA
#> 208 Not classified
#> 209           IBRD
#> 210          Blend
#> 211            IDA
#> 212 Not classified
#> 213          Blend
#> 214            IDA
#> 215            IDA
#> 216 Not classified
#> 217 Not classified
#> 218 Not classified
#> 219           IBRD
#> 220            IDA
#> 221 Not classified
#> 222            IDA
#> 223            IDA
#> 224           IBRD
#> 225            IDA
#> 226          Blend
#> 227            IDA
#> 228 Not classified
#> 229          Blend
#> 230            IDA
#> 231            IDA
#> 232           IBRD
#> 233 Not classified
#> 234            IDA
#> 235           IBRD
#> 236          Blend
#> 237 Not classified
#> 238            IDA
#> 239          Blend
#> 240           IBRD
#> 241            IDA
#> 242 Not classified
#> 243          Blend
#> 244            IDA
#> 245            IDA
#> 246            IDA
#> 247            IDA
#> 248            IDA
#> 249           IBRD
#> 250           IBRD
#> 251            IDA
```

#### 2021年のGDPの降順での表示（２）

最初に、World と表示され、グループや、カテゴリーのデータもあるようですから、それを、まず、削除することが必要です。`region` の列を見ると、World などは、Aggregates となっているので、そのようなものを削除すればよさそうです。数値の大きい順に並べたいので、`desc` 降順（descending order）にします。


```r
df_gdp %>% filter(year == 2021, region != "Aggregates") %>% 
  drop_na(gdp) %>% arrange(desc(gdp))
#>                            country iso2c iso3c year
#> 1                    United States    US   USA 2021
#> 2                            China    CN   CHN 2021
#> 3                            Japan    JP   JPN 2021
#> 4                          Germany    DE   DEU 2021
#> 5                            India    IN   IND 2021
#> 6                   United Kingdom    GB   GBR 2021
#> 7                           France    FR   FRA 2021
#> 8                            Italy    IT   ITA 2021
#> 9                           Canada    CA   CAN 2021
#> 10              Russian Federation    RU   RUS 2021
#> 11                     Korea, Rep.    KR   KOR 2021
#> 12                          Brazil    BR   BRA 2021
#> 13                       Australia    AU   AUS 2021
#> 14                           Spain    ES   ESP 2021
#> 15                          Mexico    MX   MEX 2021
#> 16                       Indonesia    ID   IDN 2021
#> 17                     Netherlands    NL   NLD 2021
#> 18                    Saudi Arabia    SA   SAU 2021
#> 19                         Turkiye    TR   TUR 2021
#> 20                     Switzerland    CH   CHE 2021
#> 21                          Poland    PL   POL 2021
#> 22                          Sweden    SE   SWE 2021
#> 23                         Belgium    BE   BEL 2021
#> 24                        Thailand    TH   THA 2021
#> 25                         Ireland    IE   IRL 2021
#> 26                          Norway    NO   NOR 2021
#> 27                          Israel    IL   ISR 2021
#> 28                       Argentina    AR   ARG 2021
#> 29                         Austria    AT   AUT 2021
#> 30                         Nigeria    NG   NGA 2021
#> 31                Egypt, Arab Rep.    EG   EGY 2021
#> 32                       Singapore    SG   SGP 2021
#> 33                    South Africa    ZA   ZAF 2021
#> 34                      Bangladesh    BD   BGD 2021
#> 35            United Arab Emirates    AE   ARE 2021
#> 36                         Denmark    DK   DNK 2021
#> 37                     Philippines    PH   PHL 2021
#> 38                        Malaysia    MY   MYS 2021
#> 39            Hong Kong SAR, China    HK   HKG 2021
#> 40                         Vietnam    VN   VNM 2021
#> 41              Iran, Islamic Rep.    IR   IRN 2021
#> 42                        Pakistan    PK   PAK 2021
#> 43                        Colombia    CO   COL 2021
#> 44                           Chile    CL   CHL 2021
#> 45                         Finland    FI   FIN 2021
#> 46                         Romania    RO   ROU 2021
#> 47                     New Zealand    NZ   NZL 2021
#> 48                        Portugal    PT   PRT 2021
#> 49                            Peru    PE   PER 2021
#> 50                          Greece    GR   GRC 2021
#> 51                            Iraq    IQ   IRQ 2021
#> 52                         Ukraine    UA   UKR 2021
#> 53                      Kazakhstan    KZ   KAZ 2021
#> 54                         Hungary    HU   HUN 2021
#> 55                           Qatar    QA   QAT 2021
#> 56                         Algeria    DZ   DZA 2021
#> 57                         Morocco    MA   MAR 2021
#> 58                          Kuwait    KW   KWT 2021
#> 59                 Slovak Republic    SK   SVK 2021
#> 60                        Ethiopia    ET   ETH 2021
#> 61                           Kenya    KE   KEN 2021
#> 62                     Puerto Rico    PR   PRI 2021
#> 63                         Ecuador    EC   ECU 2021
#> 64              Dominican Republic    DO   DOM 2021
#> 65                       Sri Lanka    LK   LKA 2021
#> 66                            Oman    OM   OMN 2021
#> 67                       Guatemala    GT   GTM 2021
#> 68                      Luxembourg    LU   LUX 2021
#> 69                        Bulgaria    BG   BGR 2021
#> 70                           Ghana    GH   GHA 2021
#> 71                   Cote d'Ivoire    CI   CIV 2021
#> 72                        Tanzania    TZ   TZA 2021
#> 73                         Belarus    BY   BLR 2021
#> 74                      Uzbekistan    UZ   UZB 2021
#> 75                         Croatia    HR   HRV 2021
#> 76                          Panama    PA   PAN 2021
#> 77                       Lithuania    LT   LTU 2021
#> 78                          Angola    AO   AGO 2021
#> 79                         Myanmar    MM   MMR 2021
#> 80                      Costa Rica    CR   CRI 2021
#> 81                          Serbia    RS   SRB 2021
#> 82                        Slovenia    SI   SVN 2021
#> 83                         Uruguay    UY   URY 2021
#> 84                Congo, Dem. Rep.    CD   COD 2021
#> 85                      Azerbaijan    AZ   AZE 2021
#> 86                         Tunisia    TN   TUN 2021
#> 87                        Cameroon    CM   CMR 2021
#> 88                          Jordan    JO   JOR 2021
#> 89                          Uganda    UG   UGA 2021
#> 90                         Bolivia    BO   BOL 2021
#> 91                        Paraguay    PY   PRY 2021
#> 92                           Libya    LY   LBY 2021
#> 93                          Latvia    LV   LVA 2021
#> 94                         Bahrain    BH   BHR 2021
#> 95                         Estonia    EE   EST 2021
#> 96                           Nepal    NP   NPL 2021
#> 97                           Sudan    SD   SDN 2021
#> 98                Macao SAR, China    MO   MAC 2021
#> 99                     El Salvador    SV   SLV 2021
#> 100                       Honduras    HN   HND 2021
#> 101                         Cyprus    CY   CYP 2021
#> 102                       Zimbabwe    ZW   ZWE 2021
#> 103                        Senegal    SN   SEN 2021
#> 104                       Cambodia    KH   KHM 2021
#> 105               Papua New Guinea    PG   PNG 2021
#> 106                        Iceland    IS   ISL 2021
#> 107            Trinidad and Tobago    TT   TTO 2021
#> 108         Bosnia and Herzegovina    BA   BIH 2021
#> 109                        Lebanon    LB   LBN 2021
#> 110                         Zambia    ZM   ZMB 2021
#> 111                          Haiti    HT   HTI 2021
#> 112                          Gabon    GA   GAB 2021
#> 113                   Burkina Faso    BF   BFA 2021
#> 114                           Mali    ML   MLI 2021
#> 115                        Lao PDR    LA   LAO 2021
#> 116                       Botswana    BW   BWA 2021
#> 117                        Georgia    GE   GEO 2021
#> 118             West Bank and Gaza    PS   PSE 2021
#> 119                        Albania    AL   ALB 2021
#> 120                          Malta    MT   MLT 2021
#> 121                          Benin    BJ   BEN 2021
#> 122                         Guinea    GN   GIN 2021
#> 123                     Mozambique    MZ   MOZ 2021
#> 124                       Mongolia    MN   MNG 2021
#> 125                          Niger    NE   NER 2021
#> 126                        Jamaica    JM   JAM 2021
#> 127                    Afghanistan    AF   AFG 2021
#> 128                     Madagascar    MG   MDG 2021
#> 129                      Nicaragua    NI   NIC 2021
#> 130              Brunei Darussalam    BN   BRN 2021
#> 131                        Armenia    AM   ARM 2021
#> 132                North Macedonia    MK   MKD 2021
#> 133                        Moldova    MD   MDA 2021
#> 134                    Congo, Rep.    CG   COG 2021
#> 135                         Malawi    MW   MWI 2021
#> 136                        Namibia    NA   NAM 2021
#> 137              Equatorial Guinea    GQ   GNQ 2021
#> 138                           Chad    TD   TCD 2021
#> 139                Channel Islands    JG   CHI 2021
#> 140                   Bahamas, The    BS   BHS 2021
#> 141                      Mauritius    MU   MUS 2021
#> 142                         Rwanda    RW   RWA 2021
#> 143                  New Caledonia    NC   NCL 2021
#> 144                     Mauritania    MR   MRT 2021
#> 145                         Kosovo    XK   XKX 2021
#> 146                     Tajikistan    TJ   TJK 2021
#> 147                Kyrgyz Republic    KG   KGZ 2021
#> 148                         Monaco    MC   MCO 2021
#> 149                           Togo    TG   TGO 2021
#> 150                         Guyana    GY   GUY 2021
#> 151                        Somalia    SO   SOM 2021
#> 152                  Liechtenstein    LI   LIE 2021
#> 153                        Bermuda    BM   BMU 2021
#> 154                           Guam    GU   GUM 2021
#> 155               French Polynesia    PF   PYF 2021
#> 156                 Cayman Islands    KY   CYM 2021
#> 157                     Montenegro    ME   MNE 2021
#> 158                       Maldives    MV   MDV 2021
#> 159                       Barbados    BB   BRB 2021
#> 160                       Eswatini    SZ   SWZ 2021
#> 161                           Fiji    FJ   FJI 2021
#> 162                   Sierra Leone    SL   SLE 2021
#> 163                  Faroe Islands    FO   FRO 2021
#> 164                    Timor-Leste    TL   TLS 2021
#> 165                        Liberia    LR   LBR 2021
#> 166                       Djibouti    DJ   DJI 2021
#> 167                        Andorra    AD   AND 2021
#> 168                      Greenland    GL   GRL 2021
#> 169                          Aruba    AW   ABW 2021
#> 170                       Suriname    SR   SUR 2021
#> 171                        Burundi    BI   BDI 2021
#> 172                        Curacao    CW   CUW 2021
#> 173                         Bhutan    BT   BTN 2021
#> 174       Central African Republic    CF   CAF 2021
#> 175                         Belize    BZ   BLZ 2021
#> 176                        Lesotho    LS   LSO 2021
#> 177                     Cabo Verde    CV   CPV 2021
#> 178                    Gambia, The    GM   GMB 2021
#> 179                     San Marino    SM   SMR 2021
#> 180                      St. Lucia    LC   LCA 2021
#> 181                  Guinea-Bissau    GW   GNB 2021
#> 182                Solomon Islands    SB   SLB 2021
#> 183            Antigua and Barbuda    AG   ATG 2021
#> 184      Sint Maarten (Dutch part)    SX   SXM 2021
#> 185                        Comoros    KM   COM 2021
#> 186                     Seychelles    SC   SYC 2021
#> 187                        Grenada    GD   GRD 2021
#> 188       Turks and Caicos Islands    TC   TCA 2021
#> 189                        Vanuatu    VU   VUT 2021
#> 190 St. Vincent and the Grenadines    VC   VCT 2021
#> 191            St. Kitts and Nevis    KN   KNA 2021
#> 192                          Samoa    WS   WSM 2021
#> 193                 American Samoa    AS   ASM 2021
#> 194                       Dominica    DM   DMA 2021
#> 195          Sao Tome and Principe    ST   STP 2021
#> 196                          Tonga    TO   TON 2021
#> 197          Micronesia, Fed. Sts.    FM   FSM 2021
#> 198               Marshall Islands    MH   MHL 2021
#> 199                       Kiribati    KI   KIR 2021
#> 200                          Palau    PW   PLW 2021
#> 201                          Nauru    NR   NRU 2021
#> 202                         Tuvalu    TV   TUV 2021
#>              gdp status lastupdated
#> 1   2.331508e+13         2023-07-25
#> 2   1.782046e+13         2023-07-25
#> 3   5.005537e+12         2023-07-25
#> 4   4.259935e+12         2023-07-25
#> 5   3.150307e+12         2023-07-25
#> 6   3.122480e+12         2023-07-25
#> 7   2.957880e+12         2023-07-25
#> 8   2.114356e+12         2023-07-25
#> 9   2.001487e+12         2023-07-25
#> 10  1.836892e+12         2023-07-25
#> 11  1.810956e+12         2023-07-25
#> 12  1.649623e+12         2023-07-25
#> 13  1.552703e+12         2023-07-25
#> 14  1.427381e+12         2023-07-25
#> 15  1.272839e+12         2023-07-25
#> 16  1.186505e+12         2023-07-25
#> 17  1.011799e+12         2023-07-25
#> 18  8.685859e+11         2023-07-25
#> 19  8.190345e+11         2023-07-25
#> 20  8.006402e+11         2023-07-25
#> 21  6.794419e+11         2023-07-25
#> 22  6.368562e+11         2023-07-25
#> 23  5.943520e+11         2023-07-25
#> 24  5.055681e+11         2023-07-25
#> 25  5.041826e+11         2023-07-25
#> 26  4.902934e+11         2023-07-25
#> 27  4.885265e+11         2023-07-25
#> 28  4.872271e+11         2023-07-25
#> 29  4.803684e+11         2023-07-25
#> 30  4.408336e+11         2023-07-25
#> 31  4.246718e+11         2023-07-25
#> 32  4.237970e+11         2023-07-25
#> 33  4.190156e+11         2023-07-25
#> 34  4.162648e+11         2023-07-25
#> 35  4.150216e+11         2023-07-25
#> 36  3.983033e+11         2023-07-25
#> 37  3.940874e+11         2023-07-25
#> 38  3.729811e+11         2023-07-25
#> 39  3.689114e+11         2023-07-25
#> 40  3.661376e+11         2023-07-25
#> 41  3.590969e+11         2023-07-25
#> 42  3.482625e+11         2023-07-25
#> 43  3.185118e+11         2023-07-25
#> 44  3.167136e+11         2023-07-25
#> 45  2.963876e+11         2023-07-25
#> 46  2.854047e+11         2023-07-25
#> 47  2.555517e+11         2023-07-25
#> 48  2.539828e+11         2023-07-25
#> 49  2.237178e+11         2023-07-25
#> 50  2.148739e+11         2023-07-25
#> 51  2.076916e+11         2023-07-25
#> 52  1.997659e+11         2023-07-25
#> 53  1.971123e+11         2023-07-25
#> 54  1.822754e+11         2023-07-25
#> 55  1.796771e+11         2023-07-25
#> 56  1.634722e+11         2023-07-25
#> 57  1.428666e+11         2023-07-25
#> 58  1.367974e+11         2023-07-25
#> 59  1.186566e+11         2023-07-25
#> 60  1.112619e+11         2023-07-25
#> 61  1.097037e+11         2023-07-25
#> 62  1.063689e+11         2023-07-25
#> 63  1.061659e+11         2023-07-25
#> 64  9.424343e+10         2023-07-25
#> 65  8.849654e+10         2023-07-25
#> 66  8.819198e+10         2023-07-25
#> 67  8.605308e+10         2023-07-25
#> 68  8.550624e+10         2023-07-25
#> 69  8.406140e+10         2023-07-25
#> 70  7.915641e+10         2023-07-25
#> 71  7.181108e+10         2023-07-25
#> 72  7.065563e+10         2023-07-25
#> 73  6.967375e+10         2023-07-25
#> 74  6.960061e+10         2023-07-25
#> 75  6.884367e+10         2023-07-25
#> 76  6.740674e+10         2023-07-25
#> 77  6.641499e+10         2023-07-25
#> 78  6.568544e+10         2023-07-25
#> 79  6.512477e+10         2023-07-25
#> 80  6.461648e+10         2023-07-25
#> 81  6.308202e+10         2023-07-25
#> 82  6.174859e+10         2023-07-25
#> 83  6.141227e+10         2023-07-25
#> 84  5.535097e+10         2023-07-25
#> 85  5.482541e+10         2023-07-25
#> 86  4.668730e+10         2023-07-25
#> 87  4.533829e+10         2023-07-25
#> 88  4.511632e+10         2023-07-25
#> 89  4.051024e+10         2023-07-25
#> 90  4.040821e+10         2023-07-25
#> 91  3.995090e+10         2023-07-25
#> 92  3.979842e+10         2023-07-25
#> 93  3.972538e+10         2023-07-25
#> 94  3.930340e+10         2023-07-25
#> 95  3.719117e+10         2023-07-25
#> 96  3.692484e+10         2023-07-25
#> 97  3.422951e+10         2023-07-25
#> 98  3.012380e+10         2023-07-25
#> 99  2.945124e+10         2023-07-25
#> 100 2.848872e+10         2023-07-25
#> 101 2.840806e+10         2023-07-25
#> 102 2.837124e+10         2023-07-25
#> 103 2.756914e+10         2023-07-25
#> 104 2.696106e+10         2023-07-25
#> 105 2.631166e+10         2023-07-25
#> 106 2.555264e+10         2023-07-25
#> 107 2.446020e+10         2023-07-25
#> 108 2.364957e+10         2023-07-25
#> 109 2.313194e+10         2023-07-25
#> 110 2.214765e+10         2023-07-25
#> 111 2.087741e+10         2023-07-25
#> 112 2.021795e+10         2023-07-25
#> 113 1.973762e+10         2023-07-25
#> 114 1.930946e+10         2023-07-25
#> 115 1.882715e+10         2023-07-25
#> 116 1.873707e+10         2023-07-25
#> 117 1.862937e+10         2023-07-25
#> 118 1.810900e+10         2023-07-25
#> 119 1.793057e+10         2023-07-25
#> 120 1.774338e+10         2023-07-25
#> 121 1.769008e+10         2023-07-25
#> 122 1.609182e+10         2023-07-25
#> 123 1.577676e+10         2023-07-25
#> 124 1.528644e+10         2023-07-25
#> 125 1.491500e+10         2023-07-25
#> 126 1.465759e+10         2023-07-25
#> 127 1.458314e+10         2023-07-25
#> 128 1.455475e+10         2023-07-25
#> 129 1.414585e+10         2023-07-25
#> 130 1.400650e+10         2023-07-25
#> 131 1.386141e+10         2023-07-25
#> 132 1.382505e+10         2023-07-25
#> 133 1.369223e+10         2023-07-25
#> 134 1.336623e+10         2023-07-25
#> 135 1.260233e+10         2023-07-25
#> 136 1.244629e+10         2023-07-25
#> 137 1.226939e+10         2023-07-25
#> 138 1.177998e+10         2023-07-25
#> 139 1.173566e+10         2023-07-25
#> 140 1.152760e+10         2023-07-25
#> 141 1.147643e+10         2023-07-25
#> 142 1.105528e+10         2023-07-25
#> 143 1.007135e+10         2023-07-25
#> 144 9.996240e+09         2023-07-25
#> 145 9.412034e+09         2023-07-25
#> 146 8.937805e+09         2023-07-25
#> 147 8.740682e+09         2023-07-25
#> 148 8.596157e+09         2023-07-25
#> 149 8.334047e+09         2023-07-25
#> 150 8.044499e+09         2023-07-25
#> 151 7.628000e+09         2023-07-25
#> 152 7.186429e+09         2023-07-25
#> 153 7.127200e+09         2023-07-25
#> 154 6.123000e+09         2023-07-25
#> 155 6.080359e+09         2023-07-25
#> 156 6.028374e+09         2023-07-25
#> 157 5.861431e+09         2023-07-25
#> 158 5.405557e+09         2023-07-25
#> 159 4.843800e+09         2023-07-25
#> 160 4.748702e+09         2023-07-25
#> 161 4.296235e+09         2023-07-25
#> 162 4.249235e+09         2023-07-25
#> 163 3.649879e+09         2023-07-25
#> 164 3.621222e+09         2023-07-25
#> 165 3.509000e+09         2023-07-25
#> 166 3.372287e+09         2023-07-25
#> 167 3.325145e+09         2023-07-25
#> 168 3.235816e+09         2023-07-25
#> 169 3.126019e+09         2023-07-25
#> 170 2.984706e+09         2023-07-25
#> 171 2.775799e+09         2023-07-25
#> 172 2.699612e+09         2023-07-25
#> 173 2.539551e+09         2023-07-25
#> 174 2.516498e+09         2023-07-25
#> 175 2.491500e+09         2023-07-25
#> 176 2.373416e+09         2023-07-25
#> 177 2.091742e+09         2023-07-25
#> 178 2.038415e+09         2023-07-25
#> 179 1.855383e+09         2023-07-25
#> 180 1.691259e+09         2023-07-25
#> 181 1.638518e+09         2023-07-25
#> 182 1.580304e+09         2023-07-25
#> 183 1.560519e+09         2023-07-25
#> 184 1.384637e+09         2023-07-25
#> 185 1.296089e+09         2023-07-25
#> 186 1.286688e+09         2023-07-25
#> 187 1.122800e+09         2023-07-25
#> 188 1.044779e+09         2023-07-25
#> 189 9.716361e+08         2023-07-25
#> 190 8.722261e+08         2023-07-25
#> 191 8.608444e+08         2023-07-25
#> 192 8.438508e+08         2023-07-25
#> 193 7.090000e+08         2023-07-25
#> 194 5.552667e+08         2023-07-25
#> 195 5.266538e+08         2023-07-25
#> 196 4.692281e+08         2023-07-25
#> 197 4.040289e+08         2023-07-25
#> 198 2.595387e+08         2023-07-25
#> 199 2.276100e+08         2023-07-25
#> 200 2.178000e+08         2023-07-25
#> 201 1.455366e+08         2023-07-25
#> 202 6.019637e+07         2023-07-25
#>                         region             capital
#> 1                North America     Washington D.C.
#> 2          East Asia & Pacific             Beijing
#> 3          East Asia & Pacific               Tokyo
#> 4        Europe & Central Asia              Berlin
#> 5                   South Asia           New Delhi
#> 6        Europe & Central Asia              London
#> 7        Europe & Central Asia               Paris
#> 8        Europe & Central Asia                Rome
#> 9                North America              Ottawa
#> 10       Europe & Central Asia              Moscow
#> 11         East Asia & Pacific               Seoul
#> 12   Latin America & Caribbean            Brasilia
#> 13         East Asia & Pacific            Canberra
#> 14       Europe & Central Asia              Madrid
#> 15   Latin America & Caribbean         Mexico City
#> 16         East Asia & Pacific             Jakarta
#> 17       Europe & Central Asia           Amsterdam
#> 18  Middle East & North Africa              Riyadh
#> 19       Europe & Central Asia              Ankara
#> 20       Europe & Central Asia                Bern
#> 21       Europe & Central Asia              Warsaw
#> 22       Europe & Central Asia           Stockholm
#> 23       Europe & Central Asia            Brussels
#> 24         East Asia & Pacific             Bangkok
#> 25       Europe & Central Asia              Dublin
#> 26       Europe & Central Asia                Oslo
#> 27  Middle East & North Africa                    
#> 28   Latin America & Caribbean        Buenos Aires
#> 29       Europe & Central Asia              Vienna
#> 30          Sub-Saharan Africa               Abuja
#> 31  Middle East & North Africa               Cairo
#> 32         East Asia & Pacific           Singapore
#> 33          Sub-Saharan Africa            Pretoria
#> 34                  South Asia               Dhaka
#> 35  Middle East & North Africa           Abu Dhabi
#> 36       Europe & Central Asia          Copenhagen
#> 37         East Asia & Pacific              Manila
#> 38         East Asia & Pacific        Kuala Lumpur
#> 39         East Asia & Pacific                    
#> 40         East Asia & Pacific               Hanoi
#> 41  Middle East & North Africa              Tehran
#> 42                  South Asia           Islamabad
#> 43   Latin America & Caribbean              Bogota
#> 44   Latin America & Caribbean            Santiago
#> 45       Europe & Central Asia            Helsinki
#> 46       Europe & Central Asia           Bucharest
#> 47         East Asia & Pacific          Wellington
#> 48       Europe & Central Asia              Lisbon
#> 49   Latin America & Caribbean                Lima
#> 50       Europe & Central Asia              Athens
#> 51  Middle East & North Africa             Baghdad
#> 52       Europe & Central Asia                Kiev
#> 53       Europe & Central Asia              Astana
#> 54       Europe & Central Asia            Budapest
#> 55  Middle East & North Africa                Doha
#> 56  Middle East & North Africa             Algiers
#> 57  Middle East & North Africa               Rabat
#> 58  Middle East & North Africa         Kuwait City
#> 59       Europe & Central Asia          Bratislava
#> 60          Sub-Saharan Africa         Addis Ababa
#> 61          Sub-Saharan Africa             Nairobi
#> 62   Latin America & Caribbean            San Juan
#> 63   Latin America & Caribbean               Quito
#> 64   Latin America & Caribbean       Santo Domingo
#> 65                  South Asia             Colombo
#> 66  Middle East & North Africa              Muscat
#> 67   Latin America & Caribbean      Guatemala City
#> 68       Europe & Central Asia          Luxembourg
#> 69       Europe & Central Asia               Sofia
#> 70          Sub-Saharan Africa               Accra
#> 71          Sub-Saharan Africa        Yamoussoukro
#> 72          Sub-Saharan Africa              Dodoma
#> 73       Europe & Central Asia               Minsk
#> 74       Europe & Central Asia            Tashkent
#> 75       Europe & Central Asia              Zagreb
#> 76   Latin America & Caribbean         Panama City
#> 77       Europe & Central Asia             Vilnius
#> 78          Sub-Saharan Africa              Luanda
#> 79         East Asia & Pacific           Naypyidaw
#> 80   Latin America & Caribbean            San Jose
#> 81       Europe & Central Asia            Belgrade
#> 82       Europe & Central Asia           Ljubljana
#> 83   Latin America & Caribbean          Montevideo
#> 84          Sub-Saharan Africa            Kinshasa
#> 85       Europe & Central Asia                Baku
#> 86  Middle East & North Africa               Tunis
#> 87          Sub-Saharan Africa             Yaounde
#> 88  Middle East & North Africa               Amman
#> 89          Sub-Saharan Africa             Kampala
#> 90   Latin America & Caribbean              La Paz
#> 91   Latin America & Caribbean            Asuncion
#> 92  Middle East & North Africa             Tripoli
#> 93       Europe & Central Asia                Riga
#> 94  Middle East & North Africa              Manama
#> 95       Europe & Central Asia             Tallinn
#> 96                  South Asia           Kathmandu
#> 97          Sub-Saharan Africa            Khartoum
#> 98         East Asia & Pacific                    
#> 99   Latin America & Caribbean        San Salvador
#> 100  Latin America & Caribbean         Tegucigalpa
#> 101      Europe & Central Asia             Nicosia
#> 102         Sub-Saharan Africa              Harare
#> 103         Sub-Saharan Africa               Dakar
#> 104        East Asia & Pacific          Phnom Penh
#> 105        East Asia & Pacific        Port Moresby
#> 106      Europe & Central Asia           Reykjavik
#> 107  Latin America & Caribbean       Port-of-Spain
#> 108      Europe & Central Asia            Sarajevo
#> 109 Middle East & North Africa              Beirut
#> 110         Sub-Saharan Africa              Lusaka
#> 111  Latin America & Caribbean      Port-au-Prince
#> 112         Sub-Saharan Africa          Libreville
#> 113         Sub-Saharan Africa         Ouagadougou
#> 114         Sub-Saharan Africa              Bamako
#> 115        East Asia & Pacific           Vientiane
#> 116         Sub-Saharan Africa            Gaborone
#> 117      Europe & Central Asia             Tbilisi
#> 118 Middle East & North Africa                    
#> 119      Europe & Central Asia              Tirane
#> 120 Middle East & North Africa            Valletta
#> 121         Sub-Saharan Africa          Porto-Novo
#> 122         Sub-Saharan Africa             Conakry
#> 123         Sub-Saharan Africa              Maputo
#> 124        East Asia & Pacific         Ulaanbaatar
#> 125         Sub-Saharan Africa              Niamey
#> 126  Latin America & Caribbean            Kingston
#> 127                 South Asia               Kabul
#> 128         Sub-Saharan Africa        Antananarivo
#> 129  Latin America & Caribbean             Managua
#> 130        East Asia & Pacific Bandar Seri Begawan
#> 131      Europe & Central Asia             Yerevan
#> 132      Europe & Central Asia              Skopje
#> 133      Europe & Central Asia            Chisinau
#> 134         Sub-Saharan Africa         Brazzaville
#> 135         Sub-Saharan Africa            Lilongwe
#> 136         Sub-Saharan Africa            Windhoek
#> 137         Sub-Saharan Africa              Malabo
#> 138         Sub-Saharan Africa           N'Djamena
#> 139      Europe & Central Asia                    
#> 140  Latin America & Caribbean              Nassau
#> 141         Sub-Saharan Africa          Port Louis
#> 142         Sub-Saharan Africa              Kigali
#> 143        East Asia & Pacific             Noum'ea
#> 144         Sub-Saharan Africa          Nouakchott
#> 145      Europe & Central Asia            Pristina
#> 146      Europe & Central Asia            Dushanbe
#> 147      Europe & Central Asia             Bishkek
#> 148      Europe & Central Asia              Monaco
#> 149         Sub-Saharan Africa                Lome
#> 150  Latin America & Caribbean          Georgetown
#> 151         Sub-Saharan Africa           Mogadishu
#> 152      Europe & Central Asia               Vaduz
#> 153              North America            Hamilton
#> 154        East Asia & Pacific               Agana
#> 155        East Asia & Pacific             Papeete
#> 156  Latin America & Caribbean         George Town
#> 157      Europe & Central Asia           Podgorica
#> 158                 South Asia                Male
#> 159  Latin America & Caribbean          Bridgetown
#> 160         Sub-Saharan Africa             Mbabane
#> 161        East Asia & Pacific                Suva
#> 162         Sub-Saharan Africa            Freetown
#> 163      Europe & Central Asia            Torshavn
#> 164        East Asia & Pacific                Dili
#> 165         Sub-Saharan Africa            Monrovia
#> 166 Middle East & North Africa            Djibouti
#> 167      Europe & Central Asia    Andorra la Vella
#> 168      Europe & Central Asia                Nuuk
#> 169  Latin America & Caribbean          Oranjestad
#> 170  Latin America & Caribbean          Paramaribo
#> 171         Sub-Saharan Africa           Bujumbura
#> 172  Latin America & Caribbean          Willemstad
#> 173                 South Asia             Thimphu
#> 174         Sub-Saharan Africa              Bangui
#> 175  Latin America & Caribbean            Belmopan
#> 176         Sub-Saharan Africa              Maseru
#> 177         Sub-Saharan Africa               Praia
#> 178         Sub-Saharan Africa              Banjul
#> 179      Europe & Central Asia          San Marino
#> 180  Latin America & Caribbean            Castries
#> 181         Sub-Saharan Africa              Bissau
#> 182        East Asia & Pacific             Honiara
#> 183  Latin America & Caribbean        Saint John's
#> 184  Latin America & Caribbean         Philipsburg
#> 185         Sub-Saharan Africa              Moroni
#> 186         Sub-Saharan Africa            Victoria
#> 187  Latin America & Caribbean      Saint George's
#> 188  Latin America & Caribbean          Grand Turk
#> 189        East Asia & Pacific           Port-Vila
#> 190  Latin America & Caribbean           Kingstown
#> 191  Latin America & Caribbean          Basseterre
#> 192        East Asia & Pacific                Apia
#> 193        East Asia & Pacific           Pago Pago
#> 194  Latin America & Caribbean              Roseau
#> 195         Sub-Saharan Africa            Sao Tome
#> 196        East Asia & Pacific          Nuku'alofa
#> 197        East Asia & Pacific             Palikir
#> 198        East Asia & Pacific              Majuro
#> 199        East Asia & Pacific              Tarawa
#> 200        East Asia & Pacific               Koror
#> 201        East Asia & Pacific      Yaren District
#> 202        East Asia & Pacific            Funafuti
#>      longitude   latitude              income
#> 1      -77.032    38.8895         High income
#> 2      116.286    40.0495 Upper middle income
#> 3       139.77      35.67         High income
#> 4      13.4115    52.5235         High income
#> 5       77.225    28.6353 Lower middle income
#> 6    -0.126236    51.5002         High income
#> 7      2.35097    48.8566         High income
#> 8      12.4823    41.8955         High income
#> 9     -75.6919    45.4215         High income
#> 10     37.6176    55.7558 Upper middle income
#> 11     126.957    37.5323         High income
#> 12    -47.9292   -15.7801 Upper middle income
#> 13     149.129    -35.282         High income
#> 14    -3.70327    40.4167         High income
#> 15    -99.1276     19.427 Upper middle income
#> 16      106.83   -6.19752 Lower middle income
#> 17     4.89095    52.3738         High income
#> 18     46.6977    24.6748         High income
#> 19     32.3606    39.7153 Upper middle income
#> 20     7.44821     46.948         High income
#> 21       21.02      52.26         High income
#> 22     18.0645    59.3327         High income
#> 23     4.36761    50.8371         High income
#> 24     100.521    13.7308 Upper middle income
#> 25    -6.26749    53.3441         High income
#> 26     10.7387    59.9138         High income
#> 27     35.2035    31.7717         High income
#> 28    -58.4173   -34.6118 Upper middle income
#> 29     16.3798    48.2201         High income
#> 30     7.48906    9.05804 Lower middle income
#> 31     31.2461    30.0982 Lower middle income
#> 32      103.85    1.28941         High income
#> 33     28.1871    -25.746 Upper middle income
#> 34     90.4113    23.7055 Lower middle income
#> 35     54.3705    24.4764         High income
#> 36     12.5681    55.6763         High income
#> 37     121.035    14.5515 Lower middle income
#> 38     101.684    3.12433 Upper middle income
#> 39     114.109    22.3964         High income
#> 40     105.825    21.0069 Lower middle income
#> 41     51.4447    35.6878 Lower middle income
#> 42        72.8    30.5167 Lower middle income
#> 43     -74.082    4.60987 Upper middle income
#> 44    -70.6475    -33.475         High income
#> 45     24.9525    60.1608         High income
#> 46     26.0979    44.4479         High income
#> 47     174.776   -41.2865         High income
#> 48    -9.13552    38.7072         High income
#> 49    -77.0465   -12.0931 Upper middle income
#> 50     23.7166    37.9792         High income
#> 51      44.394    33.3302 Upper middle income
#> 52     30.5038    50.4536 Lower middle income
#> 53     71.4382    51.1879 Upper middle income
#> 54     19.0408    47.4984         High income
#> 55     51.5082    25.2948         High income
#> 56     3.05097    36.7397 Lower middle income
#> 57     -6.8704    33.9905 Lower middle income
#> 58     47.9824    29.3721         High income
#> 59     17.1073    48.1484         High income
#> 60     38.7468    9.02274          Low income
#> 61     36.8126   -1.27975 Lower middle income
#> 62         -66      18.23         High income
#> 63    -78.5243  -0.229498 Upper middle income
#> 64    -69.8908     18.479 Upper middle income
#> 65     79.8528    6.92148 Lower middle income
#> 66     58.5874    23.6105         High income
#> 67    -90.5328    14.6248 Upper middle income
#> 68      6.1296      49.61         High income
#> 69     23.3238    42.7105 Upper middle income
#> 70    -0.20795    5.57045 Lower middle income
#> 71     -4.0305      5.332 Lower middle income
#> 72     35.7382   -6.17486 Lower middle income
#> 73     27.5766    53.9678 Upper middle income
#> 74      69.269    41.3052 Lower middle income
#> 75     15.9614    45.8069         High income
#> 76    -79.5188    8.99427         High income
#> 77     25.2799    54.6896         High income
#> 78      13.242   -8.81155 Lower middle income
#> 79     95.9562     21.914 Lower middle income
#> 80    -84.0089    9.63701 Upper middle income
#> 81     20.4656    44.8024 Upper middle income
#> 82     14.5044    46.0546         High income
#> 83    -56.0675   -34.8941         High income
#> 84     15.3222     -4.325          Low income
#> 85     49.8932    40.3834 Upper middle income
#> 86       10.21    36.7899 Lower middle income
#> 87     11.5174     3.8721 Lower middle income
#> 88     35.9263    31.9497 Upper middle income
#> 89     32.5729   0.314269          Low income
#> 90    -66.1936   -13.9908 Lower middle income
#> 91    -57.6362   -25.3005 Upper middle income
#> 92     13.1072    32.8578 Upper middle income
#> 93     24.1048    56.9465         High income
#> 94     50.5354    26.1921         High income
#> 95     24.7586    59.4392         High income
#> 96     85.3157    27.6939 Lower middle income
#> 97     32.5363    15.5932          Low income
#> 98      113.55    22.1667         High income
#> 99    -89.2073    13.7034 Lower middle income
#> 100   -87.4667    15.1333 Lower middle income
#> 101    33.3736    35.1676         High income
#> 102    31.0672   -17.8312 Lower middle income
#> 103   -17.4734    14.7247 Lower middle income
#> 104    104.874    11.5556 Lower middle income
#> 105    147.194   -9.47357 Lower middle income
#> 106   -21.8952    64.1353         High income
#> 107   -61.4789    10.6596         High income
#> 108    18.4214    43.8607 Upper middle income
#> 109    35.5134    33.8872 Lower middle income
#> 110    28.2937   -15.3982          Low income
#> 111   -72.3288    18.5392 Lower middle income
#> 112    9.45162    0.38832 Upper middle income
#> 113   -1.53395    12.3605          Low income
#> 114   -7.50034    13.5667          Low income
#> 115    102.177    18.5826 Lower middle income
#> 116    25.9201   -24.6544 Upper middle income
#> 117     44.793      41.71 Upper middle income
#> 118                       Lower middle income
#> 119    19.8172    41.3317 Upper middle income
#> 120    14.5189    35.9042         High income
#> 121     2.6323     6.4779 Lower middle income
#> 122      -13.7    9.51667          Low income
#> 123    32.5713   -25.9664          Low income
#> 124    106.937    47.9129 Lower middle income
#> 125     2.1073     13.514          Low income
#> 126    -76.792    17.9927 Upper middle income
#> 127    69.1761    34.5228          Low income
#> 128    45.7167   -20.4667          Low income
#> 129   -86.2734    12.1475 Lower middle income
#> 130    114.946    4.94199         High income
#> 131     44.509    40.1596 Upper middle income
#> 132    21.4361    42.0024 Upper middle income
#> 133    28.8497    47.0167 Upper middle income
#> 134    15.2662    -4.2767 Lower middle income
#> 135    33.7703   -13.9899          Low income
#> 136    17.0931   -22.5648 Upper middle income
#> 137     8.7741     3.7523 Upper middle income
#> 138    15.0445    12.1048          Low income
#> 139                               High income
#> 140    -77.339    25.0661         High income
#> 141    57.4977   -20.1605 Upper middle income
#> 142    30.0587   -1.95325          Low income
#> 143    166.464   -22.2677         High income
#> 144   -15.9824    18.2367 Lower middle income
#> 145     20.926     42.565 Upper middle income
#> 146    68.7864    38.5878 Lower middle income
#> 147    74.6057    42.8851 Lower middle income
#> 148    7.41891    43.7325         High income
#> 149     1.2255     6.1228          Low income
#> 150   -58.1548    6.80461 Upper middle income
#> 151    45.3254    2.07515          Low income
#> 152    9.52148    47.1411         High income
#> 153    -64.706    32.3293         High income
#> 154    144.794    13.4443         High income
#> 155    -149.57    -17.535         High income
#> 156   -81.3857    19.3022         High income
#> 157    19.2595    42.4602 Upper middle income
#> 158    73.5109     4.1742 Upper middle income
#> 159   -59.6105    13.0935         High income
#> 160    31.4659   -26.5225 Lower middle income
#> 161    178.399   -18.1149 Upper middle income
#> 162   -13.2134     8.4821          Low income
#> 163   -6.91181    61.8926         High income
#> 164    125.567   -8.56667 Lower middle income
#> 165   -10.7957    6.30039          Low income
#> 166    43.1425    11.5806 Lower middle income
#> 167     1.5218    42.5075         High income
#> 168   -51.7214    64.1836         High income
#> 169   -70.0167    12.5167         High income
#> 170   -55.1679     5.8232 Upper middle income
#> 171    29.3639    -3.3784          Low income
#> 172                               High income
#> 173    89.6177    27.5768 Lower middle income
#> 174    21.6407    5.63056          Low income
#> 175   -88.7713    17.2534 Upper middle income
#> 176    27.7167   -29.5208 Lower middle income
#> 177   -23.5087    14.9218 Lower middle income
#> 178   -16.5885    13.4495          Low income
#> 179    12.4486    43.9322         High income
#> 180   -60.9832         14 Upper middle income
#> 181   -15.1804    11.8037          Low income
#> 182    159.949   -9.42676 Lower middle income
#> 183   -61.8456    17.1175         High income
#> 184                               High income
#> 185    43.2418   -11.6986 Lower middle income
#> 186    55.4466    -4.6309         High income
#> 187   -61.7449    12.0653 Upper middle income
#> 188 -71.141389 21.4602778         High income
#> 189    168.321   -17.7404 Lower middle income
#> 190   -61.2653    13.2035 Upper middle income
#> 191   -62.7309       17.3         High income
#> 192   -171.752   -13.8314 Lower middle income
#> 193   -170.691   -14.2846 Upper middle income
#> 194     -61.39    15.2976 Upper middle income
#> 195     6.6071    0.20618 Lower middle income
#> 196   -175.216    -21.136 Upper middle income
#> 197    158.185    6.91771 Lower middle income
#> 198    171.135    7.11046 Upper middle income
#> 199    172.979    1.32905 Lower middle income
#> 200    134.479    7.34194 Upper middle income
#> 201 166.920867    -0.5477         High income
#> 202 179.089567 -8.6314877 Upper middle income
#>            lending
#> 1   Not classified
#> 2             IBRD
#> 3   Not classified
#> 4   Not classified
#> 5             IBRD
#> 6   Not classified
#> 7   Not classified
#> 8   Not classified
#> 9   Not classified
#> 10            IBRD
#> 11  Not classified
#> 12            IBRD
#> 13  Not classified
#> 14  Not classified
#> 15            IBRD
#> 16            IBRD
#> 17  Not classified
#> 18  Not classified
#> 19            IBRD
#> 20  Not classified
#> 21            IBRD
#> 22  Not classified
#> 23  Not classified
#> 24            IBRD
#> 25  Not classified
#> 26  Not classified
#> 27  Not classified
#> 28            IBRD
#> 29  Not classified
#> 30           Blend
#> 31            IBRD
#> 32  Not classified
#> 33            IBRD
#> 34             IDA
#> 35  Not classified
#> 36  Not classified
#> 37            IBRD
#> 38            IBRD
#> 39  Not classified
#> 40            IBRD
#> 41            IBRD
#> 42           Blend
#> 43            IBRD
#> 44            IBRD
#> 45  Not classified
#> 46            IBRD
#> 47  Not classified
#> 48  Not classified
#> 49            IBRD
#> 50  Not classified
#> 51            IBRD
#> 52            IBRD
#> 53            IBRD
#> 54  Not classified
#> 55  Not classified
#> 56            IBRD
#> 57            IBRD
#> 58  Not classified
#> 59  Not classified
#> 60             IDA
#> 61           Blend
#> 62  Not classified
#> 63            IBRD
#> 64            IBRD
#> 65            IBRD
#> 66  Not classified
#> 67            IBRD
#> 68  Not classified
#> 69            IBRD
#> 70             IDA
#> 71             IDA
#> 72             IDA
#> 73            IBRD
#> 74           Blend
#> 75            IBRD
#> 76            IBRD
#> 77  Not classified
#> 78            IBRD
#> 79             IDA
#> 80            IBRD
#> 81            IBRD
#> 82  Not classified
#> 83            IBRD
#> 84             IDA
#> 85            IBRD
#> 86            IBRD
#> 87           Blend
#> 88            IBRD
#> 89             IDA
#> 90            IBRD
#> 91            IBRD
#> 92            IBRD
#> 93  Not classified
#> 94  Not classified
#> 95  Not classified
#> 96             IDA
#> 97             IDA
#> 98  Not classified
#> 99            IBRD
#> 100            IDA
#> 101 Not classified
#> 102          Blend
#> 103            IDA
#> 104            IDA
#> 105          Blend
#> 106 Not classified
#> 107           IBRD
#> 108           IBRD
#> 109           IBRD
#> 110            IDA
#> 111            IDA
#> 112           IBRD
#> 113            IDA
#> 114            IDA
#> 115            IDA
#> 116           IBRD
#> 117           IBRD
#> 118 Not classified
#> 119           IBRD
#> 120 Not classified
#> 121            IDA
#> 122            IDA
#> 123            IDA
#> 124           IBRD
#> 125            IDA
#> 126           IBRD
#> 127            IDA
#> 128            IDA
#> 129            IDA
#> 130 Not classified
#> 131           IBRD
#> 132           IBRD
#> 133           IBRD
#> 134          Blend
#> 135            IDA
#> 136           IBRD
#> 137           IBRD
#> 138            IDA
#> 139 Not classified
#> 140 Not classified
#> 141           IBRD
#> 142            IDA
#> 143 Not classified
#> 144            IDA
#> 145            IDA
#> 146            IDA
#> 147            IDA
#> 148 Not classified
#> 149            IDA
#> 150            IDA
#> 151            IDA
#> 152 Not classified
#> 153 Not classified
#> 154 Not classified
#> 155 Not classified
#> 156 Not classified
#> 157           IBRD
#> 158            IDA
#> 159 Not classified
#> 160           IBRD
#> 161          Blend
#> 162            IDA
#> 163 Not classified
#> 164          Blend
#> 165            IDA
#> 166            IDA
#> 167 Not classified
#> 168 Not classified
#> 169 Not classified
#> 170           IBRD
#> 171            IDA
#> 172 Not classified
#> 173            IDA
#> 174            IDA
#> 175           IBRD
#> 176            IDA
#> 177          Blend
#> 178            IDA
#> 179 Not classified
#> 180          Blend
#> 181            IDA
#> 182            IDA
#> 183           IBRD
#> 184 Not classified
#> 185            IDA
#> 186           IBRD
#> 187          Blend
#> 188 Not classified
#> 189            IDA
#> 190          Blend
#> 191           IBRD
#> 192            IDA
#> 193 Not classified
#> 194          Blend
#> 195            IDA
#> 196            IDA
#> 197            IDA
#> 198            IDA
#> 199            IDA
#> 200           IBRD
#> 201           IBRD
#> 202            IDA
```

これは、グラフではありませんが、これも一つの視覚化とも考えられないことはありません。

上位７カ国は、United States, China, Japan, Germany, India, United Kingdom, France であることがわかりました。8番目は、Italy でここまでが、GDP が 2兆ドルを越している国となります。

#### Fig 3. 2021年時のGDP上位7カ国のGDP経年変化


```r
df_gdp %>% filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR")) %>%
  ggplot(aes(x = year, y = gdp, col = iso2c)) + geom_line()
#> Warning: Removed 10 rows containing missing values
#> (`geom_line()`).
```

![](03-first-example_files/figure-latex/unnamed-chunk-14-1.pdf)<!-- --> 

```         
df_gdp %>% filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR")) %>%
  ggplot(aes(x = year, y = gdp, col = iso2c)) + geom_line()
```

ここでは、最初に、`filter` を使って、7カ国のデータを選択しています。 そのときには、`%in%` として、国名を、combine するといういみで、`c()` とひとまとめにします。数字ではなく、文字なので、引用符で囲んでいます。この場合は、single quote でも構いませんが、半角を使ってください。

このグラフからは、どのようなことがわかりますか。気づいたことを書いてみましょう。

もう少し、このようなグラフをみてみたいというような、メモも大切です。

#### Fig 4. 世界のGDP における割合（１）


```r
df_gdp %>% 
  filter(region != "Aggregates") %>% drop_na(gdp) %>% 
  group_by(year) %>% mutate(gdp_ratio = gdp/sum(gdp)) %>% ungroup() %>%
  filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR"))  %>%
  ggplot(aes(x = year, y = gdp_ratio, fill = iso2c)) + geom_area() +
  geom_line(col = "black", position = "stack", linewidth = 0.3) + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))
```

![](03-first-example_files/figure-latex/unnamed-chunk-15-1.pdf)<!-- --> 

まず、下の部分が新しいですが、ここでは、年毎にグループにして、その上で、新しい `dgp_ratio` という名前の列を追加し、その gdp の値を、gdp 合計で割っています。すなわち、世界の、GDP における割合が計算されています。

```         
  group_by(year) %>% mutate(gdp_ratio = gdp/sum(gdp)) %>% ungroup() %>%
```

下の部分では、`geom_area` を使って、`fill=iso2c` により、`iso2c` ごとに、違う色を塗って、position = "stack" により、積み上げ型の、グラフを描き、境目がわかりやすいように、0.3 の太さの黒の線を描いてください。また、y 軸は、小数点以下を省いたパーセント表示に変えてください。というコードです。

```         
  ggplot(aes(x = year, y = gdp_ratio, fill = iso2c)) + geom_area() +
  geom_line(col = "black", position = "stack", linewidth = 0.3) + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))
```

#### Fig 4. 世界のGDP における割合（２）

これは、上から、iso2c の アルファベットの順番になっていますが、積み上げの順序を変更することもできます。


```r
df_gdp %>% 
  filter(region != "Aggregates") %>% drop_na(gdp) %>% 
  group_by(year) %>% mutate(gdp_ratio = gdp/sum(gdp)) %>% ungroup() %>%
  filter(iso2c %in% c("US", "CN", "JP", "DE", "IN", "GB", "FR"))  %>%
  mutate(iso2co = factor(iso2c, levels = c("IN", "CN", "FR", "GB", "DE", "JP", "US"))) %>%
  ggplot(aes(x = year, y = gdp_ratio, fill = iso2co)) + geom_area() +
  geom_line(col = "black", position = "stack", linewidth = 0.3) + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))
```

![](03-first-example_files/figure-latex/unnamed-chunk-16-1.pdf)<!-- --> 

これらは、世界全体の GPT における割合です。

どのようなことがわかりますか。

主要国で、60%〜70% を占めていることがわかります。それぞれの国や、幾つかの国の影響力も、ある程度みることができるように見えます。

気づいたこと、疑問に思ったことなどを、書き出してみてください。

GDP が大きな国と、小さな国があるのはわかりますが、それは、どのように分布しているのでしょうか。

#### Fig 5. 2021年の世界の国のGDPの分布（１）


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year == 2021) %>% filter(region != "Aggregates") %>%
  ggplot(aes(gdp)) + geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
```

![](03-first-example_files/figure-latex/unnamed-chunk-17-1.pdf)<!-- --> 

小さいところに集中していることがわかりますが、`scale_x_log10()` を加え、対数軸をとってみます。

$log10(1000) = 3$, $log10(1000000) = 6$, $log10(1000000000) = 9$ などになります。

#### Fig 6. 2021年の世界の国のGDPの分布（２）


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year == 2021) %>% filter(region != "Aggregates") %>%
  ggplot(aes(gdp)) + geom_histogram() + scale_x_log10()
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
```

![](03-first-example_files/figure-latex/unnamed-chunk-18-1.pdf)<!-- --> 

幅を変更したり、分ける個数を変更するには `binwidth = 0.5` や、`bins = 20` を、`geom_histogram()` のかっこの中に入れます。

#### Fig 7. 2021年の世界の国のGDPの分布（３）

また、密度曲線に変えるには、`geom_density` を使います。


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year == 2021) %>% filter(region != "Aggregates") %>%
  ggplot(aes(gdp)) + geom_density() + scale_x_log10()
```

![](03-first-example_files/figure-latex/unnamed-chunk-19-1.pdf)<!-- --> 

#### Fig 8. 2021年の世界の国のGDPの分布（４）

これは、2021年のデータですが、density の変化を見てみます。alpha の値は透明度です。


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year %in% c(1961, 1971, 1981, 1991, 2001, 2011, 2021)) %>%
  ggplot(aes(gdp, fill = factor(year))) + geom_density(alpha = 0.4) + scale_x_log10()
```

![](03-first-example_files/figure-latex/unnamed-chunk-20-1.pdf)<!-- --> 

#### Fig 9. 2021年の世界の国のGDPの分布（５）

少しみにくいので、分けてみます。


```r
df_gdp %>% drop_na(gdp) %>% 
  filter(year %in% c(1971, 1981, 1991, 2001, 2011, 2021)) %>%
  ggplot(aes(gdp, fill = factor(year))) + 
  geom_density() + scale_x_log10() + facet_wrap(~year)
```

![](03-first-example_files/figure-latex/unnamed-chunk-21-1.pdf)<!-- --> 

#### Fig 10. 地域ごとの GDP の分布

いくつかのグループごとに分布をみてみることも可能です。それには、Boxplot が有効です。


```r
df_gdp %>% drop_na(gdp) %>% filter(region != "Aggregates") %>%
  drop_na(region) %>% filter(year %in% c(2021)) %>%
  ggplot(aes(gdp, region, fill = region)) + 
  geom_boxplot() + scale_x_log10() + labs(y = "") + 
  theme(legend.position = "none")
```

![](03-first-example_files/figure-latex/unnamed-chunk-22-1.pdf)<!-- --> 

#### Fig 11. 収入の多寡による分類ごとの GDP 分布


```r
df_gdp %>% drop_na(gdp) %>% filter(region != "Aggregates") %>%
  drop_na(income) %>% filter(year %in% c(2021)) %>%
  mutate(level = factor(income, c("High income", "Upper middle income", "Lower middle income", "Low income"))) %>%
  ggplot(aes(gdp, level, fill = income)) + 
  geom_boxplot() + scale_x_log10() + labs(y = "") + 
  theme(legend.position = "none")
```

![](03-first-example_files/figure-latex/unnamed-chunk-23-1.pdf)<!-- --> 

これからも、いろいろなことがわかりますね。

#### 世界地図の準備

地図で、国の income level をみてみましょう。


```r
library(maps)
gdp_short <- df_gdp %>% filter(year == 2021, region != "Aggregates") %>%
  select(iso2c, gdp, income)
map_world <- map_data('world')
map_gdp <- map_world %>% 
  mutate(iso2c = iso.alpha(region, n=2)) %>% 
  left_join(gdp_short, by = "iso2c") 
head(map_gdp)
#>        long      lat group order region subregion iso2c
#> 1 -69.89912 12.45200     1     1  Aruba      <NA>    AW
#> 2 -69.89571 12.42300     1     2  Aruba      <NA>    AW
#> 3 -69.94219 12.43853     1     3  Aruba      <NA>    AW
#> 4 -70.00415 12.50049     1     4  Aruba      <NA>    AW
#> 5 -70.06612 12.54697     1     5  Aruba      <NA>    AW
#> 6 -70.05088 12.59707     1     6  Aruba      <NA>    AW
#>          gdp      income
#> 1 3126019385 High income
#> 2 3126019385 High income
#> 3 3126019385 High income
#> 4 3126019385 High income
#> 5 3126019385 High income
#> 6 3126019385 High income
```

#### Fig 12. Income Level による色分け地図


```r
map_gdp %>% mutate(income_level = factor(income, levels = c("High income", "Upper middle income", "Lower middle income", "Low income", "Not classified", NA))) %>%
  ggplot() +
  geom_map(aes(long, lat, map_id = region, fill = income_level), map = map_world, col = "black", size = 0.1) 
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2
#> 3.4.0.
#> i Please use `linewidth` instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where
#> this warning was generated.
#> Warning in geom_map(aes(long, lat, map_id = region, fill =
#> income_level), : Ignoring unknown aesthetics: x and y
```

![](03-first-example_files/figure-latex/unnamed-chunk-25-1.pdf)<!-- --> 

#### Fig 13. GDP による色分け地図


```r
map_gdp %>%
  ggplot() +
  geom_map(aes(x=long, y=lat, map_id = region, fill = gdp), map = map_world, col = "black", size = 0.1) 
#> Warning in geom_map(aes(x = long, y = lat, map_id = region,
#> fill = gdp), : Ignoring unknown aesthetics: x and y
```

![](03-first-example_files/figure-latex/unnamed-chunk-26-1.pdf)<!-- --> 

## 練習

1.  それぞれのグラフから、わかったこと、問いなどを列挙してみましょう。
2.  Fig 1 の　Japan の部分を他の国や、グループ（World など）に変えてみてください。何がわかりますか。
3.  Fig 3 の iso2c で選択する、国を変更してください。何がわかりますか。
4.  Fig 4 または Fig 5 の iso2c の部分を他の国に変更してください。何がわかりますか。
5.  Fig 5 または Fig 6 の、区間の幅や、数を 変更してみてください。何がわかりますか。
6.  Fig 7, Fig 8, Fig 9 の年を変更してみてください。何がわかりますか。
7.  Fig 12, Fig 13 の年を変更してみてください。何がわかりますか。

## プロジェクト

他のデータで、同様のことをしてみましょう。

1.  最初に、`gdp = "NY.GDP.MKTP.CD"` としましたが、GNI per capita, Atlas method (current US\$): NY.GNP.PCAP.CD に変えてみましょう。


```r
df_gnppcap <- WDI(country = "all", 
              indicator = c(gnppcap = "NY.GNP.PCAP.CD"), 
              extra = TRUE)
```

2.  [World Development Indicators](https://datatopics.worldbank.org/world-development-indicators/) のサイトの下にある、Data Themes（テーマ）から自分が調べたいテーマを選び、そのテーマから、データコードを取得して、同様の分析をしてみてください。データがあまりない場合もありますので、ある程度データが多いものを選択することをお勧めします。

## まとめ

今回は、経済指標である、GDP を使いました。データサイエンスについて少しずつ、学んでいきます。

コードの説明は、簡単にしかしていませんから、理解するのは難しいと思いますが、いくつかのことは、ご理解いただけると思います。

-   それほど、長くはない、コードで、データを見ていく。R は対話型（interactive）のプログラミング言語と言われています。

-   コードに続けて、結果が表示されるので、コードと出力の対応が見やすい。また、コメントや説明も併記することができる。これは、RMarkdown という形式の中で、コードを書いていることによるものです。RMarkdown は、再現性（reproducibility）と、プログラム・コードの内容をコンピュータにわかるようにでなく、人間にもわかるように記述する（Literate Programming）を実現しています。

-   視覚化（Visualization）によって、わかることが色々とある。また、視覚化の方法もたくさんあり、いろいろな見方をすることで、データについての理解が深まっていく。

-   視覚化を通して、データを理解すること、問いを持ち、他の視覚化などを用いて、さらに、理解を深めることがたいせつ。

-   理解したことを元にして、さらに、そのデータ、または、他のデータを使って、新たな発見をしていく。

統計的な指標も用いますが、それらによって、新しい知識を生み出すとも表現しますが、そのような営み全体が、データサイエンスの核をなす部分だと思います。
