library(purrr)

install.packages('rsconnect')

install.packages('rsconnect')


rdisease_primary_tbs = 5
rdisease_secondary_tbs = 9
rdisease_tertiary_tbs = 9

rgender_tbs = 1
rage_tbs = 40

rbilirubin_tbs = 436
rinr_tbs = 1.2
rcreatinine_tbs = 52
rsodium_tbs = 137

rpotassium_tbs = 3.2
ralbumin_tbs = 17

centre_tbs= 6
rregistration_tbs = 1
rinpatient_tbs = 0
rwaiting_time_tbs = 0
rrenal_tbs = 0

previous_tx_tbs = 0
rprevious_surgery_tbs = 0

rencephalopathy_tbs = 0
rascites_tbs = 0

rdiabetes_tbs = 0

rmax_afp_tbs = 999
rtumour_number_tbs = 1
rmax_tumour_size_tbs = 5

dage_tbs = 52
dcause_tbs = 1
dbmi_tbs = 25
ddiabetes_tbs = 1
dtype_tbs = 0
splittable_tbs = 0
bloodgroup_compatible_tbs = 0

hb = 101
plt = 78


r_params = tibble (centre_tbs,
                 rregistration_tbs,
                 rinpatient_tbs,
                 rwaiting_time_tbs,
                 rage_tbs,
                 rgender_tbs,
                 rdisease_primary_tbs, 
                 rdisease_secondary_tbs,
                 rdisease_tertiary_tbs,
                 previous_tx_tbs,
                 rprevious_surgery_tbs,
                 rbilirubin_tbs,
                 rinr_tbs,
                 rcreatinine_tbs,
                 rrenal_tbs,
                 rsodium_tbs,
                 rpotassium_tbs,
                 ralbumin_tbs,
                 rencephalopathy_tbs,
                 rascites_tbs,
                 rdiabetes_tbs,
                 rmax_afp_tbs,
                 rtumour_number_tbs,
                 rmax_tumour_size_tbs,
                 dage_tbs,
                 dcause_tbs,
                 dbmi_tbs,
                 ddiabetes_tbs,
                 dtype_tbs,
                 splittable_tbs,
                 bloodgroup_compatible_tbs, 
                 include_table = FALSE)


tbs_out_current = tibble(pmap_dfr(r_params, fn_tbs_new))

a=

a=1:2000
b=2001:4000


plot(x= a, y=b, col ="#F8766D", xlab = "Time (days)", ylab = "% Survival" )
 points(x= 2000, y = 3400)
  axis(2, at = c(500, 2000))
  
axis



tibble(tbs_out_current)
m1 = round( tbs_out_current$m1_curve %>% sum(), 0)
m2 = round( tbs_out_current$m2_curve %>% sum(), 0)
tbs = m2-m1

tbs = tibble(tbs = round(tbs_out_current$m2_curve %>% sum() - tbs_out_current$m1_curve %>% sum() , 1), count = .25)
tbs_val = round(tbs_out_current$m2_curve %>% sum() - tbs_out_current$m1_curve %>% sum() , 0)

test = ggplot(data = tbs, aes(y = count, x = tbs))+
  geom_point(size = 10)+
  geom_vline(xintercept = -500, linetype = "dashed", alpha = 0.5)+
  geom_vline(xintercept = 0, linetype = "dashed", alpha = 0.5)+
  geom_vline(xintercept = 500, linetype = "dashed", alpha = 0.5)+
  geom_vline(xintercept = 1000, linetype = "dashed", alpha = 0.5)+
  geom_vline(xintercept = 1500, linetype = "dashed", alpha = 0.5)+
  geom_vline(xintercept = 2000, linetype = "dashed", alpha = 0.5)+
  annotate("text", x=tbs_val, y= 0.6, label = paste("TBS"), size= 10)+
  annotate("text", x=tbs_val, y= 0.4, label =  paste(tbs_val), size = 10)+
  coord_cartesian(ylim = c(0, .75))+
  theme_minimal()+
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank(), axis.title.y = element_blank(), axis.title.x = element_blank(),  text = element_text(size = 15), 
        
        plot.margin=unit(c(0,0,1,0), 'cm')
        
        
        )



ggplot()+
  annotate("text", x=tbs_val, y= 0.4, label = paste("TBS=", tbs), size= 10, alpha = 0.6)+
  theme_void()






tbs_calc =  ggplot(data = tbs, aes(y = count, x = tbs))+
  annotate("text", x=tbs_val, y= 0.4, label = paste("TBS=",auc_m2, " (Utility) - " ,auc_m1, "Need" ), size= 10, alpha = 0.6)+
  theme_void()


test / test 

(test + theme(plot.margin = unit(c(0,0,20,0), "pt"))) / test


?plot_spacer()




library(scales)

surv = tibble(tbs_out_current, day = 1:1826)
auc= round( tbs_out_current$m1_curve %>% sum(), 0)


ggplot(data = surv, aes(x= day, y= m1_curve) )+
  geom_line(colour = "#F8766D", size = 1)+
  geom_area( fill = "#F8766D", alpha= 0.3)+
  annotate("text", x=913, y= 0.8, label = paste("Area under curve:"), size= 7)+
  annotate("text", x=913, y= 0.6, label =  paste(auc), size = 10)+
  coord_cartesian(ylim = c(0, 1))+
  theme_bw()+
  labs(y = "Predicted Survival", x = "Time (Days")+
  scale_x_continuous(breaks=seq(0, 1826, 365))+
  scale_y_continuous(labels = percent)+
  theme(text = element_text(size = 15))







surv_curve = tibble(
  m1 = c(tbs_out_current()[[1]]$m1_curve))


x = tibble(c(1:5, 6:10))



output$m1_curve_comparison <- renderPlot({
  
curve_m1 = tibble(
  day = 1:1826,
  m1_curve_v1 = tbs_out_current()$m1_curve,
  m1_curve_v2 = tbs_out_new()$m1_curve)

ggplot(aes(data = curve_m1, x= m1_curve_v1, y= day))+
  geom_point()

})







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

ggplot(aes())

