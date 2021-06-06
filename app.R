library(shiny)

if(require(shiny)){
    loadMesPackages <- function(){
        library("gsheet")
        library("tm")
        library("SnowballC")
        library("wordcloud")
        library("RColorBrewer")
        library("syuzhet")
        library("ggplot2")
        library(utf8)
        library(wordcloud2)
        #library('rsconnect')
        library(tidyverse)
    }
    loadMesPackages()

    # Define the UI
    ui <- fluidPage(
        titlePanel("ESC database"),
        tabsetPanel(
            type = "tabs",
            tabPanel("eurovison",
                     dataTableOutput('eurovision')
            )
        )
    )


    # Define the server code
    server <- function(input, output) {

        output$name <- renderDataTable({

        })
        output$eurovision <- renderDataTable({
            esc <- function(){
                df <- suppressWarnings(data.frame(gsheet2tbl('https://docs.google.com/spreadsheets/d/1BTbjPp-CPe_GQNEe-uKq8U3tLUocMM1YzvqPGZ0ScNE/edit#gid=380071250')))
                df
            }
            esc <- esc()
            esc <- esc %>% filter(DF=="F"||DF=="1"||DF=="2") %>% select(annee:Points,-Country)
            esc
        })
    }
    # Return a Shiny app object
    shinyApp(ui = ui, server = server)
}
