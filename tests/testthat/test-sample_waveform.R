context("sample waveform")

test_that("parameters are of correct type", {
  wf <- sample_waveform()
  expect_null(wf, "sample_waveform should return NULL")
  wf <- sample_waveform(fig_max_samples=5, start_zero = FALSE,invert=TRUE, tdsc_shapes = TRUE,limit_y=FALSE)
  expect_null(wf, "sample_waveform should return NULL")
})