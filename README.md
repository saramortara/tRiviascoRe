
# **tRiviascoRe**: a package to score teams during the useR2021 tRivia event

To install and load the package use:

``` r
remotes::install_github("saramortara/tRiviascoRe")
library(tRiviascoRe)
```

``` r
library(tidyr)
library(dplyr)
library(readr)
library(gsheet)
```

## What do you need?

1.  A Google form with multiple choice questions. All questions must
    have unique names

2.  A reference data frame with two or three columns: `question_name`,
    `correct_answer` and `round` (optional)

3.  The answers from the google
form

## How we run the code

#### Reference table

``` r
ref_url <- "https://docs.google.com/spreadsheets/d/1uCPz4XFWUGd20-fVgXjIo59eWp31AREzTlXCuEN8Vn0/edit#gid=0"
ref <- read_csv(construct_download_url(ref_url))
```

    ## Warning: Duplicated column names deduplicated: 'round' => 'round_1' [10]

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   round = col_double(),
    ##   theme = col_character(),
    ##   question_name = col_character(),
    ##   question = col_character(),
    ##   correct_answer = col_character(),
    ##   wrong_answer_1 = col_character(),
    ##   wrong_answer_2 = col_character(),
    ##   wrong_answer_3 = col_character(),
    ##   Source = col_character(),
    ##   round_1 = col_double()
    ## )

``` r
# Score points vector
score <- c(2, 3, 5, 10)
```

### Round 1

``` r
url1 <- "https://docs.google.com/spreadsheets/d/1JqthtHHCFat1NdUUzM-9kyS-Vi789GFHywPu0eJ_5UE/edit#gid=1753062260"

r1 <- read_csv(construct_download_url(url1))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   `Carimbo de data/hora` = col_character(),
    ##   `What is your TEAM NAME? (Mandatory question! Choose the name of the Zoom Breakout Room your team was put into)` = col_character(),
    ##   `1.1. In what country was Hadley Wickham born?` = col_character(),
    ##   `1.2. What is the name of this R Studio package?` = col_character(),
    ##   `1.3. Who is the editor-in-chief of the R Journal?` = col_character(),
    ##   `1.4. What packages are used as examples on chapter 3 (Data Visualization) of the R4DS book?` = col_character(),
    ##   `1.5. Where will the rstudio::conf take place in 2022?` = col_character()
    ## )

``` r
res1 <- score_trivia(r1, n_round = 1, score = score[1], ref)

res1
```

    ##             timestamp               team score round
    ## 1 2021-07-09 12:28:41         dplyr Room     8     1
    ## 2 2021-07-09 12:29:23 flexdashboard Room    10     1
    ## 3 2021-07-09 12:29:39      devtools Room    10     1
    ## 4 2021-07-09 12:29:44       ggplot2 Room     8     1
    ## 5 2021-07-09 12:29:50      blogdown Room    10     1
    ## 6 2021-07-09 12:29:56       janitor Room     6     1
    ## 7 2021-07-09 12:33:14         knitr Room     6     1

### Round 2

``` r
url2 <- "https://docs.google.com/spreadsheets/d/1H3V2DpZHbtY-TtOmyTVLWJXUEiPgMVdDisJGTQ2deB4/edit#gid=464947112"

r2 <- read_csv(construct_download_url(url2))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   `Carimbo de data/hora` = col_character(),
    ##   `What is your TEAM NAME? (Mandatory question! Choose the name of the Zoom Breakout Room your team was put into)` = col_character(),
    ##   `2.1. What's the name of this R Studio package?` = col_character(),
    ##   `2.2. The names of R releases are references from whatcartoon?` = col_character(),
    ##   `2.3. How many CRAN Task Views are currently avaiable?` = col_double(),
    ##   `2.4. How many chapters are there in the R4DS book (first edition)?` = col_double(),
    ##   `2.5. What is Hadley Wickham's personal website?` = col_character(),
    ##   `2.6. How long is the exam to become a certified RStudio trainer?` = col_character(),
    ##   `2.7. And what is the name of this R Studio package?` = col_character(),
    ##   `2.8. How many initiatives are listed on the #BlackLivesMatter support page on the Rstudio website?` = col_double(),
    ##   `2.9. What color is not in Hadley Wickham's Wikipedia photo shirt?` = col_character(),
    ##   `2.10. How many people attended the 2020 rstudio::conf?` = col_double()
    ## )

``` r
res2 <- score_trivia(r2, n_round = 2, score = score[2], ref)

res2
```

    ##             timestamp               team score round
    ## 1 2021-07-09 12:38:59 flexdashboard Room    30     2
    ## 2 2021-07-09 12:39:09         dplyr Room    27     2
    ## 3 2021-07-09 12:39:27       janitor Room    18     2
    ## 4 2021-07-09 12:39:32       ggplot2 Room    27     2
    ## 5 2021-07-09 12:39:40      devtools Room    27     2
    ## 6 2021-07-09 12:39:44      blogdown Room    12     2

