#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(htmltools)
bad_driving <- read.csv("data/bad-drivers.csv", stringsAsFactors = FALSE)
state_accidents <- read.csv("data/accidents-per-state-2017.csv", stringsAsFactors = FALSE)
alcohol_levels <- read.csv("data/BAC-levels-of-drivers-in-accidents.csv", stringsAsFactors = FALSE)
month <- read.csv("data/crashes-by-month-2017.csv", stringsAsFactors = FALSE)
severity <- read.csv("data/Crashes-by-severity.csv", stringsAsFactors = FALSE)
time_of_day <- read.csv("data/crashes-time-of-day-2017.csv", stringsAsFactors = FALSE)
driver_demographic <- read.csv("data/driver-demographic-2017.csv", stringsAsFactors = FALSE)
victim_types <- read.csv("data/injurys-and-victim-type.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinythemes::shinytheme("slate"),
  # Application title
  fluidRow(column(7,offset = 3,titlePanel("Bad Drivers and Insurance statistics in the United States of America 2017"))),
  p("On average 3,287 die from a car accident every day, that is a lot of lives lost. Bad driving is a big problem in the United states
    taking the 3rd place spot on leading causes of death. While we have come a long way, increasing car safety through seatbelts and airbags,
    and educating more of the population on the importance of safe driving habits, there is still more to be done. The information in this application
    was gathered by the National Highway Traffic Safety Administration 2017 anual motor safety report. This application's aim is to educate insurance companies
    and other services related to road safety, on trends to better implement their services, as well as provide information to the general public to be more 
    aware of their own safety efforts."),
  p("The Map below is an interactive depiction of the data tables that we chose. "),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
       # selectInput("mapview", label = h3("Choose what to display on the map"),
       #             choices = list("Number of drivers in collisions per billions of miles" = "map1",
       #                            "Percentage of drivers who were speeding" = "map2"
       #                            # "Percentage of drivers who were alcohol impaired" = 4,
       #                            # "Percentage of drivers who were NOT distracted" = 5
       #                            ),
       #             selected = "map1")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Interactive Map", 
                 #Sequence of interactive maps
                 h2("Number of drivers involved in fatal collisions (per billion miles)"),
                 leafletOutput("map1"),
                 div("As Shown in this map, Southern, Central, and Central-Northern states have the highest number of drivers
                     involved in fatal collisions per 1 billion miles. As a reminder, this is just correlation so further investigation
                     is necessary in order to establish a well-established conclusion"),
                 
                 h2("Percentage of drivers who were speeding"),
                 leafletOutput("map2"),
                 div("While many drivers were speeding at the time of the accident, only Pennsylvania had a percentage that was 50 percent or above. 
                     Perhaps this suggests that most acts of incompetence that cause accidents are not speeding-related and that there are other signifiers
                     to take into account when it comes to predicting what kinds of accidents to expect"),
                 
                 h2("Percentage of drivers who were alcohol impaired"),
                 leafletOutput("map3"),
                 div("On average, between 20 and 35 percent of fatal accidents were attributed to alcohol impairment in most states. However, States
                     like Texas, South Carolina, Hawaii, Montana, Rhode Island and North Dakota had percentages that were in the high thirties or even
                     low forties. "),
                 
                 h2("Percentage of drivers who were NOT distracted"),
                 leafletOutput("map4"),
                 div("Surprisingly, The vast majority of drivers at the time of accidents were not classified as distracted. Wisconsin and 
                     Mississippi are exceptions as only 39 and 10 percent of drivers in accidents respectively were not classified as distracted. "),
                 
                 h2("Percentage of drivers who had not been involved in previous accidents"),
                 leafletOutput("map5"),
                 div("The majority of drivers involved in such accidents do not have a history of accidents in the past. However, the percentage
                     of those who were not involved in previous accidents does vary by state. The East Coast seems to have noticeably lower percentages 
                     of drivers who were not involved in previous accidents than other states. Maybe this could be due to higher population density leading
                     to a higher concentrations of motor vehicles on the roads that is responsible for people being more likely to be involved in accidents in the past. "),
                 
                 h2("Price of car insurance premiums"),
                 leafletOutput("map6"),
                 div("Most of the North Eastern USA, Florida, and Louisiana have the highest car insurance premiums. 
                     Overall, states in the south have higher insurance premiums than states in the north. The midwest is
                     notable for having relatively low car insurance premiums in comparison to other states. Another interesting, 
                     detail is that Washington and Montana are notable for having higher insurance premiums in comparison to \
                     nearby states. "),
                 
                 h2("Cost of losses incurred by insurance companies per insured driver"),
                 leafletOutput("map7"),
                 div("The East coast and Southern states are shown to have the highest costs of losses incurred by insurance
                     companies per insured drivers. This could be linkd to the number of drivers involved in fatal collisions
                     per 1 billion miles per state. However, Montana, North Dakota, and South Dakota have some of the highest
                     numbers of drivers involved in fatal collisions per 1 billion miles but still has some of the lowest costs
                     of losses incurred by insurance. Further investigation would be necessary to find a better sense of correlation
                     and causation. ")
        ),
        tabPanel("Bad Driver Table",tableOutput("badDriverTable")),
        tabPanel("State Accidents Table", tableOutput("stateAccidentsTable")),        
        tabPanel("Alcohol Levels Table",
                 sidebarLayout(
                   sidebarPanel(sliderInput("yearForAlcGraph", label = h3("Year"), min = 1988, #fix scaling to be in years
                                            max = 2017, value = 2000, animate = TRUE)
                   ),
                   mainPanel(plotOutput("alcoholLevelsGraph"), tableOutput("alcoholLevelsTable"))
                 )
                 ),
        tabPanel("Month Table", 
                 sidebarLayout(
                   sidebarPanel(radioButtons("byMonthAccidentType", label = h3("Type of Accident"),
                                             choices = list("Fatal" = "Fatal", "Injury Only" = "Injury Only", "Property Damage" = "Property Damage"), 
                                             selected = "Fatal")
                   ),
                   mainPanel(plotOutput("byMonthGraph"), tableOutput("monthTable"))
                 )
        ),        
        tabPanel("Severity Table", 
                 sidebarLayout(
                   sidebarPanel(radioButtons("severityAccidentType", label = h3("Type of Accident"),
                                             choices = list("Fatal" = "Fatal", "Injury Only" = "Injury Only", "Property Damage" = "Property Damage"), 
                                             selected = "Fatal")
                   ),
                   mainPanel(plotOutput("severityGraph"),tableOutput("severityTable"))
                             )
                   ),        
        tabPanel("Time Of Day Table", 
                 sidebarLayout(
                   sidebarPanel(textInput("dayOfWeek", label = h3("Day of the Week"), placeholder = "Monday")
                                ),
                   mainPanel(plotOutput("TODGraph"),tableOutput("timeOfDayTable"))
                 )
        ),
        tabPanel("Driver Demographic Table", 
                 sidebarLayout(
                   sidebarPanel(radioButtons("age", label = h3("Age"),
                                             choices = list("<16" = "<16", "16-20" = "16-20", "21-24" = "21-24", "25-34" = "25-34",
                                                            "35-44" = "35-44", "45-54" = "45-54", "55-64" = "55-64", "65-74" = "65-74", ">75" = ">74"), 
                                             selected = "<16")
                   ),
                   mainPanel(plotOutput("demoGraph"), tableOutput("driverDemographicTable"))
                 )
                 ),        
        tabPanel("Victim Types Table", tableOutput("victimTypeTable")),        
        tabPanel("Commentary", textOutput("dataCommentary"))
      )
    )
  )
))
