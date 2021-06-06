library(shiny)

if(require(shiny)){
    library(wordcloud2)
    library('rsconnect')
    suppressWarnings(source("./fctR/sources.R"))
    suppressWarnings(library(tidyverse))

    # Define the UI
    ui <- fluidPage(
        titlePanel("ESC database"),
        sidebarLayout(
            sidebarPanel(
            ),
            mainPanel(
                tabsetPanel(
                    type = "tabs",
                    tabPanel("eurovison",
                             dataTableOutput('eurovision')
                    )
                )

                # wordcloud2Output('wordcloud2'),
                # tableOutput('table')
            )
        )


    )


    # Define the server code
    server <- function(input, output) {

        output$hist <- renderDataTable({
            data <- data.frame(listDesc.desc())
            data %>% select(tisaep,Horodateur,status)
        })
        output$premder <- renderDataTable({
            data <- data.frame(premder.premder())
            data %>% filter(tisaep.all_1 != "") %>% select(tisaep.all_1,date.premder.all_1,status.all_1)
        })
        output$name <- renderDataTable({

        })
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
