
library(htmltools)
to_html_table<-function(dataframe){
  tags$table(
    tags$thead(tags$tr(lapply(colnames(dataframe), function(x) tags$th(x)))),
    tags$tbody(
      apply(dataframe,1, function(x) { tags$tr(lapply(x, function(y) tags$td(y)))})
    ))
}

to_html_table(iris[1:5,])
library(shiny)

# Define UI ----
ui <- fluidPage(
  uiOutput("table1")
  # ,
  # to_html_table(iris[1:5,])
)

# Define server logic ----
server <- function(input, output) {
  output$table1 <- renderUI(
    to_html_table(iris[1:5,])
  )
}

# Run the app ----
shinyApp(ui = ui, server = server)