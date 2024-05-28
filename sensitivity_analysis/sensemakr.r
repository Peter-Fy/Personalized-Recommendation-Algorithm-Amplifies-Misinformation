library(data.table)
library(sensemakr)

data <- fread("../data/featured_groupA_sensitivity.csv")

show_model <- lm(show_cnt_log1p ~ is_personal + age + sex + province +
                         play_cnt_2_month + play_cnt_7_days + active_days_2_month, data = data)

show_sensitivity <- sensemakr(model = show_model, 
                         treatment = "is_personal",
                         benchmark_covariates = c("play_cnt_2_month", "play_cnt_7_days", "active_days_2_month", "age" ,"sexM"),
                         kd = 1:3)

ovb_minimal_reporting(show_sensitivity)
r2yz_x_values <- show_sensitivity[["bounds"]][["r2yz.dx"]]
r2dz_x_values <- show_sensitivity[["bounds"]][["r2dz.x"]]
bound_labels <- show_sensitivity[["bounds"]][["bound_label"]]
one_x_indices <- grep("1x", bound_labels)
one_x_r2yz_values <- sprintf("%.5f%%", 100 * r2yz_x_values[one_x_indices])
one_x_r2dz_values <- sprintf("%.5f%%", 100 * r2dz_x_values[one_x_indices])
one_x_labels <- bound_labels[one_x_indices]
one_x_results <- data.frame(Label = one_x_labels, 
                            R2yz_dx = one_x_r2yz_values, 
                            R2dz_x = one_x_r2dz_values)
print(one_x_results)


valid_play_model <- lm(valid_play_cnt_log1p ~ is_personal + age + sex + province +
                         play_cnt_2_month + play_cnt_7_days + active_days_2_month, data = data)

valid_play_sensitivity <- sensemakr(model = valid_play_model, 
                         treatment = "is_personal",
                         benchmark_covariates = c("play_cnt_2_month", "play_cnt_7_days", "active_days_2_month", "age" ,"sexM"),
                         kd = 1:3)

ovb_minimal_reporting(valid_play_sensitivity)
r2yz_x_values <- valid_play_sensitivity[["bounds"]][["r2yz.dx"]]
r2dz_x_values <- valid_play_sensitivity[["bounds"]][["r2dz.x"]]
bound_labels <- valid_play_sensitivity[["bounds"]][["bound_label"]]
one_x_indices <- grep("1x", bound_labels)
one_x_r2yz_values <- sprintf("%.5f%%", 100 * r2yz_x_values[one_x_indices])
one_x_r2dz_values <- sprintf("%.5f%%", 100 * r2dz_x_values[one_x_indices])
one_x_labels <- bound_labels[one_x_indices]
one_x_results <- data.frame(Label = one_x_labels, 
                            R2yz_dx = one_x_r2yz_values, 
                            R2dz_x = one_x_r2dz_values)
print(one_x_results)


