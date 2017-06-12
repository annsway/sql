DROP TABLE output;
DROP TABLE subsidy;
DROP TABLE ic;

DROP TABLE jobdetail;
DROP TABLE timeclock;

DROP TABLE job;
DROP TABLE mover;


CREATE TABLE Job(
  Branch                        VARCHAR(200),
  Job_status                    VARCHAR(200),
  Non_potential_reason          VARCHAR(200),	
  JobNo                         INTEGER,
  Origin_city	                  VARCHAR(200),
  Origin_state	                VARCHAR(200),                   	
  Origin_zip		                VARCHAR(50),
  Origin_county		              VARCHAR(200),
  Destination_city		          VARCHAR(200),        
  Destination_state		          VARCHAR(200),
  Destination_zip		            VARCHAR(50), 
  Destination_county		        VARCHAR(200),
  Customer_full_name		        VARCHAR(200),          
  JobDate 		                  DATE, 
  JobTime                       TIME,
  Created_date		              DATE,   
  Booked_date                   DATE,
  Created_by		                VARCHAR(200),
  Appt_Created_Date		          DATE, 
  CustomerPay 		              DECIMAL(12,2),   
  Cubic_feet		                DECIMAL(10,2),
  Extra_cubic_feet		          DECIMAL(10,2),
  Move_type		                  VARCHAR(200),
  Service_level		              VARCHAR(200),
  Foreman_1		                  VARCHAR(200),
  Foreman_1_Type		            VARCHAR(50),
  Claim_type		                VARCHAR(800),
  Origin_address		            VARCHAR(200),
  LD_Foreman		                VARCHAR(200),  
  SubmissionDate                VARCHAR(200),
  Claim_status		              VARCHAR(200),   
  Amount_claimed		            DECIMAL(10,2),      
  Amount_settled		            DECIMAL(10,2),      
  Courtesy_Compensation		      DECIMAL(10,2),            
  Coverage_option		            VARCHAR(200),
  Claim_open_date		            DATE,
  Claim_close_date		          DATE,
  Adjustment_total		          DECIMAL(10,2),
  Adjustment_type		            VARCHAR(200),
  Recommended		                VARCHAR(200),  
  Sales_department		          VARCHAR(200),
  Special_services_charge		    DECIMAL(10,2),              
  Packing_charge		            DECIMAL(10,2),
  Unpacking_charge		          DECIMAL(10,2),        
  Valuation_charge		          DECIMAL(10,2),
  Box_order_charge		          DECIMAL(10,2),
  Extra_packing	                DECIMAL(10,2),
  Extra_assembly_disassembly		DECIMAL(10,2),                   
  Referral_name		              VARCHAR(200),
  Referral_commission		        DECIMAL(10,2),
  Extra_stairs_charge		        DECIMAL(10,2),
  Requested_services		        DECIMAL(10,2),
  Requested_services_no_comm    DECIMAL(10,2),		                  
  Sales_person		              VARCHAR(200),    
  Ad_category		                VARCHAR(200),  
  Ad_source		                  VARCHAR(200),
  Weblead		                    VARCHAR(50),
  Truck_num_assigned		        VARCHAR(50),             
  Trip_name		                  VARCHAR(200),
  Job_final_CF		              DECIMAL(10,2), 
  Discount_percent		          DECIMAL(10,2),
  Rounding_discount		          DECIMAL(10,2),
  Surcharge		                  DECIMAL(10,2),
  Sales_surcharge		            DECIMAL(10,2),
  Mileage		                    DECIMAL(20,2),
  CF_charge		                  DECIMAL(10,2),
  Charge_per_CF	                DECIMAL(10,2),
  Mileage_charge		            DECIMAL(10,2),
  Crate_charge		              DECIMAL(10,2),    
  Stairs_charge		              DECIMAL(10,2),    
  Zone_price		                DECIMAL(10,2), 
  Truck_charge		              DECIMAL(10,2),
  Special_handling		          DECIMAL(10,2),
  Long_carry		                DECIMAL(10,2),  
  Extra_stops		                DECIMAL(10,2),
  SalesAnswer		                VARCHAR(50),  
  PrepAnswer		                VARCHAR(50),  
  MoversAnswer		              VARCHAR(50),    
  DispatchAnswer		            VARCHAR(50),      
  Cancellation_date		          DATE, 
  Soft_confirmation		          VARCHAR(50),        
  BoxDel_Val_Pack_Unpack	      DECIMAL(10,2),
  Appt_date		                  DATE, 
  Appt_create_by		            VARCHAR(200),
  Car_assgined                  VARCHAR(50),		                  
  Not_Booking_Reason		        VARCHAR(200),
  Customer_email		            VARCHAR(200),
  Date_job_was_first_assigned   DATE,
  Person_first_Assigned_Job	    VARCHAR(200),              	
  Destination_Address		        VARCHAR(200),
  Last_Date_of_Activity		      DATE,
  First_Date_Quoted		          DATE, 
  Person_set_origin_COI_Req     VARCHAR(200),		                  
  Person_set_Dest_COI_Req       VARCHAR(200),		                  
  Payment_Entered               VARCHAR(50),		                  
  Move_Plan_Signed              VARCHAR(50),		                  
  Trip_Per_CF_rate		          DECIMAL(10,2),        
  Trip_services		              DECIMAL(10,2),    
  LD_shuttle		                DECIMAL(10,2),  
  Claim_items	                  VARCHAR(800),
  
  CommHrs                       DECIMAL(10,2),
  CommPay_Job                   DECIMAL(10,2),
  SubsidyPay_Job                DECIMAL(10,2),
  MoverPay_Job                  DECIMAL(10,2),
  MoverCountPlanned             INTEGER,
  
  CONSTRAINT PKJobNo PRIMARY KEY (JobNo)
);



