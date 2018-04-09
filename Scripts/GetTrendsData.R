GetTrendsData = function(categories) {
  # Downloads the specified categories from Google Trends.
  # 
  # Args:
  #   categories: A data frame with the name and id of the Google Trends categories.
  # 
  # Returns:
  #   A ts object containing the Google Trends data.
  
  trendsData = gtrends('', 
                    geo = 'NO', 
                    time = '2004-01-01 2017-12-01', 
                    category = categories$id[1])$interest_over_time[, c('date', 'hits')]
  
  for (i in 2:length(categories$id)) {
    Sys.sleep(1)
    tmp = try(gtrends('', 
                      geo = 'NO', 
                      time = '2004-01-01 2017-12-01', 
                      category = categories$id[i])$interest_over_time[, 'hits'])
    
    if (is.null(tmp)) {
      trendsData[, i + 1] = NA
    } else {
      trendsData[, i + 1] = tmp
      print(paste(i, length(categories$id), sep = '/'))
    }
  
  }
  
  trendsData = ts(trendsData[, -1], start = c(2004, 1), end = c(2017, 12), frequency = 12)
  
  colnames(trendsData) = categories$name
  
  return(trendsData)
}