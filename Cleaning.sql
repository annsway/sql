
------------------------------------------
---- 5/9 - Sample - Jan - Mar 2016 -------
------------------------------------------

### SUM(MealHrs) by JobNo 

SELECT JobNo, JobDate, PayDateStart,
       FORMAT(SUM(MealHrs/JobCount_byGroupNo), 2)            AS MealHrs_Job
FROM (SELECT *, 
            (SELECT COUNT(JobNo)
             FROM   t_MealHrs j2
             WHERE  j2.GroupNo = t_MealHrs.GroupNo
             #AND    j2.JobNo = t_MealHrs.JobNo
             AND    j2.MoverID = t_MealHrs.MoverID
             GROUP BY j2.GroupNo) AS JobCount_byGroupNo
      FROM t_MealHrs) j

WHERE JobNo = 759663
GROUP BY JobNo
ORDER BY GroupNo
;


### GrossHrs









