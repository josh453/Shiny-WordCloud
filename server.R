library(shiny)
library(wordcloud)
library(RColorBrewer)
source("wordcloud.R")

shinyServer(function(input, output) {
  blah <- reactive({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    dataset <- try(read.table(inFile$datapath,sep = ";"), TRUE)
    validate(
      need(class(dataset) != 'try-error', "Upload has empty rows, please fix and try again.")
    )
    dataset
  })
  worddata <- reactive({
    worddata <- wordcloudfun(blah())
    worddata
  })
  wordtable <- function(){
    dtm1 <- TermDocumentMatrix(worddata(), control = list(wordLengths = c(3,10)))
    dtm1 = removeSparseTerms(dtm1, 0.995)
    m <- as.matrix(dtm1)
    v <- sort(rowSums(m), decreasing=TRUE)
    freq <- sort(rowSums(as.matrix(dtm1)), decreasing=TRUE)
    data.frame(freq)
  }
  wordplot <- function(){
    wordplot <- wordcloud(worddata(),scale = c(6,1),max.words=input$maxwords,random.order=FALSE, 
                          rot.per=0.35,colors=brewer.pal(8, input$color),vfont=c(input$font,"plain"))
    wordplot
  }
  observeEvent(input$button, {
    output$wordcloud <- renderPlot ({
      withProgress(message = 'Plot is Loading',
                   detail = 'This may take a while...', value = 0, {
                     for (i in 1:10) {
                       wordplot()
                       incProgress(1/10)
                       Sys.sleep(0.25)
                     }
                   })
    })
  })
  output$downloadPlot <- downloadHandler(
    filename = "WordCloud.png",
    content = function(file) {
      png(file)
      wordplot()
      dev.off()
    }
  )
  output$downloadwords <- downloadHandler(
    filename = "WordTable.csv",
    content = function(file) {
      write.csv(wordtable(), file)
    }
  )
})