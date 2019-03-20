#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(flextable)
library(kableExtra)
library(knitr)
library(magrittr)
library(ReporteRs)
ID=c(LETTERS[1:5])
Group1=c(" ", "X", " ", "X", "X")
Group2=c("X", "X", "X", " ", " ")

df1=data.frame(ID, Group1, Group2)
rownames(df1)=df1$ID
df1$ID=NULL
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {

   # output$tbl <- renderDataTable({
   #   df1$ID <- paste0('<label><input type="checkbox" id="ID', 
   #                         seq_along(rownames(df1)), '"> <span>', rownames(df1), '</span></label>')
   #   df1 = df1[c("ID", "Group1", "Group2")] # Put col 'id' in the first place
   #   datatable(df1,rownames = F,
   #             escape=F )
   # })
   
   output$tbl <- renderFlexTable({
     df1$ID <- paste0('<label><input type="checkbox" id="ID', 
                      seq_along(rownames(df1)), '"> <span>', rownames(df1), '</span></label>')
     df1 = df1[c("ID", "Group1", "Group2")] # Put col 'id' in the first place
     ft = vanilla.table(df1) # convert to FlexTable objet
     ft = setZebraStyle( ft, odd = '#eeeeee', even = 'white' )
     
     ft[, "ID", to = "header"] <- parLeft() # left align checkboxes
     ft[, "ID"] <- parLeft() # left align header
     return(ft)
   })
  
  # output$tbl  <- function() {
  #      df1$ID <- paste0('<label><input type="checkbox" id="ID', 
  #                            seq_along(rownames(df1)), '"> <span>', rownames(df1), '</span></label>')
  #      df1 = df1[c("ID", "Group1", "Group2")] # Put col 'id' in the first place
  #   kable(df1 )%>%
  #     kable( escape = F) %>%
  #     column_spec(1, bold = T, border_right = T) %>%
  #     column_spec(2, background = "#f9d4da")%>%
  #     column_spec(3, background = "#c7cdf9")%>%
  #     kable_styling("striped", full_width = FALSE)%>%
  #     cat(., file = "df.html")
  # }
   ### input strategies
   str_selected=reactive({
     # results
     res <- unlist(lapply(1:nrow(df1), function(i) input[[paste0("ID", i)]]))
     if (any(res)) {
       a=rownames(df1)[res]
     } else{
       a=NULL
     }
     a
   })
   output$default <- renderText({ 
     str_selected()
     })
  observe({
    updateCheckboxInput(session, 'ID1', value =input$bar)
    updateCheckboxInput(session, 'ID2', value =input$bar)
    updateCheckboxInput(session, 'ID3', value =input$bar)
    updateCheckboxInput(session, 'ID4', value =input$bar)
    updateCheckboxInput(session, 'ID5', value =input$bar)
  })
  
  observe({
    updateCheckboxInput(session, 'ID2', value =input$grp1)
    updateCheckboxInput(session, 'ID4', value =input$grp1)
    updateCheckboxInput(session, 'ID5', value =input$grp1)
  })
  
  observe({
    updateCheckboxInput(session, 'ID1', value =input$grp2)
    updateCheckboxInput(session, 'ID2', value =input$grp2)
    updateCheckboxInput(session, 'ID3', value =input$grp2)
  })
  
})
