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
  
  canvas = ggplot(data = tbs, aes(y = count, x = tbs))+
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
   
  
  canvas +geom_point(size = 10, colour ="#F8766D", alpha = 0.5)

      
      })


### V1 M1 survival curve

output$v1_m1_curve <- renderPlot({
  
  surv = tibble(tbs_out_current(), day = 1:1826)
  auc= round( surv$m1_curve %>% sum(), 0)
  
canvas =   ggplot(data = surv, aes(x= day, y= m1_curve) )+
  #  geom_area( fill = "#F8766D", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4, alpha = 0.6)+
    annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10, alpha = 0.6)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(y = "Survival WITHOUT Tx", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15))


canvas+    geom_line(colour = "#F8766D", size = 1)


})


output$tbs_v1_base <- renderPlot({
  
  surv = tibble(tbs_out_current())
 m1= round( surv$m1_curve %>% sum(), 0)   
 m2= round( surv$m2_curve %>% sum(), 0)  
 tbs = m2-m1
 par(mar = c(1, 0.5,0 , 0.5))
 plot(x=tbs, y=0.1, col ="#FF911C",bg ="#FF911C", pch= 25, cex = 3,
      xlim = c(-505,2005),
      ylim = c(0,0.8), 
      axes = FALSE
    #  xaxt='n',
     # yaxt='n'
 )
  
 axis(side = 1, at=c(-500, 0, 500, 1000, 1500, 2000), mgp=c(0.1,0.1,0.1), labels = c("-500", "0","","1000","","2000"), cex.axis = 1.5, tck = 1, lty = 2, col = "gray")

 #text(x = tbs, y = 0.9, label= substitute(paste(bold("TBS ="))), cex = 2, col= "#FF911C")
 text(x = tbs, y = 0.45, # Coordinates
      label = tbs, cex = 5, col= "#FF911C")
 
})



output$tbs_v2_base <- renderPlot({
  
  surv = tibble(tbs_out_new())
  m1= round( surv$m1_curve %>% sum(), 0)   
  m2= round( surv$m2_curve %>% sum(), 0)  
  tbs = m2-m1
  par(mar = c(1, 0.5,0 , 0.5))
  plot(x=tbs, y=0.1, col ="#0073B7",bg ="#0073B7", pch= 25, cex = 3,
       xlim = c(-505,2005),
       ylim = c(0,0.8), 
       axes = FALSE
  )
  
  axis(side = 1, at=c(-500, 0, 500, 1000, 1500, 2000), mgp=c(0.1,0.1,0.1), labels = c("-500", "0","","1000","","2000"), cex.axis = 1.5, tck = 1, lty = 2, col = "gray")
  
  #text(x = tbs, y = 0.8, label= substitute(paste(bold("TBS ="))), cex = 1.5)
  text(x = tbs, y = 0.45, # Coordinates
       label = tbs, cex = 5, col =  "#0073B7")
  
})





