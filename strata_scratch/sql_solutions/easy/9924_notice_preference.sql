/*
Find libraries who haven't provided the email address in circulation year 2016 but their notice preference definition is set to email.
Output the library code.

https://platform.stratascratch.com/coding/9924-find-libraries-who-havent-provided-the-email-address-in-2016-but-their-notice-preference-definition-is-set-to-email?tabname=question
*/

select home_library_code
from library_usage
where 
    circulation_active_year = '2016'
    and notice_preference_code = 'z'
    and provided_email_address = 'FALSE'
group by home_library_code;