'''
Find the price of the cheapest property for every city.

https://platform.stratascratch.com/coding/9625-cheapest-properties?code_type=2
'''

# Import your libraries
import pandas as pd
import numpy as np

# Start writing code
cheapest_property = airbnb_search_details.groupby(['city'])['price'].min().reset_index()[['city', 'price']]
result = cheapest_property.rename(columns={'price': 'min_price'})

result