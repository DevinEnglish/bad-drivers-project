library(dplyr)
library(ggplot2)

bad_driving <- read.csv("data/bad-drivers.csv")
hi <- bad_driving$Car.Insurance.Premiums....
state_compare <- ggplot(data = bad_driving) +
  geom_bar(mapping = aes(x = State, y = Percentage.Of.Drivers.Involved.In.Fatal.Collisions.Who.Had.Not.Been.Involved.In.Any.Previous.Accidents), stat = "identity")
print(state_compare)

insurance_accident_compare <- ggplot(data = bad_driving) +
  geom_bar(mapping=aes(x = State, y = Car.Insurance.Premiums....), stat = "identity")

print(insurance_accident_compare)

get_state_stats <- function(state_name) {
  state_info <- filter(bad_driving, State == state_name)
  num_involved = state_info$Number.of.drivers.involved.in.fatal.collisions.per.billion.miles
  insurance_prem <- state_info$Car.Insurance.Premiums....
  paste("Stats: ", state_name, num_involved, insurance_prem)
}

test <- get_state_stats("Alabama")
print (test)