CREATE TABLE Mover(
  MoverID                       INTEGER, 
  FirstName                     VARCHAR(200),
  LastName                      VARCHAR(200),
  
  CONSTRAINT PKMoverID PRIMARY KEY(MoverID)
);


DROP TABLE jobdetail;

CREATE TABLE jobdetail(
  MoverID                       INTEGER, 
  FirstName                     VARCHAR(200),
  LastName                      VARCHAR(200),
  JobDate                       DATE,
  JobNo                         INTEGER, 
  PayDateStart                  DATE,
  PayDateEnd                    DATE,
  GrossHrs                      DECIMAL(10,2),         
  NetCommPay                    DECIMAL(10,2),
  MealHrs                       DECIMAL(10,2),
  
  CONSTRAINT PKJobDetail PRIMARY KEY(MoverID, JobNo, PayDateStart),
  CONSTRAINT FKJob       FOREIGN KEY(JobNo)             REFERENCES Job(JobNo),
  CONSTRAINT FKMover     FOREIGN KEY(MoverID)           REFERENCES Mover(MoverID)
);



CREATE TABLE TimeClock(
  MoverID                       INTEGER, 
  FirstName                     VARCHAR(50),
  LastName                      VARCHAR(50),
  Role                          VARCHAR(50),
  
  Level                         VARCHAR(50),
  
  CommHrs                       DECIMAL(10,2),
  MealHrs                       DECIMAL(10,2),
  NetCommHrs                    DECIMAL(10,2),
  CommPay                       DECIMAL(10,2),
  
  BonusPay                     DECIMAL(10,2),
  CommWithBonus                DECIMAL(10,2),
  
  NonCommHrs                    DECIMAL(10,2),
  NonCommMealHrs                DECIMAL(10,2),
  NetNonCommHrs                 DECIMAL(10,2),
  NonCommPay                    DECIMAL(10,2),
  TotalHrs                      DECIMAL(10,2),
  CommAvgRate                   DECIMAL(10,2),
  OvertimeBase                  DECIMAL(10,2),
  CalculatedMin                 DECIMAL(10,2),
  ShiftPay                      DECIMAL(10,2),
  
  OtherPay                     DECIMAL(10,2),
  
  TotalPay                      DECIMAL(10,2),
  
  Adjustment                   DECIMAL(10,2),
  AdjPaid                      DECIMAL(10,2),
  DaysAvail                    DECIMAL(10,2),
  MinWeekly                    DECIMAL(10,2),
  ProratedMinWeekly            DECIMAL(10,2),
  TotalPay2                    DECIMAL(10,2),
 
--   Subsidy                       DECIMAL(10,2),
--   SubsidyPaid                   DECIMAL(10,2),
--   Comm_NonComm_Adj              DECIMAL(10,2),
--   Other_NonComm                 DECIMAL(10,2),
--   TotPayExSubsidy               DECIMAL(10,2),
--   CalcSubsidy                   DECIMAL(10,2),
--   VAR                           DECIMAL(10,2),
--   NetCommHrsBracket             VARCHAR(20),
--   OThrs                         DECIMAL(10,2),
--   SubPercentComm                DECIMAL(10,2),
--   FirstLast                     VARCHAR(100),
--   
  PayDateStart                  DATE,
  PayDateEnd                    DATE,
  CONSTRAINT PKTimeClock2 PRIMARY KEY (MoverID, PayDateStart), 
  CONSTRAINT FKMover22    FOREIGN KEY(MoverID) REFERENCES Mover(MoverID)
);



