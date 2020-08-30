# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes

#Import Libarires
library(ggplot2) #Data visulization 
library(readr) # To read CSV File
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


# Read the data
games_list<- read.csv("games.csv",na.strings="")

#Data elaboration and cleaning
#rm(games_list)
class(games_list)
head(games_list)
str(games_list)
summary(games_list)

#missing value analysis
sum(complete.cases(games_list))

#Remove records with NA
games_list<-na.omit(games_list)

#Check for duplicates
duplicated(games_list) 
sum()

#Creating table
table(games_list$Rating)
table(games_list$Genre)

## Correcting Typos
games_list$Genre[games_list$Genre == "ACTION"] <- "Action"
games_list$Genre[games_list$Genre == "RACING"] <- "Racing"
games_list$Genre[games_list$Genre == "sPorts"] <- "Sports"

#Replacing string value in integer column to NA 
games_list$Critic_Score[games_list$User_Score=="tbd"]<- "NA"

##remove the records with NA
games_list <- na.omit(games_list)

#Univariate_Analysis

# 1. Frequency 
table(games_list$Rating)
table(games_list$Genre)

# 2 percentage table
100*(table(games_list$Rating)/sum(table(games_list$Rating)))
100*(table(games_list$Genre)/sum(table(games_list$Genre)))

# 3 Location
## Mean 
mean(as.integer(games_list$User_Score))
mean(as.integer(games_list$Critic_Score))
mean(games_list$Global_Sales)
mean(games_list$NA_Sales)
mean(games_list$EU_Sales)
mean(games_list$JP_Sales)

## Median
median(as.integer(games_list$User_Score))
median(as.integer(games_list$Critic_Score))
median(games_list$Global_Sales)
median(games_list$NA_Sales)
median(games_list$EU_Sales)
median(games_list$JP_Sales)

## 4	Spread (minimum, maximum, range, quartiles, standard deviation, etc.)

# min values
min(games_list$Global_Sales)
min(games_list$NA_Sales)
min(games_list$EU_Sales)
min(games_list$JP_Sales)
min(as.integer(games_list$User_Score))
min(as.integer(games_list$Critic_Score))

# max values
max(as.integer(games_list$User_Score))
max(as.integer(games_list$Critic_Score))
max(games_list$Global_Sales)
max(games_list$NA_Sales)
max(games_list$EU_Sales)
max(games_list$JP_Sales)

# range
range(as.integer(games_list$User_Score))
range(as.integer(games_list$Critic_Score))
range(games_list$Global_Sales)
range(games_list$NA_Sales)
range(games_list$EU_Sales)
range(games_list$JP_Sales)

# quartiles
quantile(as.integer(games_list$User_Score))
quantile(as.integer(games_list$Critic_Score))
quantile(games_list$Global_Sales)
quantile(games_list$NA_Sales)
quantile(games_list$EU_Sales)
quantile(games_list$JP_Sales)

#variance
var(games_list$Global_Sales)
var(games_list$NA_Sales)
var(games_list$EU_Sales)
var(games_list$JP_Sales)
var(as.integer(games_list$User_Score))
var(as.integer(games_list$Critic_Score))

#Standard Deviation
sd(as.integer(games_list$User_Score))
sd(as.integer(games_list$Critic_Score))
sd(games_list$Global_Sales)
sd(games_list$NA_Sales)
sd(games_list$EU_Sales)
sd(games_list$JP_Sales)



# 4 Bar chart
par(mfrow = c(2,2), mar=c(4, 4, 2,1))
barplot( games_list$Global_Sales,col = "Green", xlab = "Global_Sales", ylab = "Frequency", main = "Barplot of Global_Sales")
barplot( games_list$NA_Sales,col = "Green", xlab = "NA_Sales", ylab = "Frequency",main = "Barplot of NA_Sales")
barplot( games_list$EU_Sales,col = "Green", xlab = "EU_Sales", ylab = "Frequency", main = "Barplot of EU_Sales")
barplot( games_list$JP_Sales, col = "Green",xlab = "JP_Sales", ylab = "Frequency", main = "Barplot of JP_Sales")

## 5	Histogram
par(mfrow = c(1,2), mar=c(4, 4, 2,1))
hist( as.integer(games_list$User_Score),col = "Red", xlab = "User Score",  main = "Histogram of User Score")
hist( as.integer(games_list$Critic_Score),col = "Red", xlab = "Critic Score",  main = "Histogram of Critic Score")

## 6 Pie chart
par(mfrow = c(1,2), mar=c(4, 4, 2,1))
pie(table(games_list$Rating), main = "Rating Pie Chart",col=brewer.pal(length(games_list$Rating),'Spectral'))
legend("topleft",c("E","AO","T","RP","M","E10+","EC","K-A"),cex = 0.4,fill = brewer.pal(length(games_list$Rating),'Spectral'))

pie(table(games_list$Genre), main = "Genre Pie Chart",col=brewer.pal(length(games_list$Genre),'Spectral'))
legend("topleft",c("Action","Sports","Racing","Platform","Puzzle","Adventure","Strategy","Sports","Shooter","Role-Playing","Misc","Fighting"),cex = 0.4,fill = brewer.pal(length(games_list$Genre),'Spectral'))
# Save the file.
dev.off()

## 7	Boxplot
par(mfrow = c(1, 2), mar=c(4, 4, 2,1))
boxplot(as.integer(games_list$Year_of_Release),xlab="Year of Release", main = "Year of Release" , outline = FALSE)
boxplot(as.integer(games_list$Genre),xlab="Genre",main = "Genre" , outline = FALSE)


## 8 WordCloud

d <- data.frame(table(games_list$Genre))
set.seed(1234)
wordcloud(words = d$Var1, freq = d$Freq , min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


## Bivariate Analysis

##-	Frequency
table(games_list$Rating, games_list$Genre) 

##-	Percentage
100*(table(games_list$Rating, games_list$Genre)/sum(table(games_list$Rating, games_list$Genre)))

##-	Correlation
cor(games_list$Global_Sales, games_list$NA_Sales)
cor(games_list$Global_Sales, games_list$EU_Sales)
cor(games_list$Global_Sales, games_list$JP_Sales)

## covariance
cov(games_list$Global_Sales, games_list$NA_Sales)
cov(games_list$Global_Sales, games_list$EU_Sales)
cov(games_list$Global_Sales, games_list$JP_Sales)

##-	Linear Regression
##calculating linear model
linear_model<-lm(NA_Sales ~ Global_Sales, data=games_list)

##plotting linear model
lines(games_list$Global_Sales,linear_model$fitted.values)

##-	Polynomial Regression
##calculating polynomial model
poly_model <- lm(games_list$Global_Sales~poly(games_list$NA_Sales,2))
## plotting model
lines(games_list$Global_Sales,poly_model$fitted.values)


##-	Bar plot based on Genre of games
par(mfrow = c(1, 2), mar=c(4, 4, 2,1))
barplot(table( games_list$Genre,  as.integer(games_list$Critic_Count)),xlab = "Genre", main = "Critic Count", col = "blue")
barplot(table( games_list$Genre, as.integer(games_list$User_Count)),xlab = "Genre", main = "User Count" , col = "blue")

##-	Box plot based on Ratings of games
par(mfrow = c(1, 1), mar=c(4, 4, 2,1))
boxplot(as.integer(games_list$User_Score),as.integer(games_list$Critic_Score),xlab = "User Score",ylab = "Critic Score", col = "Red", outline = FALSE)
  