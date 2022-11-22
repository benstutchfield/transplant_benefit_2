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
        
        # tabPanel("Young patient", 	actionButton("NAFLD_60_45", "NAFLD age 45 UKELD 60"), 
        #          
        #          actionButton("NAFLD_49_45", "NAFLD age 45 UKELD 49"),
        #          
        #          actionButton("ALD_60_45", "ALD age 45 UKELD 60"),
        #          
        #          actionButton("ALD_49_45", "ALD age 45 UKELD 49"),	
        #          
        #          actionButton("PSC_60_45", "PSC age 45 UKELD 60"),
        #          
        #          actionButton("retx_60_45", "Retransplant age 45 UKELD 60"),
        #          
        #          actionButton("ca_size5_afp1000_45", "Max cancer age 45"),
        #          
        #          ),
        
        # tabPanel("Older patient",  actionButton("NAFLD_60_65", "NAFLD age 65 UKELD 60"),
        #          
        #          actionButton("NAFLD_49_65", "NAFLD age 65 UKELD 49"),
        #          
        #          actionButton("ALD_60_65", "ALD age 65 UKELD 60"),
        #          
        #          actionButton("ALD_49_65", "ALD age 65 UKELD 49"),
        #          
        #          actionButton("PSC_60_65", "PSC age 65 UKELD 60"),
        #          
        #          actionButton("retx_60_65", "Retransplant age 65 UKELD 60"),
        #          
        #          actionButton("ca_size5_afp1000_65", "Max cancer age 65"),
        #          
        #          ), 
        
)