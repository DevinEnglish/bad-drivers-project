#Libraries
library(shiny)
library(leaflet)
library(htmltools)
library(geojsonio)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(plotly)

#Plots
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

names <- append(state.name,"District of Columbia",after=8)
num_range <- function(data,div) {
  bins <- seq(min(data),max(data),length.out = div)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  #Interactive maps
  
  #Drivers involved in fatal collisions (per billion miles)
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
  
  #Percentage of drivers who were speeding
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
  #Percentage of drivers who were alcohol impaired
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
  
  #Percentage of drivers who were NOT distracted
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
  
  #Percentage of drivers who had not been involved in previous accidents
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
  
  #Price of car insurance premiums
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
  
  #Cost of losses incurred by insurance companies per insured driver
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
  
  #Table of types of bad drivers
  output$badDriverTable <- renderTable({
    bad_driving %>% dplyr::rename("Number of drivers involved in fatal collisions (per billion miles)"=colnames(bad_driving)[2],
                                  "Percentage of drivers who were speeding"=colnames(bad_driving)[3],
                                  "Percentage of drivers who were alcohol impaired"=colnames(bad_driving)[4],
                                  "Percentage of drivers who were NOT distracted"=colnames(bad_driving)[5],
                                  "Percentage of drivers who had not been involved in previous accidents"=colnames(bad_driving)[6],
                                  "Price of car insurance premiums"=colnames(bad_driving)[7],
                                  "Cost of losses incurred by insurance companies per insured driver"=colnames(bad_driving)[8])
  })
  
  #Table of state accidents
  output$stateAccidentsTable <- renderTable({
    state_accidents %>% dplyr::rename("Other/Unkown"=colnames(state_accidents)[7])
  })
  
  #BAC levels
  output$alcoholLevelsTable <- renderTable({
    alcohol_levels %>% dplyr::rename("BAC = 0"=`BAC_0.00`,"0.01<BAC>0.07"=`BAC_0.01_0.07`,
                                     "BAC>0.08"=`BAC_OVER_0.08`,"BAC>0.01"= `BAC_over_0.01`)
  })
  
  #Reactive for examining BAC levels at the time of an accident
  Alcohol_content_plot <- reactive({
    alcohol_levels <- alcohol_levels %>% select(-c(BAC_over_0.01, Total))
    alcohol_levels <- gather(alcohol_levels, level, amount, 2:4)
    alcohol_levels <- alcohol_levels %>% mutate(level = gsub("X","",level)) %>% mutate(level = gsub("(.)_(.)", "\\1 - \\2",level)) %>%
    filter(year == input$yearForAlcGraph)
    alcohol_bargraph <-ggplot(data= alcohol_levels, aes(x= level, y=amount)) +
      expand_limits(y=c(0,30000))+
      geom_bar(stat="identity", fill="tan1") +
      theme_economist()+
      labs(title = paste("Alcohol content of drivers involved in accidents in", input$yearForAlcGraph), y = "Number of accidents", x = "Alcohol level",
           caption = "BAC = Blood Alcohol Content\n Legally impaired with BAC of 0.08 + in the United States") +
      theme(plot.title = element_text(hjust = 0.5))# date changes with input
    print(alcohol_bargraph)
  })
  output$alcoholLevelsGraph <- renderPlotly({
    ggplotly(Alcohol_content_plot())
  })
  output$monthTable <- renderTable({
    month %>% dplyr::rename("Property Damage"=colnames(month)[4])
  })
  
  #Reactive for choosing the type of accident
  by_month_graph <- reactive ({
    if(input$byMonthAccidentType == "Fatal"){
      accidents <- month$Fatal
    }
    if(input$byMonthAccidentType == "Injury Only"){
      accidents <- month$Injury
    }
    if(input$byMonthAccidentType == "Property Damage"){
      accidents <- month$property.damage
    }
    month_order <- factor(month$Month, level = c('Jan', 'Feb', 'March', 'April', 'May', 'June', 'July', 'Aug', 'Sept',
                                                 'Oct', 'Nov', 'Dec'))
    month_bargraph <-ggplot(data= month, aes(x= month_order, y= accidents)) + 
      geom_bar(stat="identity", fill="tan1") +
      theme_economist()+
      labs(title = paste("Accidents (",input$byMonthAccidentType, ") by Month in 2017", sep=""), x = "Month", y = "Number of accidents") + # accident type changes
      theme(plot.title = element_text(hjust = 0.5))
    print(month_bargraph)
  })
  
  #Plots and tables for 
  output$byMonthGraph <- renderPlotly({
    ggplotly(by_month_graph())
  })
  output$severityTable <- renderTable({
    severity %>% dplyr::rename("Percent fatal (%)"=percent.fatal,"Fatalities"=fatal,"Percent injuries (%)"=percent.injury,
                               "Percent property damage (%)"=percent.property.damage)
  })
  
  #Reactive graph for accident severity
  severity_graph <- reactive({
    if(input$severityAccidentType == "Fatal"){
      accidents <- severity$fatal
    }
    if(input$severityAccidentType == "Injury Only"){
      accidents <- severity$injury
    }
    if(input$severityAccidentType == "Property Damage"){
      accidents <- severity$property.damage
    }
    severity_line <- ggplot(data= severity, aes(x=year, y= accidents, group=1)) +
      geom_line(color="steelblue4", size = 1.5)+
      geom_point(color = "tan1", size = 3.5) +
      theme_economist()+
      labs(title = paste("Number of", input$severityAccidentType,"accidents from 1988-2017"), x = "Year", y = "Number of accidents") + # accident type changes
      theme(plot.title = element_text(hjust = 0.5))
    print(severity_line)
  })
  output$severityGraph <- renderPlotly({
    ggplotly(severity_graph())
  })
  output$timeOfDayTable <- renderTable({
    time_of_day %>% dplyr::rename("Time"=TOD)
  })
  
  #Choose which day of the week. Not case sensitive
  TOD_graph <- reactive({
    #Default option
    if(input$dayOfWeek == "" | tolower(input$dayOfWeek) == "monday") {
      accidents <- time_of_day$Monday
      name <- paste("Monday")
    }
    if(tolower(input$dayOfWeek) == "tuesday") {
      accidents <- time_of_day$Tuesday
      name <- input$dayOfWeek
    }
    if(tolower(input$dayOfWeek) == "wednesday") {
      accidents <- time_of_day$Wednesday
      name <- input$dayOfWeek
    }
    if(tolower(input$dayOfWeek) == "thursday") {
      accidents <- time_of_day$Thursday
      name <- input$dayOfWeek
    }
    if(tolower(input$dayOfWeek) == "friday") {
      accidents <- time_of_day$Friday
      name <- input$dayOfWeek
    }
    if(tolower(input$dayOfWeek) == "saturday") {
      accidents <- time_of_day$Saturday
      name <- input$dayOfWeek
    }
    if(tolower(input$dayOfWeek) == "sunday") {
      accidents <- time_of_day$Sunday
      name <- input$dayOfWeek
    }
    time_of_day <- time_of_day[-(9:27),]
    TOD_order <- factor(time_of_day$TOD, level = c('12-3AM','3-6AM','6-9AM','9AM-12PM','12-3PM','3-6PM',"6-9PM", '9PM-12AM')) 
    TOD_line <- ggplot(data= time_of_day, aes(x= TOD_order, y= accidents, group=1)) +
      geom_line(color="steelblue4", size = 1.5)+
      theme_economist()+
      geom_point(color = "tan1", size = 3.5) +
      labs(title = paste("Average Number of Accidents on", name, "in 2017"), x = "Time of Day", y = "Number of accidents") + # accident type changes
      theme(plot.title = element_text(hjust = 0.5))
    print(TOD_line)
  })
  
  #Graph of time of day
  output$TODGraph <- renderPlotly({
    ggplotly(TOD_graph())
  })
  
  #table of driver demographics
  output$driverDemographicTable <- renderTable({
    driver_demographic
  })
  
  #Age-Sex accident demographic reactive plot
  demo_graph <- reactive({
    driver_demographic <- driver_demographic %>% filter(Age == input$age) # change in age
    driver_demographic <- gather(driver_demographic, sex, amount, 2:3)
    age_bargraph <-ggplot(data= driver_demographic, aes(x= sex, y= amount)) + # y changes with input
      geom_bar(stat="identity", fill="tan1") +
      theme_economist()+
      labs(title = paste("Male vs Females age", input$age), x = "Sex", y = "Number of accidents") + # accident type changes
      theme(plot.title = element_text(hjust = 0.5))
    print(age_bargraph)
  })
  
  #Output for Age-Sex accident demographic plot
  output$demoGraph <- renderPlotly({
    ggplotly(demo_graph())
  })
  
  #Victim Table
  output$victimTypeTable <- renderTable({
    victim_types %>% dplyr::rename("Passenger Cars"=colnames(victim_types)[2],"Light Trucks"=colnames(victim_types)[3],
                                   "Large Trucks"=colnames(victim_types)[4])
  })
  
  #Selects which type of the car the victim was using at the time of the accident and plots it on a line
  victim_demo <- reactive({
    inputData <- input$victimType
    if(inputData == "Passenger Car"){
      accidents <- victim_types$Passenger.Cars
    }
    if(inputData == "Light Truck"){
      accidents <- victim_types$Light.Trucks
    }
    if(inputData == "Large Truck"){
      accidents <- victim_types$Large.Trucks
    }
    if(inputData == "Bus"){
      accidents <- victim_types$Buses
    }
    if(inputData == "Motorcycle"){
      accidents <- victim_types$Motorcycles
    }
    if(inputData == "Pedestrian"){
      accidents <- victim_types$Pedestrian
    }
    if(inputData == "Cyclist"){
      accidents <- victim_types$Pedalcyclist
    }
    if(inputData == "Total"){
      accidents <- victim_types$Total
    }
  victim_line <- ggplot(data= victim_types, aes(x= year, y= accidents)) +
  geom_line(color="steelblue4", size = 1.5)+
    geom_point(color = "tan1", size = 3.5) +
    theme_economist()+
    labs(title = paste("Number of", input$victimType,"accidents from 1988-2017"), x = "Year", y = "Number of accidents") + # accident type changes
    theme(plot.title = element_text(hjust = 0.5))
  print(victim_line)
  })
  
  #Output for victim line
  output$victimDemo <- renderPlotly({
    ggplotly(victim_demo())
  })
  
})
