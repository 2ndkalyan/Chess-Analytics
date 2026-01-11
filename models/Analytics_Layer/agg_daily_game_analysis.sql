{{ config(
    materialized="table"
) }}

WITH games AS (
  SELECT game_date, time_class,
    SUM(
        CASE 
      WHEN results = '1-0' AND whites_username = 'kalyan_999' THEN 1
      WHEN results = '1/2-1/2' AND whites_username = 'kalyan_999' THEN 0.5
      else 0 end
    ) as white_wins,
    SUM(
        CASE 
      WHEN whites_username = 'kalyan_999' THEN 1
      else 0 end
    ) as whites_game_count,
    SUM(
        CASE 
      WHEN results = '0-1' AND blacks_username = 'kalyan_999' THEN 1
      WHEN results = '1/2-1/2' AND blacks_username = 'kalyan_999' THEN 0.5
      else 0 end
    ) as blacks_wins,
    SUM(
        CASE 
      WHEN blacks_username = 'kalyan_999' THEN 1
      else 0 end
    ) as blacks_game_count,
    -- SUM( whites_winning_rate + blacks_winning_rate) as wins,
    SUM(
        CASE 
      WHEN results = '1-0' AND whites_username = 'kalyan_999' THEN 1
      WHEN results = '0-1' AND blacks_username = 'kalyan_999' THEN 1
      WHEN results = '1/2-1/2' THEN 0.5
      else 0 end) as total_wins,

    AVG(
    case 
        when whites_username = 'kalyan_999'  then  whites_rating
        when blacks_username = 'kalyan_999'  then  blacks_rating
    else 0 end) as Rating,
    AVG(
    case 
        when whites_username = 'kalyan_999'  then  blacks_rating
        when blacks_username = 'kalyan_999'  then  whites_rating
    else 0 end) as Opponent_Rating,
    count(*) as total_games
  FROM {{ref('stg_game_analysis')}}
  WHERE rated = 'true'
  GROUP BY game_date, time_class
  order by game_date desc
)
SELECT * FROM games 
