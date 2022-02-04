
-- 1.Get number of monthly active customers.
select monthdata,yeardata, count(monthdata) from monththingy
group by monthdata, yeardata
order by yeardata asc;

-- 2.Active users in the previous month.

with cte_view as (
select monthdata,yeardata, count(monthdata) as active_users, lag(count(monthdata)) over() as last_month from monththingy
where yeardata=2005
group by monthdata, yeardata
order by yeardata asc)
select monthdata, (active_users - last_month) as active_in_prev from cte_view;



-- 3.Percentage change in the number of active customers.
with cte_view1 as (
select monthdata,yeardata, count(monthdata) as active_users, lag(count(monthdata)) over() as last_month from monththingy
where yeardata=2005
group by monthdata, yeardata
order by yeardata asc)
select monthdata, yeardata, (((active_users - last_month) / last_month) * 100) from cte_view1;

-- 4.Retained customers every month.
with cte_view2 as (
select monthdata,yeardata, count(monthdata) as active_users, lag(count(monthdata)) over() as last_month from monththingy
where yeardata=2005
group by monthdata, yeardata
order by yeardata asc)
select monthdata, (active_users - last_month) as active_in_prev from cte_view2;