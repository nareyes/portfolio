/*
Find all messages which have references to either user 2 or 3.

https://platform.stratascratch.com/coding/9767-find-all-messages-which-have-references-to-either-user-2-or-3?tabname=question
*/

select
    sender,
    message_id,
    text
from facebook_messages_sent
where text like '%2%' or text like '%3%';