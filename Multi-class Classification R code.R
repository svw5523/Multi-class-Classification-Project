# clean up workspace environment
rm(list = ls())
# load library
library(ggplot2)
library(class)
library(boot)
library(MASS)
library(glmnet)
library(dplyr)

### Data Preparation  
# Load dataset
library(readxl)
cancer_data <- read_excel("Documents/STSCI 4740/Final Report/cancer_data.xlsx")

# Clean dataset
cancer_data = na.omit(cancer_data)
glimpse(cancer_data)

# Use 80% training set and 20% test set
set.seed(1)
train_idx = sort(sample(seq(1, nrow(cancer_data), by=1), size = 0.8*nrow(cancer_data)))
test_idx = setdiff(seq(1, nrow(cancer_data), by=1), train_idx)
training_set = cancer_data[train_idx, -1]
validation_set = cancer_data[test_idx, -1]


### Exploratory Data Analysis (EDA)
# inspect our dataset
summary(training_set)
summary(validation_set)
ncol(training_set)
ncol(validation_set)
nrow(training_set) # case of training_set
nrow(validation_set) # case of validation_set

# Diagnostic plot
# png(filename="barplot_train.png", width=960, height=960, res=120)
training_set %>%
  ggplot(aes(Level)) +
  geom_bar(fill = 'grey60')+
  xlab('Cancer levels') +
  ggtitle('Trend of the number of patients in each respective level') +
  theme(plot.title = element_text(hjust = 0.5))
# graphics.off()

# png(filename="barplot_test.png", width=960, height=960, res=120)
validation_set %>%
  ggplot(aes(Level)) +
  geom_bar(fill = 'grey60')+
  xlab('Cancer levels') +
  ggtitle('Trend of the number of patients in each respective level') +
  theme(plot.title = element_text(hjust = 0.5))
# graphics.off()

# png(filename="boxplot_train.png", width=960, height=960, res=120)
training_set %>%
  ggplot(aes(x = reorder(Level, Age, mean), y = Age)) +
  geom_boxplot(stat = 'boxplot') +
  xlab('Cancer levels') +
  ylab('Patient ages') +
  ggtitle('Relationship between cancer levels and age for patients') +
  theme(plot.title = element_text(hjust = 0.5))
# graphics.off()

# png(filename="boxplot_test.png", width=960, height=960, res=120)
validation_set %>%
  ggplot(aes(x = reorder(Level, Age, mean), y = Age)) +
  geom_boxplot(stat = 'boxplot') +
  xlab('Cancer levels') +
  ylab('Patient ages') +
  ggtitle('Relationship between cancer levels and age for patients') +
  theme(plot.title = element_text(hjust = 0.5))
# graphics.off()

# png(filename="densityplot_train.png", width=960, height=960, res=120)
training_set %>%
  ggplot(aes(x = `Coughing of Blood`)) +
  geom_density(aes(fill = Level, color = Level), alpha = 0.5) +
  ggtitle('Density level for coughing of blood situation for patients') +
  theme(legend.position = "top") +
  theme(plot.title = element_text(hjust = 0.5))
# graphics.off()

# png(filename="densityplot_test.png", width=960, height=960, res=120)
validation_set %>%
  ggplot(aes(x = `Coughing of Blood`)) +
  geom_density(aes(fill = Level, color = Level), alpha = 0.5) +
  ggtitle('Density level for coughing of blood situation for patients') +
  theme(legend.position = "top") +
  theme(plot.title = element_text(hjust = 0.5))
# graphics.off()


### Linear Discriminant Analysis

# use set.seed(1) to make results reproducible
set.seed(1)

# perform linear discriminant analysis using all the variables in training set
lda_model = lda(Level~ ., data = training_set)
lda_model
plot(lda_model)

# compute the validation set error which is the fraction of patient in the validation set whose cancer level is misclassified
lda_predict = predict(lda_model, validation_set)
lda_predict$class # prediction result
lda_class = lda_predict$class
table(lda_class, validation_set$Level)
mean(lda_class != validation_set$Level) # estimate the test error

### K-Nearest Neighbors

# use set.seed(1) to make results reproducible
set.seed(1)

# Transform variables in dataset
train_X = training_set[,-24] #X for training data
test_X = validation_set[,-24] #X for testing data
train_Y = training_set$Level #Y for training data

# perform K-Nearest Neighbors analysis using all the variables in training set and 
knn_predict = knn(train_X,test_X,train_Y,k=3)
knn_predict
plot(knn_predict)

# compute the validation set error which is the fraction of patient in the validation set whose cancer level is misclassified
table(knn_predict, validation_set$Level)
mean(knn_predict != validation_set$Level) # estimate the test error
