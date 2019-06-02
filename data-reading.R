library(dplyr)
library(ggplot2)

bad_driving <- read.csv("data/bad-drivers.csv", stringsAsFactors = FALSE)
severity <- read.csv("data/Crashes-by-severity.csv")
colnames(bad_driving) <- c("state", "fatal.collisions", "speeding", "alcohol.impaired",
                           "not.distracted", "no.previous","premiums", "losses")
# variables for naional row (averages over all states)
n_collisions <- round(sum(bad_driving$fatal.collisions) / 51, digits = 2)
n_speeding <- round(sum(bad_driving$speeding) / 51)
n_alcohol <-  round(sum(bad_driving$alcohol.impaired) / 51)
n_distraction <- round(sum(bad_driving$not.distracted) / 51)
n_previous <- round(sum(bad_driving$no.previous) / 51)
n_premiums <- round(sum(bad_driving$premiums) / 51, digits = 2)
n_losses <- round(sum(bad_driving$losses) / 51, digits = 2)
bad_driving[nrow(bad_driving) + 1,] = list("National", n_collisions, n_speeding, n_alcohol,
                                         n_distraction, n_previous, n_premiums, n_losses)

# DATA FRAMES FOR EACH GRAPH

#Data for heat map of fata collisions
collisions_state <- bad_driving %>% select(state, fatal.collisions) %>% filter(state != "National")

#Data for pie chart of driver type
driver_type <- bad_driving %>% select(state, speeding, alcohol.impaired, not.distracted, no.previous)


hi <- bad_driving$premiums
state_compare <- ggplot(data = bad_driving) +
  geom_bar(mapping = aes(x = state, y = no.previous), stat = "identity")
print(state_compare)

insurance_accident_compare <- ggplot(data = bad_driving) +
  geom_bar(mapping=aes(x = state, y = premiums), stat = "identity")

print(insurance_accident_compare)

get_state_stats <- function(state_name) {
  state_info <- filter(bad_driving, state == state_name)
  num_involved = state_info$fatal.collisions
  insurance_prem <- state_info$premiums
  paste("Stats: ", state_name, num_involved, insurance_prem)
}

test <- get_state_stats("Alabama")
print (test)