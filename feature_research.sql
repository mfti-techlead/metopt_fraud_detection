-- person attributes
-- select count(*) from (
select first, last, cc_num, dob, zip, gender, street, city, state, zip, lat, long, city_pop, job, count(*), count(case when is_fraud = 1 then 1 end)
from fraud_train
group by first, last, cc_num, dob, zip, gender, street, city, state, zip, lat, long, city_pop, job
order by count(case when is_fraud = 1 then 1 end) desc;
--)

-- merchant attributes
-- select count(*) from (
select merchant, /*category*/ count(*), count(case when is_fraud = 1 then 1 end)
from fraud_train
group by merchant, merch_lat, merch_long
order by count(case when is_fraud = 1 then 1 end) desc;
-- ) a

-- transaction attributes
-- select count(*) from (
select trans_num, unix_time, trans_date_trans_time, merch_lat, merch_long, count(case when is_fraud = 1 then 1 end)
from fraud_train
group by trans_num, unix_time, trans_date_trans_time, merch_lat, merch_long;
--)

-- transaction time
-- select count(*) from (
select unix_time, trans_date_trans_time, count(*), count(case when is_fraud = 1 then 1 end)
from fraud_train
group by unix_time, trans_date_trans_time
order by unix_time asc;
--)
-- 1 274 823 unix_time
-- 1 274 791 trans_datetime

-- transaction dinamycs monthly
select substr(trans_date_trans_time,1,7), count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by substr(trans_date_trans_time,1,7)
order by 1;

-- transaction dinamycs daily
select substr(trans_date_trans_time,1,11), count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by substr(trans_date_trans_time,1,11)
order by 1

-- transaction sum by fraud 
select is_fraud, 
round(avg(cast(amt as float)),1),
round(stdev(cast(amt as float)),1),
round(median(cast(amt as float)),1),
round(min(cast(amt as float)),1),
round(max(cast(amt as float)),1),
count(*)
from fraud_train
group by is_fraud
order by 1


-- fraud rate for distance between points
with a as (
SELECT first, last,
(cast(merch_lat as float) - cast(lat as float)) * (cast(merch_lat as float) - cast(lat as float))
+ 
(cast(merch_long as float) - cast(long as float)) * (cast(merch_long as float) - cast(long as float)) distance
,is_fraud

FROM fraud_train 
ORDER BY 3 desc 
)

select round(distance,1), 
count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from a
group by round(distance,1)


-- fraud rate by cities
select city, count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by city
order by 4 desc 

-- fraud rate by states
select state, count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by state
order by 4 desc 

-- fraud rate by zips
select zip, count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by zip 
order by 4 desc 

-- fraud rate by gender
select gender, count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by gender 
order by 4 desc 

-- fraud rate by year of birth
select substr(dob,1,4), count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by substr(dob,1,4)
order by 4 desc 

-- fraud rate by merchant category
select category, count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by category
order by 4 desc 

-- fraud rate by job 
select job, count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by job
order by 4 desc 

-- fraud rate by hour 
select substr(trans_date_trans_time,12,2), count(*),  count(case when is_fraud = 1 then 1 end),
round(100 * cast(count(case when is_fraud = 1 then 1 end) as float) / cast(count(*) as float),5) fraud_share 
from fraud_train
group by substr(trans_date_trans_time,12,2)
order by 4 desc 