### Round 3

``` r
url3 <- "https://docs.google.com/spreadsheets/d/1blvK5r3WGHQbatNeqFt3H0nIVXPXYpaS_CYY6IiMRsU/edit?usp=sharing"

r3 <- read_csv(construct_download_url(url3))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   `Carimbo de data/hora` = col_character(),
    ##   `What is your TEAM NAME? (Mandatory question! Choose the name of the Zoom Breakout Room your team was put into)` = col_character(),
    ##   `3.1. What is the name of this R Studio package?` = col_character(),
    ##   `3.2. Which of the following is a base package for R language?` = col_character(),
    ##   `3.3. In what year was R-1.0.0 released?` = col_double(),
    ##   `3.4. How many bread and loaf recipes are there in Hadley's family recipes website?` = col_double(),
    ##   `3.5. According to RStudio, who translated cheatsheets into Uzbek?` = col_character(),
    ##   `3.6. What is the annual membership fee for a person to become a supporting member of the R foundation?` = col_character(),
    ##   `3.7. How many pages long is the PDF version of the CRAN Repository Policy?` = col_double(),
    ##   `3.8. How many of the 38 members of the R Foundation are women?` = col_double(),
    ##   `3.9. What is the animal on the cover of the R4DS book (edited by O'Reilly)?` = col_character(),
    ##   `3.10. In what year was the current R logo registered?` = col_double(),
    ##   `3.11. What is the name of this R Studio package?` = col_character(),
    ##   `3.12. Who is NOT wearing a hat on their RStudio Team profile page picture?` = col_character(),
    ##   `3.13. In ggplot2, what is the point shape from the code 24?` = col_character(),
    ##   `3.14. In what year was Hadley Wickham born?` = col_double(),
    ##   `3.15. What is the name of this R Studio package?` = col_character()
    ## )

``` r
res3 <- score_trivia(r3, n_round = 3, score = score[3], ref)

res3
```

    ##             timestamp               team score round
    ## 1 2021-07-09 12:49:29         knitr Room    25     3
    ## 2 2021-07-09 12:50:20       ggplot2 Room    55     3
    ## 3 2021-07-09 12:50:22       janitor Room    45     3
    ## 4 2021-07-09 12:50:23 flexdashboard Room    70     3
    ## 5 2021-07-09 12:50:23         dplyr Room    50     3
    ## 6 2021-07-09 12:50:44      devtools Room    55     3
    ## 7 2021-07-09 12:50:51      blogdown Room    55     3

### Round 4

``` r
url4 <- "https://docs.google.com/spreadsheets/d/1FavTAbTzBqDXnBJTIjeKMY8bhLzUF8Kx9NSIgMczCuI/edit?usp=sharing"

r4 <- read_csv(construct_download_url(url4))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   .default = col_character(),
    ##   `4.2. How many CRAN packages were published in its first three years?` = col_double(),
    ##   `4.17. How many women have won the Nobel Prize in Physics?` = col_double(),
    ##   `4.18 How many people have won the Nobel Prize in Physics?` = col_double()
    ## )
    ## ℹ Use `spec()` for the full column specifications.

``` r
res4 <- score_trivia(r4, n_round = 4, score = score[4], ref)

res4
```

    ##             timestamp               team score round
    ## 1 2021-07-09 12:59:34         dplyr Room   100     4
    ## 2 2021-07-09 13:00:04         knitr Room   120     4
    ## 3 2021-07-09 13:00:05 flexdashboard Room   160     4
    ## 4 2021-07-09 13:00:06       janitor Room   130     4
    ## 5 2021-07-09 13:00:09      devtools Room   140     4
    ## 6 2021-07-09 13:00:11      blogdown Room   160     4
    ## 7 2021-07-09 13:00:15       ggplot2 Room   160     4

### Final Score ——————————————————————

``` r
score_list <- list(res1, res2, res3, res4)

res <- bind_rows(score_list)

rank_teams(res)
```

    ## Third place: blogdown Room Score: 237 🥉

    ## Second place: ggplot2 Room Score: 250 🥈

    ## First place: flexdashboard Room Score: 270 🥇

    ##                 team score           timestamp
    ## 4 flexdashboard Room   270 2021-07-09 13:00:06
    ## 5       ggplot2 Room   250 2021-07-09 13:00:09
    ## 1      blogdown Room   237 2021-07-09 12:59:34
    ## 2      devtools Room   232 2021-07-09 13:00:04
    ## 6       janitor Room   199 2021-07-09 13:00:11
    ## 3         dplyr Room   185 2021-07-09 13:00:05
    ## 7         knitr Room   151 2021-07-09 13:00:15
