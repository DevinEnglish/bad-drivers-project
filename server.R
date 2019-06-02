#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
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


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$interactiveMap <- renderPlot({
    
  })
  output$badDriverTable <- renderTable({
    bad_driving
  })
  output$stateAccidentsTable <- renderTable({
    state_accidents
  })
  output$alcoholLevelsTable <- renderTable({
    alcohol_levels
  })
  output$monthTable <- renderTable({
    month
  })
  output$severityTable <- renderTable({
    severity
  })
  output$timeOfDayTable <- renderTable({
    time_of_day
  })
  output$driverDemographicTable <- renderTable({
    driver_demographic
  })
  output$victimTypeTable <- renderTable({
    victim_types
  })
  #Summary tab
  output$dataCommentary <- renderText({
    paste0("This tab will include our own commentary on the data. For now, we won't have that much available here since we have not done any thorough calculations or observations.")
  })
  
  
})
