# ABC Grocery: Regression Modeling to Predict Loyalty Scores

In this project, we apply regression modeling to predict the loyalty scores for customers missing loyalty scores.
Only 50% of the customer data contains loyalty information, which we will use to predict the loyalty scores of
the remaining customers. 
_________

## Table of Contents
- [Project Context](#project-context)
- [Project Actions](#project-actions)
- [Data Prep, Application, and Results](#data-preparation-application-and-results)
- [Concept Overview](#concept-overview)
________

## Project Context
ABC Grocery hired a market research consultancy to append market level customer loyalty information to the database.  However, only around 50% of the client's customer base could be tagged, thus the other half did not have this information present.

The overall aim of this work is to accurately predict the *loyalty score* for those customers who could not be tagged, enabling our client a clear understanding of true customer loyalty, regardless of total spend volume - and allowing for more accurate and relevant customer tracking, targeting, and communications.

To achieve this, we looked to build out a predictive model that will find relationships between customer metrics and *loyalty score* for those customers who were tagged, and use this to predict the loyalty score metric for those who were not.
________

## Project Actions
We firstly needed to compile the necessary data from tables in the database, gathering key customer metrics that may help predict *loyalty score*, appending on the dependent variable, and separating out those who did and did not have this dependent variable present.

As we are predicting a numeric output, we tested three regression modelling approaches;
- Linear Regression
- Decision Tree
- Random Forest

**Key Definition**
- The *loyalty score* metric measures the % of grocery spend (market level) that each customer allocates to the client vs. all of the competitors.  
    - Example 1: Customer X has a total grocery spend of $100 and all of this is spent with our client. Customer X has a *loyalty score* of 1.0
    - Example 2: Customer Y has a total grocery spend of $200 but only 20% is spent with our client.  The remaining 80% is spend with competitors.  Customer Y has a *customer loyalty score* of 0.2
________

## Data Preparation, Application, and Results
[Jupyter Notebook: ]()

**R-Squared Results (K-Fold Cross Validation, k = 4)**
- Random Forest = 
- Decision Tree = 
- Linear Regression = 0.8498188815541201

**Adjusted R-Squared Results (Test Set)**
- Random Forest = 
- Decision Tree = 
- Linear Regression = 0.8313350515915503

> As the most important outcome for this project was predictive accuracy, rather than explicitly understanding weighted drivers of prediction, we chose the Random Forest as the model to use for making predictions on the customers who were missing the *loyalty score* metric.
_________
_________

<br>

# Concept Overview