#library(shiny)
library(shinythemes)
library(shinydashboard)


  ui = navbarPage(  tags$img(src= "https://argonaut.is.ed.ac.uk/public/tb.png")
, theme = shinytheme("flatly"),
                  tabPanel("TBS",
                           sidebarLayout(
                             sidebarPanel(
                               h3("This tab has a sidebar")
                             ),
                             mainPanel(
                               
                               tabItem("tbs",
                                       fluidRow(
                                         # Input
                                         column(2,
                                                fluidRow(source(file.path("ui", "ui_input1_header_v2.R"))$value),
                                                fluidRow(source(file.path("ui", "ui_input1_1_v2.R"))$value)
                                         ),
                                         column(2,
                                                source(file.path("ui", "ui_input1_2_v2.R"))$value
                                         ),
                                         column(2,
                                                source(file.path("ui", "ui_input1_3_v2.R"))$value,
                                                source(file.path("ui", "ui_input1_4_v2.R"))$value,
                                                
                                         ),
                                         column(3,
                                                fluidRow(
                                                  
                                                  
                                                  box(title = "TBS version 1 (discontinued)", status = "info", width=12),
                                                  infoBoxOutput("", width=12),
                                                  
                                                  box(plotOutput("v1_tbs", height = 150), width = 12),
                                                  
                                                  box(plotOutput("v1_m1_curve", height = 200), width = 12),
                                                  
                                                  infoBoxOutput("", width=12),
                                                  box(plotOutput("v1_m2_curve", height = 200), width = 12),
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  
                                                  ###########################################################
                                                  
                                                  
                                                ),
                                                source(file.path("ui", "ui_input1_5_v2.R"))$value
                                                
                                         ),
                                         column(3,
                                                fluidRow(
                                                  
                                                  
                                                  box(title = "TBS version 2 (current)", status = "info", width=12),
                                                  
                                                  box(plotOutput("v2_tbs", height = 150), width = 12),
                                                  
                                                  
                                                  
                                                  #     column(6, actionButton("add_graph", "Add Graph")),
                                                  #   column(6, actionButton("reset_graph", "Reset Graphs")),
                                                  # box( plotOutput("plots", height = 300), width = 12),
                                                  
                                                  
                                                  #        
                                                  box(plotOutput("v2_m1_curve", height = 200), width = 12),
                                                  #       
                                                  infoBoxOutput("", width=12),
                                                  
                                                  box(plotOutput("v2_m2_curve", height = 200), width = 12),
                                                  
                                                  # box(plotOutput("v1_m1_curve_base", height = 200), width = 12),
                                                  
                                                  
                                                  
                                                  
                                                  infoBoxOutput("ukeldBox", width=12),
                                                  infoBoxOutput("meldBox", width=12),
                                                  infoBoxOutput("meldnaBox", width=12),
                                                  
                                                  source(file.path("ui", "ui_1_6_selection_criteria_v2.R"))$value,
                                                  source(file.path("ui", "ui_1_7_cld_criteria_v2.R"))$value,
                                                  source(file.path("ui", "ui_footnote_v2.R"))$value
                                                )
                                                
                                                
                                         ),
                                         
                                                           ),
                                       
                                       # Retina images
                                       tags$script(type="text/javascript", src="retina.min.js")
                                       
                                                 ),
                               
                               
                               
                               
                               h2("Victim tab")
                             )
                           )
                  ),
                  tabPanel("Trafficker",
                           h2("Trafficker tab")
                  )
  )



# Server
server <- function(input, output, session) {
  
  # Include the logic (server) for each tab
  source(file.path("server", "server0_fn_comp_v3.R"),  local = TRUE)$value
  
  # TBS server ----
  source(file.path("server", "server1_1_v3.R"),  local = TRUE)$value
  source(file.path("server", "server1_2_v2.R"),  local = TRUE)$value
  source(file.path("server", "server1_3_v2.R"),  local = TRUE)$value
  # source(file.path("server", "server1_4_v2.R"),  local = TRUE)$value
  source(file.path("server", "server1_5_download_v2.R"),  local = TRUE)$value
  
  
  
  # ALF server ----
  source(file.path("server", "server2_1_alf.R"),  local = TRUE)$value
  
  # HCC server ----
  source(file.path("server", "server3_1_hcc.R"),  local = TRUE)$value
  
  # Variant server ----
  # Intentionally blank. 
}

# Run the application 
shinyApp(ui = ui, server = server)




