# 視覚化の詳細　 {#visualize2}

::: {#gg2 .rmdcaution}
**描画の原理（Grammar of Graphics）**

`Ggplot2` は、描画の原理という理論に則って設計されています。

一つ一つが層（Layer）になっていって、それを定めていくことで、描画（グラフを描いていくこと）をするという設計思想になっています。

-   データ：Data

-   変数の対応：Aestics（絵を飾る要素）: Mapping

-   幾何的関数：Geom Functions

-   統計的処理方法：Stat Option

-   配置の選択：Position Option

-   座標の選択：Coordinate Function

-   尺度関数：Scale Function

-   テーマ関数：Theme Function

簡易的に表現すると、全体として次のようなコードになるというものです。すでに、実例をみてきましたから、おおまかなことは理解できるかと思います。このような設計思想を理解すると、コードを書く時にも、順に頭のなかで構成していくこともできるので、論理的に考えることができます。

ただ、あまり、理論にこだわるのは、ハードルを高くするだけだと思いますので、ここでは、設計思想の背景には、そんなものがあるのかぐらいに理解してくださればよいと思います。

```         
ggplot (data = <DATA> ) +
  <GEOM_FUNCTION> (mapping = aes( <MAPPINGS> ),　
    stat = <STAT> , position = <POSITION> ) + 
  <COORDINATE_FUNCTION> + 
  <FACET_FUNCTION> + 
  <SCALE_FUNCTION> + 
  <THEME_FUNCTION>
```

1.  最初にデータを指定します。パイプを使うことも可能です。

2.  幾何関数は一つに限る必要はありませんが、まず、変数の対応を `mapping = aes()` で、定義し、それに、統計処理が必要な時は、stat として加え、場所指定をする時には、position として加えます。

3.  座標系を指定します。

4.  座標軸の物差しを指定します。

5.  全体のテーマなどを最後に指定します。
:::

上記の原理の詳細について述べます。

## 視覚化逆引き事典
