#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#http://shiny.rstudio.com/
#


#Load require packages

# Load Helper files

# set variables
max_features <- 2

# Load data

# Define UI for application that draws a histogram
ui <- navbarPage("Analyzing NCAA Basketball Tournament Teams",
  tabPanel("Interactive Binary Classification",
  titlePanel("Binary Classification of Whether College Basketball Team Will Make the Tournamnet"),

    sidebarPanel(
      
      helpText("Implement different features of the College Basketball Dataset to learn how they affect the accuracy in determining if
      college basketball team will make the NCAA March Madness Tournament"),
      
      selectInput("classifier", 
                  label = "Choose a Binary Classifier",
                  choices = c("Logistic Regression")),
      
      selectizeInput(inputId = "features", 
                     label = "Please Select 2 Features to Implement into the Model",
                     choices = c("Adjusted_Defensive_Efficiency",
                                 "Adjusted_Offensive_Efficiency",
                                 "Adjusted_Tempo",
                                 "Effective_Field_Goal_Percentage_Shot",
                                 "Effective_Field_Goal_Percentage_Allowed",
                                 "Free_Throw_Rate",
                                 "Free_Throw_Rate_Allowed",
                                 "Games",
                                 "Offensive_Rebound_Rate",
                                 "Offensive_Rebound_Rate_Allowed",
                                 "Power_Rating",
                                 "Steal_Rate",
                                 "Three_Point_Shooting_Percentage",
                                 "Three_Point_Shooting_Percentage_Allowed",
                                 "Two_Point_Shooting_Percentage",
                                 "Two_Point_Shooting_Percentage_Allowed",
                                 "Turnover_Rate",
                                 "Wins"),
                     selected = c("Adjusted_Defensive_Efficiency", "Adjusted_Offensive_Efficiency"),
                     options = list(maxItems = 2)),
      submitButton("Submit")),
  
    
    mainPanel(
      h1("Selected Classifier and Features"),
      h3(textOutput("selected_classifier")),
      h3(textOutput("selected_features")),
      h2("Training Model for Two Feature Classifier"),
      h3(textOutput("train_accuracy_for_2_feat")),
      h3("Plot for Training Model"),
      plotOutput("train_plot_for_2_feat"),
      h2("Testing Model for Two Feature Classifier"),
      h3(textOutput("test_accuracy_for_2_feat")),
      h3("Plot for Testing Model"),
      plotOutput("test_plot_for_2_feat"),
      h2(textOutput("train_x1")),
      h3(textOutput("train_accuracy_for_1")),
      h3("Plot for Training Model"),
      plotOutput("train_plot_for_1"),
      h2(textOutput("test_x1")),
      h3(textOutput("test_accuracy_for_1")) ,
      h3("Plot for Testing Model"),
      plotOutput("test_plot_for_1"),
      h2(textOutput("train_x2")),
      h3(textOutput("train_accuracy_for_2")),
      h3("Plot for Training Model"),
      plotOutput("train_plot_for_2"),
      h2(textOutput("test_x2")),
      h3(textOutput("test_accuracy_for_2")),
      h3("Plot for Testing Model"),
      plotOutput("test_plot_for_2")
    )
  ),
  
  tabPanel("About Algorithms",
          h3("Binary Classification"),
          h4("Binary classification is predicting the outcome of a model when there are only two classifications the outcome can be. Binary classification 
            is a supervised learning algorithm, which typically used 0 and 1 to denote the two possible outcomes. Based on the model’s prediction using binary 
            classification, there are four ways the result can be interpreted. These interpretations include True Positive, False Positives, False Negatives, 
            and True Negatives. True Positive (TP) means that the prediction and the actual were both positive. False Positive (FP) means that the prediction 
            was positive, but the actual result was negative. False Negatives (FN) mean that the actual result was positive, but the prediction was falsely 
            predicted negative. Lastly, True Negatives (TN) are predictions that correctly identified actual as negative. These elements combine to make up 
            a confusion matrix. A metric associated with binary classification and confusion matrices is accuracy, which is used to assess the logistic 
            regression models the user puts together. The formula for accuracy is (TP + TN) / (TP + FP + TN + FN). Accuracy assesses the percentage of correct 
            predictions the model makes."),
          h3("Logistic Regression"),
          h4("Logistic regression is a classification algorithm that uses predicted probabilities of the categorical target variable to assign data 
             to a category. There are three different kinds of logistic regression. The first type is binomial, which is a binary classifier where 
             the model attempts to predict between two categories. Next, there is multinomial, which classify when there are three or more
             categories of the target variable. Lastly, ordinal logistic regression is used when the categories have meaning in the order they are listed."),
          h4("Along with the different types of logistic regression, there are different activation functions that allocate probabilities to specific classes.
             A couple different examples of activation functions used with logistic regression are SoftMax and Sigmoid activations. SoftMax uses assigned 
             probabilities to predict a single class during a multi-class classification. SoftMax assigns probabilities to each of the available classes and 
             then chooses the class with the highest probability as the expected output. The predicted probabilities for the classes must sum to one, meaning 
             that the probabilities are affected by other classes’ probabilities. In the Sigmoid activation function, which is typically used for binomial 
             logistic regression, the function takes numerical values as the input and outputs probabilities for the corresponding value. Sigmoid activation 
             uses the function to predict probabilities between 0 and 1 (Shrivastava et al., 2022)."),
           ),
  tabPanel("Motivation",
           h3("Question 1: What data did I collect?"),
           h4("The data I collected is from Kaggle and it is called ‘College Basketball Dataset.’ The dataset contains previous college basketball
             team data from 2013 – 2019. The contents of the data set are 25 attributes which span across 2,456 rows. The link for the dataset can
             be found in the ‘About the Dataset’ tab as well as a data dictionary. This dataset was collected because of I wanted to conducted binary
             classification on a dataset. I have a passion for sports and this dataset allowed me to combine both data science and sports."),
           h3("Question 2: Why is this topic  intersting or important to you?"),
           h4("The topic of both classification and NCAA March Madness Tournament both draw heavy interest from me. I have done work with multiclass 
             classification before, but never with a binary classification. This dataset allowed me to use my previous skills while also developing 
             new ones as well. In terms of NCAA Basketball, I have always had a strong passion for sports. I originally was looking for a dataset that
             pertained to baseball, but with both the Men’s and Women’s NCAA March Madness Tournaments currently going on, it was very fitting. I believe 
             this project will also help in creating a bracket predictor. As no one has ever correctly guess every game of the NCAA Men’s March Madness 
             Tournament, gaining insight into the complexity of predicting which teams make the tournament, I believe this will give me an edge on the 
             competition and will help be create a model to predict next year’s game winners."),
           h3("Question 3: How did you analyze the data?"),
           h4("To analyze the data, I ran summaries in R on the data set in an attempt to familiarize myself with the dataset. As I knew I wanted to 
             conduct research in binary classification, I saw drawn to the attribute ‘Seed,’ which showed the seeds in the NCAA Tournament of the 
             different college across different years. As only 68 of the 353 Division 1 Collegiate Basketball programs make the tournament each year, 
             I saw this as an area to learn into. To create a binary problem, I feature engineered the attribute ‘MadeTournament’ to designate if the 
             team made the tournament or not. In the dataset, I used binary number to represent if the team made the tournament or not. 1 represents 
             Yes and 0 represents No. I removed the attributes 'Team' and 'CONF'as these were textual columns and 'Wins Above Bubble', PostSeason', 
              'SEED', and 'Year' as I felt these had issues of data leaking when predicting if the team would make the tournament."),
           h4("To continue analyzing the data, I conducted an 80/20 train/test split on the dataset. From here, I began implementing logistic 
              regression to function as the binary classifier for both the training and testing data. Specifically, the model uses the attribute 
              ‘MadeTournament’ as the target value and the user is able to insert two of the other attributes of the dataset from the dropdown menu. 
              The inserted attributes are used as predictors for make the prediction if the team made the tournament. The model shows accuracy results 
              for both the training and testing data for the logistic regression classifier of the combination of the input features, as well as the 
              input features acting as individual predictors. For each model, I ran accuracy metrics on the data sets to measure the success of the 
              binary classifier.  "),
           h3("Question 4: What did you find in the data?"),
           
           h4("First, I looked at a correlation matrix of the the numerical fields of the training data to gain insight into the relationships between variables. Correlation is 
           the relationship between two variables.The range of correlation is between 1 and -1. There are three types of relationships for correlation. Positive correlation is
           above 0 to 1 and says that as one variable increases the other variable does as well. No correlation is a score of 0. Negative correlation is below 0 to -1 and denotes 
           that if one variable is increases, the other variable decreases. I mainly focused on looking at relationships between the variable 'MadeTournament', as this was the 
           target variable, and the other variables of the dataset. I quickly found out how each variable correlated the attribute 'MadeTournament'. The results are shown in the 
           table below. Wins has the highest correlation to 'MakeTournament' at .62 and 'Power Rating' was right behind at .59. The attribute with lowest correlation was Adjusted 
              Defensive Effciency at -.5."),
            plotOutput("corrplot"),
           tableOutput("corrTable"),
            h4("For further exploratory data analysis, I wanted to look into the number of teams that make the tournament. In the graph below, it illustrates that 1571 teams did 
              not make the NCAA March Madness Tournament while only 393 teams did. This means that out of all the teams in the training dataset only 20% make the tournament each year."),
            plotOutput("madeTourn"),
           
           h4("As Wins was the most correlated attribute to 'MadeTournament', I wanted to look further into the number of wins teams making and not making the tournament had. The two
          histograms that follow illustrates the number of wins for both teams that made the tournament and teams that missed it. The mean number of wins for teams that made the 
          tournament was 24.67 and the mean number of wins for teams that did not make the tournament was 14.39. The median number of wins for teams that made thetournament was 24 and the median
          number of wins for teams that did not make the tournament was 14. As we can see, there is a 10 win difference in making the tournament or not. When it comes to the range wins for making
          the tournament or not, there does indicate that there are some exceptions as teams with over the number of average and median wins to make it have not made it in and teams with below 
          the number of average wins to not make it in have made it to the tournament. The range of wins for teams that made the tournament was 12 to 37 and the range number of wins for teams that 
          did not make the tournament was 0 to 30."),
           plotOutput("tournWins"),
           h4("In terms of results, the main takeaway is that at on the average, the logistic regression classifier with one predictor when assessing the training data 
            can correctly predict if the team made or did not make the NCAA March Madness Tournament 82.65% of the time. The best single predictor was the attribute 
            'Power Rating, which calculates the chance the given team has of beating an average Division 1 basketball team, at 89.6% accuracy. The single predictor 
            with the lowest accuracy at 79.8%. The results for the rest of the logistic regression predictors can be found when using the 'Interactive Binary Classifier.'
            Graphs for the individual predictors are also shown in the 'Interactive Binary Classifier'. The x-axis for the graphs is the inputed predictor and the y-axis 
            is if the team made the tournament, which is represented by 1 or 0."), 
            h4("Furthermore, when implementing two predictors, the accuracies for the predictors increase when combined in comparison to when the attributes are individual 
            predictors. The two predictor logistic regression classifier can be built by selecting two of features. The accuracy results and the plots of the data points 
               for both the training and testing data will be shown after using the 'Interactive Binary Classifier'. To conclude, I found that adding more predictors helped 
               the accuracy of the logistic regression model. Hopefully, I can continue to develop this model and use the model to help me predict which teams make the 
               tournament and potenitally transform the model to be able to predict how far teams go in the tournament and who will win each matchup."),
           
  ),
  tabPanel("About the Dataset",
           h3("About the Dataset"),
           h4("For this project, I utilized a dataset from Kaggle which consisted of data from 2013 - 2019 NCAA Division 1 college basketball season.
  The link to the dataset is provided here:", a("https://www.kaggle.com/datasets/andrewsundberg/college-basketball-dataset?resource=download.", href="https://www.kaggle.com/datasets/andrewsundberg/college-basketball-dataset?resource=download")," The dataset consists of 25 attributes
  from 2,456 rows. The rows contain the data from a specific season of a college team. I feature engineered one attribute in the data set, 'MadeTournament', which is in reference
  to a team gaining entry into the NCAA March madness Tournament for that year. I feature engineered this attribute by looking at the attribute 'Seed' for the tournament. If there
  was an entry in the 'Seed' attribute that was 'NA', I understood this to mean the team did not make the tournament and a 0 was put down. For team with
  a number between 1 and 16, I put a 1 in the 'MadeTournament' attribute as there are 4 sets of 16 different seeds in each annual NCAA March Madness. 
  The interpretation of this binary thinking is that 1 means Yes, the team made the tournament, and 0 means that the 
  team did not make the tournament. The 'MadeTournament' attribute was used as the predictors for the binary classification algorithms."),
  
           hr(),
           h3("Data Dictionary of the Attribute of the College Basketball Dataset"),
           h5("TEAM: The Division I college basketball school"),
           h5("CONF: The Athletic Conference in which the school participates in"),
           h5("G: Number of games played"),
           h5("WINS: Number of games won"),
           h5("ADJOE: Adjusted Offensive Efficiency"),
           h5("ADJDE: Adjusted Defensive Efficiency"),
           h5("BARTHAG: Power Rating"),
           h5("EFG_O: Effective Field Goal Percentage Shot"),
           h5("EFG_D: Effective Field Goal Percentage Allowed"),
           h5("TOR: Turnover Percentage Allowed"),
           h5("TORD: Turnover Percentage Committed"),
           h5("ORB: Offensive Rebound Rate"),
           h5("DRB: Offensive Rebound Rate Allowed"),
           h5("FTR : Free Throw Rate"),
           h5("FTRD: Free Throw Rate Allowed"),
           h5("2P_O: Two-Point Shooting Percentage"),
           h5("3P_O: Three-Point Shooting Percentage"),
           h5("3P_D: Three-Point Shooting Percentage Allowed"),
           h5("ADJ_T: Adjusted Tempo"),
           h5("WAB: Wins Above Bubble"),
           h5("POSTSEASON: Round where the given team was eliminated or where their season ended"),
           h5("SEED: Seed in the NCAA March Madness Tournament"),
           h5("MADETOURNAMENT: Signifies if the team made the NCAA March Madness Tournament; 1 for Yes, 0 for No"),
           h5("YEAR: Season data is from")
           
  )
)



