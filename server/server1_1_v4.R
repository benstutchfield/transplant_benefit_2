# TBS calculation

# Define variables used else where
rcreatinine = reactive(make_rcreatinine(input$centre_tbs, input$rcreatinine_tbs))
rcancer = reactive({
	is_cancer(input$rdisease_primary_tbs, 
						input$rdisease_secondary_tbs,
						input$rdisease_tertiary_tbs)
})

# Load table of coefficients and survival functions
betas_current = readr::read_csv("data/betas_current_2022.csv")
surv_cancer_current = readr::read_csv("data/surv_cancer_current.csv")
surv_noncancer_current = readr::read_csv("data/surv_noncancer_current.csv")

betas_new = readr::read_csv("data/betas_new_2022_v3.csv")
surv_cancer_new = readr::read_csv("data/surv_cancer_2022.csv")
surv_noncancer_new = readr::read_csv("data/surv_noncancer_2022.csv")


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




#### tbs calc


output$v1_tbs <- renderPlot({
  
  tbs = tibble(tbs = round(tbs_out_current()$m2_curve %>% sum() - tbs_out_current()$m1_curve %>% sum() , 1), count = .1)
  tbs_val = round(tbs_out_current()$m2_curve %>% sum() - tbs_out_current()$m1_curve %>% sum() , 0)
  
  ggplot(data = tbs, aes(y = count, x = tbs))+
    geom_point(size = 10, colour ="#F8766D", alpha = 0.5)+ 
    geom_vline(xintercept = -500, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 0, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 500, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 1000, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 1500, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 2000, linetype = "dashed", alpha = 0.5)+
    annotate("text", x=tbs_val, y= 0.6, label = paste("TBS"), size= 10, alpha = 0.6)+
    annotate("text", x=tbs_val, y= 0.4, label =  paste(tbs_val), size = 10, alpha = 0.6)+
    coord_cartesian(ylim = c(0, .75))+
    theme_minimal()+
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank(), axis.title.y = element_blank(), axis.title.x = element_blank(),  text = element_text(size = 15))
})





# Add graphs

observeEvent(input$add_graph_v1, {
  
  
  surv = tibble(tbs_out_current(), day = 1:1826)
  auc_m1= round( surv$m1_curve %>% sum(), 0)
  
  m1_v1 =  ggplot(data = surv, aes(x= day, y= m1_curve) )+
   geom_line(colour = "#F8766D", size = 1)+
  #  geom_area( fill = "#F8766D", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)+
    annotate("text", x=913, y= 0.6, label =  paste(auc_m1), size = 10)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(title = "WITHOUT transplant (Need)", y = "Predicted Survival", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15),         plot.margin=unit(c(.2,0,.2,0), 'cm'))
  
  
  
  auc_m2 = round( surv$m2_curve %>% sum(), 0)
  
  m2_v1 = ggplot(data = surv, aes(x= day, y= m2_curve) )+
    geom_line(colour = "#F8766D", size = 1)+
    #geom_area( fill = "#F8766D", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)+
    annotate("text", x=913, y= 0.6, label =  paste(auc_m2), size = 10)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(title = "AFTER transplant (Utility)", y = "Predicted Survival", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15),         plot.margin=unit(c(.2,0,.2,0), 'cm'))
  
  
  tbs = auc_m2 - auc_m1
  tbs_calc =  ggplot()+
    annotate("text", x=tbs_val, y= 0.4, label = paste("TBS=",auc_m2, " (Utility) - " ,auc_m1, "(Need)" ), size= 6, alpha = 0.6)+
    theme_void()
  
  
 
 output$v1_plots = renderPlot({
   
   m1_v1  / m2_v1 / tbs_calc

 })
 
  
})



observeEvent(input$add_graph_v2, {
  
  
  surv = tibble(tbs_out_new(), day = 1:1826)
  auc_m1= round( surv$m1_curve %>% sum(), 0)
  
  
  canvas_m1 = ggplot(data = surv,  aes(x= day, y= m1_curve ))+
        coord_cartesian(ylim = c(0, 1))+
      theme_bw()+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15),         plot.margin=unit(c(.2,0,.2,0), 'cm'))
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)

  m1_v2 =  canvas_m1 +
    #geom_area( fill = "#00BFC4", alpha= 0.3)+
    annotate("text", x=913, y= 0.6, label =  paste(auc_m1), size = 10)+
   geom_line(colour = "#00BFC4", size = 1)+
    labs(title = "WITHOUT transplant (Need)", y = "Predicted Survival", x = "Time (Days)")
  
  auc_m2 = round( surv$m2_curve %>% sum(), 0)
  
  
  
