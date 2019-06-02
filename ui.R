#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

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
  
  # Application title
  titlePanel("Bad Drivers and Insurance statistics in the United States of America 2017"),
  p("This is the beginning of this project. Right now this project is pretty empty because we haven't added everything in here yet. "),
  p("The Map below is an interactive depiction of the data tables that we chose. "),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Interactive Map", plotOutput("interactiveMap")),
        tabPanel("Bad Driver Table", tableOutput("badDriverTable")),     
        tabPanel("State Accidents Table", tableOutput("stateAccidentsTable")),        
        tabPanel("Alcohol Levels Table", tableOutput("alcoholLevelsTable")),        
        tabPanel("Month Table", tableOutput("monthTable")),        
        tabPanel("Severity Table", tableOutput("severityTable")),        
        tabPanel("Time Of Day Table", tableOutput("timeOfDayTable")),        
        tabPanel("Driver Demographic Table", tableOutput("driverDemographicTable")),        
        tabPanel("Victim Types Table", tableOutput("victimTypeTable")),        
        tabPanel("Commentary", textOutput("dataCommentary"))
      )
    )
  )
))