# 視覚化（Visualize） {#visualize}

## 準備


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
```

## 基本的なこと

### Importing data

Let us assign the `iris` data in the pre-installed package `datasets` to `df_iris`. You can give any name starting from an alphabet, though there are some rules. 


```r
df_iris <- datasets::iris
class(df_iris)
#> [1] "data.frame"
```

The class of data `iris` is `data.frame`, the basic data class of R. You can assign the same data as a `tibble`, the data class of `tidyverse` as follows.


```r
tbl_iris <- as_tibble(datasets::iris)
class(tbl_iris)
#> [1] "tbl_df"     "tbl"        "data.frame"
```

* `df_iris <- iris` can replace  `df_iris <- datasets::iris` because the package `datasets` is installed and attached as default. Since you may have other data called `iris` included in a different package or you may have changed `iris` before, it is safer to specify the package's name with the data's name.
* Within R Notebook or in Console, you may get different output, and `tf_iris` and `tbl_iris` behave differently. It is because of the default settings of R Markdown. 



### Look at the data

#### Several ways to view the data.

The `View` command opens up a window to show the contents of the data, and you can also use the filter.


```r
View(df_iris)
```


The following simple command also shows the data. 


```r
df_iris
```

```
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1           5.1         3.5          1.4         0.2
#> 2           4.9         3.0          1.4         0.2
#> 3           4.7         3.2          1.3         0.2
#> 4           4.6         3.1          1.5         0.2
#> 5           5.0         3.6          1.4         0.2
#> 6           5.4         3.9          1.7         0.4
#> 7           4.6         3.4          1.4         0.3
#> 8           5.0         3.4          1.5         0.2
#> 9           4.4         2.9          1.4         0.2
#> 10          4.9         3.1          1.5         0.1
#>    Species
#> 1   setosa
#> 2   setosa
#> 3   setosa
#> 4   setosa
#> 5   setosa
#> 6   setosa
#> 7   setosa
#> 8   setosa
#> 9   setosa
#> 10  setosa
```

`%>%` is called a pipe command, and we use it often. 

The output within R Notebook is a tibble style. Try the same command in Console.


```r
slice(df_iris, 1:10)
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1           5.1         3.5          1.4         0.2
#> 2           4.9         3.0          1.4         0.2
#> 3           4.7         3.2          1.3         0.2
#> 4           4.6         3.1          1.5         0.2
#> 5           5.0         3.6          1.4         0.2
#> 6           5.4         3.9          1.7         0.4
#> 7           4.6         3.4          1.4         0.3
#> 8           5.0         3.4          1.5         0.2
#> 9           4.4         2.9          1.4         0.2
#> 10          4.9         3.1          1.5         0.1
#>    Species
#> 1   setosa
#> 2   setosa
#> 3   setosa
#> 4   setosa
#> 5   setosa
#> 6   setosa
#> 7   setosa
#> 8   setosa
#> 9   setosa
#> 10  setosa
```


```r
1:10
#>  [1]  1  2  3  4  5  6  7  8  9 10
```




#### Data Structure

Let us look at the structure of the data. You can try `str(df_iris)` on Console or by adding a code chunk in R Notebook introducing later.


```r
glimpse(df_iris)
#> Rows: 150
#> Columns: 5
#> $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.…
#> $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.…
#> $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.…
#> $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.…
#> $ Species      <fct> setosa, setosa, setosa, setosa, setos…
```

There are six types of data in R; Double, Integer, Character, Logical, Raw, and Complex. In this course, we use only the first four.

The names after $ are column names. If you call `df_iris$Species`, you have the Species column. Species is in the 5th column, `typeof(df_iris[[5]])` does the same as the next. 

`df_iris[2,4] = `0.2 is the fourth entry of Sepal.Width.




```r
typeof(df_iris$Species)
#> [1] "integer"
```


```r
class(df_iris$Species)
#> [1] "factor"
```

For `factors = fct` see [the R Document](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/factor) or an explanation in [Factor in R: Categorical Variable & Continuous Variables](https://www.guru99.com/r-factor-categorical-continuous.html).




```r
typeof(df_iris$Sepal.Length)
#> [1] "double"
class(df_iris$Sepal.Length)
#> [1] "numeric"
```


**Q1.** What are the differences of `df_iris`, `slice(df_iris, 1:10)` and `glimpse(df_iris)` above?

**Q2.** What are the differences of`df_iris`, `slice(df_iris, 1:10)` and `glimpse(df_iris)` in the console?



#### Summary of the Data

The following is very convenient to get the summary information of a data.


```r
summary(df_iris)
#>   Sepal.Length    Sepal.Width     Petal.Length  
#>  Min.   :4.300   Min.   :2.000   Min.   :1.000  
#>  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600  
#>  Median :5.800   Median :3.000   Median :4.350  
#>  Mean   :5.843   Mean   :3.057   Mean   :3.758  
#>  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100  
#>  Max.   :7.900   Max.   :4.400   Max.   :6.900  
#>   Petal.Width          Species  
#>  Min.   :0.100   setosa    :50  
#>  1st Qu.:0.300   versicolor:50  
#>  Median :1.300   virginica :50  
#>  Mean   :1.199                  
#>  3rd Qu.:1.800                  
#>  Max.   :2.500
```

Minimum, 1st Quadrant (25%),  Median, Mean, 3rd Quadrant (75%), Maximum, and the count of each factor.



## 散布図（Scatter Plot）

We use `ggplot` to draw graphs. The scatter plot is a projection of data with two variables $x$ and $y$. 

```
ggplot(data = <data>, aes(x = <column name for x>, y = <column name for y>)) +
  geom_point()
