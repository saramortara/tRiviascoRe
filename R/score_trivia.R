#' Calculate scores for a tRivia team based on a data.frame with correct answers
#'
#' @param data url or a data frame with the results of a multiple choice google form pool
#' @param n_round vector indicating the round of questions, if applies
#' @param score Numeric value indicating the score for questions at the round
#' @param ref Data frame containing two columns: 'question_name' and 'correct_answer'
#'
#' @export
#'
#' @importFrom lubridate dmy_hms
#' @importFrom rlang .data
#' @import dplyr
#' @importFrom readr read_csv
#' @importFrom magrittr %>%
#' @importFrom gsheet construct_download_url
#'
score_trivia <- function(data, n_round = NULL, score, ref){

  if (is.character(data)) data <- read_csv(construct_download_url(data))

  data <- data %>%
    mutate(timestamp = dmy_hms(data$`Carimbo de data/hora`),
           team_name = data$`FILL OUT THE NAME OF YOUR TEAM:`)

  # Checking if there's only one form per team
  ## if more than one, we'll pick the
  last_form <- data %>%
    group_by(.data$team_name) %>%
    summarise(last = max(.data$timestamp))

  # Filtering only the last form for each team
  data <- data %>%
    filter(.data$team_name %in% last_form$team_name & .data$timestamp %in% last_form$last)

  # Checking if answer matches responses ---------------------------------------

  #if (!is.null(n_round)) {
    ref_round <- ref %>%
      filter(.data$round == n_round) %>%
      select("question_name", "correct_answer")
  #}

  quest <- data[, ref_round$question_name]

  quest_res <- NULL

  for (i in 1:ncol(quest)) {

    x <- quest[, i]
    answer <- ref$correct_answer[ref$question_name %in% names(x)]
    val <- (x == answer) * score
    quest_res <- cbind(quest_res, val)

  }

  res <- data.frame(team = data$team_name, score = rowSums(quest_res))

  return(res)

}
