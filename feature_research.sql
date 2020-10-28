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
order by 1
