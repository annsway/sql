
--------------------------------------
------ Calculation -------------------
--------------------------------------

CREATE TABLE output2(
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
  PayDateStart             DATE,
  PayDateEnd               DATE,
  JobDate                  DATE,
  JobTime                  TIME,
  
  GrossHrs                 DECIMAL(10,2),
  MealHrs                  DECIMAL(10,2),
  NetCommPay               DECIMAL(10,2),
  CommHrs                  DECIMAL(10,2),
  
  Income_total             DECIMAL(10,2),
  Income_quoted            DECIMAL(10,2),
  Income_adj               DECIMAL(10,2),
  
  SubsidyPay_Job           DECIMAL(10,2),
  CommPay_Job              DECIMAL(10,2),

  TotalPay_Week            DECIMAL(10,2),  
  CommPay_Week             DECIMAL(10,2),
  DailyExtra_Week          DECIMAL(10,2),  
  
  NumJobs_Week             INTEGER, 
  CummGrossHrs_Week          DECIMAL(10,2),
  SumGrossHrs_Week           DECIMAL(10,2),
  DailyExtra_Job           DECIMAL(10,2),
  
  TotalSub_Week            DECIMAL(10,2),
  SubPay_Job_Mover         DECIMAL(10,2),
  OT                       VARCHAR(10),
  
  CONSTRAINT PKoutput2 PRIMARY KEY(MoverID, JobNo),
  CONSTRAINT FKtest441 FOREIGN KEY(MoverID) REFERENCES Mover(MoverID),
  CONSTRAINT FKtest442 FOREIGN KEY(JobNo) REFERENCES Job(JobNo)
);


