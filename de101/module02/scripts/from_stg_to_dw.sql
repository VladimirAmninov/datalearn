-- Create schema
-- Create dim tables (calendar, product, shipping, customer, geofrafy)
-- Fix data quality problem
-- Create sales_fact table
-- Match number of rows between staging and dw (business layer)


--____SCHEMA____--
create schema dw;


--____CALENDAR____--

--creating table
drop table if exists dw.calendar_dim ;
create table dw.calendar_dim
(
dateid      serial  not null primary key,
year        int not null,
quarter     int not null,
month       int not null,
week        int not null,
date        date not null,
week_day    varchar(20) not null,
leap        varchar(20) not null
);

--deleting rows
truncate table dw.calendar_dim;

--adding data
insert into dw.calendar_dim 
select to_char(date,'yyyymmdd')::int as date_id,  
       extract('year' from date)::int as year,
       extract('quarter' from date)::int as quarter,
       extract('month' from date)::int as month,
       extract('week' from date)::int as week,
       date::date,
       to_char(date, 'dy') as week_day,
       extract('day' from
               (date + interval '2 month - 1 day')
              ) = 29
       as leap
from generate_series(date '2000-01-01',
                       date '2030-01-01',
                       interval '1 day') as t(date);
--checking
select * from dw.calendar_dim; 


--____PRODUCT____--

--creating a table
drop table if exists dw.product_dim ;
create table dw.product_dim
(
 prod_id      serial not null primary key, --we created surrogated key
 product_id   varchar(50) not null,  --exist in public.orders table
 product_name varchar(127) not null,
 category     varchar(15) not null,
 sub_category varchar(11) not null,
 segment      varchar(11) not null
 );

--deleting rows
truncate table dw.product_dim;

--addind data
insert into dw.product_dim 
select row_number() over () as prod_id,
       product_id, 
       product_name, 
       category, 
       subcategory, 
       segment 
from (select distinct product_id, 
					  product_name, 
					  category, 
					  subcategory, 
					  segment 
	  from stg.orders ) a;

--checking
select * from dw.product_dim cd;


--____SHIPPING____--

--creating a table
drop table if exists dw.shipping_dim;
create table dw.shipping_dim
(
 ship_id       serial not null primary key,
 ship_mode varchar(20) not null
 );

--deleting rows
truncate table dw.shipping_dim;

--addind data
insert into dw.shipping_dim 
select row_number() over(), 
	   ship_mode 
from (select distinct ship_mode 
	  from stg.orders) a;

--checking
select * from dw.shipping_dim sd; 


--____CUSTOMER____--

--creating table
drop table if exists dw.customer_dim ;
create table dw.customer_dim
(
cust_id serial not null primary key,
customer_id   varchar(10) not null, --id can't be NULL
customer_name varchar(30) not null
);

--deleting rows
truncate table dw.customer_dim;

--adding data
insert into dw.customer_dim 
select row_number() over(), 
	   customer_id, 
	   customer_name 
from (select distinct customer_id, 
					  customer_name 
	  from stg.orders) a;
	 
--checking
select * from dw.customer_dim cd;  


--____GEOGRAFY____--

--creating table
drop table if exists dw.geo_dim ;
create table dw.geo_dim
(
 geo_id      serial not null primary key,
 country     varchar(13) not null,
 city        varchar(17) not null,
 state       varchar(20) not null,
 postal_code varchar(20) null       --can't be integer, we lost first 0
);

--deleting rows
truncate table dw.geo_dim;

--adding data
insert into dw.geo_dim 
select row_number() over(), 
	   country, 
	   city, 
	   state, 
	   postal_code 
from (select distinct country, 
					  city, 
					  state, 
					  postal_code 
	  from stg.orders) a;
	 
--data quality check
select distinct country, city, state, postal_code 
from dw.geo_dim
where country is null or city is null or postal_code is null;

-- City Burlington, Vermont doesn't have postal code
update dw.geo_dim
set postal_code = '05401'
where city = 'Burlington'  and postal_code is null;

--also update source file
update stg.orders
set postal_code = '05401'
where city = 'Burlington'  and postal_code is null;


select * from dw.geo_dim
where city = 'Burlington'


--____SALES____--

--creating a table
drop table if exists dw.sales_fact ;
create table dw.sales_fact
(
 sales_id      serial not null primary key,
 cust_id 	   integer not null,
 order_date_id integer not null,
 ship_date_id  integer not null,
 prod_id  	   integer not null,
 ship_id       integer not null,
 geo_id        integer not null,
 order_id      varchar(20) not null,
 sales         numeric(9,4) not null,
 profit        numeric(21,16) not null,
 quantity      integer not null,
 dicsount	   numeric(4,2) not null
 );

--deleting rows
truncate table dw.sales_fact;

insert into dw.sales_fact 
select row_number() over() as sales_id,
	   cust_id,
	   to_char(order_date,'yyyymmdd')::int as  order_date_id,
	   to_char(ship_date,'yyyymmdd')::int as  ship_date_id,
	   p.prod_id,
	   s.ship_id,
	   geo_id,
	   o.order_id,
	   sales,
	   profit,
       quantity,
	   discount
from stg.orders o 
inner join dw.shipping_dim s on o.ship_mode = s.ship_mode
inner join dw.geo_dim g on o.postal_code = g.postal_code and g.country=o.country and g.city = o.city and o.state = g.state 
inner join dw.product_dim p on o.product_name = p.product_name and o.segment=p.segment and o.subcategory=p.sub_category and o.category=p.category and o.product_id=p.product_id 
inner join dw.customer_dim cd on cd.customer_id=o.customer_id and cd.customer_name=o.customer_name 


--do we get 9994rows?
select count(*) from dw.sales_fact sf
inner join dw.shipping_dim s on sf.ship_id=s.ship_id
inner join dw.geo_dim g on sf.geo_id=g.geo_id
inner join dw.product_dim p on sf.prod_id=p.prod_id
inner join dw.customer_dim cd on sf.cust_id=cd.cust_id;


