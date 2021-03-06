shinyUI(fluidPage(
  theme = shinythemes::shinytheme('cosmo'),
  titlePanel("Egovernments"),
  sidebarLayout(
    sidebarPanel(
      width = 3,
      fluidRow(
        selectInput(
          "complaintType", label = h5("Complaint Type"), 
          # show only the top complaint types
          choices = c( "All", topComplaintTypes)
        ),
        selectInput(
          "ward", label = h5("Ward"),
          choices = c("All",
                      as.character(unique(df$Ward))
                      [order(as.character(unique(df$Ward)))])
        ),
        selectInput(
          "timePeriod", label = h5("Periodicity"),
          choices = choicesForTime
        ),
        dateRangeInput(
          "dateRange", label = "Date Range",
          min = minDate, max = maxDate,
          start = minDate, end = maxDate
        ),
        sliderInput('daysToResolve', label = 'No. of Days to Resolve',
                    min = 0, max = 1050, value = c(0, 1050)),
        sliderInput('topNComplaintTypes', label = 'Number of Top Complaint Types',
                    min = 5, max = 15, value = 10),
        sliderInput('topNWards', label = 'Number of Top Wards by complaints',
                    min = 5, max = 15, value = 10)
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          title = 'Trends',
          tags$style(type = "text/css",
                     ".shiny-output-error { visibility: hidden; }",
                     ".shiny-output-error:before { visibility: hidden; }"
          ),
          dygraphOutput('plotData'),
          plotlyOutput('plotSpread')
        ),
        tabPanel(
          title = 'Top Wards and/or Complaints',
          br(),
          plotlyOutput("plotTopNComplaints"),
          br(), br(), br(),
          plotlyOutput("plotTopNWards")
        )
      )
    )
  )
))