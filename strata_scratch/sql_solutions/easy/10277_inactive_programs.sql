/*
Find all inspections which are part of an inactive program.

https://platform.stratascratch.com/coding/10277-find-all-inspections-which-are-part-of-an-inactive-program?code_type=1
*/

select * 
from los_angeles_restaurant_health_inspections
where lower (program_status) = 'inactive';