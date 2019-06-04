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
        tabPanel("Interactive Map", h2("Number of drivers involved in fatal collisions (per billion miles)"),
                 leafletOutput("map1"),
                 h2("Percentage of drivers who were speeding"),
                 leafletOutput("map2"),
                 h2("Percentage of drivers who were alcohol impaired"),
                 leafletOutput("map3"),
                 h2("Percentage of drivers who were NOT distracted"),
                 leafletOutput("map4"),
                 h2("Percentage of drivers who had not been involved in previous accidents"),
                 leafletOutput("map5"),
                 h2("Price of car insurance premiums"),
                 leafletOutput("map6"),
                 h2("Cost of losses incurred by insurance companies per insured driver"),
                 leafletOutput("map7")
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
