# ------------------------------------------------------------------------------
# month_year_labeller

# Used in charts to display custom date labels on chart facets.
# Only the month and year is displayed.
# Ex: "Jan 2024"

month_year_labeller <- function(labels) {
  formatted_labels <- format(as.Date(labels, format = "%Y-%m-%d"), "%b %Y")
  return(formatted_labels)
}


# ------------------------------------------------------------------------------
# read_and_merge_excels

# Used to import data from excel files.
# Reads multiple excel files with same structure and merge them into a single
# tibble.

read_and_merge_excels <- function(file_list, col_types = c("text")) {
  # Use lapply to read each file with specified column types and store the results in a list of tibbles
  tibbles_list <- lapply(file_list, function(file) {
    read_excel(file, col_types = col_types)
  })
  
  # Combine all tibbles into a single tibble using bind_rows
  merged_tibble <- bind_rows(tibbles_list)
  
  return(merged_tibble)
}


# ------------------------------------------------------------------------------
# convert_to_factor

# Used at import time to change the type of a colulmn into a factor.
# An additional check is performed to ensure the column contains only allowed
# values.

convert_to_factor <- function(data, column, allowed_levels) {
  
  # Extract the column as a vector
  column_data <- pull(data, {{column}})
  
  # Find any values in the column that are not in the allowed levels
  invalid_values <- setdiff(unique(column_data), allowed_levels)
  
  # If there are invalid values, stop and throw an error
  if (length(invalid_values) > 0) {
    stop(paste("Invalid values found in", deparse(substitute(column)), ":", paste(invalid_values, collapse = ", ")))
  }
  
  # If no invalid values, convert the column to a factor with the allowed levels
  data <- data %>%
    mutate({{column}} := factor({{column}}, levels = allowed_levels))
  
  return(data)
}


# ------------------------------------------------------------------------------

ensure_dir <- function(path) {
  ifelse(dir.exists(path), FALSE, dir.create(path))
}


# ------------------------------------------------------------------------------

save_plot <- function(name, width = 30, height = 20) {
  ensure_dir(config.output_dir)
  filePath <- file.path(config.output_dir, name)
  ggsave(filePath, width = width, height = height, units="cm", dpi=300)
}


# ------------------------------------------------------------------------------

generate_monthly_dates <- function(start_date, end_date) {
  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)
  
  dates <- seq(
    from = floor_date(start_date, "month"), 
    to = floor_date(end_date, "month"), 
    by = "month"
  )
  
  return(dates)
}
