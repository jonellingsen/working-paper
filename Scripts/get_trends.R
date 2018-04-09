# Clear all ---------------------------------------------------------------

rm(list = ls())



# Load packages -----------------------------------------------------------

setwd("~/Dropbox/Working paper/Scripts")
library(gtrendsR)
# Import functions
sapply(list.files(pattern = "[.]R$",
                  path = "~/Dropbox/Working Paper/Functions",
                  full.names = TRUE), source)



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

rawData = GetTrendsData(categories)



# Preprocess data ---------------------------------------------------------

data = ProcessData(rawData)


# Save data ---------------------------------------------------------------

setwd("~/Dropbox/Working paper/Data")
save(rawData, file = "raw_data_retail_sales_categories.RData")
save(data, file = "data_retail_sales_categories.RData")