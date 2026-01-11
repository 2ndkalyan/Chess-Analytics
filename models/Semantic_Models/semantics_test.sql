with cte as (
    select 
    rating,time_class
    from {{ref('agg_daily_game_analysis')}}
)
select * from cte
