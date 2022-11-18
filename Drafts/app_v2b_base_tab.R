# TransplantBenefit.org
# Ewen Harrison + Ben Stutchfield
# Surgical Inforamatics
# University of Edinburgh
# Started November 2022

#library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(ggridges)
library(viridis)
library(finalfit)
library(DT)
library(patchwork)



#add in acute on chronic
#add in parameters

# Define UI
ui <-  
  

  
  
  navbarPage(
    title = "Title here",
    skin="black",
  
  
   tabPanel("tab1",
            
            # Transplant benefit score  ----
            tabItem("tbs",
                    
                    source(file.path("ui", "ui_input1_5_v2.R"))$value,
                    fluidRow(
                      # Input
                      column(2,
                             # fluidRow(source(file.path("ui", "ui_input1_header_v2.R"))$value),
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
                               
                               box(title = "TBS version 1 (discontinued)", status = "info", height = 50, width=12),
                               # infoBoxOutput("", width=12),
                               
                               box(plotOutput("tbs_v1_base", height = 100), width = 12), 
                               
                               #  box(plotOutput("v1_tbs", height = 100), width = 12),
                               box(title = "TBS Survival predictions",  height = 40, status = "info", width=12),
                               
                               box(plotOutput("v1_m1_curve_base", height = 200), width = 12),
                               
                               infoBoxOutput("", width=12),
                               box(plotOutput("v1_m2_curve_base", height = 200), width = 12),
                                           ),
                             #        source(file.path("ui", "ui_input1_5_v2.R"))$value
                             
                      ),
                      column(3,
                             fluidRow(
                               
                               
                               box(title = "TBS version 2 (current)", status = "info", height = 50,  width=12),
                               
                               #     box(plotOutput("v2_tbs", height = 100), width = 12),

                               box(plotOutput("tbs_v2_base", height = 100), width = 12), 
                          box(title = "TBS Survival predictions", height = 40, status = "info", width=12),
                               
                                     
                               box(plotOutput("v2_m1_curve_base", height = 200), width = 12),
                               #       
                               infoBoxOutput("", width=12),
                               
                               box(plotOutput("v2_m2_curve_base", height = 200), width = 12),
                               
                               
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
            
   
            
           ),
   
   
   

   
   tabPanel("panel 2", 
            
            
            # Acute liver failure ----
            tabItem("acute_liver",
                    fluidRow(
                      
                      
                      
                      
                      
                      
                      
                      column(width = 4,
                             source(file.path("ui", "ui_input2_1_acute_liver.R"))$value
                      ),
                      column(width = 4,
                             infoBoxOutput("uk_alfBox", width=12)
                      ),
                      column(width = 4,
                             source(file.path("ui", "ui2_2_ald_criteria.R"))$value,
                             source(file.path("ui", "ui_footnote.R"))$value
                      )
                    )
            )
            ),
            
            

   tabPanel("panel 3", 
            
            
            # Hepatocellular carcinoma ----
            tabItem("hcc", 
                    fluidRow(
                      column(width = 4,
                             source(file.path("ui", "ui_input3_1_hcc.R"))$value
                      ),
                      column(width = 4,
                             infoBoxOutput("uk_hccBox", width=12),
                             infoBoxOutput("milan_hccBox", width=12),
                             infoBoxOutput("ucsf_hccBox", width=12)
                      ),
                      column(width = 4,
                             infoBoxOutput("duvoux_hccBox", width=12),
                             source(file.path("ui", "ui_hcc_criteria.R"))$value,
                             source(file.path("ui", "ui_footnote.R"))$value
                      )
                    )
            ),
            
            
            
            
            "three"),


tabPanel("panel 4",
         
# TBS parameters ----
tabItem("tbs_params", 
        
        fluidPage(
          #  titlePanel("TransplantBenefit.org"), 
          mainPanel(
            
            br(),
            
            p(em(" parameters included in the TBS version 1 and TBS version 2 calculations")),
            
            
            
          ))
        
        
        
)),

tabPanel("panel 5",
         
         # Variant syndromes ----
         tabItem("variants",
                 source(file.path("ui", "ui_input4_1_var.R"))$value
         )
         
         
         
         ),




tabPanel("panel 6",
         
         # Acute on chronic listing category ----
         tabItem("acute_on_chronic", 
                 
                 fluidPage(
                   titlePanel("TBC"))
                 
         )
        
         
         ),

tabPanel("panel 7",
         
         
         # UK PSC risk score ----
         tabItem("uk_psc", 
                 fluidPage(
                   titlePanel("TBC"))
                 
         ),
         
         
         
         
         
         
         
         
         
         )
)


  
  
            

  
#  dashboardHeader(
#    disable = FALSE,
#    tags$li(class = "dropdown", # Hack to get this to work. 
 #           tags$head(
#              tags$link(rel="shortcut icon", href="https://argonaut.is.ed.ac.uk/public/favicon.ico"),
              
              # Google analytics tracker info pasted into root file named as below. Not included in git. 
              # includeHTML("analytics.html")
 #           )
#    ),
    
    # Retina quality images via JS plugin, see end body
 #   title = HTML("<a href = 'https://transplantbenefit.org'>
#									<img src='/public/tb.png' data-rjs = '3' />
	#									</a>,"
   # ),
    
  #  titleWidth = 320
#  ),
  
  
#
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











