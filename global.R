#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#http://shiny.rstudio.com/
#
#load sources
source("ui.R")
source("server.R")

#Load require packages
library(shiny)
library(Metrics)
library(ggplot2)
library(dplyr)
library(plotly)
library(rsconnect)
library(corrplot)


# importing training and testing data
train_cbb <- read.csv("train_cbb.csv")
test_cbb <- read.csv("test_cbb.csv")

# log regression training data
log_reg_train <- function(x_value1, x_value2 = NULL){
  if(missing(x_value2)) {
    formula <- MakeTournament ~ x_value1
  } else{
    formula <- MakeTournament ~ x_value1 + x_value2
  } 
  logistic_model_student <- glm(formula = formula, data = train_cbb,
                                family = binomial())
  train_cbb$logistic_predictions <- predict(logistic_model_student, type = "response")
  train_cbb$prediction <- ifelse(train_cbb$logistic_predictions < .50, 0, 1)
  accuracy <- accuracy(train_cbb$MakeTournament, train_cbb$prediction )
  return(accuracy) 
}          

# log regression testing data
log_reg_test <- function(x_value1, x_value2 = NULL){
  if(missing(x_value2)) {
    formula <- MakeTournament ~ x_value1
  } else {
    formula <- MakeTournament ~ x_value1 + x_value2
  } 
  logistic_model_student <- glm(formula = formula, data = test_cbb,
                                family = binomial())
  test_cbb$logistic_predictions <- predict(logistic_model_student, type = "response")
  test_cbb$prediction <- ifelse(test_cbb$logistic_predictions < .50, 0, 1)
  accuracy <- accuracy(test_cbb$MakeTournament, test_cbb$prediction)
  return(accuracy)
}

# train data create figure 2
fig_log_reg_train <- function(x_value1, x_value2 = NULL){

  if(missing(x_value2)) {
    formula1 <- MakeTournament ~ x_value1
    
    simple_logistic_model <- glm(data = train_cbb,
                                 formula = formula1,
                                 family = binomial())
    train_cbb$logistic_predictions <- predict(simple_logistic_model, type = "response")
    fig <- train_cbb %>%
      ggplot(aes(x = x_value1,y = MakeTournament)) +
      geom_point() +
      labs(y = "Make the Tournament") +
      theme_minimal()
  } 
  else {
    formula2 <- MakeTournament ~ x_value1 + x_value2
    logistic_model_student <- glm(formula = formula2, data = train_cbb,
                                  family = binomial())
    train_cbb$logistic_predictions <- predict(logistic_model_student, type = "response")
    train_cbb$prediction_new_for_plot = ifelse(train_cbb$logistic_predictions < .50,
                                               "No", "Yes")
    color_labels <- c("No" = "blue", "Yes" = "green")
    fig <- train_cbb %>%
      ggplot(aes(x = x_value1,y = x_value2, color = prediction_new_for_plot)) +
      geom_point(alpha = .6) +
      scale_color_manual(values = color_labels)+
      labs(y = "x_value2", x = "x_value1", color = "Made the Tournament") +
      theme_minimal()
  } 
  return(fig) 
}

# test data create figure 2 
fig_log_reg_test <- function(x_value1, x_value2 = NULL){

  if(missing(x_value2)) {
    formula1 <- MakeTournament ~ x_value1
    
    simple_logistic_model <- glm(data = test_cbb,
                                 formula = formula1,
                                 family = binomial())
    test_cbb$logistic_predictions <- predict(simple_logistic_model, type = "response")
    fig <- test_cbb %>%
      ggplot(aes(x = x_value1,y = MakeTournament)) +
      geom_point() +
      labs(y = "Make the Tournament", x = "x_value1") +
      theme_minimal()
  } 
  else {
    formula2 <- MakeTournament ~ x_value1 + x_value2
    logistic_model_student <- glm(formula = formula2, data = test_cbb,
                                  family = binomial())
    test_cbb$logistic_predictions <- predict(logistic_model_student, type = "response")
    test_cbb$prediction_new_for_plot = ifelse(test_cbb$logistic_predictions < .50,
                                              "No", "Yes")
    color_labels <- c("No" = "blue", "Yes" = "green")
    fig <- test_cbb %>%
      ggplot(aes(x = x_value1,y = x_value2, color = prediction_new_for_plot)) +
      geom_point(alpha = .6) +
      scale_color_manual(values = color_labels)+
      labs(y = "x_value2", x = "x_value1", color = "Made the Tournament") +
      theme_minimal()
  } 
  return(fig) 
}

corr_matrix <- function(data){
  numerical_data <- subset(data, select = -c(1:2, 21:23,25))
  cor_matrix<- cor(numerical_data[,])
  
  corrplot <- corrplot(cor_matrix, method = "color", tl.cex = .5, cl.cex = 0.6, cex.lab = 0.6, main = "Correlation Plot of Traning Data", cex.main = .6)
  return(corrplot)
}

MadeTournCor <- data.frame(
  Attribute = c("MakeTournament", "Wins", "Power_Rating", "Adjusted_Offensive_Efficiency", "Games", 
                "Effective_Field_Goal_Percentage_Shot", "Two_Point_Shooting_Percentage", "Three_Point_Shooting_Percentage", 
                "Offensive_Rebound_Rate", "Free_Throw_Rate", "Steal_Rate", "Adjusted_Tempo", 
                "Offensive_Rebound_Rate_Allowed", "Free_Throw_Rate_Allowed", "Three_Point_Shooting_Percentage_Allowed", 
                "Turnover_Rate", "Two_Point_Shooting_Percentage_Allowed", "Effective_Field_Goal_Percentage_Allowed", 
                "Adjusted_Defensive_Efficiency"),
  Correlation = c(1.00, 0.62,0.59,0.55,0.52,0.36,0.34,0.27,0.22,0.12,0.08,-0.02,-0.17,-0.21,-0.29,-0.30,-0.34,-0.38,-0.50)
)
shinyApp(ui = ui, server = server)