canvas_m2 = ggplot(data = surv,  aes(x= day, y= m2_curve ))+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15),         plot.margin=unit(c(.2,0,.2,0), 'cm'))
  annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)
  
  
  m2_v2 = canvas_m2 +
    #geom_area(  fill = "#00BFC4", alpha= 0.3)+
    geom_line(colour = "#00BFC4", size = 1)+
    annotate("text", x=913, y= 0.6, label =  paste(auc_m2), size = 10)+
    labs(title = "AFTER transplant (Utility)", y = "Predicted Survival", x = "Time (Days)")

    #annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)+
    #theme(text = element_text(size = 15),         plot.margin=unit(c(.2,0,.2,0), 'cm'))
    #scale_x_continuous(breaks=seq(0, 1826, 365))+
   # theme_bw()+
  #  coord_cartesian(ylim = c(0, 1))+
  
  tbs = auc_m2 - auc_m1
 tbs_calc =  ggplot()+
   annotate("text", x=tbs_val, y= 0, label = paste("TBS=",auc_m2, " (Utility) - " ,auc_m1, "(Need)" ), size= 6, alpha = 0.6)+
    theme_void()
  
  
  output$v2_plots = renderPlot({
    
    m1_v2  / m2_v2 / tbs_calc
    
  })
  
  
})

   


### V1 M1 survival curve

output$v1_m1_curve <- renderPlot({
  
  surv = tibble(tbs_out_current(), day = 1:1826)
  auc= round( surv$m1_curve %>% sum(), 0)
  
  ggplot(data = surv, aes(x= day, y= m1_curve) )+
    geom_line(colour = "#F8766D", size = 1)+
    geom_area( fill = "#F8766D", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)+
    annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(y = "Survival WITHOUT Tx", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15))
})



### V1 M2 survival curve

output$v1_m2_curve <- renderPlot({
  
  surv = tibble(tbs_out_current(), day = 1:1826)
  auc= round( surv$m2_curve %>% sum(), 0)
  
  ggplot(data = surv, aes(x= day, y= m2_curve) )+
    geom_line(colour = "#F8766D", size = 1)+
    geom_area( fill = "#F8766D", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)+
    annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(y = "Survival AFTER Tx", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15))
  
})


#### tbs calc v2

output$v2_tbs <- renderPlot({
  
  tbs = tibble(tbs = round(tbs_out_new()$m2_curve %>% sum() - tbs_out_new()$m1_curve %>% sum() , 1), count = .1)
  tbs_val = round(tbs_out_new()$m2_curve %>% sum() - tbs_out_new()$m1_curve %>% sum() , 0)
  
  ggplot(data = tbs, aes(y = count, x = tbs))+
    geom_point(size = 10, colour ="#00BFC4", alpha = 0.5)+ 
    geom_vline(xintercept = -500, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 0, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 500, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 1000, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 1500, linetype = "dashed", alpha = 0.5)+
    geom_vline(xintercept = 2000, linetype = "dashed", alpha = 0.5)+
    annotate("text", x=tbs_val, y= 0.6, label = paste("TBS"), size= 10, alpha = 0.6)+
    annotate("text", x=tbs_val, y= 0.4, label =  paste(tbs_val), size = 10, alpha = 0.6)+
    coord_cartesian(ylim = c(0, .75))+
    theme_minimal()+
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank(), axis.title.y = element_blank(), axis.title.x = element_blank(),  text = element_text(size = 15))
})


### V1 M1 survival curve

output$v2_m1_curve <- renderPlot({
  
  surv = tibble(tbs_out_new(), day = 1:1826)
  auc= round( surv$m1_curve %>% sum(), 0)
  
  ggplot(data = surv, aes(x= day, y= m1_curve) )+
    geom_line(colour = "#00BFC4", size = 1)+
    geom_area( fill = "#00BFC4", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)+
    annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(y = "Survival WITHOUT Tx", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15))
})



### V1 M2 survival curve

output$v2_m2_curve <- renderPlot({
  
  surv = tibble(tbs_out_new(), day = 1:1826)
  auc= round( surv$m2_curve %>% sum(), 0)
  
  ggplot(data = surv, aes(x= day, y= m2_curve) )+
    geom_line(colour = "#00BFC4", size = 1)+
    geom_area( fill = "#00BFC4", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4)+
    annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(y = "Survival AFTER Tx", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15))
  
})



