
{{ config(
    materialized="table"
) }}

with game_formats as( 
select 'rapid' as time_class
union all
select  'bullet'  as time_class 
union all
select 'blitz' as time_class 

) select * from game_formats


