/*
Classify each business as either a restaurant, cafe, school, or other. 
- A restaurant should have the word 'restaurant' in the business name. 
- For cafes, either 'cafe', 'café', or 'coffee' can be in the business name. 
- 'School' should be in the business name for schools. 
- All other businesses should be classified as 'other'. 
Output the business name and the calculated classification.

https://platform.stratascratch.com/coding/9726-classify-business-type?code_type=1
*/

select
    distinct business_name,
    case
        when business_name like '%restaurant%' then 'restaurant'
        when business_name like '%school%' then 'school'
        when business_name like '%cafe%' or business_name like '%coffee%'  or business_name like  '%café%' then 'cafe'
        else 'other'
    end as business_type
from sf_restaurant_health_violations;