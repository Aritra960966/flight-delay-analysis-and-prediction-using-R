# NYC Flights Data Analysis

This project involves a comprehensive analysis of the NYC flights dataset, sourced from [OpenIntro](https://www.openintro.org/data/index.php?data=nycflights1). The analysis includes data exploration, cleaning, visualization, and statistical modeling. The project is documented using R Markdown, and the results are presented through various plots and summaries.

## Table of Contents

1. [Data Loading and Exploration](#data-loading-and-exploration)
2. [Data Cleaning](#data-cleaning)
3. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
4. [Correlation Analysis](#correlation-analysis)
5. [Categorical Variable Analysis](#categorical-variable-analysis)
6. [Time Series Analysis](#time-series-analysis)
7. [Airport Analysis](#airport-analysis)
8. [Weather Impact Analysis](#weather-impact-analysis)
9. [Statistical Test](#statistical-test)
10. [Regression Model](#regression-model)
11. [Data Presentation](#data-presentation)
12. [Conclusion](#conclusion)

## Data Loading and Exploration

- **Dataset Source**: The dataset is downloaded from the OpenIntro website.
- **Loading**: The `flights` dataset is loaded into R.
- **Exploration**: The first few rows and summary statistics of the dataset are explored to understand the data structure and the basic characteristics.

## Data Cleaning

- **Missing Values**: The dataset is checked for missing values.
- **Data Types**: Columns are converted to appropriate data types for further analysis.

## Exploratory Data Analysis (EDA)

- **Visualizations**: 
  - Histograms and bar charts are created to understand the distribution of departure delays, arrival delays, and flight distances.
  - Relationships between these features are explored through scatter plots and correlation analysis.

## Correlation Analysis

- **Correlation Matrix**: A correlation matrix is calculated between departure delays, arrival delays, and flight distances.
- **Visualization**: The correlation matrix is visualized using a heatmap.

## Categorical Variable Analysis

- **Distribution Analysis**: The distribution of categorical variables such as airlines and destinations is explored.
- **Visualization**: The average departure delays are visualized across different airlines and destinations.

## Time Series Analysis

- **Pattern Exploration**: Departure delays are analyzed over time (by month or day of the week) to identify any trends or seasonal patterns.
- **Time Series Plots**: Time series plots are created to visualize these trends.

## Airport Analysis

- **Average Delays**: The airport with the highest average departure delays (JFK, LGA, EWR) is identified.
- **Visualization**: The distribution of departure delays is visualized for each airport.

## Weather Impact Analysis

- **Weather Variables**: The impact of weather conditions (e.g., visibility, wind speed) on departure delays is explored.
- **Visualizations**: Relationships between departure delays and weather variables are visualized using scatter plots and regression lines.

## Statistical Test

- **Two-Sample T-Test**: A two-sample t-test is performed to compare the means of arrival delays between flights from JFK and LGA airports.

## Regression Model

- **Model Building**: A regression model is built to predict departure delays based on relevant features.
- **Model Evaluation**: The model’s performance is evaluated using appropriate metrics, such as R-squared.

## Data Presentation

- **Report**: The findings are summarized in a report using R Markdown. The report includes visualizations and interpretations of the results.

## Conclusion

- **Coefficients**: The coefficients of the predictors in the model are as follows:
  - Intercept: -13.464797
  - Distance: 0.002866
  - Air_time: -0.025867
  - Hour: 2.153145
  - Month: -0.202686
  
  These coefficients represent the estimated effect of each predictor variable on the dependent variable (dep_delay). For example, for every one-unit increase in distance, dep_delay is expected to increase by approximately 0.002866 units, holding other variables constant.

- **R-squared**: The R-squared value is 0.06438, which indicates that approximately 6.44% of the variance in dep_delay is explained by the predictors included in the model.

- **Mean Absolute Error (MAE)**: The Mean Absolute Error (MAE) is 21.6533. This represents the average absolute difference between the observed dep_delay values and the predicted values by the model.

- **Mean Squared Error (MSE)**: The Mean Squared Error (MSE) is 1581.8262. This represents the average of the squares of the errors, indicating the average squared difference between the observed dep_delay values and the predicted values by the model.

Based on this information:
- The coefficients provide insight into how each independent variable influences the dependent variable.
- The R-squared value indicates that the regression model explains a small proportion of the variance in dep_delay.
- The MAE and MSE provide measures of the regression model’s accuracy in predicting dep_delay.

Overall, the model has limited explanatory power and predictive accuracy, as indicated by the low R-squared value and the relatively high MAE and MSE. Further improvement of the model may be needed to better understand and predict dep_delay.



## How to Run the Analysis

1. Clone this repository:
    ```sh
    git clone https://github.com/Aritra960966/flight-delay-analysis-and-prediction-using-R.git
    ```
2. Open the R project in RStudio.
3. Install the necessary packages by running:
    ```r
    install.packages(c("dplyr", "ggplot2", "tidyr", "lubridate", "corrplot"))
    ```
4. Run the R Markdown file to generate the report.


