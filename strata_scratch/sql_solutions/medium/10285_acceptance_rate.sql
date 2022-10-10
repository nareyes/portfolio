/*
What is the overall friend acceptance rate by date? 
Your output should have the rate of acceptances by the date the request was sent. 
Order by the earliest date to latest.

Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request 
to another user (i.e., user_id_receiver) that's logged in the table with action = 'sent'. 
If the request is accepted, the table logs action = 'accepted'. 
If the request is not accepted, no record of action = 'accepted' is logged.

https://platform.stratascratch.com/coding/10285-acceptance-rate-by-date?code_type=1
*/


with 

action_sent as (
    select
        date,
        user_id_sender,
        user_id_receiver
    from fb_friend_requests
    where action = 'sent'
),

action_accepted as (
    select
        date,
        user_id_sender,
        user_id_receiver
    from fb_friend_requests
    where action = 'accepted'
)

select
    a.date,
    count (b.user_id_receiver) / cast (count (a.user_id_sender) as decimal) as percentage_acceptance
from action_sent as a
    left join action_accepted as b
        on a.user_id_sender = b.user_id_sender
        and a.user_id_receiver = b.user_id_receiver
group by a.date;