
------------------------------------------
---- 5/15 -- 3 weeks --- 4.21-5.11 -------
------------------------------------------

DROP TABLE IC;

CREATE TABLE IC(
  JobNo           INTEGER,
  JobDate         Date,
  JobTime         Time,
  CubicFeet       DECIMAL(10,2),
  IC_Comm         DECIMAL(10,2),
  IC_Packing      DECIMAL(10,2),
  IC_Services     DECIMAL(10,2),
  IC_Travel       DECIMAL(10,2),
  IC_Other        DECIMAL(10,2),
  IC_total        DECIMAL(10,2),
  IC_Truck        DECIMAL(10,2),
  IC_Adj          DECIMAL(10,2),
  IC_Tip          DECIMAL(10,2),
  LaborCost       DECIMAL(10,2),  
  IC              VARCHAR(20),
  CONSTRAINT PKIC PRIMARY KEY(JobNo, IC),
  CONSTRAINT FKIC FOREIGN KEY (JobNo) REFERENCES job(JobNo) 
);


SELECT  
       job.JobNo,
       DATE_FORMAT(job.JobDate, '%m/%d/%y')            AS JobDate,   
       job.JobTime,
              
       job.Move_type,
       job.Service_level,
       job.Mileage,
       
       
       job.Cubic_feet + job.Extra_cubic_feet           AS CF_total, 
       job.Cubic_feet                                  AS CF_quoted,
       job.Extra_cubic_feet                            AS CF_adj,  
       
       ic.*,
       
       FORMAT(ic.LaborCost/(job.Cubic_feet + job.Extra_cubic_feet),2) AS CostPerCF,
       (job.CustomerPay - ic.LaborCost)                 AS Profit,
       (job.CustomerPay - ic.LaborCost)/job.CustomerPay AS ProfitMargin,

       job.CustomerPay                                 AS Income_total,
       job.CustomerPay - job.Adjustment_total          AS Income_quoted, 
       job.Adjustment_total                            AS Income_adj,
              
              
      
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
       
  
       job.Origin_zip,
       job.Destination_zip,      
       job.Claim_status
       
 
FROM job JOIN ic ON ic.JobNo = job.JobNo
WHERE ic.IC <> 'Paya Inc'
ORDER BY CostPerCF DESC #LIMIT 10
;


SELECT job.jobNo,
       FORMAT(ic.LaborCost/(job.Cubic_feet + job.Extra_cubic_feet),2) AS CostPerCF,
       job.Origin_zip
FROM job JOIN ic ON ic.JobNo = job.JobNo
ORDER BY CostPerCF DESC LIMIT 10
;