output$v1_m1_curve_base <- renderPlot({
  
  surv = tibble(tbs_out_current(), day = 1:1826)
  auc= round( surv$m1_curve %>% sum(), 0)
  yr5 = surv %>% filter(day == 1826)
  yr1 = surv %>% filter(day == 365)
  

    par(mar = c(2, 2, 1, 0.5))
  plot(x= surv$day, y=surv$m1_curve, col ="#FF911C", type = "l", 
      xlim = c(0,1826),
       ylim = c(0,1),
       lwd = 4, 
       xaxt='n', 
     yaxt= 'n'
  )
  
  ##############################
  #5 year survival
  points(x = 1826, y = yr5$m1_curve, cex = 2 , pch = 19, col= "#FF911C")
  text(x = 1826, y = yr5$m1_curve + 0.1, 
       label = paste0((round(yr5$m1_curve, digits = 2))*100, "%"), cex = 1.5, col= "#FF911C")
  
  #1 year survival
  points(x = 365, y = yr1$m1_curve, cex = 2, pch = 19, col= "#FF911C")
  text(x = 365, y = yr1$m1_curve + 0.1, 
       label = paste0((round(yr1$m1_curve, digits = 2))*100, "%"), cex = 1.5, col= "#FF911C")
  
  
  
  axis( side = 1, at=c(0,365, 730, 1095, 1460, 1825), mgp=c(0.2,0.2,0), labels = c(0,1,2,3,4,5), tck = 1, lty = 2, col = "gray")
  
  axis(side = 2, at= c(0, 0.25, 0.5, 0.75, 1.01), labels= c("0%", "", "50%", "", "100%"), tck = 1, lty = 2, col = "gray", mgp=c(0.2,0.2,0))
  
  title(#main="Without transplant (Need)", 
        xlab="Time (years)", ylab="Predicted Survival", mgp=c(1.1,1.3,0))
  text(x = 912.5, y = 0.45, label= "Area under curve", col= "#FF911C", cex = 1.5)
  text(x = 912.5, y = 0.25, # Coordinates
       label = auc, cex = 3, col= "#FF911C")
  
  
#  grid(nx = NULL, ny = NULL,
 #      lty = 2,      # Grid line type
  #     col = "gray", # Grid line color
   #    lwd = 2)      # Grid line width
  
  
  
  
  
  
  
})


output$v1_m2_curve_base <- renderPlot({
  
  surv = tibble(tbs_out_current(), day = 1:1826)
  auc= round( surv$m2_curve %>% sum(), 0)
  yr5 = surv %>% filter(day == 1826)
  yr1 = surv %>% filter(day == 365)
  
  par(mar = c(2, 2, 1, 0.5))
  
  plot(x= surv$day, y=surv$m2_curve, col ="#FF911C", type = "l",
       xlim = c(0,1826),
       ylim = c(0,1),
       lwd = 3, 
       xaxt='n', 
       yaxt= 'n'
  )
  
  #5 year survival
  points(x = 1826, y = yr5$m2_curve, cex = 2, pch = 19, col= "#FF911C")
  text(x = 1826, y = yr5$m2_curve + 0.1, 
       label = paste0((round(yr5$m2_curve, digits = 1.5))*100, "%"), cex = 1.5, col= "#FF911C")
  
  #1 year survival
  points(x = 365, y = yr1$m2_curve, cex = 2, pch = 19, col= "#FF911C")
  text(x = 365, y = yr1$m2_curve + 0.1, 
       label = paste0((round(yr1$m2_curve, digits = 1.5))*100, "%"), cex = 1.5, col= "#FF911C")
  
  
  
  
  
  axis(side = 1, at=c(0,365, 730, 1095, 1460, 1825), mgp=c(0.2,0.2,0), labels = c(0,1,2,3,4,5), tck = 1, lty = 2, col = "gray")
  
  axis(side = 2, at= c(0, 0.25, 0.5, 0.75, 1.01), labels= c("0%", "", "50%", "", "100%"), tck = 1, lty = 2, col = "gray", mgp=c(0.2,0.2,0))
  
  title(#main="After transplant (Utility)", 
        xlab="Time (years)", ylab="Predicted Survival", mgp=c(1.1,1.2,0))
  text(x = 912.5, y = 0.45, label= "Area under curve", col= "#FF911C", cex = 1.5)
  text(x = 912.5, y = 0.25, # Coordinates
       label = auc, cex = 3, col= "#FF911C")
       
  
})







