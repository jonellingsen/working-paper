# Clear all ---------------------------------------------------------------

rm(list = ls())



# Load packages -----------------------------------------------------------

setwd("~/Dropbox/Working paper/Scripts")
library(gtrendsR)
# Import function
source('GetTrendsData.R')



# Get categories -----------------------------------------------------------

data("categories")
rownames(categories) = c(1:nrow(categories))
categories = categories[1249:1350,]

# Manually remove irrelevant categories
irrelevant = c("Apparel Services",
               "Headwear", 
               "Uniforms & Workwear",
               "Consumer Advocacy & Protection",
               "Coupons & Discount Offers",
               "Customer Services",
               "Vehicle Specs, Reviews & Comparisons",
               "Photo & Video Services",
               "Stock Photography",
               "Sports Memorabilia",
               "Swap Meets & Outdoor Markets")

categories = categories[!(categories$name %in% irrelevant), ]
categories = categories[!duplicated(categories$name), ]



# Download data from Google trends -----------------------------------------------------------

trendsData = GetTrendsData(categories)



# Remove variables that contain NAs or zeros. Save trends. -----------------------------------------------------------

categories = categories[!apply(is.na(trendsData), 2, any), ]
trendsData = trendsData[, !apply(is.na(trendsData), 2, any)]

categories = categories[!apply(trendsData == 0, 2, any), ]
trendsData = trendsData[, !apply(trendsData == 0, 2, any)]

colnames(trendsData) = categories$name


# Save data ---------------------------------------------------------------

setwd("~/Dropbox/Working paper/Data")
save(trendsData, file = "trendsData.RData")