context('standard column format')

test_that('it correctly parses numeric input', {
  expect_equal(standard_column_format(c(1,5), iris),
               c('Sepal.Length', 'Species'))
})

test_that('it correctly parses logical input', {
  expect_equal(standard_column_format(c(TRUE, FALSE, FALSE, FALSE, TRUE), iris),
               c('Sepal.Length', 'Species'))
})

test_that('it correctly parses character input', {
  expect_equal(standard_column_format('Sepal.Length', iris), 'Sepal.Length')
})

test_that('it correctly parses function input', {
  expect_equal(standard_column_format(is.numeric, iris),
               colnames(iris)[vapply(iris, is.numeric, logical(1))])

  mean_fn <- function(x) is.numeric(x) && mean(x, na.rm = TRUE) > 5
  expect_equal(standard_column_format(mean_fn, iris),
               colnames(iris)[vapply(iris, mean_fn, logical(1))])
})

test_that('it correctly parses list input', {
  cols <- standard_column_format(list(1:2, 'Sepal.Width'), iris)
  expect_equal(cols, colnames(iris)[2])
})

test_that('it correctly parses nested list input', {
  cols <- standard_column_format(list(5, 'Species', list(is.factor)), iris)
  expect_equal(cols, colnames(iris)[5])
})

