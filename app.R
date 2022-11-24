# TransplantBenefit.org
# Ewen Harrison + Ben Stutchfield
# Surgical Inforamatics
# University of Edinburgh
# Started November 2022

#tester

#library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(shinyWidgets)
library(DT)

#library(readr)
#library(ggplot2)
#library(ggridges)
#library(viridis)
#library(finalfit)

#library(patchwork)



#add in acute on chronic
#add in parameters

# Define UI
ui <- dashboardPage(
  
  title = "The Liver Score app",
  skin="black",
  
  dashboardHeader(
    disable = FALSE,
    tags$li(class = "dropdown", # Hack to get this to work. 
            tags$head(
              tags$link(rel="shortcut icon", href="https://argonaut.is.ed.ac.uk/public/favicon.ico"),
              
              # Google analytics tracker info pasted into root file named as below. Not included in git. 
              # includeHTML("analytics.html")
            )
    ),
    
    title = tags$img(src= "https://argonaut.is.ed.ac.uk/public/tb.png"),
    
    
    # Retina quality images via JS plugin, see end body
   # title = HTML("<a href = 'https://transplantbenefit.org'>
		#							<img src='/public/tb.png' data-rjs = '3' />
		#								</a>,"
  #  ),
    
    titleWidth = 320
  ),
  
  
  
  
  
  dashboardSidebar(disable = FALSE, collapsed = TRUE,
                   sidebarMenu(
  
              #  menuItem("Overview", tabName = "overview"),
                     menuItem("Transplant benefit score", tabName = "tbs"),
                     
                #     menuItem("TBS parameters: v1 & v2", tabName = "tbs_params"), 

                  
                     menuItem("HCC", tabName = "hcc"),
                     
                     menuItem("Acute liver failure", tabName = "acute_liver"),
                     
                      menuItem("Acute on Chronic listing criteria", tabName = "acute_on_chronic"), 
                     
                     menuItem("Variant syndromes", tabName = "variants"),
                     
                     menuItem("UK PSC risk score", tabName = "uk_psc"),
                     
                     menuItem("About", tabName = "about")
      
                     )
  ),
  
  dashboardBody(
    tabItems(
      # Overview ----
      tabItem("overview", 

              fluidPage(
                titlePanel("TransplantBenefit.org"), 
                mainPanel(


                  em("This app includes tools used to predict outcomes in patients with liver disease."),
                  p(em("The app is provided as an information resource for clinicians and is not to be used for any diagnostic or treatment purposes.")),
                  br(),
                  br(),
                  br(),
                  h3("Transplant Benefit Score"),

                  em("Calculates the net benefit of transplant for UK liver transplant waiting list patients"),
                  p(em("Transplant benefit score is used to allocated deceased donors after brain stem death within the UK")),

                #  strong("Parameters included in each version:"),
                 # p("version 1 (active March 2018 - October 2022): "), 
                #  p("version 2 (active October 2022 - present): "),
                  br(),
                  br(),
                  br(),
                  h3("Acute liver failure"),
                p(em("UK transplant superurgent selection criteria for patients with acute liver failure")),
                br(),
                br(),
                br(),
                h3("Acute on chronic listing category"), 
                p(em("TBC")),
                  br(),
                  br(),
                  br(),
                  h3("HCC (hepatocellular carcinoma)"),
                p(em("UK transplant selection criteria for patients with hepatocellular carcinoma")),
                
                  br(),
                  br(),
                  br(),
                  h3("Variant syndromes"),    
                p(em("Patient eligable for transplantation via the variant syndrome pathway")),
                br(),
                br(),
                br(),
                h3("UK PSC risk score"),
                p(em("TBC"))
                  
                  ))),
      
      # Transplant benefit score  ----
      
      
      tabItem("tbs",# checkboxInput('showPanel1', 'Show panel', FALSE),
            #  conditionalPanel(condition = 'input.showPanel1',
              
                        #  source(file.path("ui", "ui_input1_5_v2.R"))$value,

            fluidRow(
              
              align = "center", style="color:red",
              
              "This app is provided as an information resource for clinicians and patients. It is not to be used for any diagnostic or treatment purposes.",
            ),
            
            fluidRow( "." ),
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

                     
                      box( title = "TBS version 1 (discontinued Oct 2022)", status = "warning", solidHeader = TRUE,  addSpinner( plotOutput("tbs_v1_base", height = 100), color = "#FF911C"), width = 12 ), 

                       
                      box(title = "Survival without transplant (Need)",  collapsible = TRUE, collapsed = TRUE, status  = "warning",  plotOutput("v1_m1_curve_base", height = 200), width = 12),
                      
                      infoBoxOutput("", width=12),
                       box(title = "Survival after transplant (Utility)", collapsible = TRUE, collapsed = TRUE,  status  = "warning",  plotOutput("v1_m2_curve_base", height = 200), width = 12),
                        
               
                    box(title = "TBS is based on area under predicted survival curves without transplant and after transplant",  height = 60, width=12),
                    
                    
                  tabBox( title = "Examples",
                            width = 12, height = "250px", side = "right",
                            id = "tabset1",



                             tabPanel("Additions",


                                      actionButton("yrs3_wait", "+ 3 years"),

                                      actionButton("small_cancer", "+ 2cm cancer"),

                                      actionButton("large_cancer", "+ 5cm cancer"),

                                      actionButton("max_cancer", "+ 5cm cancer AFP 1000"),

                                      actionButton("remove_cancer", "Remove cancer"),

                                      actionButton("inpatient", "Admit to hospital"),

                                      actionButton("outpatient", "Outpatient"),

                                      actionButton("ascites_enceph", "+ ascites & encephalopathy"),

                                      actionButton("renal_replace", "+ renal replacement therapy"),

                             ),

                           tabPanel("Young patient", 	actionButton("NAFLD_60_45", "NAFLD age 45 UKELD 60"),
                          
                                    actionButton("NAFLD_49_45", "NAFLD age 45 UKELD 49"),
                          
                                    actionButton("ALD_60_45", "ALD age 45 UKELD 60"),
                          
                                    actionButton("ALD_49_45", "ALD age 45 UKELD 49"),
                          
                                    actionButton("PSC_60_45", "PSC age 45 UKELD 60"),
                          
                                   actionButton("retx_60_45", "Retransplant age 45 UKELD 60"),
                          
                                    actionButton("ca_size5_afp1000_45", "Max cancer age 45"),
                          
                                    ),

                           tabPanel("Older patient",  actionButton("NAFLD_60_65", "NAFLD age 65 UKELD 60"),
                          
                                    actionButton("NAFLD_49_65", "NAFLD age 65 UKELD 49"),
                          
                                  actionButton("ALD_60_65", "ALD age 65 UKELD 60"),
                          
                                    actionButton("ALD_49_65", "ALD age 65 UKELD 49"),
                          
                                    actionButton("PSC_60_65", "PSC age 65 UKELD 60"),
                          
                                    actionButton("retx_60_65", "Retransplant age 65 UKELD 60"),
                          
                                    actionButton("ca_size5_afp1000_65", "Max cancer age 65"),
                          
                                    ),

                          ),
                  
                  
                  
                  
                  
                  

                  ),

                ),


                column(3,
                   fluidRow(
 
                      box(title = "TBS version 2 (current)", status = "primary", solidHeader = TRUE, addSpinner( plotOutput("tbs_v2_base", height = 100), color = "#0073B7"), width = 12), 
                   
                        box(title = "Survival without transplant (Need)", status = "primary",  collapsible = TRUE, collapsed = TRUE, plotOutput("v2_m1_curve_base", height = 200), width = 12),
                  #       
                       infoBoxOutput("", width=12),
                         
                        box(title = "Survival after transplant (Utility)", status = "primary",  collapsible = TRUE, collapsed = TRUE, plotOutput("v2_m2_curve_base", height = 200), width = 12),
                                                             
                      box(title = "TBS = Survival AFTER transplant (Utility) - Survival WITHOUT transplant (Need)",  height = 60, width=12),

                 
                 tabBox( title = "Other", 
                         width = 12, height = "250px", side = "right",
                   id = "tabset2", 
                   
                    tabPanel("UKELD", infoBoxOutput("ukeldBox", width=12)),

                    tabPanel("MELD-Na", infoBoxOutput("meldnaBox", width=12) ),
                   
                    tabPanel("MELD",  infoBoxOutput("meldBox", width=12)),

                 ),),
                 
                 source(file.path("ui", "ui_footnote_v2.R"))$value,
                 
                 fluidRow(
                   column(12,
                          checkboxInput("data_table", label = "Show data table", FALSE),
                          conditionalPanel(
                            condition = 'input.data_table == true',
                            DT::dataTableOutput("x1"))
                   ),
                 ),
                 
                 
                 
                 ),
                
                
                
                
                
                ),

              # Retina images
              tags$script(type="text/javascript", src="retina.min.js")
      ),
      
      
      # TBS parameters ----
      tabItem("tbs_params", 
              
              fluidPage(
                #  titlePanel("TransplantBenefit.org"), 
                mainPanel(
                  
                  br(),
                  
                  p(em(" parameters included in the TBS version 1 and TBS version 2 calculations")),
 
                ))),
      
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
                ))),
      
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
      
      # Variant syndromes ----
      tabItem("variants",
              source(file.path("ui", "ui_input4_1_var.R"))$value
      ),
      
      # Acute on chronic listing category ----
      tabItem("acute_on_chronic", 
              
              fluidPage(
                titlePanel("TBC"))
              
              ),
      
      # UK PSC risk score ----
      tabItem("uk_psc", 
              fluidPage(
                titlePanel("TBC"))
              
      ),
              

      # About ----
      tabItem("about", 
  
              fluidPage(
              #  titlePanel("TransplantBenefit.org"), 
                mainPanel(
                  
                  p("TBC"),

                )) ))  ) )


# Server
server <- function(input, output, session) {
  
  # Include the logic (server) for each tab
  source(file.path("server", "server0_fn_comp_v3.R"),  local = TRUE)$value
  
  # TBS server ----
  source(file.path("server", "server1_1_v3b.R"),  local = TRUE)$value
  source(file.path("server", "server1_2_v2.R"),  local = TRUE)$value
  source(file.path("server", "server1_3_v2.R"),  local = TRUE)$value
  source(file.path("server", "server1_4_v2.R"),  local = TRUE)$value
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











