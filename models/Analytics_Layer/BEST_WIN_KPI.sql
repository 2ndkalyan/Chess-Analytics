
with best_win as (
    select 
    max(
    case 
        when whites_username = 'kalyan_999' and results = '1-0' then blacks_rating
    else 0 end) as best_win_white
    ,
    max(
    case 
        when blacks_username = 'kalyan_999' and results = '0-1' then whites_rating
    else 0 end) as best_win_black
    from  "DBT_CHESS_ANALYTICS_STG".stg_game_analysis  
)select * from best_win


