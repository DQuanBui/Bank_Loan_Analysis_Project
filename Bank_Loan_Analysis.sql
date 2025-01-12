-- SQL Script for Bank Loan Analysis Project
-- Author: Dang Quan Bui

USE bank_loan_db;

-- =====================================
-- Part 1: Updating the Database Overall
-- =====================================

-- Look at the database to understand key metrics
SELECT
	*
FROM
	bank_loan;

-- Add the alternative column to update the issue date
ALTER TABLE bank_loan ADD COLUMN con_issue_date DATE;

-- Converting the date values in the 'issue_date' column to a valid date format and adding the values into the column 'issue_date_valid'
UPDATE bank_loan
SET con_issue_date = 
	CASE 
		WHEN issue_date LIKE '__/__/____' THEN STR_TO_DATE(issue_date, '%d/%m/%Y') -- DD/MM/YYYY
        	WHEN issue_date LIKE '__-__-____' THEN STR_TO_DATE(issue_date, '%d-%m-%Y') -- DD-MM-YYYY
        	WHEN issue_date LIKE '____-__-__' THEN STR_TO_DATE(issue_date, '%Y-%m-%d') -- YYYY-MM-DD
	ELSE NULL 
END;
    
ALTER TABLE bank_loan DROP COLUMN issue_date;

ALTER TABLE bank_loan CHANGE COLUMN con_issue_date issue_date DATE;

-- ========================
-- PART 2: SUMMARY ANALYSIS
-- ========================

-- 2.1 Key Performance Indicators (KPIs)

-- Look at the total number of Loan Applications
SELECT
	COUNT(id) AS Total_Loan_Applications
FROM
	bank_loan;
    
-- Look at the total number of Loan Applications in the current month (December)
SELECT
	COUNT(id) AS MTD_Total_Loan_Applications
FROM 
	bank_loan
WHERE 
	Month(issue_date) = 12
    	AND YEAR(issue_date) = 2021;

-- Look at the total number of Loan Applications in the previous month (November)
SELECT
	COUNT(id) AS PMTD_Total_Loan_Applications
FROM 
	bank_loan
WHERE 
	Month(issue_date) = 11
    	AND YEAR(issue_date) = 2021;

-- Look at the Total Funded Amount
SELECT
	SUM(loan_amount) AS Total_Funded_Amount
FROM 
	bank_loan;
    
-- Look at the Total Funded Amount in the current month (December)
SELECT
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM 
	bank_loan
WHERE 
	Month(issue_date) = 12
	AND YEAR(issue_date) = 2021;

-- Look at the Total Funded Amount in the previous month (November)
SELECT
	SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM 
	bank_loan 
WHERE
	MONTH(issue_date) = 11
    	AND YEAR(issue_date) = 2021;
    
-- Look at the Total Amount Received from Borrowers
SELECT
	SUM(total_payment) AS Total_Amount_Received 
FROM 
	bank_loan;

-- Look at the Total Amount Received from Borrowers in the current month (December)
SELECT
	SUM(total_payment) AS MTD_Total_Amount_Received 
FROM 
	bank_loan
WHERE 
	MONTH(issue_date) = 12
    	AND YEAR(issue_date) = 2021; 
    
-- Look at the Total Amount Received from Borrowers in the previous month (November)
SELECT
	SUM(total_payment) AS PMTD_Total_Amount_Received 
FROM 
	bank_loan
WHERE 
	MONTH(issue_date) = 11
    	AND YEAR(issue_date) = 2021;
    
-- Look at the average Interest Rate in all loans
SELECT 
	ROUND(AVG(int_rate) * 100, 2) AS Avg_Int_Rate
FROM 
	bank_loan; 
    
-- Look at the average Interest Rate in all loans in the current month (December)
SELECT 
	ROUND(AVG(int_rate) * 100, 2) AS MTD_Avg_Int_Rate
FROM 
	bank_loan
WHERE 
	MONTH(issue_date) = 12
	AND YEAR(issue_date) = 2021;
    
-- Look at the average Interest Rate in all loans in the previous month (November)
SELECT 
	ROUND(AVG(int_rate) * 100, 2) AS PMTD_Avg_Int_Rate
FROM 
	bank_loan
WHERE 
	MONTH(issue_date) = 11
	AND YEAR(issue_date) = 2021;
    
-- Look at the Average Debt-to-Income Ratio (DTI) for our Borrowers
SELECT
	ROUND(AVG(dti) * 100, 2) AS Avg_DTI 
FROM 
	bank_loan;
    
