.mode column
.headers on
.width 40 8
select search, count(1) as cnt from caps_holder group by 1;


