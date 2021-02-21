test_that("prenoms is loaded works", {
  library(prenoms)
  data("prenoms")
  expect_true(exists("prenoms"))
  expect_is(prenoms,"data.frame")
  expect_equal(names(prenoms),c("year", "sex", "name", "n", "dpt", "prop"))
})
test_that("prenoms is loaded works", {
  library(prenoms)
  data("prenoms_france")
  expect_true(exists("prenoms_france"))
  expect_is(prenoms_france,"data.frame")
  expect_equal(names(prenoms_france),c("year", "sex", "name", "n", "prop"))

})
