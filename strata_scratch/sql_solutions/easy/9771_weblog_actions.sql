/*
Find all actions which occurred more than once in the weblog.

https://platform.stratascratch.com/coding/9771-find-all-actions-which-occurred-more-than-once-in-the-weblog?code_type=5
*/

select action
from facebook_web_log
group by action
having count (action) > 1;