output$v2_m1_curve_base <- renderPlot({
  
  surv = tibble(tbs_out_new(), day = 1:1826)
  auc= round( surv$m1_curve %>% sum(), 0)
  yr5 = surv %>% filter(day == 1826)
  yr1 = surv %>% filter(day == 365)
  
  par(mar = c(2, 2, 1, 0.5))
  
  plot(x= surv$day, y=surv$m1_curve, col ="#0073B7", type = "l",  
       xlim = c(0,1826),
       ylim = c(0,1),
       lwd = 3, 
       xaxt='n', 
       yaxt= 'n'
  )
  
  
  
  #5 year survival
  points(x = 1826, y = yr5$m1_curve, cex = 2, pch = 19, col= "#0073B7")
  text(x = 1826, y = yr5$m1_curve + 0.1, 
       label = paste0((round(yr5$m1_curve, digits = 2))*100, "%"), cex = 1.5, col= "#0073B7")
  
  #1 year survival
  points(x = 365, y = yr1$m1_curve, cex = 2, pch = 19, col= "#0073B7")
  text(x = 365, y = yr1$m1_curve + 0.1, 
       label = paste0((round(yr1$m1_curve, digits = 2))*100, "%"), cex = 1.5, col= "#0073B7")
  
  
  
  
  
  axis(side = 1, at=c(0,365, 730, 1095, 1460, 1825), mgp=c(0.2,0.2,0), labels = c(0,1,2,3,4,5), tck = 1, lty = 2, col = "gray")
  
  axis(side = 2, at= c(0, 0.25, 0.5, 0.75, 1.01), labels= c("0%", "", "50%", "", "100%"), tck = 1, lty = 2, col = "gray", mgp=c(0.2,0.2,0))
  
  title(#main="Without transplant (Need)", 
        xlab="Time (years)", ylab="Predicted Survival", mgp=c(1.1,1.2,0))
  text(x = 912.5, y = 0.45, label= "Area under curve", col= "#0073B7", cex = 1.5)
  text(x = 912.5, y = 0.25, # Coordinates
       label = auc, cex = 3, col= "#0073B7")
  
  
})


output$v2_m2_curve_base <- renderPlot({
  
  surv = tibble(tbs_out_new(), day = 1:1826)
  auc= round( surv$m2_curve %>% sum(), 0)
  yr5 = surv %>% filter(day == 1826)
  yr1 = surv %>% filter(day == 365)
  
  par(mar = c(2, 2, 1, 0.5))
  
  plot(x= surv$day, y=surv$m2_curve, col ="#0073B7", type = "l", 
       xlim = c(0,1826),
       ylim = c(0,1),
       lwd = 3, 
       xaxt='n', 
       yaxt= 'n'
  )
  
  
  
  #5 year survival
  points(x = 1826, y = yr5$m2_curve, cex = 2, pch = 19, col= "#0073B7")
  text(x = 1826, y = yr5$m2_curve + 0.1, 
       label = paste0((round(yr5$m2_curve, digits = 2))*100, "%"), cex = 1.5, col= "#0073B7")
  
  #1 year survival
  points(x = 365, y = yr1$m2_curve, cex = 2, pch = 19, col= "#0073B7")
  text(x = 365, y = yr1$m2_curve + 0.1, 
       label = paste0((round(yr1$m2_curve, digits = 2))*100, "%"), cex = 1.5, col= "#0073B7")
  
  
  
  
  
  
  axis(side = 1, at=c(0,365, 730, 1095, 1460, 1825), mgp=c(0.2,0.2,0), labels = c(0,1,2,3,4,5), tck = 1, lty = 2, col = "gray")
  
  axis(side = 2, at= c(0, 0.25, 0.5, 0.75, 1.01), labels= c("0%", "", "50%", "", "100%"), tck = 1, lty = 2, col = "gray", mgp=c(0.2,0.2,0))
  
  title(#main="After transplant (Utility)", 
        xlab="Time (years)", ylab="Predicted Survival", mgp=c(1.1,1.2,0))
  text(x = 912.5, y = 0.45, label= "Area under curve", col= "#0073B7", cex = 1.5)
  text(x = 912.5, y = 0.25, # Coordinates
       label = auc, cex = 3, col= "#0073B7")
       
  
  
  
})








### V1 M2 survival curve

