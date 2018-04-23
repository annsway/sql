# Date Time 

#1 
SELECT date(((PERIOD_ADD (EXTRACT(YEAR_MONTH 
     FROM CURDATE()),-3)*100)+1));