CREATE TABLE TimeClock_new(
  MoverID                       INTEGER, 
  FirstName                     VARCHAR(50),
  LastName                      VARCHAR(50),
  Role                          VARCHAR(50),
  
  #Level                        VARCHAR(50),
  
  CommHrs                       DECIMAL(10,2),
  MealHrs                       DECIMAL(10,2),
  NetCommHrs                    DECIMAL(10,2),
  CommPay                       DECIMAL(10,2),
  
  #BonusPay                     DECIMAL(10,2),
  #CommWithBonus                DECIMAL(10,2),
  
  NonCommHrs                    DECIMAL(10,2),
  NonCommMealHrs                DECIMAL(10,2),
  NetNonCommHrs                 DECIMAL(10,2),
  NonCommPay                    DECIMAL(10,2),
  TotalHrs                      DECIMAL(10,2),
  CommAvgRate                   DECIMAL(10,2),
  OvertimeBase                  DECIMAL(10,2),
  CalculatedMin                 DECIMAL(10,2),
  ShiftPay                      DECIMAL(10,2),
  
  #OtherPay                     DECIMAL(10,2),
  
  TotalPay                      DECIMAL(10,2),
  
  #Adjustment                   DECIMAL(10,2),
  #AdjPaid                      DECIMAL(10,2),
  #DaysAvail                    DECIMAL(10,2),
  #MinWeekly                    DECIMAL(10,2),
  #ProratedMinWeekly            DECIMAL(10,2),
  #TotalPay2                    DECIMAL(10,2),
 
  Subsidy                       DECIMAL(10,2),
  SubsidyPaid                   DECIMAL(10,2),
  Comm_NonComm_Adj              DECIMAL(10,2),
  Other_NonComm                 DECIMAL(10,2),
  TotPayExSubsidy               DECIMAL(10,2),
  CalcSubsidy                   DECIMAL(10,2),
  VAR                           DECIMAL(10,2),
  NetCommHrsBracket             VARCHAR(20),
  OThrs                         DECIMAL(10,2),
  SubPercentComm                DECIMAL(10,2),
  FirstLast                     VARCHAR(100),
  
  PayDateStart                  DATE,
  PayDateEnd                    DATE,
  CONSTRAINT PKTimeClock PRIMARY KEY (MoverID, PayDateStart), 
  CONSTRAINT FKMover2    FOREIGN KEY(MoverID) REFERENCES Mover(MoverID)
);





CREATE TABLE Subsidy(
  JobNo                         INTEGER,
  MoverCountPlanned             INTEGER,
  CommHrs                       DECIMAL(10,2),
  TotalPaid                     DECIMAL(10,2),
  ActHrRate                     DECIMAL(10,2),
  Subsidy                       VARCHAR(20),
  SubsidyPay                    DECIMAL(10,2),
  SubsidyPercent                DECIMAL(10,2),
  Mileage                       DECIMAL(10,2),
  MoveType                      VARCHAR(30),
  JobDate                       DATE,
  CubicFeet                     DECIMAL(10,2),
  EstTime                       DECIMAL(10,2),
  Diff                          DECIMAL(10,2),
  SubPerMover                   DECIMAL(10,2),
  CostofMove                    DECIMAL(10,2),
  AddCostsPercent               DECIMAL(10,2),
  Packing                       DECIMAL(10,2),
  Stairs                        DECIMAL(10,2),
  SpecialServices               DECIMAL(10,2),
  TotalCost_Paid                DECIMAL(10,2),
  
  CONSTRAINT PKsubsidy1 PRIMARY KEY (JobNo)
);









