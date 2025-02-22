------- Puzzle ---------------
-- 1.

DROP TABLE IF EXISTS patient_info;
CREATE TABLE patient_info (
  pat_fguid varchar(100) NOT NULL,
  pat_fname varchar(50) NOT NULL,
  pat_lname varchar(50) NOT NULL,
  pat_mname varchar(10) NOT NULL
);

INSERT INTO patient_info 
VALUES 
  ('1-1','Thomas','Cruise','Mapother'),
  ('1-2','Michael','Tyson','Gerard'),
  ('2-1','John','Cena','Felix');

DROP TABLE IF EXISTS virtual_folder;
CREATE TABLE virtual_folder (
  fld_guid varchar(100) NOT NULL,
  fld_owner varchar(100) NOT NULL,
  fld_parent_guid varchar(100) NOT NULL,
  fld_name varchar(255) NOT NULL
);

INSERT INTO virtual_folder 
VALUES 
  ('1-1','1','','Pat1(Tom Cruise)'),
  ('1-1-1','1','1-1','holiday'),
  ('1-1-2','1','1-1','movie_photos'),
  ('1-1-2-1','1','1-1-2','Jack Reacher'),
  ('1-1-2-2','1','1-1-2','Mission Impossible'),
  ('1-1-2-2-1','1','1-1-2-2','MI2'),
  ('1-1-2-2-2','1','1-1-2-2','Mission Impossible 1'),
  ('1-2','1','','Pat2(Mike Tyson)'),
  ('1-2-1','1','1-2','Boxing'),
  ('1-2-2','1','1-2','Daily'),
  ('1-2-2-1','1','1-2-2','Family'),
  ('1-2-2-2','1','1-2-2','Friends'),
  ('2-1','2','','Pat3(John Cena)');



select * from patient_info 
select * from virtual_folder 


;with cte as (
select 
     v.fld_guid,
   v.fld_name,
   cast(concat('/',p.pat_lname,',',p.pat_fname,',',p.pat_mname,'(',v.fld_guid,')') as nvarchar(max)) as full_path 
   
from patient_info as p
inner join virtual_folder as v on p.pat_fguid = v.fld_guid
union all
select 
     v2.fld_guid,
   v2.fld_name,
   cast(concat(cte.full_path,'/',v2.fld_name,'(',v2.fld_guid,')') as nvarchar(max)) as full_path
from virtual_folder as v2
inner join cte on v2.fld_parent_guid = cte.fld_guid

)
select * from cte
order by cte.fld_guid




