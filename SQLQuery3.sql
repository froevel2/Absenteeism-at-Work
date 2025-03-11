--CREATE A JOIN TABLE
select * from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number

--find the healthiest employees for the bonus
select * from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25 and
Absenteeism_time_in_hours < (select avg(Absenteeism_time_in_hours) from Absenteeism_at_work)

---compensation rate increase for non-semokers / budget $983221   $0.68 increase per hour / $1,414,4 per year
select count(*) as nonsmokers from Absenteeism_at_work
where Social_smoker = 0

--optimize this query
select
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
case when Body_mass_index <18.5 then 'uderweight'
	when Body_mass_index between 18.5 and 25 then 'Healthy Weight'
	when Body_mass_index between 25 and 30 then 'Overweight'
	when Body_mass_index >30 then 'Obese'
	else 'Unknown' end as BMI_Category,
case when Month_of_absence in (12, 1, 2) then 'Winter'
	when Month_of_absence in (3, 4 , 5) then 'Spring'
	when Month_of_absence in (6, 7, 8) then 'Summer'
	when Month_of_absence in (10, 11, 12) then 'Fall'
	else 'Unknown' end as Season_Names,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number