wellPanel( 
	h4("Recipient"),
	fluidRow(
		column(6,
					 selectInput("centre_tbs", label = "Centre", 
					 						choices = list("Newcastle" = 0, 
					 													 "Leeds" = 1,
					 													 "Cambridge" = 2,
					 													 "Royal Free" = 3,
					 													 "King's College" = 4,
					 													 "Birmingham" = 5,
					 													 "Edinburgh" = 6,
					 													 "Other" = 7),
					 						selected = 6, selectize=FALSE, width=NULL)),
		column(6, 
					 selectInput("rregistration_tbs", label = "Registered", 
					 						choices = list("2013+" = 1,
					 													 "2012" = 7,
					 													 "2011" = 6,
					 													 "2010" = 5,
					 													 "2009" = 4,
					 													 "2008" = 3,
					 													 "2007" = 2),
					 						selected = 1, selectize=FALSE, width=NULL))
	),
	radioButtons("rinpatient_tbs", label = "Location", 
							 choices = list("Outpatient" = 0, "Inpatient" = 1),
							 selected = 0, width=NULL, inline=TRUE),
	sliderInput("rwaiting_time_tbs", "Waiting time (days)", value=30, min = 0, max = 2000, step = 1,
							width = NULL),
	
	sliderInput("rage_tbs", "Recipient age (years)", value=52, min = 12, max = 90, step = 0.5,
							width = NULL),
	radioButtons("rgender_tbs", label = "Sex", 
							 choices = list("Male" = 0, 
							 							 "Female" = 1),
							 selected = 0, width=NULL, inline=TRUE),
	selectInput("rdisease_primary_tbs", label = "Primary liver disease", 
							choices = list("Alcohol" = 3,
														 "NAFLD" = 8, 
														 "HCC" = 1,
														 "Hepatitis B (HBV)" = 4, 
														 "Hepatitis C (HCV)" = 2,
														 "PSC" = 5,
														 "PBC" = 6,
														 "Autoimmune/cryptogenic" = 7,
														 "Metabolic/Wilson's/alpha-1" = 8,
														 "Other" = 9),
							selected = 3, selectize=FALSE, width=NULL),
	selectInput("rdisease_secondary_tbs", label = "Secondary liver disease", 
							choices = list("Alcohol" = 3,
														 "NAFLD" = 8, 
														 "HCC" = 1,
														 "Hepatitis B (HBV)" = 4, 
														 "Hepatitis C (HCV)" = 2,
														 "PSC" = 5,
														 "PBC" = 6,
														 "Autoimmune/cryptogenic" = 7,
														 "Metabolic/Wilson's/alpha-1" = 8,
														 "Nil or other" = 9),
							selected = 9, selectize=FALSE, width=NULL),
	selectInput("rdisease_tertiary_tbs", label = "Tertiary liver disease", 
							choices = list("Alcohol" = 3,
														 "NAFLD" = 8, 
														 "HCC" = 1,
														 "Hepatitis B (HBV)" = 4, 
														 "Hepatitis C (HCV)" = 2,
														 "PSC" = 5,
														 "PBC" = 6,
														 "Autoimmune/cryptogenic" = 7,
														 "Metabolic/Wilson's/alpha-1" = 8,
														 "Nil or other" = 9),
							selected = 9, selectize=FALSE, width=NULL),
	sliderInput("previous_tx_tbs", "Number previous liver transplants", 
							value=0, min = 0, max = 5, step = 1,
							width = NULL),
	radioButtons("rprevious_surgery_tbs", label = "Previous abdominal surgery", 
							 choices = list("No" = 0, "Yes" = 1),
							 selected = 0, width=NULL, inline=TRUE)
)
