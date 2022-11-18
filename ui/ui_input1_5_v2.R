wellPanel( collapsible = TRUE, 
	tags$b("Example patients: younger  "),
	
	actionButton("NAFLD_60_45", "NAFLD age 45 UKELD 60"),
	
	actionButton("NAFLD_49_45", "NAFLD age 45 UKELD 49"),
	
	actionButton("ALD_60_45", "ALD age 45 UKELD 60"),

	actionButton("ALD_49_45", "ALD age 45 UKELD 49"),	
 
 	actionButton("PSC_60_45", "PSC age 45 UKELD 60"),
 
 actionButton("retx_60_45", "Retransplant age 45 UKELD 60"),
 
 actionButton("ca_size5_afp1000_45", "Max cancer age 45"),
 
 tags$br(),
 
 tags$b("Example patients: older  "),
 
 actionButton("NAFLD_60_65", "NAFLD age 65 UKELD 60"),
 
 actionButton("NAFLD_49_65", "NAFLD age 65 UKELD 49"),
 
 actionButton("ALD_60_65", "ALD age 65 UKELD 60"),
 
 actionButton("ALD_49_65", "ALD age 65 UKELD 49"),
 
 actionButton("PSC_60_65", "PSC age 65 UKELD 60"),
 
 actionButton("retx_60_65", "Retransplant age 65 UKELD 60"),
 
 actionButton("ca_size5_afp1000_65", "Max cancer age 65"),
 
 tags$br(),
 
 tags$b("Additions:  "),
 
  actionButton("inpatient", "Admit to hospital"),
 
 	actionButton("yrs3_wait", "+ 3 years"),
	
 actionButton("small_cancer", "+ 2cm cancer"),
	
 actionButton("large_cancer", "+ 5cm cancer"),
 
 actionButton("max_cancer", "+ 5cm cancer AFP 1000"),
 
 actionButton("ascites_enceph", "+ ascites & encephalopathy"),

 
 actionButton("renal_replace", "+ renal replacement therapy"),
 
   
	
	
#	actionButton("ALD_60_ca", "+ cancer"),
	
#	actionButton("rreset", "Recipient"),
#	actionButton("dreset", "Donor"),
#	tags$h4("Examples: recipient"),
#	actionButton("rmodrisk", "Mod risk"),
#	actionButton("rhighrisk", "High risk"),
#	actionButton("rveryhighrisk", "V high risk"),
#	actionButton("rcancer", "HCC early"),
#	actionButton("rcancerclose", "HCC at criteria"),
#	tags$h4("Examples: donor"),
#	actionButton("dlowrisk", "DBD good"),
#	actionButton("dmodrisk", "DBD moderate"),
#	actionButton("dmarginal", "DBD marginal"),
#	actionButton("ddcdgood", "DCD good"),
#	actionButton("ddcdmarginal", "DCD marginal"),
#	tags$h4("Examples: change over time"),
#	actionButton("decompensate", "Decompensate (click 1 mth)"),
#	actionButton("stable_on_list", "Stable on list (click 6 mths)"),
#	actionButton("cancer_growing", "HCC grows (click 2 mm/mth)")
)