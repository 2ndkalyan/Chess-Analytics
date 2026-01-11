{{ config(materialized='table') }}

select
    generate_series(
        date '2017-08-01',
        date '2030-12-31',
        interval '1 day'
    )::date as date_day

