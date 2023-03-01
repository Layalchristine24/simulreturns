#' @title Compute the final value of an investment project.
#'
#' @description Function computing the final of an investment project.
#'
#' @param n_per Number of periods (years) over which the final value should be
#' calculated.
#'
#' @param v_0 Initial investment capital.
#'
#' @param exp_return Average expected return per year (in percent).
#'
#' @param x_yearly Yearly annuity. Default = 0.
#'
#' @param immediate If TRUE, immediate annuities (1st annuity on the 1st of January).
#' Otherwise, ordinary annuities (1st annuity on the 31st of December).
#'
#' @param compound If TRUE, compound interests. Otherwise, simple interests.
#'
#' @return
#' - `FINAL_VALUE`: Investment final value time series.
#'
#' @author [Layal Christine Lettry](mailto:layal.lettry@gmail.com)
#'
#' @import dplyr
#'
#' @export
#'
#' @examples
#' get_final_value(
#'   n_per = 30,
#'   v_0 = 5000,
#'   exp_return = 10,
#'   compound = TRUE,
#'   x_yearly = 12000,
#'   immediate = TRUE
#' )
get_final_value <- function(n_per,
                            v_0,
                            exp_return,
                            compound,
                            x_yearly = 0,
                            immediate = TRUE) {
  # Expected return in percent
  exp_return_pct <- exp_return / 100

  # Final value
  FINAL_VALUE <- tibble(
    period = 1:n_per
  ) %>%
    mutate(
      final_value = case_when(
        # Simple return, no annuities
        x_yearly == 0 &
          compound == FALSE ~ v_0 * (1 + period * exp_return_pct),
        # Compound return, no annuities
        x_yearly == 0 &
          compound == TRUE ~ v_0 * (1 + exp_return_pct)^period,
        # Simple return, with ordinary annuities
        x_yearly > 0 &
          compound == FALSE &
          immediate == FALSE ~ v_0 * (1 + period * exp_return_pct) +
          x_yearly * ((1 + exp_return_pct)^period - 1) / exp_return_pct,
        # Compound return, with ordinary annuities
        x_yearly > 0 &
          compound == TRUE &
          immediate == FALSE ~ v_0 * (1 + exp_return_pct)^period +
          x_yearly * ((1 + exp_return_pct)^period - 1) / exp_return_pct,

        # Simple return, with immediate annuities
        x_yearly > 0 &
          compound == FALSE &
          immediate == TRUE ~ v_0 * (1 + period * exp_return_pct) +
          x_yearly * ((1 + exp_return_pct)^period - 1) / exp_return_pct * (1 + exp_return_pct),
        # Compound return, with immediate annuities
        x_yearly > 0 &
          compound == TRUE &
          immediate == TRUE ~ v_0 * (1 + exp_return_pct)^period +
          x_yearly * ((1 + exp_return_pct)^period - 1) / exp_return_pct * (1 + exp_return_pct)
      )
    )




  # Output
  return(FINAL_VALUE)
}
