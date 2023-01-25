test_that("function final value works compound interest immediate annuities", {
  expect_equal(get_final_value(
    n_per = 5,
    v_0 = 5000,
    exp_return = 10,
    compound = TRUE,
    x_yearly = 12000,
    immediate = TRUE
  )[, 2][["final_value"]], c(18700.00, 33770.00, 50347.00, 68581.70, 88639.87))
})

test_that("function final value works simple interest immediate annuities", {
  expect_equal(get_final_value(
    n_per = 5,
    v_0 = 5000,
    exp_return = 10,
    compound = FALSE,
    x_yearly = 12000,
    immediate = TRUE
  )[, 2][["final_value"]], c(18700.00, 33720.00, 50192.00, 68261.20, 88087.32))
})

test_that("function final value works simple interest ordinary annuities", {
  expect_equal(get_final_value(
    n_per = 5,
    v_0 = 5000,
    exp_return = 10,
    compound = FALSE,
    x_yearly = 12000,
    immediate = FALSE
  )[, 2][["final_value"]], c(17500.0, 31200.0, 46220.0, 62692.0, 80761.2))
})

test_that("function final value works simple interest no annuities", {
  expect_equal(get_final_value(
    n_per = 5,
    v_0 = 5000,
    exp_return = 10,
    compound = FALSE,
    x_yearly = 0,
    immediate = FALSE
  )[, 2][["final_value"]], c(5500, 6000, 6500, 7000, 7500))
})
