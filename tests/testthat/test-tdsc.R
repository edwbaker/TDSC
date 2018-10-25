context("tdsc")

test_that("parameters are of correct type", {
  wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
  
  expect_error(tdsc("string"), "wave must be a Wave object")
  expect_silent(tdsc(wave))
  
  expect_error(suppressWarnings(tdsc(wave, lag="string")), "lag must be an integer")
  expect_error(tdsc(wave, lag=1.5), "lag must be an integer")
  expect_silent(tdsc(wave, lag=2))
  
  expect_error(suppressWarnings(tdsc(wave, max_D="string")), "max_D must be an integer")
  expect_error(tdsc(wave, max_D=1.5), "max_D must be an integer")
  expect_silent(tdsc(wave, max_D=5))
  
  expect_silent(tdsc(wave, plot=TRUE))
})
