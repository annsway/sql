
DELETE FROM output;
DELETE FROM jobdetail;
DELETE FROM ic;

DELETE FROM timeclock;
DELETE FROM mover;
DELETE FROM job;

------------------------------------------
---- 5/22 -- 4 weeks --- 4.21-5.18 -------
------------------------------------------

SELECT DISTINCT  
       job.JobNo,
      
       job.MoverCountPlanned,
       
       (SELECT COUNT(DISTINCT MoverID) 
        FROM   jobdetail jd
        WHERE  jd.JobNo = jobdetail.JobNo)             AS MoverCountExecuted,
       
       job.Move_type,
       job.Service_level,
       job.Mileage,
       
       
       job.Cubic_feet + job.Extra_cubic_feet           AS CF_total, 
       job.Cubic_feet                                  AS CF_quoted,
       job.Extra_cubic_feet                            AS CF_adj,  
       
       job.Sales_person,
       jobdetail.MoverID,
       jobdetail.FirstName,
       jobdetail.LastName,
       
       DATE_FORMAT(timeclock.PayDateStart, '%m/%d/%y') AS PayDateStart_tc,
       DATE_FORMAT(timeclock.PayDateEnd, '%m/%d/%y')   AS PayDateEnd_tc,

    #   DATE_FORMAT(jobdetail.PayDateStart, '%m/%d/%y') AS PayDateStart_jd,
    #   DATE_FORMAT(jobdetail.PayDateEnd, '%m/%d/%y')   AS PayDateEnd_jd,
       
       DATE_FORMAT(job.JobDate, '%m/%d/%y')            AS JobDate,
       
       job.JobTime,
       
       jobdetail.GrossHrs,
       
       jobdetail.MealHrs,
       
       jobdetail.GrossHrs - jobdetail.MealHrs          AS NetHrs,
       
       
       jobdetail.NetCommPay,
       
       job.CommHrs,

       job.CustomerPay                                 AS Income_total,
       job.CustomerPay - job.Adjustment_total          AS Income_quoted, 
       job.Adjustment_total                            AS Income_adj,
       
       job.CommPay_Job + IF(job.SubsidyPay_Job<0,0,job.SubsidyPay_Job)   AS TotalPaid_Job,
       IF(job.SubsidyPay_Job<0,0,job.SubsidyPay_Job)   AS SubsidyPay_Job,
       job.CommPay_Job,
       
       
       timeclock.TotalPay                              AS TotalPaid_Week_tc,      
          
       timeclock.CommPay                               AS CommPay_Week_tc,
       
       timeclock.TotalPay - timeclock.CommPay          AS TotalSub_Week_tc,
       
       timeclock.NonCommPay                            AS DailyExtra_Week_tc,
       
      
              
       ### Total Services Charge
       job.Special_services_charge +
       job.Unpacking_charge +
       job.Packing_charge +
       job.Mileage_charge +
       job.Stairs_charge + 
       job.Extra_stairs_charge AS Services_charge_total,     
       
       
       ### Services Charge
       job.Special_services_charge,
       job.Unpacking_charge,
       job.Packing_charge, 
       job.Mileage_charge,
     
       ### Total Stairs Charge
       job.Stairs_charge + job.Extra_stairs_charge AS Stairs_charge_total,     
       job.Extra_stairs_charge,
       job.Stairs_charge,

       
       ### Other Services Charge
       job.Truck_charge,
       job.Box_order_charge,
       
       
       job.Origin_zip,
       job.Destination_zip,
       job.Claim_status
       
       
FROM job JOIN jobdetail ON (job.JobNo = jobdetail.JobNo)

         JOIN mover     ON (jobdetail.MoverID = Mover.MoverID)

         JOIN timeclock ON (mover.MoverID = timeclock.MoverID)

WHERE timeclock.PayDateStart = jobdetail.PayDateStart AND  timeclock.PayDateEnd = jobdetail.PayDateEnd
AND job.Move_type = 'Local Moving'
AND job.Origin_zip = 10075
ORDER BY job.JobNo, jobdetail.MoverID;




SELECT job.Origin_address, job.Origin_zip, Origin_city
FROM job
WHERE job.Origin_zip = 10075
AND job.Job_status = 'Done - Completed'
ORDER BY job.Origin_zip
;










