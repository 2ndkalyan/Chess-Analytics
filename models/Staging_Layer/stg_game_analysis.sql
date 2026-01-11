{{ config(
    materialized="table",
    schema = "STG"
) }}


with games as(
select url,
pgn,
to_date(
  replace(
    regexp_replace(
      pgn::text,
      '.*\[Date "([^"]+)"\].*',
      '\1'
    ),
    '.',
    '-'
  ),
  'YYYY-MM-DD'
) as game_date,
regexp_replace(
      pgn::text,
      '.*\[Result "([^"]+)"\].*',
      '\1'
    )::TEXT as results,
time_control,
to_timestamp(end_time::bigint) as game_end_ts,
rated,
tcn,
uuid,
initial_setup,
fen,
time_class,
rules,
(white->>'@id')::text as whites_ID,
(black->>'@id')::text as blacks_ID,
(white->>'username')::text as whites_UserName,
(black->>'username')::text as blacks_UserName,
(white->>'rating')::numeric as whites_rating,
(black->>'rating')::numeric as blacks_rating,
(white->>'result')::text as whites_result,
(black->>'result')::text as blacks_result,
eco
FROM {{source('raw','chess_com_games')}}
)
select * FROM games
