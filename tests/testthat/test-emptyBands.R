library(tuneR)
context("empty bands")

test_that("check  known missing bands in example file with chesmore2011 coding matrix", {
  wave <- readWave(system.file("extdata", "1.wav", package="tdsc"))
  data(chesmore2011)
  t <- tdsc(wave, coding_matrix = chesmore2011)
  emptyBands(t,t)
  test_that(emptyBands(t,t)$missing == 11)
})