SELECT DISTINCT job.JobNo, job.Sales_person, jobdetail.MoverID, jobdetail.FirstName, jobdetail.LastName
FROM job JOIN jobdetail ON (job.JobNo = jobdetail.JobNo)

         JOIN mover     ON (jobdetail.MoverID = Mover.MoverID)

         JOIN timeclock ON (mover.MoverID = timeclock.MoverID)

WHERE job.JobNo IN(
855311,
856154,
853420,
854082,
858457,
854932,
858418,
855549,
855953,
853337
)

;






















--------------------------------
---- CREATE output table ------
--------------------------------

CREATE TABLE output(
  JobNo                    INTEGER,
  MoverCountPlanned        INTEGER,
  MoverCount               INTEGER,
  MoveType                 VARCHAR(30),
  ServiceLevel             VARCHAR(30),
  
  CF_quoted                DECIMAL(10,2),
  CF_adj                   DECIMAL(10,2),
  CF_total                 DECIMAL(10,2),
  
  MoverID                  INTEGER,
  FirstName                VARCHAR(30),
  LastName                 VARCHAR(30),
  PayDateStart_tc          DATE,
  PayDateEnd_tc            DATE,
  
  PayDateStart_jd          DATE,
  PayDateEnd_jd            DATE,
  
  JobDate                  DATE,
  JobTime                  TIME,
  
  GrossHrs                 DECIMAL(10,2),
#  MealHrs                  DECIMAL(10,2),
  NetCommPay               DECIMAL(10,2),
  CommHrs_Job              DECIMAL(10,2),
  
  Income_total             DECIMAL(10,2),
  Income_quoted            DECIMAL(10,2),
  Income_adj               DECIMAL(10,2),
  
  SubsidyPay_Job           DECIMAL(10,2),
  CommPay_Job              DECIMAL(10,2),

  TotalPay_Week_tc         DECIMAL(10,2),  
  CommPay_Week_tc          DECIMAL(10,2),
  TotalSub_Week_tc         DECIMAL(10,2), 
  DailyExtra_Week_tc       DECIMAL(10,2),  
  
  CONSTRAINT PKtest5  PRIMARY KEY(JobNo, MoverID), 
  CONSTRAINT FKJob5   FOREIGN KEY(JobNo)   REFERENCES Job(JobNo),
  CONSTRAINT FKMover5 FOREIGN KEY(MoverID) REFERENCES Mover(MoverID)
);



--------------------------------------
------ Running Sum Calculator --------
--------------------------------------
### Note: SUM(NetCommPay) can be retreived using PIVOT TABLE for output1

SELECT *,      

      (SELECT SUM(GrossHrs)
       FROM   output t2
       WHERE  t1.MoverID          =  t2.MoverID
       AND    t1.PayDateStart_tc >=  t2.PayDateStart_tc
       AND    t1.JobDate         >=  t2.JobDate
       AND   (t1.JobDate + INTERVAL TIME_TO_SEC(t1.JobTime) SECOND) >=  (t2.JobDate + INTERVAL TIME_TO_SEC(t2.JobTime) SECOND)
       AND    t1.PayDateStart_tc <=  t2.JobDate) AS CumGrossHrs_Week,
      
      (SELECT SUM(GrossHrs) 
       FROM   output t2
       WHERE  t1.MoverID          =  t2.MoverID
       AND    t1.PayDateStart_tc  =  t2.PayDateStart_tc
       #AND    t1.JobDate        >=  t2.JobDate
       #AND   (t1.JobDate + INTERVAL TIME_TO_SEC(t1.JobTime) SECOND) >=  (t2.JobDate + INTERVAL TIME_TO_SEC(t2.JobTime) SECOND)
       AND    t1.PayDateStart_tc <=  t2.JobDate)   AS SumGrossHrs_Week,
                            
      FORMAT(SubsidyPay_Job/(SELECT COUNT(MoverID) 
                             FROM   output t2
                             WHERE  t1.MoverID          =  t2.MoverID
                             AND    t1.PayDateStart_tc >=  t2.PayDateStart_tc
                             AND    t1.JobDate         >=  t2.JobDate
                             AND   (t1.JobDate + INTERVAL TIME_TO_SEC(t1.JobTime) SECOND) >=  (t2.JobDate + INTERVAL TIME_TO_SEC(t2.JobTime) SECOND)
                             AND    t1.PayDateStart_tc <=  t2.JobDate),2) AS SubPay_Job_Mover
       
FROM output t1

ORDER BY MoverID, t1.PayDateStart_tc, JobDate, JobTime
;





