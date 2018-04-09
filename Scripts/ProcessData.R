ProcessData = function(rawData) {
  #   Handles the preprocessing of the data.
  #   This includes both removing all series containing NaNs or zeros and 
  #   seasonal adjustment using X-13 ARIMA-SEATS.
  # 
  #   Args:
  #     - rawData: A ts object containing the raw data series.
  # 
  #   Returns:
  #   A ts object containing the processed data.
  
  # Load packages
  require(seasonal)
  
  # Remove variables that contain NAs or zeros ------------------------------
  data = rawData[, !apply(is.na(rawData), 2, any) & !apply(rawData == 0, 2, any)]
  
  # Seasonally adjust the data ----------------------------------------------
  for (i in 1:dim(data)[2]) {
    data[, i] = final(seas(data[, i]))
  }
  
  return(data)
  
}