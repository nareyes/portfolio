/*
Meta/Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees. 
The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. 
Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location. 
Luckily the user IDs of employees completing the surveys were stored.

Based on the above, find the average popularity of the Hack per office location.
Output the location along with the average popularity.

https://platform.stratascratch.com/coding/10061-popularity-of-hack?code_type=1
*/

select
    e.location,
    avg (cast (s.popularity as float)) as avg_popularity
from facebook_employees as e
    inner join facebook_hack_survey as s
        on e.id = s.employee_id
group by e.location;