-- Look at the Average Debt-to-Income Ratio (DTI) for our Borrowers in the current month (December)
SELECT
	ROUND(AVG(dti) * 100, 2) AS Avg_DTI 
FROM 
	bank_loan
WHERE 
	MONTH(issue_date) = 12
    	AND YEAR(issue_date) = 2021;
    
-- Look at the Average Debt-to-Income Ratio (DTI) for our Borrowers in the previous month (November)
SELECT
	ROUND(AVG(dti) * 100, 2) AS Avg_DTI 
FROM 
	bank_loan
WHERE 
	MONTH(issue_date) = 11
    	AND YEAR(issue_date) = 2021;
    
-- 2.2 Comparing Good Loan <> Bad Loan KPIs

-- Look at the percentage of Good Loans ('Fully Paid' or 'Current')
SELECT
	(COUNT(
    	CASE
		WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100) /
		COUNT(loan_status) AS Good_Loan_Percentage
FROM
	bank_loan;
    
-- Look at the number of Good Loan Applications
SELECT 
	COUNT(id) AS Good_Loan_Applications
FROM 
	bank_loan
WHERE 
	loan_status = 'Fully Paid'
    	OR loan_status = 'Current';
    
-- Look at the Total Funded Amount for Good Loans
SELECT 
	SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM 
	bank_loan
WHERE 
	loan_status = 'Fully Paid'
    	OR loan_status = 'Current';
    
-- Look at the Total Amount Received for Good Loans
SELECT 
	SUM(total_payment) AS Good_Loan_Amount_Received
FROM 
	bank_loan
WHERE 
	loan_status = 'Fully Paid'
    	OR loan_status = 'Current';
    
-- Look at the percentage of Bad Loans ('Charged Off')
SELECT
	(COUNT(
    	CASE
		WHEN loan_status = 'Charged Off' THEN id END) * 100) /
		COUNT(loan_status) AS Bad_Loan_Percentage
FROM
	bank_loan;
    
-- Look at the number of Bad Loan Applications
SELECT 
	COUNT(id) AS Bad_Loan_Applications
FROM 
	bank_loan
WHERE 
	loan_status = 'Charged Off';
    
-- Look at the Total Funded Amount for Bad Loans
SELECT 
	SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM 
	bank_loan
WHERE 
	loan_status = 'Charged Off';
    
-- Look at the Total Amount Received for Bad Loans
SELECT 
	SUM(total_payment) AS Bad_Loan_Amount_Received
FROM 
	bank_loan
WHERE 
	loan_status = 'Charged Off';
    
-- 2.3 Loan Status Grid View

-- Look at the Loan Performance metrics categorized by Loan Status 
SELECT
    loan_status,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS AVG_Interest_Rate,
    AVG(dti * 100) AS Avg_DTI
FROM
    bank_loan
GROUP BY
    loan_status;
    
-- Look at the monthly totals received and funded categorized by loan status in the current month (December)
SELECT 
    loan_status, 
    SUM(total_payment) AS MTD_Total_Amount_Received, 
    SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM 
	bank_loan
WHERE 
	MONTH(issue_date) = 12 
GROUP BY 
	loan_status;

-- ===============================================
-- Part 3: Detailed Overview of Lending Operations
-- ===============================================

-- 3. 1 Look at the Monthly Trends by Issue Date
SELECT 
    MONTH(issue_date) AS Month_Number, 
    MONTHNAME(issue_date) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
	bank_loan
GROUP BY 
	MONTH(issue_date), 
    MONTHNAME(issue_date)
ORDER BY 
	MONTH(issue_date);
    
-- 3.2 Look at the Regional Analysis by State
SELECT 
    address_state AS State, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
	bank_loan
GROUP BY 
	address_state
ORDER BY 
	COUNT(id) DESC;
    
-- 3.3 Look at the Loan Term Analysis
SELECT 
    term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
	bank_loan
GROUP BY 
	term
ORDER BY 
	term;
    
-- 3.4 Look at the Employee Length Analysis
SELECT 
    emp_length, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
	bank_loan
GROUP BY 
	emp_length
ORDER BY 
	COUNT(id) DESC;
    
-- 3.5 Look at the Loan Purpose Breakdown
SELECT 
    purpose, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
	bank_loan
GROUP BY 
	purpose
ORDER BY 
	COUNT(id) DESC;
    
-- 3.6 Look at the Home Ownership Analysis
SELECT 
    home_ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM 
	bank_loan
GROUP BY 
	home_ownership
ORDER BY 
	COUNT(id) DESC;
    
-- =====================================
-- The End of Bank Loan Analysis Project
-- =====================================
