# Machine Learning Prediction for Multi-class Classification

Apply machine to predict the categorical response variable of “cancer level” using R, based on patients’ detailed physical indexes (age, obesity, alcohol use, etc.).

Compare the performance of each machine learning method and evaluate the prediction test error rates.

We used variety kinds of machines to perform analysis to multi-class classification, including Linear Discriminant Analysis, K-Nearest Neighbors, Support Vector Machine, Naive Bayes, Multinomial Regression, Decision Tree and Random Forest. Here, the R code accounts for EDA part and two specific machines:

### Model 1 
Linear Discriminant Analysis (LDA)
- Apply Linear Discriminant Analysis based on Bayes’ theorem to predict our dataset "cancer data"
- Fit LDA to all the variables except our response variable "Level" with respect to training set
- Determine test error rate by checking how many predicted cancer level value are misclassified by validation set approach with 80% train set and 20% test set respectively
- Obtained an extreme good test error rate around 0.035, which may indicate the original dataset "cancer data" is well-separated and enough cleaned

### Model 2
K-Nearest Neighbors (KNN)
- The intuition behind KNN method is that we estimate P(Y = j | X = x0) by calculating the fraction of points in jth class around all the data points around x0
- We also have different cluster N with K data points close to the target data point j in the training data
- To account for bias-variance trade-off, we will choose K = 3 to balance the prediction error
- Obtained a perfect test error rate 0 by applying KNN method here, so we have the reason to believe that KNN method makes perfectly prediction

Conclusion: All models are close to perfect. We also evaluate the prediction accuracy. KNN, SVM, Multinomial Regression and Random Forest are tie in the first rank with perfect test error rate. Therefore, we are confident that the dataset "cancer level" is clean with non-noise. In the future we will consider do this project on a more real-world dataset
