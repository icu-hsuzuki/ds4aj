# e-Stat 日本の政府統計 {#estat-site}

## 概要

* [e-Stat](https://www.e-stat.go.jp/)：政府統計の総合窓口 - 統計で見る日本
* [ダッシュボード](https://dashboard.e-stat.go.jp)：対話型形式でのデータの視覚化

## 日本政府統計

基本的なデータベースは、「[社会・人口統計体系](https://www.e-stat.go.jp/stat-search/database?page=1&layout=normal&toukei=00200502)」から見ることができます。一覧表示も可能ですが、まずは、リンクから階層形式で見ると、都道府県別データと、市町村別データに分かれています。また、それぞれが、基礎データと社会統計指標に分かれ、さらに、それぞれが、

## はじめての e-Stat with API

はじめて、R の `etatapi` を使って、e-Stat のデータを取得する方法を簡単に説明します。

### 初期設定 {-}

パッケージの、`estatapi` が、e-Stat のデータを取得するためのものです。`tidyverse` は基本的な解析をおこなうため、`showtext` と `showtext_auto()` は、グラフなどに、日本語が含まれる場合の文字化けを防ぐためのものです。

インストールされていないパッケージがありましたら、上のメニューの Tools > Install Packages から、インストールしてください。


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
library(showtext)
#> Loading required package: sysfonts
#> Loading required package: showtextdb
library(estatapi)
#> このサービスは、政府統計総合窓口(e-Stat)のAPI機能を使用していますが、サービスの内容は国によって保証されたものではありません。
showtext_auto()
```

### e-Stat 登録と、アプリケーションIDの取得

e-Stat API を利用するには、appId が必要です。

1. e-stat: https://www.e-stat.go.jp/ のページへ行く。
2. 右上の新規登録から、アカウント登録をします。
    - メールアドレスを入力し、そこに届いてリンクを開き、パスワードを設定。
    - パスワード設定は、Google などのアカウント連携ですることも可能です。
3. アカウントにログイン。上の帯に、メールアドレスが表示されます。
4. その右のマイページに行き、API機能（アプリケーションID発行）へ。まず、必要事項の入力が必要ですが、説明をみてください。
    - 名称：API機能を利用するアプリケーション名（システム名等）- R または、RStudio
    - URL：アプリケーションのURL（トップページ等のURL）
* If you do not use it on the public site, please enter "http: // test.localhost /" etc. - localhost でよいでしょう。
    - 概要：アプリケーション（システム）の概要 - estatapi とでも書いておけば良いでしょう。
    - 右の発行を押すと、appId が表示されます。これを記録。

<!-- ### 最初の例 -->

<!-- ``` -->
<!-- appId <- " " # 私のものは、英数40文字 -->
<!-- ``` -->

<!-- ```{r include=FALSE} -->
<!-- appId <- read_lines("./../../../_data/key/estatkey.txt") -->
<!-- ``` -->

<!-- 以下の形式でデータを取得する。appID は上で指定したもの。appId の場所を、実際のもので置き換えても良いが、人に見せるものではないので、appId として、置き換えておくのがよいだろう。 -->

<!-- 必要なのは、statsDataId で、すべてのデータにこの ID が振られているわけではない。データをしらべて、API の表示があるものは、それを開くと、途中に、 -->

<!-- `statsDataId=0003009189` -->

<!-- などの部分があるので、この10桁の番号をコピーして貼り付ける。8桁の「政府統計コード」ではないので、混乱しないこと。 -->

<!-- `statsDataId` 取得については、最後の「参考」に少し書いてあります。 -->

<!-- ダウンロードしたデータをあとで使うために名前を設定する。 -->

<!-- ``` -->
<!-- data0 <- estat_getStatsData(appId, statsDataId = "1234567890" -->
<!-- ) -->
<!-- data0 -->
<!-- ``` -->

<!-- メタ・データは、同じように、`estat_getMetaInfo` で得られる。 -->

<!-- ``` -->
<!-- data0m <- estat_getMetaInfo(appId, statsDataId = "1234567890") -->
<!-- data0m -->
<!-- ``` -->

<!-- #### 例1 社会・人口統計体系 -->

<!-- [社会・人口統計体系 / 都道府県データ / 基礎データ](https://www.e-stat.go.jp/stat-search/database?page=1&statdisp_id=0000010103) -->

<!-- ```{r cache = TRUE} -->
<!-- df1 <- estat_getStatsData(appId,statsDataId = "0000010103") -->
<!-- df1 -->
<!-- ``` -->
<!-- ```{r} -->
<!-- glimpse(df1) -->
<!-- ``` -->

<!-- ```{r cache = TRUE} -->
<!-- df1m <- estat_getMetaInfo(appId, statsDataId = "0000010103") -->
<!-- glimpse(df1m) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- df1m$tab -->
<!-- ``` -->

<!-- コード（cat01_code）によって、各データが分類されている。 -->

<!-- ```{r} -->
<!-- df1m$cat01 -->
<!-- ``` -->

<!-- ```{r} -->
<!-- df1m$area -->
<!-- ``` -->

<!-- ```{r} -->
<!-- df1m$time -->
<!-- ``` -->

<!-- ```{r} -->
<!-- df1m$.names -->
<!-- ``` -->

<!-- ```{r} -->
<!-- df1 %>% filter(cat01_code %in% c('C1101', 'C1102')) %>% -->
<!--   filter(地域 == "全国") %>% -->
<!--   ggplot(aes(調査年, value, color = cat01_code)) + geom_point() -->
<!-- ``` -->

<!-- 調査年が文字データなので、数値の連続データとして、折れ線グラフには描けません。一旦、数値データにして、それから、ラベルだけ書き換える必要があります。まず、数値データにするため、調査年の最初の四つの数字を取り出します。 -->

<!-- ```{r} -->
<!-- df1 %>% filter(cat01_code %in% c('C1101', 'C1102')) %>% -->
<!--   filter(地域 == "全国") %>% mutate(year = as.numeric(stringr::str_sub(調査年, 1L, 4L))) %>% -->
<!--   select(cat01_code, year, value) -->
<!-- ``` -->


<!-- ```{r} -->
<!-- df1 %>% filter(cat01_code %in% c('C1101', 'C1102')) %>% -->
<!--   filter(地域 == "全国") %>% mutate(year = as.numeric(stringr::str_sub(調査年, 1L, 4L))) %>%  -->
<!--   ggplot(aes(year, value, color = cat01_code)) + geom_line() + -->
<!--   labs(title = "C1101_県内総生産額（平成17年基準）, C1102_県内総生産額（産業）（平成17年基準）", x = "", y = "", color = "") + scale_x_continuous(breaks = seq(1975,2021,2), labels = paste0(seq(1975,2021,2),"年度")) -->
<!-- ``` -->

<!-- ### 例2　年齢別人口 -->


<!-- ```{r cache = TRUE} -->
<!-- df2 <- estat_getStatsData(appId, statsDataId = "0003448228") -->
<!-- df2 -->
<!-- ``` -->
<!-- ```{r cache = TRUE} -->
<!-- df2m <- estat_getMetaInfo(appId, statsDataId = "0003448228") -->
<!-- glimpse(df2m) -->
<!-- ``` -->

<!-- #### 人口：就業状態 -->

<!-- ```{r cache = TRUE} -->
<!-- df3 <- estat_getStatsData(appId, statsDataId = "0003009189") -->
<!-- df3 -->
<!-- ``` -->


<!-- ```{r cache = TRUE} -->
<!-- df3m <- estat_getMetaInfo(appId, statsDataId = "0003009189") -->
<!-- glimpse(df3m) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- df3m$cat02 -->
<!-- ``` -->

<!-- #### Population in English -->

<!-- ```{r cache = TRUE} -->
<!-- df3e <- estat_getStatsData(appId, statsDataId = "0003445078", lang = "E") -->
<!-- df3e -->
<!-- ``` -->

<!-- #### Data Search -->

<!-- ```{r} -->
<!-- estat_getStatsList(appId = appId, lang = "E", -->
<!--                    searchWord = "Population",  -->
<!--                    .use_label = FALSE) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- estat_getStatsList(appId = appId, lang = "E", -->
<!--                    searchWord = "Unemployed",  -->
<!--                    .use_label = FALSE) -->
<!-- ``` -->

<!-- ```{r cache = TRUE} -->
<!-- df4e <- estat_getStatsData(appId, statsDataId = "0003445099", lang = "E") -->
<!-- df4e -->
<!-- ``` -->


<!-- ```{r cache = TRUE} -->
<!-- estat_getStatsList(appId = appId, lang = "J", -->
<!--                    searchWord = "全国家計構造調査",  -->
<!--                    .use_label = FALSE) -->
<!-- ``` -->

<!-- ```{r cache = TRUE} -->
<!-- df5 <- estat_getStatsData(appId, statsDataId = "0003443384", lang = "J") -->
<!-- df5 -->
<!-- ``` -->

<!-- ```{r cache = TRUE} -->
<!-- df5m <- estat_getMetaInfo(appId, statsDataId = "0003443384") -->
<!-- glimpse(df5m) -->
<!-- ``` -->

<!-- #### 例：出生動向基本調査 -->

<!-- 出生動向基本調査、 -->
<!-- 人口問題基本調査、検索で表示されず。 -->

<!-- ```{r cache = TRUE} -->
<!-- estat_getStatsList(appId = appId, lang = "J", -->
<!--                    searchWord = "人口動態統計",  -->
<!--                    .use_label = FALSE) -->
<!-- ``` -->

<!-- ```{r cache = TRUE} -->
<!-- estat_getStatsList(appId = appId, lang = "J", -->
<!--                    searchWord = "出生率",  -->
<!--                    .use_label = FALSE) -->
<!-- ``` -->

<!-- ```{r cache = TRUE} -->
<!-- estat_getStatsList(appId = appId, lang = "J", -->
<!--                    searchWord = "出生率",  -->
<!--                    .use_label = FALSE) %>% -->
<!--   filter(stringr::str_detect(STATISTICS_NAME, "出生")) %>% -->
<!--   distinct(STATISTICS_NAME) %>% pull() -->
<!-- ``` -->

<!-- ### Using URL -->

<!-- API URL の構造を理解する。 -->

<!-- Rからe-Stat APIを使う: https://qiita.com/nozma/items/f88f5cc60ab63461deae -->

<!-- ```{r} -->
<!-- library(httr) -->
<!-- # アプリケーション ID を指定します。 -->
<!-- appid <- appId # "あなたのアプリケーション ID" -->

<!-- # 統計表 ID を指定します。 -->
<!-- statsDataId <- "0003445078" -->

<!-- # データを取得します。 -->
<!-- response <- GET(url = "http://api.e-stat.go.jp/rest/3.0/app/getSimpleStatsData", -->
<!--                  query = list(appId = appid, -->
<!--                               statsDataId = statsDataId, -->
<!--                               metaGetFlg = "Y", -->
<!--                               cntGetFlg = "N", -->
<!--                               explanationGetFlg = "Y", -->
<!--                               annotationGetFlg = "Y", -->
<!--                               sectionHeaderFlg = "1", -->
<!--                               replaceSpChars = "0")) -->
<!-- glimpse(response) -->
<!-- ``` -->



<!-- ## `estatapi` -->

<!-- * R Package `etatapi` home:  https://CRAN.R-project.org/package=estatapi -->
<!-- * Manual: https://cran.r-project.org/web/packages/estatapi/estatapi.pdf -->
<!-- * README: https://cran.r-project.org/web/packages/estatapi/readme/README.html -->
<!-- * GitHubPages: https://yutannihilation.github.io/estatapi/ -->
<!--   - GitHub: https://github.com/yutannihilation/estatapi/ -->

<!-- ### 基本事項 -->

<!-- [GitHubPages](https://yutannihilation.github.io/estatapi/) の内容をまずは、確認します。 -->

<!-- #### 統計表情報取得（`estat_getStatsList()`） -->

<!-- ``` -->
<!-- appId <- " " # 私のものは、英数 -->
<!-- ``` -->


<!-- ```{r include=FALSE} -->
<!-- appId <- read_lines("./../../../_data/key/estatkey.txt") -->
<!-- ``` -->
<!-- ```{r} -->
<!-- estat_getStatsList(appId = appId, searchWord = "チョコレート") -->
<!-- ``` -->

<!-- ここで、STAT_NAMEやGOV_ORGは人間が読みやすい形式のラベルになっていますが、 プログラム中で扱う場合はコードのままの方が都合がいいこともあります。そのときは.use_label = FALSEを指定してください。 -->

<!-- ```{r} -->
<!-- estat_getStatsList(appId = appId,  -->
<!--                    searchWord = "チョコレート",  -->
<!--                    .use_label = FALSE) -->
<!-- ``` -->

<!-- #### メタ情報取得（`estat_getMetaInfo()`） -->

<!-- 統計データのメタ情報を取得します。この関数は、結果をlistとして返します。listの各要素が、それぞれのデータ項目についてのメタ情報を含んだtbl_dfになっています。 -->

<!-- 例えば、0003103532というIDの統計に関するメタ情報を取得するには、statsDataIdという引数にIDを指定して、以下のようにします。 -->

<!-- ```{r} -->
<!-- meta_info <- estat_getMetaInfo(appId = appId, statsDataId = "0003103532") -->
<!-- names(meta_info) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- meta_info$cat01 -->
<!-- ``` -->

<!-- #### 統計データ取得（`estat_getStatsData()`） -->

<!-- ```{r} -->
<!-- estat_getStatsData( -->
<!--   appId = appId, -->
<!--   statsDataId = "0003103532", -->
<!--   cdCat01 = c("010800130","010800140") -->
<!-- ) -->
<!-- ``` -->

<!-- limitで取得する最大のレコード数を、startPositionで取得を始めるレコードの位置を指定することもできます。とりあえず少しだけ抜き出して見たい場合や、少しずつデータを取ってきたい場合にはこれらのパラメータが便利です。 -->

<!-- ```{r} -->
<!-- estat_getStatsData( -->
<!--   appId = appId, statsDataId = "0003103532", cdCat01 = c("010800130","010800140"), -->
<!--   limit = 3 -->
<!-- ) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- estat_getStatsData( -->
<!--   appId = appId, statsDataId = "0003103532", cdCat01 = c("010800130","010800140"), -->
<!--   startPosition = 101, -->
<!--   limit = 3 -->
<!-- ) -->
<!-- ``` -->

<!-- #### データカタログ情報取得（`estat_getDataCatalog()`） -->

<!-- 統計表ファイル（Excel、CSV、PDF）および統計データベースの情報を取得できます。 -->

<!-- このAPIはファイルのURLを返すだけなので、そのままRで処理することは難しいかもしれません。 -->


<!-- ```{r eval=FALSE} -->
<!-- catalog1 <- estat_getDataCatalog(appId = appId, searchWord = "チョコレート", dataType = c("PDF", "XLS")) -->
<!-- ``` -->


<!-- ```{r eval=FALSE} -->
<!-- catalog1[1, c("@id", "STAT_NAME", "TABLE_NAME", "SURVEY_DATE", "TABLE_SUB_CATEGORY1", "DATASET_NAME", "NAME", "LANDING_PAGE", "URL", "FORMAT")] %>% -->
<!--   glimpse -->
<!-- ``` -->

<!-- ### estatapiパッケージで簡単にe-Statのデータ取得 -->

<!-- 2016.5.27 更新の記事：https://qiita.com/kazutan/items/9c0b2dd0f055fde45cda -->

<!-- ```{r} -->
<!-- social_life_stat <- estat_getStatsList(appId = appId, searchWord = "社会生活基本調査") -->
<!-- ``` -->

<!-- ```{r} -->
<!-- glimpse(social_life_stat) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- stats_list_eg1 <- estat_getStatsList(appId = appId, searchWord = "", statsCode = "00450012") -->
<!-- ``` -->

<!-- ```{r} -->
<!-- glimpse(stats_list_eg1) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- meta_info <- estat_getMetaInfo(appId = appId, statsDataId = "0003066844") -->
<!-- names(meta_info) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- df1 <- estat_getStatsData( -->
<!--   appId = appId, -->
<!--   statsDataId = "0003066844", -->
<!--   cdCat01 = "002", -->
<!--   cdArea = "00000") -->
<!-- ``` -->

<!-- ```{r} -->
<!-- glimpse(df1) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- knitr::kable(head(df1,9)) -->
<!-- ``` -->

<!-- #### Rからestatapiパッケージを通してe-stat APIをつかう -->

<!-- Update: 2020.12.6 https://ronri-rukeichi.hatenablog.com/entry/2020/12/06/230445 -->

<!-- ```{r} -->
<!-- res1 <- estat_getStatsList(appId = appId, searchWord = "産業 AND 年齢", surveyYears = "199001-199512",statsCode= "00200" ,limit=100, statsField = "03") -->
<!-- ``` -->

<!-- ```{r} -->
<!-- glimpse(res1) -->
<!-- ``` -->

<!-- ##### meta data -->

<!-- ```{r} -->
<!-- meta1 <-  estat_getMetaInfo(appId,"0000140440" ) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- glimpse(meta1) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- dta1_f <- estat_getStatsData(appId ,"0000140440" ,cdCat02 = c("002")) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- glimpse(dta1_f) -->
<!-- ``` -->

<!-- ```{r eval=FALSE} -->
<!-- catalog1 <- estat_getDataCatalog(appId, searchWord = "チョコレート", dataType = c("CSV")) -->
<!-- ``` -->


<!-- #### Rからe-Statデータ取得 -->

<!-- ```{r} -->
<!-- estat_getStatsList(appId = appId,  -->
<!--                    searchWord = "", -->
<!--                    statsCode = "00200521") -->
<!-- ``` -->

<!-- 政府統計コード表：https://www.e-stat.go.jp/stat-search/database?page=1 -->

<!-- ### estatapi を用いた公的統計の利活用 -->
<!-- ~昼夜間人口に基づく発見地自殺死亡率の指標作成~ 久保田 貴文(多摩大学) -->

<!-- https://www.jstage.jst.go.jp/article/jscstaikai/33/0/33_93/_pdf/-char/ja -->

<!-- ### その無茶振り，（Rで）GISが解決します：フローデータ分析編（e-Stat使い倒しの巻） -->

<!-- Keisuke Takano: https://rpubs.com/k_takano/r_de_geonw_app -->

<!-- ##### 県外進学者データ -->

<!-- 学校基本調査の統計表の一覧を取得 -->
<!-- estatapiのestat_getStatsList関数を用いて，学校基本調査に該当する統計表の一覧を取得します．統計表の検索方法はいくつかありますが，今回は，政府統計コードを用いた検索を行います．政府統計コードの一覧はこちらのページにあります．学校基本統計調査のコードは「00400001」と書いてありますので，引数statsCodeに，こちらを指定します．引数appIdには先程入力したappIdを，searchWordはブランクを指定してください． -->

<!-- ```{r} -->
<!-- tbl_info_school <- estatapi::estat_getStatsList(appId=appId, -->
<!--                                                 statsCode="00400001", -->
<!--                                                 searchWord="") -->
<!-- ``` -->


<!-- ```{r} -->
<!-- tbl_info_school -->
<!-- ``` -->


<!-- ```{r} -->
<!-- glimpse(tbl_info_school) -->
<!-- ``` -->

<!-- 今回は例として，2010年の県外進学データを取得します．項目STATISTICS_NAMEに「平成２２年」「大学・大学院」，TITLEに「出身高校の所在地県別　入学者数」を含むデータがその候補になりますので，統計表情報からそちらを抽出します． -->

<!-- ```{r} -->
<!-- tbl_info_school_mig_2010 <- tbl_info_school %>% -->
<!--   dplyr::filter(grepl("平成２２年",STATISTICS_NAME)& -->
<!--                   grepl("大学・大学院",STATISTICS_NAME)& -->
<!--                   grepl("出身高校の所在地県別　入学者数",TITLE)) -->
<!-- tbl_info_school_mig_2010 -->
<!-- ``` -->

<!-- ```{r} -->
<!-- mig_2010 <- estatapi::estat_getStatsData(appId=appId, -->
<!--                                          statsDataId=tbl_info_school_mig_2010$`@id`) -->
<!-- head(mig_2010) -->
<!-- ``` -->

<!-- 「XX_1」となっている方が大学の所在地に関する変数，「XX_2」は出身高校の所在地に関する変数です．即ち，「XX_1」は着地側，「XX_2」は発地側の位置情報です．変数valueが，都道府県ペア間の県外進学数です．変数「設置者別9」には，大学の設置者及び性別を区別する変数です．都道府県コードに対応する変数は，大学の所在地についてのみ把握できます． -->
<!-- 　出身高校の所在地の変数「都道府県別2」について，その値を確認すると，「都道府県」が抜けていることがわかります． -->
<!-- 　 -->
<!-- ```{r} -->
<!-- unique(mig_2010$都道府県別2) -->
<!-- ``` -->
<!-- このままでは分析上扱いにくいので，変数「都道府県別2」に「都道府県」を補ったものを，新たな変数origin_nameとして追加します． -->

<!-- ```{r} -->
<!-- mig_2010_long <- mig_2010 %>% -->
<!--   dplyr::mutate(origin_name=case_when( -->
<!--     #「京都」「大阪」なら「府」を補う -->
<!--     都道府県別2%in%c("京都","大阪") ~ paste0(都道府県別2,"府"), -->
<!--     #「東京」なら「都」を補う -->
<!--     都道府県別2=="東京" ~ "東京都", -->
<!--     #「北海道」「その他」「計」なら何も補わない -->
<!--     都道府県別2%in%c("北海道","その他","計") ~ 都道府県別2, -->
<!--     #上に該当しなければ「県」を補う -->
<!--     TRUE ~ paste0(都道府県別2,"県") -->
<!--     )) -->
<!-- ``` -->

<!-- 着地側の変数「都道府県1」は特に何かを補う必要もなさそうなので，変数名をdestination_nameに変更し，そのままにしておきます．また，変数「設置者別9」を「founder」に変えた上で，発着地名が「その他」「計」「全国」に該当しないレコードのみ残します． -->

<!-- ```{r} -->
<!-- mig_2010_long <- mig_2010_long %>% -->
<!--   #着地側の変数の名前を変更 -->
<!--   dplyr::rename(destination_name=都道府県別1) %>% -->
<!--   #設置者を示す変数の名前を変更 -->
<!--   dplyr::rename(founder=設置者別9) %>% -->
<!--   #必要な変数のみ残す -->
<!--   dplyr::select(founder,origin_name,destination_name,value) %>% -->
<!--   #発着地名が「その他」「計」「全国」に該当しないレコードのみ残す -->
<!--   dplyr::filter(!(origin_name%in%c("その他","計","全国")| -->
<!--                     destination_name%in%c("その他","計","全国"))) -->
<!-- head(mig_2010_long) -->
<!-- ``` -->

<!-- 元データから，都道府県名と都道府県コードの対応表を作ります．都道府県名は変数「都道府県別1」をそのまま用いることができますが，都道府県コードは変数area_codeの先頭2文字を取り出す必要があります．それら変数を作成した上で，都道府県名・都道府県コードの2変数についてデータをユニークにします． -->

<!-- ```{r} -->
<!-- pref_code <- mig_2010 %>% -->
<!--   #必要な変数のみ残す -->
<!--   dplyr::select(都道府県別1,area_code) %>% -->
<!--   #都道府県名pref_nameの値は，都道府県別1の値そのまま -->
<!--   dplyr::mutate(pref_name=都道府県別1, -->
<!--                 #都道府県コードpref_codeの値はarea_codeの先頭2文字 -->
<!--                 pref_code=substr(x=area_code,start=1,stop=2)) %>% -->
<!--   #都道府県名・コードでユニーク化 -->
<!--   dplyr::distinct(pref_name,pref_code) -->
<!-- ``` -->

<!-- 都道府県名をキーに，発地・着地側に都道府県コードを結合します． -->

<!-- ```{r} -->
<!-- mig_2010_long <- mig_2010_long %>% -->
<!--   #発地側に都道府県コードを結合 -->
<!--   dplyr::left_join(y=pref_code,by=c("origin_name"="pref_name")) %>% -->
<!--   #都道府県コードの変数名を変更 -->
<!--   dplyr::rename(origin=pref_code) %>% -->
<!--   #着地側に都道府県コードを結合 -->
<!--   dplyr::left_join(y=pref_code,by=c("destination_name"="pref_name")) %>% -->
<!--   #都道府県コードの変数名を変更 -->
<!--   dplyr::rename(destination=pref_code) -->
<!-- ``` -->

<!-- 最後に，現状縦に並んでいる設立者・性別毎のデータを，横並びに変形します．前者はlong型，後者はwide型とも呼びます．変数founderを基準に，データをwide型へ変換する際は，tidyrのpivot_wider関数を用いて以下のように実行します．Wide型に変換しない変数を引数id_colsで，新たに作られる変数の名前に変数founderの値を用いることを引数names_fromで，wide型に変形される観測値は変数valueから来ることを引数values_fromで明示します． -->

<!-- ```{r} -->
<!-- mig_2010_wide <- mig_2010_long %>% -->
<!--   #Wide型に変換しない変数の指定 -->
<!--   tidyr::pivot_wider(id_cols=c(origin_name,destination_name,origin,destination), -->
<!--                      #新たな変数名の元になる値が入った変数 -->
<!--                      names_from=founder, -->
<!--                      #Wide型に変換される観測値が入った変数 -->
<!--                      values_from=value) -->
<!-- head(mig_2010_wide) -->
<!-- ``` -->

<!-- 変数名が日本語のままだと扱いづらいので，英語で変数名を付け直します．また，進学者総数から男子の進学者数を差し引いたものを，女子の進学者数として変数に追加します． -->

<!-- ```{r} -->
<!-- mig_2010_wide <- mig_2010_wide %>% -->
<!--   #変数名を付け直す -->
<!--   dplyr::rename(total=計, -->
<!--                 national=国立, -->
<!--                 private=私立, -->
<!--                 male=計のうち男) %>% -->
<!--   #女子の進学者数を計算 -->
<!--   dplyr::mutate(female=total-male) -->
<!-- ``` -->

<!-- 上で作成したデータは，発着地ペアについてフロー量が縦に並んでいる形式です．一方，よく見るOD表は，行方向に発地側の地名，列方向に着地側の地名が並んだ正方行列の形のものだと思います．以下では，発着地ペアのデータをOD表の形式に変形する方法を示します． -->
<!-- 　例として，進学者総数についてOD表を作成します．表の行方向には発地側都道府県名，列方向には着地側都道府県名が並ぶ形にします．この変形には ，上と同様pivot_wider関数が使えます．引数id_colsには行方向のラベルとなる発地側都道府県名origin_name，引数names_fromには変数名となる着地側都道府県名destination_name，引数values_fromには並べ替えられる進学者総数totalを指定します． -->
<!-- 　 -->
<!-- ```{r} -->
<!-- mig_2010_total_od <- mig_2010_wide %>% -->
<!--   #データをOD表の形式に変形 -->
<!--   tidyr::pivot_wider(id_cols=c(origin_name), -->
<!--                      names_from=destination_name, -->
<!--                      values_from=total) -->
<!-- head(mig_2010_total_od) -->
<!-- ``` -->

<!-- ##### 地域属性データ -->

<!-- 社会・人口統計体系の統計表の一覧を取得 -->

<!-- 今回重力モデルの説明変数として用いるデータは，社会・人口統計体系（統計でみる都道府県・市区町村のすがた）から取得します．社会・人口統計体系は，各地域の様々な社会・経済属性のうち基礎的なものを，都道府県・市区町村単位で集計したデータで，卒業論文等での利用頻度が高いもののひとつです．社会・人口統計体系は，社会・経済変数の生の値をまとめた基礎データと，それら変数を組み合わせて計算される各種指標をまとめた社会生活統計指標に分類されます． -->
<!-- 　まずは，社会・人口統計体系を政府統計コードの一覧から探します．コードは「00200502」ですので，学校基本調査の場合と同じく，estat_getStatsListを用いて統計表のリストを取得します． -->
<!-- 　 -->
<!-- ```{r} -->
<!-- #社会・人口統計体系の統計表の一覧 -->
<!-- tbl_info_si <- estatapi::estat_getStatsList(appId=appId, -->
<!--                                             statsCode="00200502", -->
<!--                                             searchWord="") -->
<!-- head(tbl_info_si) -->
<!-- ``` -->

<!-- 統計表のリストを，都道府県データ（項目COLLECT_AREAが「都道府県」を含む）のみに絞ります -->

<!-- ```{r} -->
<!-- tbl_info_si_pref <- tbl_info_si %>% -->
<!--   #項目COLLECT_AREAが「都道府県」を含むレコードに絞る -->
<!--   dplyr::filter(grepl("都道府県",COLLECT_AREA)) -->
<!-- head(tbl_info_si_pref) -->
<!-- ``` -->

<!-- ##### 基礎データ・社会生活統計指標から必要な統計表をダウンロード -->

<!-- 今回の分析では，基礎データ・社会生活統計指標のそれぞれから，以下の変数を用います． -->

<!-- 基礎データ -->
<!-- C121101：1人当たり県民所得 -->
<!-- 社会生活統計指標 -->
<!-- #E0610202：大学収容力指数 -->
<!-- #E09504：大卒者割合 -->
<!-- 1人当たり県民所得については，項目STATISTICS_NAMEに「基礎データ」，TITLEに「Ｃ」を含む統計表に含まれます．それ以外の変数は，項目STATISTICS_NAMEに「社会生活統計指標」，TITLEに「Ｅ」を含む統計表がその候補になりますので，統計表情報からそちらを抽出します． -->

<!-- ```{r} -->
<!-- tbl_info_si_pref_vars <- tbl_info_si_pref %>% -->
<!--   #項目STATISTICS_NAMEに「基礎データ」，TITLEに「Ｃ」を含む，もしくは -->
<!--   dplyr::filter((grepl("基礎データ",STATISTICS_NAME)&grepl("Ｃ",TITLE))| -->
<!--                   #項目STATISTICS_NAMEに「社会生活統計指標」，TITLEに「Ｅ」を含む -->
<!--                   (grepl("社会生活統計指標",STATISTICS_NAME)&grepl("Ｅ",TITLE))) -->
<!-- ``` -->

<!-- 基礎データCの統計表IDは「0000010103」，社会生活統計指標Eの統計表IDは「0000010205」ですので，それぞれestat_getStatsData関数で統計表を取得します． -->

<!-- ```{r} -->
<!-- #基礎データCの統計表を取得 -->
<!-- kiso_c <- estatapi::estat_getStatsData(appId=appId, -->
<!--                                        statsDataId="0000010103") -->
<!-- #社会生活統計指標Eの統計表を取得 -->
<!-- sihyo_e <- estatapi::estat_getStatsData(appId=appId, -->
<!--                                         statsDataId="0000010205") -->
<!-- ``` -->

<!-- 取得された各統計表から，必要なレコードのみを残します．具体的には，統計コードcat01_codeが上で挙げた変数コードに一致し，かつ調査年が「2010年度」に一致するもののみを残します．その上で，それらを行方向に結合します． -->

<!-- ```{r} -->
<!-- kiso_c_vars <- kiso_c %>% -->
<!--   #1人当たり県民所得 -->
<!--   dplyr::filter(cat01_code=="C121101") %>% -->
<!--   #2010年度の観測値 -->
<!--   dplyr::filter(調査年=="2010年度") %>% -->
<!--   #不要な変数を削除 -->
<!--   dplyr::select(-`Ｃ　経済基盤`) -->
<!-- sihyo_e_vars <- sihyo_e %>% -->
<!--   #大学収容力指数 -->
<!--   dplyr::filter(cat01_code=="#E0610202"| -->
<!--                   cat01_code=="#E09504") %>% -->
<!--   #2010年度の観測値 -->
<!--   dplyr::filter(調査年=="2010年度") %>% -->
<!--   #不要な変数を削除 -->
<!--   dplyr::select(-`Ｅ　教育`) -->
<!-- #データを行方向に結合 -->
<!-- vars <- rbind(kiso_c_vars,sihyo_e_vars) -->
<!-- ``` -->

<!-- データを変数毎にwide型に変形します．前もって必要な変数のみ残し，変数area_codeの先頭2文字から都道府県コードを新たな変数として作成します．また，変数コードcat01_codeに基づいて，変形後の変数名を与える変数varnamを作成します．その上で，データをlong型からwide型に変形します． -->

<!-- ```{r} -->
<!-- vars <- vars %>% -->
<!--   #都道府県コード変数を追加 -->
<!--   dplyr::mutate(pref_code=substr(x=area_code,start=1,stop=2)) %>% -->
<!--   #必要な変数のみ残す -->
<!--   dplyr::select(cat01_code,pref_code,地域,value) %>% -->
<!--   #変数名を変更 -->
<!--   dplyr::rename(pref_name=地域) %>% -->
<!--   #変数コードに応じた変数を作成 -->
<!--   dplyr::mutate(varnam=dplyr::case_when( -->
<!--     cat01_code=="C121101" ~ "income", -->
<!--     cat01_code=="#E0610202" ~ "acom_univ", -->
<!--     cat01_code=="#E09504" ~ "univ_rate" -->
<!--   )) -->
<!-- vars_wide <- vars %>% -->
<!--   #データをlong型からwide型に変形 -->
<!--   tidyr::pivot_wider(id_cols=c(pref_code,pref_name), -->
<!--                      names_from=varnam, -->
<!--                      values_from=value) -->
<!-- head(vars_wide) -->
<!-- ``` -->

<!-- データを結合し，書き出します． -->

<!-- ##### 都道府県庁ポイント -->

<!-- 取得元：国土数値情報　国・都道府県の機関データ -->

<!-- ```{r} -->
<!-- #Shapefileを読み込み -->
<!-- pref_office <- sf::read_sf(dsn="P28-13.shp") %>% -->
<!--   #変数P28_003が「12001」（都道府県庁舎）のレコードのみ残す -->
<!--   dplyr::filter(P28_003=="12001") %>% -->
<!--   #都道府県コードの変数を作成 -->
<!--   dplyr::mutate(pref_code=substr(P28_001,1,2)) %>% -->
<!--   #都道府県コードの変数だけ残す -->
<!--   dplyr::select(pref_code) %>% -->
<!--   #都道府県コードでソート -->
<!--   dplyr::arrange(pref_code) %>% -->
<!--   #WGS84/UTM54Nに投影変換 -->
<!--   sf::st_transform(crs=sf::st_crs(32654)) -->
<!-- #GeoJSON形式で書き出し -->
<!-- sf::write_sf(obj=pref_office, -->
<!--              dsn="./data/pref_office.geojson", -->
<!--              delete_dsn=TRUE) -->
<!-- ``` -->

<!-- 都道府県ポリゴン -->

<!-- https://rpubs.com/k_takano/r_de_geonw_app -->

<!-- ```{r} -->
<!-- #都道府県ポリゴンを読み込み -->
<!-- pref_poly <- geojsonio::geojson_sf(x="jp_pref.c.topojson") %>% -->
<!--   #不整地物を補正 -->
<!--   sf::st_make_valid() %>% -->
<!--   #WGS84/UTM54Nに投影変換 -->
<!--   sf::st_transform(crs=sf::st_crs(32654)) -->
<!-- #GeoJSON形式で書き出し -->
<!-- sf::write_sf(obj=pref_poly, -->
<!--              dsn="./data/pref_poly.geojson", -->
<!--              delete_dsn=TRUE) -->
<!-- ``` -->

<!-- ##### 国土数値情報ダウンロードサイト -->

<!-- https://nlftp.mlit.go.jp/ksj/index.html -->

<!-- #### Other Sites -->

<!-- * Rで解析：政府統計の総合窓口(e-Stat)データ取得に便利です！「estatapi」パッケージ -->
<!--   - https://www.karada-good.net/analyticsr/r-457/ -->

<!-- * 地図：https://qiita.com/Ringa_hyj/items/0fc8a00ba4b7213cb51e -->

<!-- ```{r} -->
<!-- library(maps) -->
<!-- library(mapdata) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- map('japan') -->
<!-- ``` -->

<!-- ```{r} -->
<!-- map('japan') -->
<!-- map.axes() -->
<!-- ``` -->
<!-- ```{r} -->
<!-- map("japan", interior = FALSE) -->
<!-- map("japan", boundary = FALSE, lty = 2, add = TRUE) -->
<!-- ``` -->


<!-- mapdata: extra map data for a few regions -->


<!-- ```{r} -->
<!-- map("china", interior = FALSE) -->
<!-- #map("china", boundary = FALSE, lty = 2, add = TRUE) -->
<!-- ``` -->

<!-- #### Examples -->

<!-- ```{r cache = TRUE} -->
<!-- estat_getStatsList(appId = appId, searchWord = "労働力") -->
<!-- ``` -->


<!-- ```{r cache = TRUE} -->
<!-- estat_getStatsList(appId = appId, searchWord = "労働力", .use_label = FALSE) -->
<!-- ``` -->

<!-- ```{r cache = TRUE} -->
<!-- estat_getStatsData(appId=appId, statsDataId="0003177000") -->
<!-- ``` -->

<!-- ```{r cache = TRUE} -->
<!-- estat_getMetaInfo(appId = appId, statsDataId = "0003177000")　%>% names() -->
<!-- ``` -->


<!-- ## 参考 References -->

<!-- * e-Stat API 機能：https://www.e-stat.go.jp/api/ -->
<!--   - これをもとに、`estatapi` は作成されている。 -->
<!-- * API 提供データ：https://www.e-stat.go.jp/stat-search/database?page=1 -->
<!--   - リストの最初にあるものが、8桁の「政府統計コード」です。しかし、これは、データコードではないので、ここから分類の末端に行って、API と表示されたところから、`statsDataId` を得ます。 -->
<!-- * 基礎データについて：https://www.stat.go.jp/data/ssds/1.html -->
<!-- * 基礎データ：https://www.stat.go.jp/data/ssds/2.html -->
<!--   - 基礎データ項目一覧:都道府県別・市区町村別 -->
<!--   - 社会生活統計指標項目一覧:[都道府県別](https://www.e-stat.go.jp/stat-search/database?page=1&layout=datalist&toukei=00200502&tstat=000001111375&cycle=8&tclass1=000001111378&tclass2val=0)・[市区町村別](https://www.e-stat.go.jp/stat-search/database?page=1&layout=datalist&toukei=00200502&tstat=000001111376&cycle=8&tclass1=000001111381&tclass2val=0) -->

<!-- * Rからe-Stat APIを使う: https://qiita.com/nozma/items/f88f5cc60ab63461deae -->