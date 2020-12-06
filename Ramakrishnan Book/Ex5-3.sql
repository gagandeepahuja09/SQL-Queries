-- Flights(flno: integer, from: string, to: string, distance: integer,

-- departs: time, arrives: time, price: real)

-- Aircraft(aid: integer, aname: string, cruisingrange: integer)

-- Certified(eid: integer, aid: integer)

-- Employees(eid: integer, ename: string, salary: integer)

-- Note that the Employees relation describes pilots and other kinds of employees as well;
-- every pilot is certified for some aircraft, and only pilots are certified to fly. Write each
-- of the following queries in SQL.


-- 1. Find the names of aircraft such that all pilots certified to operate them have
-- salaries more than $80,000.

-- * Key part is that all the pilots ....
-- * Means no emp should have < 80k
-- * NOT EXISTS
select Distinct A.aname from Aircraft A where A.aid in
(select C.aid from Certified C, Employees E where C.eid = E.eid and 
NOT EXISTS(
  select * from Employees E1 where E.eid = E1.eid and E1.salary < 80000
));

-- 2. For each pilot who is certified for more than three aircraft, find the eid and the
-- maximum cruisingrange of the aircraft for which she or he is certified.

select A.cruisingrange, C.eid from Aircraft A, Certified C 
where C.aid = A.aid
group by C.eid
having count(*) > 3
