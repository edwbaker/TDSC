context("emptyBands.R")
library(tuneR)

test_that("error on single parameter", {
  expect_error(emptyBands(list("test"="test")), "emptyBands() requires two or more TDSC objects") #Change to TDSC object
})

test_that("all parameters are tdsc objects", {
  expect_error(emptyBands("monkey", 123), "Inputs to emptyBands must be TDSC objects.")
})

test_that("check known missing bands in example file with chesmore2001 coding matrix", {
  wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
  data(chesmore2001)
  t <- tdsc(wave, coding_matrix = chesmore2001)
  b <- emptyBands(t,t)
  expect_equal(b$missing, 11)
})

test_that("output is in correct format", {
  wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
  data(chesmore2001)
  t <- tdsc(wave, coding_matrix = chesmore2001)
  b <- emptyBands(t,t)
  expect_equal(typeof(b), "list")
  expect_equal(typeof(b$missing), "integer")
  expect_equal(typeof(b$plot), "double")
  expect_equal(ncol(b$plot), 2)
  expect_silent(plot(b$plot))
})