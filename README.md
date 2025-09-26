# HR Analytics Project  

## 📌 Overview  
This project is a complete **HR Analytics Solution** built from scratch.  
It covers the full pipeline starting from data exploration to building a Data Warehouse and finally visualizing insights with **Power BI**.  

---

## 🛠️ Tools & Technologies  
- **Python (Pandas)** → Data exploration & cleaning.  
- **SQL Server** → Staging, DWH modeling (Star Schema), ETL scripts.  
- **Power BI** → Dashboard creation & KPIs.  

---

## 📂 Project Workflow  
1. **ERD & Mapping**  
   - Defined entities & relationships across Employees, Hiring, Balances, Satisfaction, SickLeaves.  
   - Designed initial ERD to understand data flow.  

2. **Data Exploration (Python)**  
   - Explored Excel dataset.  
   - Cleaned null values, renamed columns, validated data types.  
   - Exported cleaned data into 5 CSV files.  

3. **Staging Layer (SQL Server)**  
   - Loaded raw CSVs into staging tables for each dataset.  

4. **Data Warehouse (SQL Server)**  
   - Modeled a **Star Schema**:  
     - **Dimensions**: `DimEmployees`, `DimHiring`, `DimBalances`, `DimSatisfaction`, `DimSickLeaves`, `DimDate`.  
     - **Fact**: `FactKPIs` (Tenure, Sick Leave Count, Days Off, Avg Satisfaction, Balances).  
   - Created ETL scripts to transform & load data into the warehouse.  

5. **Load to Warehouse**  
   - Populated the fact table using SQL joins.  
   - Calculated measures like Tenure, Avg Satisfaction, Sick Leave Count.  

6. **Power BI Dashboard**  
   - Connected DWH to Power BI.  
   - Built interactive dashboards:  
     - **Employees Analytics**  
     - **Balances Analytics**  
     - **Satisfaction Analytics**  
     - **Sick Leaves Analytics**  

---

## 📊 Dashboard Features  
- **Employees Analytics:** Employee growth trend, total headcount, department/job distribution.  
- **Balances Analytics:** Avg annual & sick leave balances, balances by department.  
- **Satisfaction Analytics:** Avg score, distribution of satisfaction, employee comments.  
- **Sick Leaves Analytics:** Total days off, sick leave counts, department trends.  

---

## 🚀 How to Use  
1. Clone this repository.  
2. Open the `.pbix` file in **Power BI Desktop**.  
3. Refresh the data (SQL Server connection).  
4. Explore dashboards & KPIs.  

---

## 📝 Author  
👤 Ahmed Aly  
- [LinkedIn](https://www.linkedin.com/in/ahmedaly2002/)  
- [GitHub](https://github.com/AhmedAly74)  
- [Portoflio](https://ahmedalyofficial20.wixsite.com/ahmedalyportfolio)
