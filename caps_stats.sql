.mode column
.headers on
.width 40 8
select coalesce(search,"<DS WTF>") as search_query
    , count(1) as cnt
    , round(100.0 * count(1) / sum(count(1)) over(), 2) as pct
    , sum(count(1)) over(order by 1 rows between unbounded preceding and current row) as cum
from caps_holder
group by 1
order by 1;