output$v1_m2_curve <- renderPlot({
  
  surv = tibble(tbs_out_current(), day = 1:1826)
  auc= round( surv$m2_curve %>% sum(), 0)
  
  canvas = ggplot(data = surv, aes(x= day, y= m2_curve) )+
  #  geom_area( fill = "#F8766D", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4, alpha = 0.6)+
    annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10, alpha = 0.6)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(y = "Survival AFTER Tx", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15))
  
canvas +    geom_line(colour = "#F8766D", size = 1)
  
  
})


#### tbs calc v2

output$v2_tbs <- renderPlot({
  
  tbs = tibble(tbs = round(tbs_out_new()$m2_curve %>% sum() - tbs_out_new()$m1_curve %>% sum() , 1), count = .1)
  tbs_val = round(tbs_out_new()$m2_curve %>% sum() - tbs_out_new()$m1_curve %>% sum() , 0)
  
 canvas = ggplot(data = tbs, aes(y = count, x = tbs))+
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

canvas +    geom_point(size = 10, colour ="#00BFC4", alpha = 0.5)
  
  })


### V1 M1 survival curve

output$v2_m1_curve <- renderPlot({
  
  surv = tibble(tbs_out_new(), day = 1:1826)
  auc= round( surv$m1_curve %>% sum(), 0)
  
canvas =  ggplot(data = surv, aes(x= day, y= m1_curve) )+
   # geom_area( fill = "#00BFC4", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4, alpha = 0.6)+
    annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10, alpha = 0.6)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(y = "Survival WITHOUT Tx", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15))
  
  
canvas +    geom_line(colour = "#00BFC4", size = 1)
  
})



### V1 M2 survival curve

output$v2_m2_curve <- renderPlot({
  
  surv = tibble(tbs_out_new(), day = 1:1826)
  auc= round( surv$m2_curve %>% sum(), 0)
  
 canvas =  ggplot(data = surv, aes(x= day, y= m2_curve) )+
  #  geom_area( fill = "#00BFC4", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4, alpha = 0.6)+
    annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10, alpha = 0.6)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(y = "Survival AFTER Tx", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15))
  
  
canvas+    geom_line(colour = "#00BFC4", size = 1)
  
  
})




output$v2_curves <- renderPlot({
  
  
  surv = tibble(tbs_out_current(), day = 1:1826)
  auc_m1= round( surv$m1_curve %>% sum(), 0)
  
  m1_v1 =  ggplot(data = surv, aes(x= day, y= m1_curve) )+
    geom_line(colour = "#F8766D", size = 1)+
    #  geom_area( fill = "#F8766D", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4, alpha = 0.6)+
    annotate("text", x=913, y= 0.6, label =  paste(auc_m1), size = 10, alpha = 0.6)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(title = "WITHOUT transplant (Need)", y = "Predicted Survival", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15),         plot.margin=unit(c(.2,0,.2,0), 'cm'))
  
  
  
  auc_m2 = round( surv$m2_curve %>% sum(), 0)
  
  m2_v1 = ggplot(data = surv, aes(x= day, y= m2_curve) )+
    geom_line(colour = "#F8766D", size = 1)+
    #geom_area( fill = "#F8766D", alpha= 0.3)+
    annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 4, alpha = 0.6)+
    annotate("text", x=913, y= 0.6, label =  paste(auc_m2), size = 10, alpha = 0.6)+
    coord_cartesian(ylim = c(0, 1))+
    theme_bw()+
    labs(title = "AFTER transplant (Utility)", y = "Predicted Survival", x = "Time (Days)")+
    scale_x_continuous(breaks=seq(0, 1826, 365))+
    theme(text = element_text(size = 15),         plot.margin=unit(c(.2,0,.2,0), 'cm'))
  
  
  tbs = auc_m2 - auc_m1
  tbs_calc =  ggplot()+
    annotate("text", x=tbs_val, y= 0.4, label = paste("TBS=",auc_m2, " (Utility) - " ,auc_m1, "(Need)" ), size= 6, alpha = 0.6)+
    theme_void()
  
  

    
    m1_v1  / m2_v1 / tbs_calc
    

  
  
})
