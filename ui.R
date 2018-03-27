library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Word Cloud Tool"),
  sidebarLayout(
    sidebarPanel(
      h3("Upload .csv to make a Word Cloud!"),
      fileInput('file1', 'Choose CSV File',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      ),
      tags$hr(),
      numericInput("maxwords", label = "Maximum number of words", value = 50, min = 1, max = 500),
      selectInput("color","Select a Color Scheme",c("Accent","Dark2","Paired","Pastel1","Pastel2","Set1","Set2","Set3")),
      selectInput("font","Select a Font",c("serif","script","gothic english")),
      actionButton("button","Submit",
                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
      br(),
      br(),
      downloadButton('downloadPlot', 'Download WordCloud'),
      downloadButton('downloadwords', 'Download Word Table')
    ),
    mainPanel(
      plotOutput("wordcloud")
    )
  ),
  hr(),
  print("This application was created using RStudio, Shiny and the wordcloud package."),
  br(),
  print("Created and published by Joshua Stewart")
))