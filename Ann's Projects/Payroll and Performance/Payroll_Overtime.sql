---------------------------
---- 4.18.2017 Tue --------
---------------------------
SELECT  
       job.JobNo,
       
       (SELECT COUNT(MoverID) 
        FROM   jobdetail jd
        WHERE  jd.JobNo = jobdetail.JobNo)             AS MoverCount,
       
       job.Move_type,
       job.Service_level,
       job.Cubic_feet,
       
       jobdetail.MoverID,
       jobdetail.FirstName,
       jobdetail.LastName,
       
       DATE_FORMAT(timeclock.PayDateStart, '%m/%d/%y') AS PayDateStart,
       DATE_FORMAT(timeclock.PayDateEnd, '%m/%d/%y')   AS PayDateEnd,

       DATE_FORMAT(job.JobDate, '%m/%d/%y')            AS JobDate,
       job.JobTime,
       
       jobdetail.NetHrs, 
       
       job.CommHrs,

       job.CustomerPay       AS CustomerPay_Job,
       
       job.SubsidyPay        AS SubsidyPay_Job,
       
       job.TotalPaid         AS CommPay_Job,
       
       timeclock.TotalPay    AS TotalPaid_Week,      
          
       timeclock.CommPay     AS CommPay_Week,
       
       timeclock.NonCommPay  AS DailyExtra_Week
       
FROM job JOIN jobdetail ON (job.JobNo = jobdetail.JobNo)

         JOIN mover     ON (jobdetail.MoverID = Mover.MoverID)

         JOIN timeclock ON (mover.MoverID = timeclock.MoverID)

WHERE job.JobDate >= PayDateStart AND  job.JobDate <= PayDateEnd

AND PayDateStart >= '2016-1-1'    AND PayDateEnd <='2016-4-1'

ORDER BY job.JobNo;


--------------------------------
---- CREATE output1 table ------
--------------------------------
CREATE TABLE output1(
  JobNo                    INTEGER,
  MoverCount               INTEGER,
  MoveType                 VARCHAR(30),
  ServiceLevel             VARCHAR(30),
  CubicFeet                DECIMAL(10,2),
  
  MoverID                  INTEGER,
  FirstName                VARCHAR(30),
  LastName                 VARCHAR(30),
  PayDateStart             DATE,
  PayDateEnd               DATE,
  JobDate                  DATE,
  JobTime                  TIME,
  
  NetHrs                   DECIMAL(10,2),
  CommHrs                  DECIMAL(10,2),

  
  CustomerPay_Job          DECIMAL(10,2),
  SubsidyPay_Job           DECIMAL(10,2),
  CommPay_Job              DECIMAL(10,2),

  TotalPay_Week            DECIMAL(10,2),  
  CommPay_Week             DECIMAL(10,2),
  DailyExtra_Week          DECIMAL(10,2),  
  
  CONSTRAINT PKtest5  PRIMARY KEY (JobNo, MoverID), 
  CONSTRAINT FKJob5   FOREIGN KEY(JobNo)   REFERENCES Job(JobNo),
  CONSTRAINT FKMover5 FOREIGN KEY(MoverID) REFERENCES Mover(MoverID)
);



--------------------------------------
------ Running Sum Calculator --------
--------------------------------------


SELECT MoverID, FirstName,
       DATE_FORMAT(PayDateStart, '%m/%d/%y')         AS PayDateStart, 
       DATE_FORMAT(JobDate, '%m/%d/%y')              AS JobDate, 
       JobTime, JobNo, 
       
       MoverCount,
                   
      (SELECT COUNT(JobNo) 
       FROM   output1 t2
       WHERE  t1.MoverID       =  t2.MoverID
       AND    t1.PayDateStart  =  t2.PayDateStart)   AS NumJobs_Week,    
     
       NetHrs, 

      (SELECT SUM(NetHrs)
       FROM   output1 t2
       WHERE  t1.MoverID       =  t2.MoverID
       AND    t1.PayDateStart >=  t2.PayDateStart
       AND    t1.PayDateStart <=  t2.JobDate
       AND    t1.JobDate      >=  t2.JobDate
       AND   (t1.JobDate + INTERVAL TIME_TO_SEC(t1.JobTime) SECOND) >=  (t2.JobDate + INTERVAL TIME_TO_SEC(t2.JobTime) SECOND)) AS CumNetHrs_Week,
      
      (SELECT SUM(NetHrs) 
       FROM   output1 t2
       WHERE  t1.MoverID       =  t2.MoverID
       AND    t1.PayDateStart  =  t2.PayDateStart)   AS SumNetHrs_Week,
     
       DailyExtra_Week,
    
      (SELECT FORMAT(AVG(DailyExtra_Week)/COUNT(JobNo),2) 
       FROM   output1 t2
       WHERE  t1.MoverID       =  t2.MoverID
       AND    t1.PayDateStart  =  t2.PayDateStart)   AS DailyExtra_Job,
                   
      CONCAT('$  ', TotalPay_Week)                   AS TotalPay_Week,
      CONCAT('$  ', CommPay_Week)                    AS CommPay_Week,
      CONCAT('$  ',(TotalPay_Week - CommPay_Week))   AS TotalSub_Week,

      SubsidyPay_Job,
      
      FORMAT(SubsidyPay_Job/(SELECT COUNT(MoverID) 
                             FROM   output1 t2
                             WHERE  t1.JobNo =  t2.JobNo),2) AS SubPay_Job_Mover,
      IF((
      SELECT SUM(NetHrs)
      FROM   output1 t2
      WHERE  t1.MoverID       =  t2.MoverID
      AND    t1.PayDateStart >=  t2.PayDateStart
      AND    t1.PayDateStart <=  t2.JobDate
      AND    t1.JobDate      >=  t2.JobDate
      AND   (t1.JobDate + INTERVAL TIME_TO_SEC(t1.JobTime) SECOND) >=  (t2.JobDate + INTERVAL TIME_TO_SEC(t2.JobTime) SECOND))>40, 'OT', '') AS OT
      
FROM output1 t1
ORDER BY MoverID, PayDateStart, JobDate, JobTime;
