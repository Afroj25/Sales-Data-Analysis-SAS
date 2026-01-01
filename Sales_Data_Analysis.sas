/* 
Project: Sales Data Analysis using SAS
Description:
- Import sales CSV data
- Perform descriptive statistics
- Frequency analysis
- Generate summary report
- Export PDF report
*/

proc import datafile="/home/u64409060/EPG1V2/sales_data.csv" dbms=csv 
		out=Sales_Data replace;
	getnames=yes;
run;

proc contents data=Sales_Data;
run;

proc print data=Sales_Data;
run;

proc means data=Sales_Data n nmiss;
run;

proc means data=Sales_Data mean sum min max;
	var Sales Quantity;
run;

proc means data=Sales_Data mean sum;
	class Region Product;
	var Sales;
run;

proc freq data=Sales_Data;
	tables Region Product Profit;
run;

proc freq data=Sales_Data;
	tables Region*Product;
run;

proc sql;
	create table Sales_Summary as select Region, sum(Sales) as Total_Sales, 
		avg(Sales) as Avg_Sales from Sales_Data group by Region;
quit;

proc print data=Sales_Summary;
	title "Regional Sales Summary Report";
run;

ods pdf file="/home/u64409060/EPG1V2/Sales_Report.pdf";

proc report data=Sales_Summary nowd;
run;

ods pdf close;