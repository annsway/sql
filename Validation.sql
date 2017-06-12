-----------------------------------------
-------- Validation for Jobs ------------
-----------------------------------------

### Mismatched jobs
### Analysis: there are 28 jobs in JD, but not in Output1 
###        1) JD Mismatch TC - 2 IC jobs
###        2) 

SELECT * 
FROM jobdetail
WHERE JobNo IN (SELECT DISTINCT jobdetail.JobNo
                FROM   jobdetail
                LEFT JOIN output1 ON (jobdetail.JobNo = output1.JobNo)
                WHERE  output1.JobNo IS NULL)
ORDER BY JobNo;
              
                
####### 

SELECT DISTINCT JobNo, DATE_FORMAT(JobDate, '%m/%d/%y') AS JobDate, 
                (SELECT COUNT(DISTINCT JobNo)
                 FROM jobdetail 
                 WHERE JobNo IN (SELECT DISTINCT jobdetail.JobNo
                 FROM jobdetail
                 LEFT JOIN output1 ON (jobdetail.JobNo = output1.JobNo)
                 WHERE output1.JobNo IS NULL)) AS MismatchedJobCount                  
FROM jobdetail 
WHERE JobNo IN (SELECT DISTINCT jobdetail.JobNo
                FROM jobdetail
                LEFT JOIN output1 ON (jobdetail.JobNo = output1.JobNo)
                WHERE output1.JobNo IS NULL)
ORDER BY JobNo, JobDate;

########## 1) Find out MoverID shown in JD, but not in timeclock
##########    Result: 2 jobs in JD were done by IC (not in TC): 'Heart Moving' & 'Optimus'   


# JobCount from jobdetail table
SELECT COUNT(DISTINCT JobNo)
FROM jobdetail
WHERE JobDate >='2016-1-1' AND JobDate <= '2016-3-31';

# JobCount from output1
SELECT COUNT(DISTINCT JobNo)
FROM output1;


SELECT DISTINCT *
      FROM jobdetail
      LEFT JOIN timeclock ON (jobdetail.MoverID = timeclock.MoverID)
      WHERE timeclock.MoverID IS NULL;

SELECT DISTINCT jd.MoverID, jd.FirstName, jd.LastName
      FROM jobdetail jd
      LEFT JOIN timeclock ON (jd.MoverID = timeclock.MoverID)
      WHERE timeclock.MoverID IS NULL;

###### 2) Jobs have JobDate in April or in 2015, which doesn't matter b/c they will be included in April's labor cost calc






-----------------------------------------
------ Validation for Movers ------------
-----------------------------------------
### Find out the difference between TC and JD on MoverCount
### There are 17 less Movers on timeclock

SELECT COUNT(DISTINCT MoverID) AS tc_MoverCount
FROM timeclock
WHERE PayDateStart >= '2016-1-1' AND PayDateEnd <= '2016-3-31';

SELECT COUNT(DISTINCT MoverID) AS JD_MoverCount
FROM jobdetail
WHERE JobDate >= '2016-1-1' AND JobDate <= '2016-3-31';


  
-----------------------------------------
---------------- Tables -----------------
-----------------------------------------

# Job

SELECT * 
FROM job 
WHERE JobDate >= '2016-1-1' AND JobDate <= '2016-3-31'
ORDER BY JobDate;


# JobCount from job table
SELECT COUNT(DISTINCT JobNo) AS JobCount FROM job
WHERE JobDate >='2016-1-1' AND JobDate <= '2016-3-31';


# Timeclock 

SELECT MoverID, FirstName, LastName
FROM timeclock 
WHERE PayDateStart >= '2016-1-1' AND PayDateEnd <= '2016-3-31'
ORDER BY MoverID, PayDateStart;






##################################### Check

SELECT COUNT(DISTINCT MoverID) as MoverCount, 
       SUM(NetCommPay),
       SUM(GrossHrs)
FROM jobdetail
WHERE JobNo = 854146
GROUP BY JobNo;


SELECT Mileage, Stairs_charge FROM job
WHERE JobNo = 852502;












