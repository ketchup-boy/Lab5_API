# Load the testthat package
library(testthat)

# Test suite for the get_municipality_id function
test_that("get_municipality_id handles valid input correctly", {
  
  # Test with a valid municipality (replace with an actual municipality name)
  municipality_name <- "Stockholm"
  
  # Actual API call
  municipality_id <- get_municipality_id(municipality_name)
  
  # Check that the municipality ID is returned as a non-null value
  expect_true(!is.null(municipality_id))
  
  # Check that the ID is a character string (as municipality IDs are generally strings)
  expect_type(municipality_id, "character")
})

test_that("get_municipality_id handles non-existing municipality", {
  
  # Test with a municipality name that does not exist
  non_existent_municipality <- "InvalidMunicipality"
  
  # Expect an error to be raised when the municipality is not found
  expect_error(get_municipality_id(non_existent_municipality), "Municipality not found")
})

test_that("get_municipality_id handles empty input", {
  
  # Test with an empty municipality name
  empty_municipality_name <- ""
  
  # Expect an error to be raised when the input is empty
  expect_error(get_municipality_id(empty_municipality_name), "Municipality not found")
})
