create database prj2025;

use prj2025;

create table olympics(
ID int,
Name varchar(500),
Sex varchar(10),
Age int,
Height int,
Weight int,
Team varchar(500),
NOC varchar(300),
Games varchar(1000),
Year int,
Season varchar(500),
City varchar(300),
Sport varchar(500),
Event varchar(2000),
Medal varchar(500)
);


show variables like "secure_file_priv";

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned1.csv"
into table olympics
fields terminated by ","
enclosed by '"'
lines terminated by "\r\n"
ignore 1 rows;

select * from olympics;

-- SQL PROJECT

-- 1. Show how many medal counts present for entire data
select count(*) from olympics
where medal <> 'Nomedal';

SELECT distinct(MEDAL) FROM olympics;

-- 2. Show count of unique sports present in Olympics
SELECT distinct(sport),count(*) FROM olympics
group by sport;

-- 3. Show how many different medals won by team India
select Team,Medal,count(Medal) from olympics
where Team = 'India' and Medal<>'NoMedal'
group by medal, Team;


-- 4. Show event wise medals won by India show from highest to lowest medals won in order
Select Team, Medal, Count(Medal) as MedalCount,Event from olympics
where (Team = 'India' and Medal<>'NoMedal')
group by event, Medal, team
order by MedalCount desc;


-- 5. Show event wise medals won by India in order of year
Select Team, Count(Medal) as MedalCount, Medal, Event, Year from olympics
where (Team = 'India' and Medal<>'NoMedal')
group by Medal,event,YEAR
order by Year asc;

select * from olympics;
-- 6. show country who won maximum medals.
select 	Team, Count(*), Max(Medal) as Maxmedals
from Olympics
Where Medal<>"NoMedal"
group by Team
order by count(*) desc
Limit 1;

-- 7.show top 10 countries who won gold
select 	Team, Count(*), Max(Medal) as medals
from Olympics
Where Medal="Gold"
group by Team ,Medal
order by count(*) desc
Limit 10;

select year,Medal from olympics;
--  8. show in which year did United states won most gold medal

select 	Team,Year, Count(*), Max(Medal) as medals
from Olympics
Where(Team = "United states" and Medal = "Gold")
group by Team ,Medal,Year
order by count(*) desc
Limit 1;

-- 9. In which sports United States has most medals.
Select Team, sport, max(Medal) as maxmedal , count(medal) as countmedal
from olympics
where (Team = "United States" and medal !="NoMedal")
group by sport
order by  countmedal desc
limit 1;

-- 10. Find top three players who won most medals along with their sports and country

select * from olympics;
with t1 as
            (select name, team, Sport, count(1) as total_medals
            from olympics
            where medal in ('Gold', 'Silver', 'Bronze')
            group by name, team, Sport
            order by total_medals desc),
        t2 as
            (select *, dense_rank() over (order by total_medals desc) as rnk
            from t1)
    select name, team, sport, total_medals
    from t2
    where rnk <= 3;
    
-- 11. Find player with most gold medals in cycling along with his country.
select Name, Medal, count(*), Team from olympics
where (sport = "Cycling" and Medal ="Gold")
group by name, team, Sport
order by count(*) desc
limit 1;


-- 12.Find player with most medals (Gold+Silver+Bronze) in Basketball also show his country.


SELECT id, name, team,count(id) AS count
FROM olympics
WHERE Sport ="Basketball" AND Medal != "NoMedal" 
GROUP BY id , name, team
ORDER BY count DESC
Limit 1;

-- 13. Find out the count of different medals of the top basketball player Teresa Edwards
SELECT id, name, team, Medal,count(id) AS count
FROM olympics
WHERE Name = "Teresa Edwards"
GROUP BY id , name, team , Medal
ORDER BY count DESC;

-- 14. Find out medals won by male,female each year , Export this data and plot graph in excel

