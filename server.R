#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(htmltools)
library(geojsonio)
bad_driving <- read.csv("data/bad-drivers.csv", stringsAsFactors = FALSE)
state_accidents <- read.csv("data/accidents-per-state-2017.csv", stringsAsFactors = FALSE)
alcohol_levels <- read.csv("data/BAC-levels-of-drivers-in-accidents.csv", stringsAsFactors = FALSE)
month <- read.csv("data/crashes-by-month-2017.csv", stringsAsFactors = FALSE)
severity <- read.csv("data/Crashes-by-severity.csv", stringsAsFactors = FALSE)
time_of_day <- read.csv("data/crashes-time-of-day-2017.csv", stringsAsFactors = FALSE)
driver_demographic <- read.csv("data/driver-demographic-2017.csv", stringsAsFactors = FALSE)
victim_types <- read.csv("data/injurys-and-victim-type.csv", stringsAsFactors = FALSE)
states <- geojson_read(
  x = "https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json"
  , what = "sp"
)
#names <- states$name[states$name!="Puerto Rico"]
names <- append(state.name,"District of Columbia",after=8)
num_range <- function(data,div) {
  bins <- seq(min(data),max(data),length.out = div)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$map1 <- renderLeaflet({
    pal <- colorBin("RdPu", domain = bad_driving[,2],
                    bins =num_range(bad_driving[,2],5))
    labels <- sprintf(
      "<strong>%s</strong><br/>%g drivers ",
      names, bad_driving[,2]
    ) %>% lapply(htmltools::HTML)
    leaflet(states) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(
        fillColor = ~pal(bad_driving[,2]),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        highlight = highlightOptions(
          weight = 5,
          color = "#666",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE),
        label = labels,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto")
                  ) %>%
      setView(-98.5795, 39.8282, zoom=4)

  })
  output$map2 <- renderLeaflet({
    h2("Does this show up?")
    pal <- colorBin("YlGn", domain = bad_driving[,3],
                    bins =num_range(bad_driving[,3],6))
    labels <- sprintf(
      "<strong>%s</strong><br/>%g percent",
      names, bad_driving[,3]
    ) %>% lapply(htmltools::HTML)
    leaflet(states) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(fillColor = ~pal(bad_driving[,3]),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE),
                  label = labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      setView(-98.5795, 39.8282, zoom=4)
  })
  output$map3 <- renderLeaflet({
    
    pal <- colorBin("Blues", domain = bad_driving[,4],
                    bins =num_range(bad_driving[,4],5))
    labels <- sprintf(
      "<strong>%s</strong><br/>%g percent",
      names, bad_driving[,4]
    ) %>% lapply(htmltools::HTML)
    leaflet(states) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(fillColor = ~pal(bad_driving[,4]),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE),
                  label = labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      setView(-98.5795, 39.8282, zoom=4)
  })
  output$map4 <- renderLeaflet({
    pal <- colorBin("Oranges", domain = bad_driving[,5],
                    bins =num_range(bad_driving[,5],6))
    labels <- sprintf(
      "<strong>%s</strong><br/>%g percent",
      names, bad_driving[,5]
    ) %>% lapply(htmltools::HTML)
    leaflet(states) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(fillColor = ~pal(bad_driving[,5]),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE),
                  label = labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      setView(-98.5795, 39.8282, zoom=4)
  })
  output$map5 <- renderLeaflet({
    pal <- colorBin("YlOrBr", domain = bad_driving[,6],
                    bins =num_range(bad_driving[,6],5))
    labels <- sprintf(
      "<strong>%s</strong><br/>%g percent",
      names, bad_driving[,6]
    ) %>% lapply(htmltools::HTML)
    leaflet(states) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(fillColor = ~pal(bad_driving[,6]),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE),
                  label = labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      setView(-98.5795, 39.8282, zoom=4)
  })
  output$map6 <- renderLeaflet({
    pal <- colorBin("Blues", domain = bad_driving[,7],
                    bins =num_range(bad_driving[,7],5))
    labels <- sprintf(
      "<strong>%s</strong><br/>%g premiums",
      names, bad_driving[,7]
    ) %>% lapply(htmltools::HTML)
    leaflet(states) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(fillColor = ~pal(bad_driving[,7]),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE),
                  label = labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      setView(-98.5795, 39.8282, zoom=4)
  })
  output$map7 <- renderLeaflet({
    pal <- colorBin("BuGn", domain = bad_driving[,8],
                    bins =num_range(bad_driving[,8],5))
    labels <- sprintf(
      "<strong>%s</strong><br/>%g losses",
      names, bad_driving[,8]
    ) %>% lapply(htmltools::HTML)
    leaflet(states) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(fillColor = ~pal(bad_driving[,8]),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE),
                  label = labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      setView(-98.5795, 39.8282, zoom=4)
  })
  output$badDriverTable <- renderTable({
    bad_driving %>% dplyr::rename("Number of drivers involved in fatal collisions (per billion miles)"=colnames(bad_driving)[2],
                                  "Percentage of drivers who were speeding"=colnames(bad_driving)[3],
                                  "Percentage of drivers who were alcohol impaired"=colnames(bad_driving)[4],
                                  "Percentage of drivers who were NOT distracted"=colnames(bad_driving)[5],
                                  "Percentage of drivers who had not been involved in previous accidents"=colnames(bad_driving)[6],
                                  "Number of car insurance premiums"=colnames(bad_driving)[7],
                                  "Number of losses incurred by insurance companies per insured driver"=colnames(bad_driving)[8])
  })
  output$stateAccidentsTable <- renderTable({
    state_accidents %>% dplyr::rename("Other/Unkown"=colnames(state_accidents)[7])
  })
  output$alcoholLevelsTable <- renderTable({
    alcohol_levels %>% dplyr::rename("BAC = 0"=BAC_0,"0.01<BAC>0.07"=BAC_0.01_0.07,
                                     "BAC>0.08"=BAC_over_0.08,"BAC>0.01"=BAC_over_0.01)
  })
  output$monthTable <- renderTable({
    month %>% dplyr::rename("Property Damage"=colnames(month)[4])
  })
  output$severityTable <- renderTable({
    severity %>% dplyr::rename("Percent fatal (%)"=percent.fatal,"Fatalities"=fatal,"Percent injuries (%)"=percent.injury,
                               "Percent property damage (%)"=percent.property.damage)
  })
  output$timeOfDayTable <- renderTable({
    time_of_day %>% dplyr::rename("Time"=TOD)
  })
  output$driverDemographicTable <- renderTable({
    driver_demographic
  })
  output$victimTypeTable <- renderTable({
    victim_types %>% dplyr::rename("Passenger Cars"=colnames(victim_types)[2],"Light Trucks"=colnames(victim_types)[3],
                                   "Large Trucks"=colnames(victim_types)[4])
  })
  #Summary tab
  output$dataCommentary <- renderText({
    paste0("This tab will include our own commentary on the data. For now, we won't have that much available here since we have not done any thorough calculations or observations.")
  })
  
  
})
