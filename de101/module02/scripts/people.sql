drop table if exists people;
create table people(
	person varchar(17) not null primary key,
	region varchar(7) not null
);
insert into people(person, region) values ('Anna Andreadi', 'West');
insert into people(person, region) values ('Chuck Magee', 'East');
insert into people(person, region) values ('Kelly Williams', 'Central');
insert into people(person, region) values ('Cassandra Brandow', 'South');