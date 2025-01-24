# Bank_Loan_Analysis_Project

![](https://github.com/DQuanBui/Bank_Loan_Analysis_Project/blob/main/bankimage.jpg)

## Project Overview
The Bank Loan Analysis project aims to provide actionable insights into key lending metrics through SQL scripts and interactive Tableau dashboards. It analyzes loan applications, funded amounts, repayments, and debt-to-income ratios to evaluate portfolio health and lending performance. The dashboards visualize trends, regional variations, and customer segments, enabling data-driven decision-making and risk management. This project supports transparency, operational efficiency, and strategic growth in the banking sector.

- **Dataset Link:** [Bank_Loan_Dataset](https://github.com/DQuanBui/Bank_Loan_Analysis_Project/blob/main/bank_loan_data.csv)
- **SQL Scripts:** [Bank_Loan_SQL_Scripts](https://github.com/DQuanBui/Bank_Loan_Analysis_Project/blob/main/Bank_Loan_Analysis.sql)
- **Tableau Dashboards:** [Tableau_Dashboards](https://public.tableau.com/app/profile/dang.quan.bui6438/viz/BankLoanAnalysis_17376109182850/SUMMARY)

## Tools 
- Language: SQL
- Tools: MySQLWorkbench, Tableau

## Dataset Overview
```sql 
-- Dataset Overview
SELECT
	*
FROM
	bank_loan;

-- Key Metrics Overview
SELECT
    COUNT(DISTINCT id) AS Total_Applications,
    COUNT(DISTINCT address_state) AS Unique_States,
    COUNT(DISTINCT application_type) AS Application_Type,
    ROUND(AVG(annual_income), 2) AS Average_Annual_Income,
    ROUND(AVG(loan_amount), 2) AS Average_Loan_Amount,
    ROUND(AVG(dti), 2) AS Average_DTI
FROM
    bank_loan
```

## Objectives

- Evaluate loan performance by tracking critical metrics like default rates, repayment patterns, and profitability to inform actionable financial strategies.
- Analyze loan distributions across various categories (e.g., mortgage, personal loans, business loans) to uncover key insights into portfolio performance and customer trends.
- Discover trends and patterns in the loan portfolio to enhance forecasting, strategic planning, and risk management efforts.
- Develop 3 dynamic Tableau dashboards to visualize core metrics, driving data-driven decision-making and optimizing lending practices.

## Project Results
![](https://github.com/DQuanBui/Bank_Loan_Analysis_Project/blob/main/Results/SUMMARY.png)

![](https://github.com/DQuanBui/Bank_Loan_Analysis_Project/blob/main/Results/OVERVIEW.png)

![](https://github.com/DQuanBui/Bank_Loan_Analysis_Project/blob/main/Results/DETAILS.png)

## Conclusion
The Bank Loan Analysis project leverages SQL and Tableau to analyze key metrics, visualize trends, and evaluate portfolio performance. By providing actionable insights and enhancing the understanding of loan distributions, borrower behavior, and overall portfolio health, this project supports better decision-making, stronger risk management, and optimized lending strategies. It aims to drive operational efficiency, improve financial planning, and contribute to sustainable growth in the banking sector.

## Contact
For any inquiries or questions regarding the project, please contact me at dbui10@fordham.edu
