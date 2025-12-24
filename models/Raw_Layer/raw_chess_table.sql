{{ config(
    materialized="table",
) }}

with cte as(
    select * from raw_chess_com_games
)select * from cte