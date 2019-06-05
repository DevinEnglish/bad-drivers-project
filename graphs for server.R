library(dplyr)
library(ggplot2)
library(tidyr)
library(ggthemes)
# Website csv was collected from
#https://cdan.nhtsa.gov/tsftables/tsfar.htm 

#All csv files read in
bad_driving <- read.csv("data/bad-drivers.csv", stringsAsFactors = FALSE)
state_accidents <- read.csv("data/accidents-per-state-2017.csv", stringsAsFactors = FALSE)
alcohol_levels <- read.csv("data/BAC-levels-of-drivers-in-accidents.csv", stringsAsFactors = FALSE)
month <- read.csv("data/crashes-by-month-2017.csv", stringsAsFactors = FALSE)
severity <- read.csv("data/Crashes-by-severity.csv", stringsAsFactors = FALSE)
time_of_day <- read.csv("data/crashes-time-of-day-2017.csv", stringsAsFactors = FALSE)
driver_demographic <- read.csv("data/driver-demographic-2017.csv", stringsAsFactors = FALSE)
victim_types <- read.csv("data/injurys-and-victim-type.csv", stringsAsFactors = FALSE)
state_data <- map_data('state')

#VISUALIZATIONS

# #Heatmap of states reactive:total(default), victim type
# # state_accidents <- state_accidents %>%
# #   filter(State != "National") %>%
# #   mutate(State = tolower(State)) %>% mutate(Total= as.numeric(Total)) # converting to numeric causes coercion creating NA for some states
# # state_accidents <- full_join(state_accidents, state_data, by = c("State" = "region"))
# # plot <- ggplot(state_accidents, aes(long, lat)) +
# #   geom_polygon(aes(group = group, fill = Total)) + #fill changed with input
# #   scale_fill_gradient(low = "green", high = "black") +
# #   labs(title = 'Number of accidents in 2017',
# #        x = 'Longitude',
# #        y = 'Latitude',
# #        fill = "Total accidents" # changed with input
# #   ) +
# #   theme(plot.title = element_text(hjust = 0.5))
# # print(plot)
# # 
# # #   # reaactive click on state for...
# # #   # Pie chart of driver type
# # #   bad_driving
# # #   # Bar graph for premiums/losses
# # #   bad_driving
# # #
#  #Bargraph of alcohol levels reactive: year
# alcohol_levels <- alcohol_levels %>% select(-c(BAC_over_0.01, Total))
# alcohol_levels <- gather(alcohol_levels, level, amount, 2:4)
# alcohol_levels <- alcohol_levels %>% mutate(level = gsub("X","",level)) %>% mutate(level = gsub("(.)_(.)", "\\1 - \\2",level)) %>%
#   filter(year == "2012") # filter changes with input
# alcohol_bargraph <-ggplot(data= alcohol_levels, aes(x= level, y=amount)) +
#    geom_bar(stat="identity", fill="tan1") +
#   theme_economist()+
#   labs(title = "Alcohol content of drivers involved in accidents in 1990", y = "Number of accidents", x = "Alcohol level",
#        caption = "BAC = Blood Alcohol Content\n Legally impaired with BAC of 0.08 + in the United States") # date changes with input
# print(alcohol_bargraph)
# 
# #  #bargraph of accident by month reactive: accident type
# month_order <- factor(month$Month, level = c('Jan', 'Feb', 'March', 'April', 'May', 'June', 'July', 'Aug', 'Sept',
#                                              'Oct', 'Nov', 'Dec'))
# month_bargraph <-ggplot(data= month, aes(x= month_order, y=Fatal)) + # y changes with input
#   geom_bar(stat="identity", fill="tan1") +
# theme_economist()+
#   labs(title = "Accidents (Fatal) by Month in 2017", x = "Month", y = "Number of accidents") + # accident type changes
#   theme(plot.title = element_text(hjust = 0.5))
# print(month_bargraph)
# # 
# #  #Line graph of accidents over years reactive: by severity
# severity_line <- ggplot(data= severity, aes(x=year, y=fatal, group=1)) +
#   geom_line(color="steelblue4", size = 1.5)+
#   geom_point(color = "tan1", size = 3.5) +
#   theme_economist()+
#   labs(title = "Number of Fatal accidents from 1988-2017", x = "Year", y = "Number of accidents") + # accident type changes
#   theme(plot.title = element_text(hjust = 0.5))
# print(severity_line)
# # 
# #  #line graph time of day reactive: day of week
# day <- paste("Tuesday")
# time_of_day <- time_of_day[-(9:27),]
# TOD_order <- factor(time_of_day$TOD, level = c('12-3AM','3-6AM','6-9AM','9AM-12PM','12-3PM','3-6PM',"6-9PM", '9PM-12AM'))
# TOD_line <- ggplot(data= time_of_day, aes(x= TOD_order, y= day, group=1)) +
#   geom_line(color="steelblue4", size = 1.5)+
#   theme_economist()+
#   geom_point(color = "tan1", size = 3.5) +
#   labs(title = "Average Number of Accidents on Saturdays in 2017", x = "Time of Day", y = "Number of accidents") + # accident type changes
#   theme(plot.title = element_text(hjust = 0.5))
# print(TOD_line)
# 
#  #bar graph of driver demographic reactive: age
# driver_demographic <- driver_demographic %>% filter(Age == "<16") # change in age
# driver_demographic <- gather(driver_demographic, sex, amount, 2:3)
# age_bargraph <-ggplot(data= driver_demographic, aes(x= sex, y= amount)) + # y changes with input
#   geom_bar(stat="identity", fill="tan1") +
#   theme_economist()+
#   labs(title = "Male vs Females age <16", x = "Sex", y = "Number of accidents") + # accident type changes
#   theme(plot.title = element_text(hjust = 0.5))
# print(age_bargraph)

victim_line <- ggplot(data= victim_types, aes(x= victim_types$year, y= victim_types$Passenger.Cars, group=1)) +
  geom_line(color="steelblue4", size = 1.5)+
  geom_point(color = "tan1", size = 3.5) +
  theme_economist()+
  labs(title = paste("Number of accidents from 1988-2017"), x = "Year", y = "Number of accidents") + # accident type changes
  theme(plot.title = element_text(hjust = 0.5))
print(victim_line)
