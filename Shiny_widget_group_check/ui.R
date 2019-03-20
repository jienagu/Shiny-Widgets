#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(ReporteRs)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Group Selection"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxInput('bar', 'All/None',width = 300),
      checkboxInput('grp1', 'Select Options in Group 1?',width = 300),
      checkboxInput('grp2', 'Select Options in Group 2?',width = 300) 
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow( column(4, 
    #  dataTableOutput("tbl"),
      tableOutput('tbl')
      ),
      column(4, 
      verbatimTextOutput("default") )
     # tableOutput("tbl")
      )
    )
  )
))
