#' Classify tRivia teams based on score
#'
#' @param res data frame containing at the colums: `timestamp`, `team`, `score`, and `round` returned by the score_trivia function
#'
#' @export
#'
#' @import cli
#' @importFrom emo medal
#' @importFrom stats aggregate

rank_teams <- function(res){

  # Colors for messages
  info <- combine_ansi_styles("darkorchid", "bold")
  note <- combine_ansi_styles("darkgreen")

  # Calculating sum of scores
  score <- aggregate(score ~ team, data = res, FUN = sum, na.rm = TRUE)

  # Adding timestamp ad included columns to help ranking
  score$timestamp = res$timestamp[res$round == max(res$round)]

  # Removing responses not included
  if (nrow(score) == 0) {stop("No team made to the final!")}

  # Ordering teams
  score$order <- -(score$score + 1)
  rank <- score[order(score$order, score$timestamp), ]


  # Checking for ties ----------------------------------------------------------

  # The earliest response wins
  rank$tie <- NA

  for (i in 1:nrow(rank)) {
    rank$tie[i] <- any(rank$score[i] == rank$score[-i])
  }

  first <- rank[1, ]
  second <- rank[2, ]
  third <- rank[3, ]

  res <- rank[, 1:3]

  # Announcing the winners -----------------------------------------------------

  message(info("Third place: ", third$team), note(" Score: ", third$score, " "), medal(3), ifelse(third$tie, "Tiebreaker by timestamp", ""))
  message(info("Second place: ", second$team), note(" Score: ", second$score, " "), medal(2), ifelse(second$tie, "Tiebreaker by timestamp", ""))
  message(info("First place: ", first$team), note(" Score: ", first$score, " "), medal(1), ifelse(first$tie, "Tiebreaker by timestamp", ""))


  return(res)

}
