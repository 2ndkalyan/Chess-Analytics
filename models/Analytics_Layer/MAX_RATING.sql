

with max_rating as (
select max(
case 
when whites_UserName = 'kalyan_999' then whites_rating
when blacks_UserName = 'kalyan_999' then blacks_rating
else 0 end)  as rating,
time_class
from {{ref('stg_game_analysis')}} group by time_class
)select * from max_rating