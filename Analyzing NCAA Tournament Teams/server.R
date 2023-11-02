
max_features <- 2

server <- function(input, output, session) {
  
  output$selected_classifier <- renderText({ 
    paste("You have selected the Binary Classifer: ", input$classifier)
  })
  
  
  output$selected_features <- renderText({
    paste("You have chosen the features:", 
          input$features[1],"and", input$features[2])
  })
  observe({
    if(length(input$selected_features) > max_features){
      updateCheckboxGroupInput(session, "features", selected= tail(input$selected_features,max_features))
    }
  })
  
  output$train_accuracy_for_2_feat <- renderText({
    paste("The training accuracy of the model is:", round(log_reg_train(train_cbb[[input$features[1]]],train_cbb[[input$features[2]]]),3)
    )}) 
  
  output$train_plot_for_2_feat <- renderPlot({
    fig_log_reg_train(train_cbb[[input$features[1]]],train_cbb[[input$features[2]]])
  })
  
  
  output$test_accuracy_for_2_feat <- renderText({
    paste("The testing accuracy of the model is:", 
          round(log_reg_test(test_cbb[[input$features[1]]],test_cbb[[input$features[2]]]),3)
          
    )})
  
  output$test_plot_for_2_feat <- renderPlot({
    fig_log_reg_test(test_cbb[[input$features[1]]],test_cbb[[input$features[2]]])})
  
  output$train_accuracy_for_1 <- renderText({
    paste("The training accuracy of the model is:", round(log_reg_train(train_cbb[[input$features[1]]]),3)
    )}) 
  
  output$train_plot_for_1 <- renderPlot({
    fig_log_reg_train(train_cbb[[input$features[1]]])
  })
  
  output$test_accuracy_for_1 <- renderText({
    paste("The testing accuracy of the model is:", round(log_reg_test(test_cbb[[input$features[1]]]),3)
    )})
  
  output$test_plot_for_1 <- renderPlot({
    fig_log_reg_test(test_cbb[[input$features[1]]])})
  
  
  output$train_accuracy_for_2 <- renderText({
    paste("The training accuracy of the model is:", round(log_reg_train(train_cbb[[input$features[2]]]),3)
    )}) 
  
  output$train_plot_for_2 <- renderPlot({
    fig_log_reg_train(train_cbb[[input$features[2]]])
  })
  
  
  output$test_accuracy_for_2 <- renderText({
    paste("The testing accuracy of the model is:", round(log_reg_test(test_cbb[[input$features[2]]]),3)
    )})
  
  output$test_plot_for_2 <- renderPlot({
    fig_log_reg_test(test_cbb[[input$features[2]]])})
  
  output$train_x1 <- renderText({
    paste("Training Model for Feature:",input$features[1]
    )})
  
  output$train_x2 <- renderText({
    paste("Training Model for Feature:", input$features[2]
    )})
  
  output$test_x1 <- renderText({
    paste("Testing Model for Feature:",input$features[1]
    )})
  
  output$test_x2 <- renderText({
    paste("Testing Model for Feature:",input$features[2]
    )})
  
  output$train_2_feat <- renderText({
    paste("Model for Two feature Classifier:", input$features[1], "and", input$features[2])
  })
  output$corrplot <- renderPlot({
    corr_matrix(train_cbb)
  })
  
  output$madeTourn <- renderPlot({
    counts <- table(train_cbb$MakeTournament)
    ggplot(data.frame(counts), aes(x = factor(Var1), y = Freq)) +
      geom_bar(stat = "identity", fill = c("green", "red")) +
      labs(title = "Count of Teams to Make Tournament",
           x = "Made Tournament", y = "Count of Teams") +
      scale_x_discrete(labels = c("Yes", "No"))
  })
  output$corrTable <- renderTable({
    MadeTournCor
  })
  output$tournWins <- renderPlot({
    train_made_tourn <- train_cbb[train_cbb$MakeTournament == 1,]
    hist(train_made_tourn$Wins, main = "Wins of Teams That Made the Tournament", 
         xlab = "Number of Wins", ylab = "Count of Teams")})

}
  



