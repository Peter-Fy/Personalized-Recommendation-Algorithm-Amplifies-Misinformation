library(data.table)
library(panelView)
library(fect)
library(fixest)

# Treatment status
data <- fread("./data/featured_did_data.csv")
panelview(valid_play_cnt_log1p ~ is_treated, data = data, index = c("id", "time"), 
          axis.lab = "time", xlab = "Days Since November 1, 2022", ylab = "User", 
          gridOff = TRUE, by.timing = TRUE,
          background = "white", main = "Treatment Status",
          axis.lab.gap = c(3, 0),
          legend.labs = c("Non-personalization", "Personalization"))  


# Featured
data <- fread("./data/featured_did_data.csv")
valid_play.fect <- fect(valid_play_cnt_log1p ~ is_treated, data = data, index = c("id","time"), 
  method = "fe", force = "two-way", se = TRUE, parallel = TRUE, vartype = "bootstrap" ,nboots = 200)
plot(valid_play.fect, main = "Estimated ATT of Personalization on Valid Play", ylab = "Personalization on Valid Play (log1p)", 
  cex.main = 0.8, cex.lab = 0.8, cex.axis = 0.8, stats = "F.p", ylim = c(-0.02, 0.04))


show.fect <- fect(show_cnt_log1p ~ is_treated, data = data, index = c("id","time"), 
  method = "fe", force = "two-way", se = TRUE, parallel = TRUE, vartype = "bootstrap" ,nboots = 200)
plot(show.fect, main = "Estimated ATT of Personalization on Show", ylab = "Personalization on Show (log1p)", 
  cex.main = 0.8, cex.lab = 0.8, cex.axis = 0.8, stats = "F.p", ylim = c(-0.02, 0.04))


# Find
data <- fread("./data/find_did_data.csv")
valid_play.fect <- fect(valid_play_cnt_log1p ~ is_treated, data = data, index = c("id","time"), 
  method = "fe", force = "two-way", se = TRUE, parallel = TRUE, vartype = "bootstrap" ,nboots = 200)
plot(valid_play.fect, main = "Estimated ATT of Personalization on Valid Play", ylab = "Personalization on Valid Play (log1p)", 
  cex.main = 0.8, cex.lab = 0.8, cex.axis = 0.8, stats = "F.p", ylim = c(-0.02, 0.04))


show.fect <- fect(show_cnt_log1p ~ is_treated, data = data, index = c("id","time"), 
  method = "fe", force = "two-way", se = TRUE, parallel = TRUE, vartype = "bootstrap" ,nboots = 200)
plot(show.fect, main = "Estimated ATT of Personalization on Show", ylab = "Personalization on Show (log1p)", 
  cex.main = 0.8, cex.lab = 0.8, cex.axis = 0.8, stats = "F.p", ylim = c(-0.02, 0.04))
