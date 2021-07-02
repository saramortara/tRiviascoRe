
# **tRiviascoRe**: a package to score teams during the useR2021 tRivia event

To install and load the package use:

``` r
remotes::install_github("saramortara/tRiviascoRe")
library(tRiviascoRe)
```

    ## Loading tRiviascoRe

``` r
library(tidyr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)
library(gsheet)
```

## What do you need?

1.  A Google form with multiple choice questions. All questions must
    have unique names

2.  A reference data frame with two or three columns: `question_name`,
    `correct_answer` and `round` (optional)

3.  The answers from the google form

## Example

Provide a path to spreadsheet that is the output of a google form

``` r
# Path to the google form
data <- "https://docs.google.com/spreadsheets/d/1yDHG41aGnb2hEUEKo6gmsoeWIBaQuv6uf-tDE0J4XbI/edit?usp=sharing"
data <- read_csv(construct_download_url(data))
```

    ## Warning: Duplicated column names deduplicated: 'What is the name of this actor?'
    ## => 'What is the name of this actor?_1' [4], 'What is the name of this actor?'
    ## => 'What is the name of this actor?_2' [5], 'What is the name of this actor?' =>
    ## 'What is the name of this actor?_3' [6]

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   `Carimbo de data/hora` = col_character(),
    ##   `FILL OUT THE NAME OF YOUR TEAM:` = col_character(),
    ##   `What is the name of this actor?` = col_character(),
    ##   `What is the name of this actor?_1` = col_character(),
    ##   `What is the name of this actor?_2` = col_character(),
    ##   `What is the name of this actor?_3` = col_character()
    ## )

``` r
# Vector of scores for each round
score = c(2, 3, 4, 10)
```

Provide a reference template with the answers

``` r
# Correct answers
ref <- data.frame(question_name = names(select(data, starts_with("What"))),
                  correct_answer = c("George Clooney", 
                                     "Marlon Brando", 
                                     "Al Pacino", 
                                     "Robert De Niro"),
                  round = c(1, 2, 3, 3))
```

Running the function to get the score for each team

``` r
score_list <- list()

for (j in unique(ref$round)) {
  ref_round <- filter(ref, round == j)
  n_round <- j
  score_val <- score[n_round]
  score_list[[j]] <- score_trivia(data, n_round, score_val, ref)
  
}

score_list
```

    ## [[1]]
    ##                   team score
    ## 1 ZOOM BREAKOUT ROOM 1     0
    ## 2 ZOOM BREAKOUT ROOM 2     0
    ## 3 ZOOM BREAKOUT ROOM 3     2
    ## 
    ## [[2]]
    ##                   team score
    ## 1 ZOOM BREAKOUT ROOM 1     3
    ## 2 ZOOM BREAKOUT ROOM 2     3
    ## 3 ZOOM BREAKOUT ROOM 3     0
    ## 
    ## [[3]]
    ##                   team score
    ## 1 ZOOM BREAKOUT ROOM 1     4
    ## 2 ZOOM BREAKOUT ROOM 2     0
    ## 3 ZOOM BREAKOUT ROOM 3     0