```
```
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
```





```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()
```

<img src="26-visualize_files/figure-html/unnamed-chunk-9-1.png" width="672" />



### ラベル [Labels](https://ggplot2.tidyverse.org/reference/labs.html)

Add title and labels adding `labs()`. 

```
ggplot(data = <data>, aes(x = <column name for x>, y = <column name for y>)) +
  geom_point() +
  labs(title = "Title", x = "Label for x", y = "Label for y")
```



```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() + 
  labs(title = "Scatter Plot of Sepal Data of Iris", x = "Sepal Length", y = "Sepal Width")
```

<img src="26-visualize_files/figure-html/unnamed-chunk-10-1.png" width="672" />



### 色付き [Colors](https://ggplot2.tidyverse.org/reference/aes_colour_fill_alpha.html)

Add different colors automatically to each species. Can you see each group?


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()
```

<img src="26-visualize_files/figure-html/unnamed-chunk-11-1.png" width="672" />



### 形状


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width, shape = Species)) +
  geom_point()
```

<img src="26-visualize_files/figure-html/unnamed-chunk-12-1.png" width="672" />



## 箱ひげ図 [Boxplot](https://ggplot2.tidyverse.org/reference/geom_boxplot.html)

The boxplot compactly displays the distribution of a continuous variable. 


```r
ggplot(data = df_iris, aes(x = Species, y = Sepal.Length)) +
  geom_boxplot()
```

<img src="26-visualize_files/figure-html/unnamed-chunk-13-1.png" width="672" />



##　ヒストグラム [Histogram](https://ggplot2.tidyverse.org/reference/geom_histogram.html)

Visualize the distribution of a single continuous variable by dividing the x axis into bins and counting the number of observations in each bin. Histograms (geom_histogram()) display the counts with bars. 


```r
ggplot(data = df_iris, aes(x = Sepal.Length)) +
  geom_histogram()
```

<img src="26-visualize_files/figure-html/unnamed-chunk-14-1.png" width="672" />



Change the number of bins by `bins =` `<number>`.


```r
ggplot(data = df_iris, aes(x = Sepal.Length)) +
  geom_histogram(bins = 10)
```

<img src="26-visualize_files/figure-html/unnamed-chunk-15-1.png" width="672" />



## 線形モデル Data Modeling 

Professor Kaizoji will cover the mathematical models and hypothesis testings. 


```r
ggplot(data = df_iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```

<img src="26-visualize_files/figure-html/unnamed-chunk-16-1.png" width="672" />

## コメント

### 参考文献

* Cheat Sheet in RStudio: https://www.rstudio.com/resources/cheatsheets/  
  - [RStudio IED](https://raw.githubusercontent.com/rstudio/cheatsheets/main/rstudio-ide.pdf)
  - [Base R Cheat Sheet](https://github.com/rstudio/cheatsheets/raw/main/base-r.pdf)
* 'Quick R' by DataCamp: https://www.statmethods.net/management

* [An Introduction to R](https://cran.rstudio.com)



## 練習

### Posit Primers https://posit.cloud/learn/primers

1. The Basics -- [r4ds: Explore, I](https://r4ds.had.co.nz/explore-intro.html#explore-intro)
  - [Visualization Basics](https://rstudio.cloud/learn/primers/1.1)
  - [Programming Basics](https://rstudio.cloud/learn/primers/1.2)
