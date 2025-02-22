------ Puzzle 1 ---------------

-- Write a query which find maximum value from multiple columns of the table

create table TestMax (year1 int, max1 int, max2 int, max3 int)
insert into TestMax values
                           (2001, 10, 101, 87),
                           (2002, 103, 19, 88),
                           (2003, 21, 23, 89),
                           (2004, 27, 28, 91)
select * from TestMax

select * from (
select year1, 
case when max1 > max2 and max1 > max3 then max1 
     when max2 > max1 and max2 > max3 then max2
     when max3> max2 and max3 > max1 then max3 end  as Max_value
from TestMax ) as Max_Value


----- Puzzle 2 -------------


-- Puzzle 5.
--In this puzzle you have to find employees and their managers with their hierarchy. Please check out the sample input and expected output for details.

--Table DDL:
CREATE TABLE Employees
(EmpID INT, EmpName VARCHAR(20), ReportsTo INT)
 
--Insert Data
INSERT INTO Employees(EmpID, EmpName, ReportsTo)
SELECT 1, 'Jacob', NULL UNION ALL
SELECT 2, 'Rui', NULL UNION ALL
SELECT 3, 'Jacobson', NULL UNION ALL
SELECT 4, 'Jess', 1 UNION ALL
SELECT 5, 'Steve', 1 UNION ALL
SELECT 6, 'Bob', 1 UNION ALL
SELECT 7, 'Smith', 2 UNION ALL
SELECT 8, 'Bobbey', 2 UNION ALL
SELECT 9, 'Steffi', 3 UNION ALL
SELECT 10, 'Bracha', 3 UNION ALL
SELECT 11, 'John', 5 UNION ALL
SELECT 12, 'Michael', 6 UNION ALL
SELECT 13, 'Paul', 6 UNION ALL
SELECT 14, 'Lana', 7 UNION ALL
SELECT 15, 'Johnson', 7 UNION ALL
SELECT 16, 'Mic', 8 UNION ALL
SELECT 17, 'Stev', 8 UNION ALL
SELECT 18, 'Paulson', 9 UNION ALL
SELECT 19, 'Jessica', 10

select * from Employees

-- Solution

;with cte as (
      select  EmpID, EmpName, ReportsTo, 0 as level
      from Employees
      where ReportsTo is null

      union all

      select e.EmpID, e.EmpName, e.ReportsTo, c.level+1 
      from Employees as e
      join cte as c on c.EmpID = e.ReportsTo
)
select * from cte


;with cte as (
select 
     EmpName,
   EmpID,
   0 as level,
   cast('.' + EmpName + '.' as varchar(max)) as FullyQualifiedName
from Employees
where ReportsTo is null
union all
select 
  e.EmpName,
  e.EmpID,
  cte.level + 1,
  cast(cte.FullyQualifiedName + e.EmpName as varchar(max)) as FullyQualifiedName
from Employees as e
join cte on cte.EmpID = e.ReportsTo)
select space(level*4) + cte.EmpName as Hierarchy,
       space(level *4) + cast(cte.EmpID as varchar(max)) as Hierarchy,
     *
from cte
order by cte.FullyQualifiedName









