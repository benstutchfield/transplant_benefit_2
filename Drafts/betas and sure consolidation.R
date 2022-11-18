

library(gdata)
library(dplyr)
library(readr)
library(data.table)
# Load table of coefficients and survival functions


betas_current = readr::read_csv("data/betas_current_2022.csv")
surv_cancer_current = readr::read_csv("data/surv_cancer_current.csv")
surv_noncancer_current = readr::read_csv("data/surv_noncancer_current.csv")

betas_new = readr::read_csv("data/betas_new_2022_v3.csv")
surv_cancer_new = readr::read_csv("data/surv_cancer_2022.csv")
surv_noncancer_new = readr::read_csv("data/surv_noncancer_2022.csv")


betas_surv = cbindX(betas_current, surv_cancer_current, surv_noncancer_current, betas_new, surv_cancer_new, surv_noncancer_new )

#write.csv(betas_surv, "data/betas_surv.csv")


saveRDS(betas_surv, file = "data/betas_surv.rds")




#betas_surv = fread("data/betas_surv.csv")

betas_surv = readRDS(file = "data/betas_surv.rds")

betas_current = tibble(drop_na(betas_surv %>% select(1:12)))
surv_cancer_current = tibble(drop_na(betas_surv %>% select(13:14)))
surv_noncancer_current =  tibble(drop_na(betas_surv %>% select(15:16)))

betas_new = tibble(drop_na(betas_surv %>% select(17:28)))
surv_cancer_new = tibble(drop_na(betas_surv %>% select(29:30)))
surv_noncancer_new = tibble(drop_na(betas_surv %>% select(31:32)))



