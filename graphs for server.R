library(dplyr)
library(ggplot2)
library(tidyr)
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

#Heatmap of states reactive:total(default), victim type
state_accidents <- state_accidents %>%
  filter(State != "National") %>%
  mutate(State = tolower(State)) %>% mutate(Total= as.numeric(Total)) # converting to numeric causes coercion creating NA for some states
state_accidents <- full_join(state_accidents, state_data, by = c("State" = "region"))
plot <- ggplot(state_accidents, aes(long, lat)) +
  geom_polygon(aes(group = group, fill = Total)) + #fill changed with input
  scale_fill_gradient(low = "green", high = "black") +
  labs(title = 'Number of accidents in 2017',
       x = 'Longitude',
       y = 'Latitude',
       fill = "Total accidents" # changed with input
  ) +
  theme(plot.title = element_text(hjust = 0.5))
print(plot)

#   # reaactive click on state for...
#   # Pie chart of driver type
#   bad_driving
#   # Bar graph for premiums/losses
#   bad_driving
#
 #Bargraph of alcohol levels reactive: year
alcohol_levels <- alcohol_levels %>% select(-c(BAC_over_0.01, Total))
alcohol_levels <- gather(alcohol_levels, level, amount, 2:4)
alcohol_levels <- alcohol_levels %>% filter(year == "1990") # filter changes with input
alcohol_bargraph <-ggplot(data= alcohol_levels, aes(x= level, y=amount)) +
   geom_bar(stat="identity", fill="darkgreen") +
  labs(title = "Alcohol content of drivers involved in accidents in 1990", y = "Number of accidents", x = "Alcohol level",
       caption = "BAC = Blood Alcohol Content\n Legally impaired with BAC of 0.08 + in the United States") # date changes with input
print(alcohol_bargraph)

 #bargraph of accident by month reactive: accident type
level_order <- factor(month$Month, level = c('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September',
                                             'October', 'November', 'December'))
month_bargraph <-ggplot(data= month, aes(x= level_order, y=Injury)) + # y changes with input
  geom_bar(stat="identity", fill="lightgreen") +
  labs(title = "Accidents by Month in 2017", x = "Month", y = "Number of accidents") + # accident type changes
  theme(plot.title = element_text(hjust = 0.5))
print(month_bargraph)

 #Line graph of accidents over years reactive: by severity
severity_line <- ggplot(data= severity, aes(x=year, y=fatal, group=1)) +
  geom_line(color="darkolivegreen")+
  geom_point(color = "darkolivegreen") +
  labs(title = "Number of Fatal accidents from 1988-2017", x = "Year", y = "Number of accidents") + # accident type changes
  theme(plot.title = element_text(hjust = 0.5))
print(severity_line)

 #line graph time of day reactive: day of week
TOD_line <- ggplot(data= time_of_day, aes(x= TOD, y= Saturday, group=1)) +
  geom_line(color="limegreen")+
  geom_point(color = "limegreen") +
  labs(title = "Average Number of Accidents Throughout a Saturday in 2017", x = "Time of Day", y = "Number of accidents") + # accident type changes
  theme(plot.title = element_text(hjust = 0.5))
print(TOD_line)

 #bar graph of driver demographic reactive: age
driver_demographic <- driver_demographic %>% filter(Age == "<16") # change in age
driver_demographic <- gather(driver_demographic, sex, amount, 2:3)
age_bargraph <-ggplot(data= driver_demographic, aes(x= sex, y= amount)) + # y changes with input
  geom_bar(stat="identity", fill="springgreen") +
  labs(title = "Male vs Females age <16", x = "Sex", y = "Number of accidents") + # accident type changes
  theme(plot.title = element_text(hjust = 0.5))
print(age_bargraph)
