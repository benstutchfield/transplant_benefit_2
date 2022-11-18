# TBS calculation

# Define variables used else where
rcreatinine = reactive(make_rcreatinine(input$centre_tbs, input$rcreatinine_tbs))
rcancer = reactive({
	is_cancer(input$rdisease_primary_tbs, 
						input$rdisease_secondary_tbs,
						input$rdisease_tertiary_tbs)
})

# Load table of coefficients and survival functions
#betas_current = readr::read_csv("data/betas_current_2022.csv")
#surv_cancer_current = readr::read_csv("data/surv_cancer_current.csv")
#surv_noncancer_current = readr::read_csv("data/surv_noncancer_current.csv")

#betas_new = readr::read_csv("data/betas_new_2022_v3.csv")
#surv_cancer_new = readr::read_csv("data/surv_cancer_2022.csv")
#surv_noncancer_new = readr::read_csv("data/surv_noncancer_2022.csv")

#betas_surv = fread("data/betas_surv.csv")

betas_surv = readRDS(file = "data/betas_surv.rds")


betas_current = betas_surv %>% select(1:12)
surv_cancer_current = betas_surv %>% select(13:14)
surv_noncancer_current =  betas_surv %>% select(15:16)

betas_new = betas_surv %>% select(17:28)
surv_cancer_new = betas_surv %>% select(29:30)
surv_noncancer_new = betas_surv %>% select(31:32)







tbs_out_current = reactive({
	fn_tbs_current(
		centre_tbs = input$centre_tbs,
		rregistration_tbs = input$rregistration_tbs,
		rinpatient_tbs = input$rinpatient_tbs,
		rwaiting_time_tbs = input$rwaiting_time_tbs,
		rage_tbs = input$rage_tbs,
		rgender_tbs = input$rgender_tbs,
		rdisease_primary_tbs = input$rdisease_primary_tbs, 
		rdisease_secondary_tbs = input$rdisease_secondary_tbs,
		rdisease_tertiary_tbs = input$rdisease_tertiary_tbs,
		previous_tx_tbs = input$previous_tx_tbs,
		rprevious_surgery_tbs = input$rprevious_surgery_tbs,
		rbilirubin_tbs = input$rbilirubin_tbs,
		rinr_tbs = input$rinr_tbs,
		rcreatinine_tbs = input$rcreatinine_tbs,
		rrenal_tbs = input$rrenal_tbs,
		rsodium_tbs = input$rsodium_tbs,
		rpotassium_tbs = input$rpotassium_tbs,
		ralbumin_tbs = input$ralbumin_tbs,
		rencephalopathy_tbs = input$rencephalopathy_tbs,
		rascites_tbs = input$rascites_tbs,
		rdiabetes_tbs = input$rdiabetes_tbs,
		rmax_afp_tbs = input$rmax_afp_tbs,
		rtumour_number_tbs = input$rtumour_number_tbs,
		rmax_tumour_size_tbs = input$rmax_tumour_size_tbs,
		dage_tbs = input$dage_tbs,
		dcause_tbs = input$dcause_tbs,
		dbmi_tbs = input$dbmi_tbs,
		ddiabetes_tbs = input$ddiabetes_tbs,
		dtype_tbs = input$dtype_tbs,
		splittable_tbs = input$splittable_tbs,
		bloodgroup_compatible_tbs = input$bloodgroup_compatible_tbs,
		
		include_table = TRUE
	)
})


tbs_out_new = reactive({
	fn_tbs_new(
		centre_tbs = input$centre_tbs,
		rregistration_tbs = input$rregistration_tbs,
		rinpatient_tbs = input$rinpatient_tbs,
		rwaiting_time_tbs = input$rwaiting_time_tbs,
		rage_tbs = input$rage_tbs,
		rgender_tbs = input$rgender_tbs,
		rdisease_primary_tbs = input$rdisease_primary_tbs, 
		rdisease_secondary_tbs = input$rdisease_secondary_tbs,
		rdisease_tertiary_tbs = input$rdisease_tertiary_tbs,
		previous_tx_tbs = input$previous_tx_tbs,
		rprevious_surgery_tbs = input$rprevious_surgery_tbs,
		rbilirubin_tbs = input$rbilirubin_tbs,
		rinr_tbs = input$rinr_tbs,
		rcreatinine_tbs = input$rcreatinine_tbs,
		rrenal_tbs = input$rrenal_tbs,
		rsodium_tbs = input$rsodium_tbs,
		rpotassium_tbs = input$rpotassium_tbs,
		ralbumin_tbs = input$ralbumin_tbs,
		rencephalopathy_tbs = input$rencephalopathy_tbs,
		rascites_tbs = input$rascites_tbs,
		rdiabetes_tbs = input$rdiabetes_tbs,
		rmax_afp_tbs = input$rmax_afp_tbs,
		rtumour_number_tbs = input$rtumour_number_tbs,
		rmax_tumour_size_tbs = input$rmax_tumour_size_tbs,
		dage_tbs = input$dage_tbs,
		dcause_tbs = input$dcause_tbs,
		dbmi_tbs = input$dbmi_tbs,
		ddiabetes_tbs = input$ddiabetes_tbs,
		dtype_tbs = input$dtype_tbs,
		splittable_tbs = input$splittable_tbs,
		bloodgroup_compatible_tbs = input$bloodgroup_compatible_tbs,
		
		include_table = TRUE
	)
})

# Output
## Current TBS
## new M1

#snap_m1 <- 
#	read_csv("data/snap_data.csv") %>%
#	select(curr_m1, upd_m1) %>%
#	rename(
#		current = curr_m1,
#		updated = upd_m1
#	) %>%
#	pivot_longer(
#		everything(), 
#		values_to = "m_1", names_to = "scheme")



