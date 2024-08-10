install.packages("tidyverse")
install.packages("GGally")
install.packages("reshape2")
install.packages("caret")
install.packages("lubridate")
library(reshape2)
library(tidyverse)
library(ggplot2)
library(GGally)
library(caret)
library(lubridate)
flights<-read.csv("nycflights.csv")
#exploring the dataset
head(flights)
summary(flights)

names(flights)
glimpse(flights)
#data cleaning
#get names
#SPEED ANALYSIS
flights<-flights %>% mutate(avg_speed=distance/(air_time/60))
flights %>% select(avg_speed,tailnum) %>% arrange(desc(avg_speed))
ggplot(flights,aes(x=distance,y=avg_speed))+geom_point()


#plotting the data histogram
ggplot(data=flights,aes(x=dep_delay))+geom_histogram(stat="bin",binwidth = 30)

ggplot(data=flights,aes(x=dep_delay))+geom_histogram(stat="bin",binwidth = 15)

ggplot(data=flights,aes(x=dep_delay))+geom_histogram(stat="bin",binwidth = 150)
#creating data frame
data <- data.frame(
  DepartureDelay = flights$dep_delay,
  ArrivalDelay = flights$arr_delay,
  FlightDistance = flights$distance
)


#HISTOGRAM PLOT
ggplot(data, aes(x = DepartureDelay)) +
  geom_histogram(binwidth = 10, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Departure Delays", x = "Departure Delay (minutes)", y = "Frequency") 

ggplot(data, aes(x = ArrivalDelay)) +
  geom_histogram(binwidth = 10, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Arrival Delays", x = "Arrival Delay (minutes)", y = "Frequency") 

ggplot(data, aes(x = FlightDistance)) +
  geom_histogram(binwidth = 50, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Flight Distances", x = "Flight Distance (miles)", y = "Frequency") 

#visualization
ggpairs(data)


#flight delay visualization
flights<-flights %>% 
  mutate(dept_type=ifelse(dep_delay<5,"ON TIME","DELAYED"))


flights %>% 
  group_by(origin) %>% 
  summarise(on_time_dept_rate=sum(dept_type=="ON TIME")/n()) %>% 
  arrange(desc(on_time_dept_rate))

ggplot(data=flights,aes(x=origin,fill=dept_type))+geom_bar()


#flight delay rate
flights<-flights %>% 
  mutate(arrival_type=ifelse(arr_delay<=0,"ON TIME","DELAYED"))
flights<-flights %>% 
  mutate(departure_type=ifelse(dep_delay<=0,"ON TIME","DELAYED"))

flights %>% select(departure_type,arrival_type) %>% table
#proportion of flight on time arrival
(3508/(9291+3508))*100


flights %>%
  select(dep_delay) %>%
  summary()

flights %>% 
  group_by(month) %>% 
  summarise(mean_dd=mean(dep_delay)) %>% 
  arrange(desc(mean_dd))


flights %>% 
  group_by(month) %>% 
  summarise(median_dd=median(dep_delay)) %>% 
  arrange(desc(median_dd))

ggplot(flights,aes(x=factor(month), y=dep_delay))+geom_boxplot()+labs(x="months",y="departure delay")


flights %>%
  select(tailnum,flight,origin,dest) %>% 
  filter(complete.cases(.))
#categorical 
flights_df <- data.frame(
  Airline = flights$carrier,
  Destination = flights$dest,
  Departure_Delay =flights$dep_delay)

average_delays <- flights_df %>%
  group_by(Airline, Destination) %>%
  summarise(Avg_Delay = mean(Departure_Delay)) %>% arrange(desc(Avg_Delay))

average_delays<- melt(average_delays, id.vars = c("Airline", "Destination"))

ggplot(average_delays, aes(x = Destination, y = Airline, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(title = "Average Departure Delay Across Airlines and Destinations",
       x = "Destination",
       y = "Airline",
       fill = "Average Departure Delay") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_fixed(ratio=4,expand=T) 









#correlation matrix and visualization
library(dplyr)
corrlation_matrix<-cor(select(flights,dep_delay,arr_delay,distance))
corrlation_matrix
## Visualize the correlation matrix as a heatmap
ggplot(melt(corrlation_matrix), aes(Var1, Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "yellow", midpoint = 0,
                       limit = c(-1,1), space = "Lab", name="Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 10, hjust = 1)) +
  coord_fixed()
#categorical variable analysis
ggplot(data=flights,aes(x=origin,fill=dept_type))+geom_bar()
#two sample test
JFK_delay<-flights %>% filter(origin=="JFK") %>% select(arr_delay)
JFK_delay
LGA_delay<-flights %>% filter(origin=="LGA") %>% select(arr_delay)
LGA_delay
t_test<-t.test(JFK_delay,LGA_delay)
t_test


#categorize by source_airport
df=flights %>% group_by(origin) %>% 
  summarise(c2=mean(dep_delay))
df

coul <- brewer.pal(3, "Set2")
barplot(df$c2,names.arg = df$origin,col="blue",width=c(0.2,0.1,0.05))


#time series analysis
#install.packages("forecast")
library(forecast)
#processing daily data into a variable
#cobining year month and day into date

flights$date
#loding data
#daily_flights_data<-flights %>% group_by(date) %>% summarise(dep_delay)

#creating a time series object
#ts_flights<-ts(daily_flights_data$dep_delay,frequency = 365)

#autoplot(ts_flights)
#arima_model <- auto.arima(ts_flights)
#summary(arima_model)
#forecast_values <- forecast(arima_model, h = 12) 
# Forecasting next 12 periods
#plot(forecast_values)

#autoplot(forecast_values) + 
#  labs(title = "Observed vs. Forecasted Departure Delays")

              #TIME SERIES ANALYSIS
#by month
monthly_delays <- flights %>%
  group_by(month) %>%
  summarize(avg_delay = mean(dep_delay))
#weekly
flights$day_of_week <- weekdays(as.Date(paste(flights$year, flights$month, flights$day, sep = "-")))
weekly_delays <- flights %>%
  group_by(day_of_week) %>%
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE))

#BY DAY
daily_delays <- flights %>%
  group_by(day) %>%
  summarize(avg_delay = mean(dep_delay))
#weekly delay trend
ggplot(weekly_delays, aes(x = reorder(day_of_week, avg_delay), y = avg_delay)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Departure Delay by Day of the Week",
       x = "Day of the Week",
       y = "Average Departure Delay (minutes)")+scale_fill
# Monthly Delay Trend
ggplot(monthly_delays, aes(x = month, y = avg_delay)) +
  geom_line(colour="red") +
  labs(title = "Average Departure Delay by Month", x = "Month", y = "Average Delay (minutes)")

# Daily Delay Trend
ggplot(daily_delays, aes(x = day, y = avg_delay)) +
  geom_line(color="blue") +
  labs(title = "Average Departure Delay by Day", x = "Day", y = "Average Delay (minutes)")

#distance vs departure delay
ggplot(data = flights, aes(x=distance, y=dep_delay))+geom_point(size=1,color = ifelse(flights$dep_delay > 600, "red", "blue"))

#air time vs departure delay
ggplot(data = flights, aes(x=air_time, y=dep_delay))+geom_point(size=1,color = ifelse(flights$dep_delay > 600, "red", "blue"))


#regression model
data_for_regression <- data.frame(
  DepartureDelay = flights$dep_delay,
  ArrivalDelay = flights$arr_delay,
  FlightDistance = flights$distance,
  monthdata=flights$month,
  hour_data=flights$hour
)

ggpairs(data_for_regression)

selected_features <- c("dep_delay", "distance", "air_time", "hour", "month")
model_data <- flights[, selected_features]
train_index <- createDataPartition(model_data$dep_delay, p = 0.8, list = FALSE)
train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]

lm_model <- lm(dep_delay ~ distance+air_time+hour+month, data = train_data)


predictions<-predict(lm_model, newdata = test_data)

rsquared <- cor(predictions, test_data$dep_delay)^2
mae <- mean(abs(predictions - test_data$dep_delay))
mse <- mean((predictions - test_data$dep_delay)^2)

print(paste("R-squared:", rsquared))
mae
mse




