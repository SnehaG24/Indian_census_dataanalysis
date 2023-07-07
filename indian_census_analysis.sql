 -- analysis on Indian census data 
 
select * from data1;

select * from data2;

-- number of rows in database

select count(*) from data1;
select count(*) from data2;

-- fetch data for two state that is jharkhand and bihar 

select * 
from data1
where State = 'Jharkhand' OR State = 'Bihar';

-- another method 

select * 
from data1
where State IN ('Jharkhand','Bihar');

-- population of india 

select sum(Population) from data2;

-- average growth :

select avg(growth)*100 from data1;

-- average growth of each state 

select State , avg(Growth) 
from data1
group by State;

-- average Sex_Ratio of each state 

select State , avg(Sex_Ratio) 
from data1
group by State;

-- display average Literacy of each state having average literacy greater than 60

select State , avg(Literacy) 
from data1
group by State
having avg(Literacy)>60 
order by avg(Literacy) desc;

-- the top three states with the highest growth ratio.

select State , sum(growth)
from data1
group by State
order by sum(growth) desc
limit 3;

--  provide the name of a state that starts with the letter 'A'

select distinct State
from data1
where State LIKE 'A%';

-- provide the name of a state that starts with the letter 'a' and ends with 'm'

select distinct State
from data1
where State LIKE 'A%M';

-- provide name of the DISTRICT which has secondlast letter 'a' 

select distinct State
from data1
where State LIKE '%a_';

-- total males and females in each state

select d.state,sum(d.males) total_males,sum(d.females) total_females 
from
(select c.district,c.state state,round(c.population/(c.sex_ratio+1),0) males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females 
from
(select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from data1 a inner join data2 b on a.district=b.district ) c) d
group by d.state;