output$m1_comparison <- renderPlot({
	
	est_m1 <-
		tibble(
			m_1 = c(tbs_out_current()[[1]]$m1, tbs_out_new()[[1]]$m1),
			scheme = c("current", "updated")
		)
	
	ggplot(
		data = snap_m1, 
		aes(x = m_1, y = scheme, fill = stat(x))
	) +
		stat_density_ridges(
			geom = "density_ridges_gradient",
			scale = 1,
			calc_ecdf = TRUE) +
		scale_fill_viridis_c(
			option = "viridis", 
			direction = -1) +
		geom_point(
			data = est_m1,
			aes(x = m_1, y = scheme),
			shape = "-", size = 24
		) +
		xlab("M1") +
		ylab("") +
		xlim(0, 1825) +
		coord_flip() +
		theme_minimal() +
		theme(legend.position = "none")
	
})


output$m1Box_current <- renderInfoBox({
	infoBox(
	  "M1: Survival without transplant",h1(finalfit::round_tidy(tbs_out_current()[[1]]$m1, 1)), 
	  "Longer survival = less NEED for transplant",
		icon = icon("chart-bar"),
		color = "black", fill=TRUE
	)
})






output$m2_comparison <- renderPlot({
	
	est_m2 <-
		tibble(
			m_2 = c(tbs_out()[[1]]$m2, runif(1, 0.8, 1.2) * tbs_out()[[1]]$m2),
			scheme = c("current", "new")
		)
	
	ggplot(
		data = m_2, 
		aes(x = m_2, y = scheme, fill = stat(x))
	) +
		stat_density_ridges(
			geom = "density_ridges_gradient",
			scale = 1,
			calc_ecdf = TRUE) +
		scale_fill_viridis_c(
			option = "magma", 
			direction = -1) +
		geom_point(
			data = est_m2,
			aes(x = m_2, y = scheme),
			shape = "-", size = 20
		) +
		xlab("M2") +
		ylab("") +
		xlim(0, 1825) +
		coord_flip() +
		theme_minimal() +
		theme(legend.position = "none")
	
})



output$m2Box_current <- renderInfoBox({
	infoBox(
		"M2: Survival after transplant",  h1(finalfit::round_tidy(tbs_out_current()[[1]]$m2, 1)), 
		"Longer survival = greater UTILITY for the transplant",
		icon = icon("chart-bar"),
		color = "black", fill=TRUE
	)
})



## New TBS


snap_tbs <- 
	read_csv("data/snap_data.csv") %>%
	select(curr_tbs, upd_tbs) %>%
	rename(
		current = curr_tbs,
		updated = upd_tbs
	) %>%
	pivot_longer(
		everything(), 
		values_to = "tbs", names_to = "scheme")



output$tbs_comparison <- renderPlot({
	
	est_tbs <-
		tibble(
			tbs = c(tbs_out_current()[[1]]$tbs, tbs_out_new()[[1]]$tbs),
			scheme = c("current", "updated")
		)
	
	ggplot(
		data = snap_tbs, 
		aes(x = tbs, y = scheme, fill = stat(x))
	) +
		stat_density_ridges(
			geom = "density_ridges_gradient",
			scale = 1,
			calc_ecdf = TRUE) +
		scale_fill_viridis_c(
			option = "viridis", 
			direction = 1) +
		geom_point(
			data = est_tbs,
			aes(x = tbs, y = scheme),
			shape = "-", size = 24
		) +
		xlab("TBS") +
		ylab("") +
		xlim(0, 1825) +
		coord_flip() +
		theme_minimal() +
		theme(legend.position = "none")
	
})



tbs_status_current = reactive({
	ifelse(tbs_out_current()[[1]]$tbs >1000, "red", 
				 ifelse(tbs_out_current()[[1]]$tbs >600, "orange", "green"))
})


output$tbsBox_current <- renderInfoBox({
	infoBox(
		"TBS (M2-M1)", h1(finalfit::round_tidy(tbs_out_current()[[1]]$tbs, 1)), 
		icon = icon("chart-bar"),
		"Higher number liver offer more likely",
		color = tbs_status_current(), fill=TRUE
	)
})





## New models outputs

output$m1Box_new <- renderInfoBox({
	infoBox(
		"M1: Survival without transplant", h1(finalfit::round_tidy(tbs_out_new()[[1]]$m1, 1)), 
		"Longer survival = less NEED for transplant",
		icon = icon("chart-bar"),
		color = "black", fill=TRUE
	)
})
output$m2Box_new <- renderInfoBox({
	infoBox(
		"M2: Survival after transplant", h1(finalfit::round_tidy(tbs_out_new()[[1]]$m2, 1)), 
		"Longer survival = greater UTILITY for the transplant",
		icon = icon("chart-bar"),
		color = "black", fill=TRUE
	)
})

tbs_status_new = reactive({
	ifelse(tbs_out_new()[[1]]$tbs >1000, "red", 
				 ifelse(tbs_out_new()[[1]]$tbs >600, "orange", "green"))
})


output$tbsBox_new <- renderInfoBox({
	infoBox(
		"TBS (M2-M1)", h1(finalfit::round_tidy(tbs_out_new()[[1]]$tbs, 1)), 
		icon = icon("chart-bar"),
		"Higher number liver offer more likely",
		color = tbs_status_new(), fill=TRUE
	)
})




output$x1 = DT::renderDataTable(
	DT::datatable(tbs_out()$linear_prediction_table,
								rownames=FALSE, extensions = "FixedColumns",
								options = list(#dom = 't',
									scrollX = TRUE,
									paging=FALSE,
									fixedColumns = list(leftColumns = 1, rightColumns = 0),
									searching = FALSE
								))
)
