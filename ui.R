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
library(plotly)
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
  div(img(src='banner.png'), align="center"),
  navbarPage(theme = shinythemes::shinytheme("slate"),
             "Bad Drivers",
             
             #Introduction page
             tabPanel("Home",
                      fluidRow(column(7,offset = 3,titlePanel("Bad Drivers and Insurance statistics in the United States of America 2017"))),
                      p("On average 3,287 die from a car accident every day, that is a lot of lives lost. Bad driving is a big problem in the United states
                        taking the 3rd place spot on leading causes of death. While we have come a long way, increasing car safety through seatbelts and airbags,
                        and educating more of the population on the importance of safe driving habits, there is still more to be done. The information in this application
                        was gathered by the National Highway Traffic Safety Administration 2017 anual motor safety report. This application's aim is to educate insurance companies
                        and other services related to road safety on trends to better implement their services, as well as provide information to the general public to be more
                        aware of their own safety efforts."),
                       div(img(src='photo1.jpg'), align="center")
              ),
                        
             #Interactive maps
             tabPanel("State Data",
                                               h2("Number of drivers involved in fatal collisions (per billion miles)"),
                                               leafletOutput("map1"),
                                               div("As Shown in this map, Southern, Central, and Central-Northern states have the highest number of drivers
                                                   involved in fatal collisions per 1 billion miles. As a reminder, this is just correlation so further investigation
                                                   is necessary in order to establish a well-established conclusion."),

                                               h2("Percentage of drivers who were speeding"),
                                               leafletOutput("map2"),
                                               div("While many drivers were speeding at the time of the accident, only Pennsylvania had a percentage that was 50 percent or above.
                                                   Perhaps this suggests that most acts of incompetence that cause accidents are not speeding-related and that there are other signifiers
                                                   to take into account when it comes to predicting what kinds of accidents to expect."),

                                               h2("Percentage of drivers who were alcohol impaired"),
                                               leafletOutput("map3"),
                                               div("On average, between 20 and 35 percent of fatal accidents were attributed to alcohol impairment in most states. However, States
                                                   like Texas, South Carolina, Hawaii, Montana, Rhode Island and North Dakota had percentages that were in the high thirties or even
                                                   low forties."),

                                               h2("Percentage of drivers who were NOT distracted"),
                                               leafletOutput("map4"),
                                               div("Surprisingly, The vast majority of drivers at the time of accidents were not classified as distracted. Wisconsin and
                                                   Mississippi are exceptions as only 39 and 10 percent of drivers in accidents respectively were not classified as distracted."),

                                               h2("Percentage of drivers who had not been involved in previous accidents"),
                                               leafletOutput("map5"),
                                               div("The majority of drivers involved in such accidents do not have a history of accidents in the past. However, the percentage
                                                   of those who were not involved in previous accidents does vary by state. The East Coast seems to have noticeably lower percentages
                                                   of drivers who were not involved in previous accidents than other states. Maybe this could be due to higher population density leading
                                                   to a higher concentrations of motor vehicles on the roads that is responsible for people being more likely to be involved in accidents in the past."),

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
                                                   and causation.")
                          ),
             tabPanel("Drunk Driving",
                   navbarPage("The Data",
                                        tabPanel("Drunk Driving",
                                                 sidebarLayout(
                                                   sidebarPanel(
                                                     sliderInput("yearForAlcGraph", label = h3("Year"), min = 1988, #fix scaling to be in years
                                              max = 2017, value = 2000, animate = TRUE), p("While many accidents happened when the driver had a BAC of 0, these accidents were likely caused
                                                                                           by other distractions such as texting while driving or other distracted driving. While those accidents are a majority
                                                                                           accidents caused by those legally intoxicated have large numbers as well. Since 1988 the number of accidents caused by drunk driving
                                                                                           has gone down significantly as research and awareness of achohol's harm has increased. Services such as Uber and Lift have also helped to 
                                                                                           decrease the number of intoxiated people on the roads, by providing them a safe way to get home.")),
                                              mainPanel(plotlyOutput("alcoholLevelsGraph"), p(" Getting behind the wheel of a vehicle after a night of brinking is
                                                        a crime. Driving under the influence (DUI) is defined as operating a vehicle with a blood alcohol content of 0.08% or 
                                                        above. A DUI is classified as a misdemeanor in all states, and punishment usually means up to six months in jail on a first offense, time may be increased by situation.
                                                        Even drinking a small amount of alcohol can be harmful. The effects of alcohol put you at a higher risk of accident
                                                        or road injury. It takes a lot of ability to drive safely such as concentration and quick judgments
                                                        both of which alcohol affects"),
                                                        p(" Slow reaction times: Drinking slows your response time which increases the likelihood of an accident."),
                                                        p(" Reduced coordination: Drinking affects your vision, and hand and foot coordination, all of which are very important when driving."),
                                                        p(" Decreased concentration: Alcohol greatly affects concentration, something very important when driving such as staying in your lane,
                                                          paying attention to other cars and understanding traffic signs.")
                                              )
                                              )
                                              ),
                                              tabPanel("Drunk Driving Table",mainPanel(tableOutput("alcoholLevelsTable")))
                 )
                ),
        tabPanel("Trends in 2017",
                 navbarPage("The Data",
                                      tabPanel("Monthly Trends",
                                               sidebarLayout(
                                                 sidebarPanel(radioButtons("byMonthAccidentType", label = h3("Type of Accident"),
                                                                           choices = list("Fatal" = "Fatal", "Injury Only" = "Injury Only", "Property Damage" = "Property Damage"),
                                                                           selected = "Fatal"), p("Fatal accidents seem to decline when transitioning from Fall to winter and rising significantly from early winter to mid summer.
                                                                           Injuries also appear to be more common during the spring, summer, and fall compared to winter months. Another interesting observation is that mid summer 
                                                                           shows noticeably fewer instances of propoerty damage compared to winter, spring, and fall. ")
                                                 ),
                                                 mainPanel(plotlyOutput("byMonthGraph"))
                                               )
                                      ),
                                      tabPanel("Weekly Trends",
                                               sidebarLayout(
                                                 sidebarPanel(textInput("dayOfWeek", label = h3("Day of the Week"), placeholder = "Monday"),
                                                 p("The average number of accidents seems to rise from early moorning to 3-6 PM and declines shortly after. Perhaps this is due to rush hour leading
                                                 to a higher concentration of cars on the road")
                                                              ),
                                                 mainPanel(plotlyOutput("TODGraph"))
                                                 )
                                               ),
                                      navbarMenu("Tables",
                                                 tabPanel("Monthly Trends Table",
                                                          tableOutput("monthTable")
                                                 ),
                                                 tabPanel("Weekly Trends Table",
                                                          tableOutput("timeOfDayTable"))
                                      )
        )
        ),

        tabPanel("Trends Through the Years",
                 navbarPage("The Data",
                                        tabPanel("Accident Severity",
                                                 sidebarLayout(
                                                   sidebarPanel(radioButtons("severityAccidentType", label = h3("Type of Accident"),
                                                                             choices = list("Fatal" = "Fatal", "Injury Only" = "Injury Only", "Property Damage" = "Property Damage"),
                                                                             selected = "Fatal"),
                                                                             p("Over the years, fatal injuries have decreased and/or plateaued. However, starting in 2010, the number of fatal accidents has begun to rise.  Injury-only
                                                                             accidents also experienced similar declines and raises except without the same plateauing phenomenon. However, for instances of property damage, relatively consistent
                                                                             numbers have been maintained between the mid 1990s and late 2000's. ")
                                                   ),
                                                   mainPanel(plotlyOutput("severityGraph"), p("Many inovative technologies have helped reduce the number of accidents on our roads. Some of those technologies are..."),p("Passenger restraints such as seat belts"),p("Airbags"),
                                                             p("Crash avoidance equipment such as lights and reflectors"), p("Driver assistance systems such as Electronic Stability Control"), p("Safety glass"), p("Car services such as Uber help get intoxicated people off the road"))
                                                 )
                                          ),
                                                 tabPanel("Severity Table",
                                                          tableOutput("severityTable"))
                 )),

         tabPanel("Accident Demographic",
                   navbarPage("The Data",
                                        tabPanel("Driver Demographic",
                                                 sidebarLayout(
                                                   sidebarPanel(radioButtons("age", label = h3("Age"),
                                                                             choices = list("<16" = "<16", "16-20" = "16-20", "21-24" = "21-24", "25-34" = "25-34",
                                                                                            "35-44" = "35-44", "45-54" = "45-54", "55-64" = "55-64", "65-74" = "65-74", ">75" = ">74"),
                                                                             selected = "<16"),
                                                                             p("In any given age group, males were more likely to be involved in car accidents than females. The age group that had the most number of accidents were males and females age 25-34")
                                                   ),
                                                   mainPanel(plotlyOutput("demoGraph"))
                                                 )

                                        ),
                                        tabPanel("Victim Demographic",
                                                 sidebarLayout(
                                                   sidebarPanel(radioButtons("victimType", label = h3("Type of Transportation Victim Was Using"),
                                                                             choices = list("Passenger Car"= "Passenger Car", "Light Truck"= "Light Truck", 
                                                                                            "Large Truck"= "Large Truck", "Bus"= "Bus","Motorcycle"="Motorcycle",
                                                                                            "Pedestrian"="Pedestrian", "Cyclist"="Cyclist", "Total"= "Total"), selected = "Passenger Car"),
                                                                                            p("In 1997, the total number of vehiclees victimized in accidents peaked at 3.348 Million vehicles. Every year, the majority of vehicles victimized in accidents
                                                                                            were Light Trucks.")
                                                   ),
                                                 mainPanel(plotlyOutput("victimDemo"))
                                                 )),
                                        navbarMenu("Tables",
                                                   tabPanel("Driver Demographic Table",
                                                            tableOutput("driverDemographicTable")
                                                   ),
                                                   tabPanel("Victim Demogaphic",
                                                            tableOutput("victimTypeTable")
                                                   )
                                        )
                          )

      )
  )
))
