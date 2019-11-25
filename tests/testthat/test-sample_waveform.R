context("sample waveform")

test_that("parameters are of correct type", {
  wf <- sample_waveform()
  expect_null(wf, "sample_waveofrm should return NULL")
})