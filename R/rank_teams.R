#' Classify tRivia teams based on score
#'
#' @param res data frame containing at least two colums: `team`, `score` and `round` (optional)
#'
#' @export
#'
#' @import cli
#' @importFrom emo medal
#' @importFrom stats aggregate

rank_teams <- function(res){

  info <- combine_ansi_styles("darkorchid", "bold")
  note <- combine_ansi_styles("darkgreen")

  score <- aggregate(score ~ team, data = res, FUN = sum, na.rm = TRUE)

  rank <- score[order(score$score, decreasing = TRUE), ]

  first <- rank[1, ]
  second <- rank[2, ]
  third <- rank[3, ]

  message(info("Third place: ", third$team), note(" Score: ", third$score, " "), medal(3))
  message(info("Second place: ", second$team), note(" Score: ", second$score, " "), medal(2))
  message(info("Firt place: ", first$team), note(" Score: ", first$score, " "), medal(1))

}
