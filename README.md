
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

``` r
# Vector of scores for each round
score <- c(2, 3, 4, 10)
```

Provide a reference template with the answers

``` r
# Correct answers
ref <- data.frame(question_name = names(select(data, starts_with("What"))[-1]),
                  correct_answer = c("Robert De Niro", 
                                     "Marlon Brando", 
                                     "George Clooney", 
                                     "Al Pacino"),
                  round = c(1, 2, 3, 3))
```

Running the function to get the score for each team

``` r
score_list <- list()

for (j in unique(ref$round)) {
  ref_round <- filter(ref, round == j)
  n_round <- j
  score_val <- score[n_round]
  score_list[[j]] <- score_trivia(data, n_round, score_val, ref_round)
  
}

  score_list
```

    ## [[1]]
    ##             timestamp            team score round
    ## 1 02/07/2021 13:13:33 Carol the Great     2     1
    ## 2 02/07/2021 13:13:47          Room 1     2     1
    ## 3 02/07/2021 13:15:42       supeRuseR     0     1
    ## 
    ## [[2]]
    ##             timestamp            team score round
    ## 1 02/07/2021 13:13:33 Carol the Great     3     2
    ## 2 02/07/2021 13:13:47          Room 1     3     2
    ## 3 02/07/2021 13:15:42       supeRuseR     0     2
    ## 
    ## [[3]]
    ##             timestamp            team score round
    ## 1 02/07/2021 13:13:33 Carol the Great     8     3
    ## 2 02/07/2021 13:13:47          Room 1     8     3
    ## 3 02/07/2021 13:15:42       supeRuseR     0     3

Binding the list into a single data frame

``` r
res <- bind_rows(score_list, .id = "round")
```

Getting the final score:

``` r
rank_teams(res)
```

    ## Third place: supeRuseR Score: 0 🥉

    ## Second place: Room 1 Score: 13 🥈Tiebreaker by timestamp

    ## First place: Carol the Great Score: 13 🥇Tiebreaker by timestamp
