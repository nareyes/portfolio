# ABC Grocery Hypothesis Testing to Assess Campaign Performance
In this project we apply Chi-Square Test For Independence (a Hypothesis Test) to assess the performance of two types of mailers that were sent out to promote a new service for a simulated grocery store.
__________

## Table of Contents
- [Project Context](#project-context)
- [Project Actions](#project-actions)
- [Data Prep, Application, and Results](#data-preparation-application-and-results)
- [Concept Overview](#concept-overview)
__________

## Project Context
Earlier in the year, ABC Grocery ran a campaign to promote their new Delivery Club. This is a membership that costs \$100 per year, but offers free grocery deliveries rather than the normal delivery cost of \$10 per delivery.

For the campaign promoting the club, customers were put randomly into three groups;
- The first group received a low quality, low cost mailer
- The second group received a high quality, high cost mailer
- The third group received no mailer at all (control group)

The client knows that customers who were contacted, signed up for the Delivery Club at a far higher rate than the control group, but now want to understand if there is a significant difference in signup rates between the cheap mailer and the expensive mailer.  This will allow them to make more informed decisions in the future, with the overall aim of optimizing campaign ROI.
__________

## Project Actions
For this test, as it is focused on comparing the *rates* of two groups - we applied the Chi-Square Test for Independence.

From the *campaign_data* table in the client database, we isolated customers that received "Mailer 1" (low cost) and "Mailer 2" (high cost) for this campaign, and excluded customers who were in the control group.

We set out our hypotheses and Acceptance Criteria for the test, as follows:
- **$H_0$ :** There is no relationship between mailer type and signup rate. They are independent.
- **$H_a$ :** There is a relationship between mailer type and signup rate. They are not independent.
- **Acceptance Criteria:** 0.05

As a requirement of the Chi-Square Test For Independence, we aggregated this data down to a 2x2 matrix for *signup_flag* by *mailer_type* and fed this into the algorithm (using the *scipy* library) to calculate the Chi-Square Statistic, P-Value, Degrees of Freedom, and Expected Values.
__________

## Data Preparation, Application, and Results
[Jupyter Notebook: ABC Grocery Chi-Square_Test](https://github.com/nareyes/personal_portfolio/blob/main/data_science_projects/abc_grocery_hypothesis_testing/abc_grocery_chi-square_test.ipynb)
_________
_________

<br>

# Concept Overview

## A/B Testing
An A/B Test can be described as a randomised experiment containing two groups, A & B, that receive different experiences. Within an A/B Test, we look to understand and measure the response of each group - and the information from this helps drive future business decisions. Application of A/B testing can range from testing different online ad strategies, different email subject lines when contacting customers, or testing the effect of mailing customers a coupon, vs a control group.  

## Hypothesis Testing
A Hypothesis Test is used to assess the plausibility, or likelihood of an assumed viewpoint based on sample data - in other words, it helps us assess whether a certain view we have about some data is likely to be true or not.

There are many different scenarios we can run Hypothesis Tests on, and they all have slightly different techniques and formulas - however they all have some shared, fundamental steps & logic that underpin how they work.

#### The Null Hypothesis
In any Hypothesis Test, we start with the Null Hypothesis. The Null Hypothesis is where we state our initial viewpoint, and in statistics, our initial viewpoint is always that the result is purely by chance or that there is no relationship or association between two outcomes or groups.

#### The Alternate Hypothesis
The aim of the Hypothesis Test is to look for evidence to support or reject the Null Hypothesis.  If we reject the Null Hypothesis, that would mean we’d be supporting the Alternate Hypothesis. The Alternate Hypothesis is essentially the opposite viewpoint to the Null Hypothesis - that the result is *not* by chance, or that there *is* a relationship between two outcomes or groups

#### The Acceptance Criteria
In a Hypothesis Test, before we collect any data or run any numbers - we specify an Acceptance Criteria.  This is a p-value threshold at which we’ll decide to reject or support the null hypothesis.  It is essentially a line we draw in the sand saying "if I was to run this test many times, what proportion of those times would I want to see different results come out, in order to feel comfortable, or confident that my results are not just some unusual occurrence." Conventionally, we set our Acceptance Criteria to 0.05 - but this does not have to be the case.  If we need to be more confident that something did not occur through chance alone, we could lower this value down to something much smaller, meaning that we only come to the conclusion that the outcome was special or rare if it’s extremely rare.

So to summarise, in a Hypothesis Test, we test the Null Hypothesis using a p-value and then decide it’s fate based on the Acceptance Criteria.

## Chi-Square Test For Independence
The Chi-Square Test For Independence is a type of Hypothesis Test that assumes observed frequencies for categorical variables will match the expected frequencies. The *assumption* is the Null Hypothesis, which as discussed above is always the viewpoint that the two groups will be equal.  With the Chi-Square Test For Independence we look to calculate a statistic which, based on the specified Acceptance Criteria will mean we either reject or support this initial assumption.
- The *observed frequencies* are the true values that we’ve seen.
- The *expected frequencies* are essentially what we would *expect* to see based on all of the data.

<br>

**Note:** Another option when comparing "rates" is a test known as the *Z-Test For Proportions*.  While, we could absolutely use this test here, we have chosen the Chi-Square Test For Independence because:
- The resulting test statistic for both tests will be the same
- The Chi-Square Test can be represented using 2x2 tables of data - meaning it can be easier to explain to stakeholders
- The Chi-Square Test can extend out to more than 2 groups - meaning the business can have one consistent approach to measuring signficance
__________
