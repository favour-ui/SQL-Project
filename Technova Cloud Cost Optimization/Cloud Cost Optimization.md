#  TechNova Cloud Cost Optimization Case Study
*A Data-Driven Investigation into Cloud Waste and Strategic Spend*

Analyzing and reducing unnecessary cloud expenses using MySQL to identify waste, inefficiency, and opportunities for savings.

---

## CONTEXT AND PROBLEM

TechNova Software Inc. is a fast-growing SaaS company based in Nairobi, Kenya.  
Recently, leadership noticed that **cloud costs jumped 37% between July and August 2025** — even though every engineering team was **under its quarterly budget**.

### Project Overview
TechNova Software Inc., a SaaS company based in Nairobi, Kenya, noticed that its cloud costs were rising rapidly despite stable customer growth.
As the company approached its quarterly budget limits, leadership became concerned that **a large portion of spending was being wasted on idle or redundant cloud resources.**

The goal of this project was to analyze cloud cost data using MySQL to uncover:

  - Areas of inefficient spending

  - Teams or projects exceeding budgets

  - Cost drivers behind a 37% monthly cost increase

The analysis follows the BAIIR framework — *Business Understanding, Acquisition & Cleaning, Integration, Insight Generation, and Recommendation*.

Cloud spending is rising unpredictably while budgets remain unspen.  
We need to uncover the cause of this spike, separate **strategic costs** (investments in Project Titan) from **wasteful costs** (idle or oversized resources), and recommend actions that improve efficiency without slowing innovation.

---

### Business Questions

  1. What percentage of the company’s cloud bill is wasted on idle or unused resources?

  2. Which teams or projects are responsible for the highest costs?

  3. Why did the cloud bill increase by 37% between July and August?

  4. Which parts of the infrastructure are strategic investments (e.g., Project Titan) and which are inefficient costs?

  5. How can the company reduce costs without affecting performance?

---

### Objectives and Deliverables

 - **Objectives**

   - Detect inefficient or idle cloud resources contributing to waste.

   - Compare actual vs. budgeted costs by team.

   - Identify root causes of rising cloud expenses.

   - Support the Finance and Engineering teams in decision-making.

 - **Deliverables**

   - Clean, structured relational database in MySQL.

   - SQL scripts for data cleaning, analysis, and visualization.

   - Analytical summary with key insights and recommendations.

   - A final consolidated SQL view (vw_Master_Report) for dashboards.

---

### Data Source

The data was obtained from TechNova’s internal cloud billing system, exported as CSV files.

**Datasets Used:**

  - cost_and_usage_report.csv – Contains detailed line items of cloud charges and usage.

  - resource_tags.csv – Maps each resource to a team, project, and environment.

  - resource_configuration.csv – Includes resource status, instance type, and creation/decommission dates.

  - performance_metrics.csv – Contains average performance and utilization scores.

  - quarterly_budgets.csv – Defines budget allocations per team.

  - security_findings.csv – Records compliance and security-related data.

Each dataset was imported into MySQL Workbench using LOAD DATA INFILE.

---

### Stakeholders

| Role | Responsibility |
|------|----------------|
| **CFO** | Ensures profitability and budget adherence |
| **CTO** | Oversees platform reliability and technical efficiency |
| **Engineering Managers** | Manage resource allocation per team |
| **Data Analyst (You)** | Diagnose causes, quantify impact, communicate insights |

---

## BUSINESS IMPACT

| Metric | Value | Interpretation |
|---------|--------|----------------|
| Total Cloud Spend | $29.22 K | Quarterly total (June–Aug 2025) |
| Cost Growth Rate | + 37 % | Spike between July → August |
| Wasteful Spending Ratio | 7.93 % | ≈ $2.3 K idle cost |
| Strategic Investment (Project Titan) | 31 % of total bill | Efficient, justified spending |
| Potential Savings | ≈ $2K / quarter | If idle resources are right-sized |

Even though teams used only **17–32 % of their budgets**, total costs still rose — signaling a disconnect between **budget allocation** and **actual usage**.

---

## DATA EXPLORATION AND SCHEMA DESIGN

The TechNova Cloud Analytics Dataset simulates six CSV files providing a 360° view of costs, usage, and performance.

| Table | Description | Key Columns |
|--------|--------------|-------------|
| **cost_and_usage_report** | Daily cost & usage per resource | `line_item_resource_id`, `line_item_blended_cost`, `usage_date` |
| **resource_tags** | Maps resources to team / project / environment | `resource_tag_team`, `resource_tag_project`, `resource_tag_environment` |
| **performance_metrics** | CPU utilization data | `resource_id`, `average_value` |
| **quarterly_budgets** | Team budgets | `team_name`, `quarterly_budgeted_amount` |
| **resource_configuration** | Instance types & decommission dates | `resource_id`, `instance_type`, `decommission_date` |

---

## 🧾 DECISION TABLE — DATA QUALITY & CLEANING STRATEGY

After cleaning, all tables joined successfully and 12 % of previously invalid records were corrected — ensuring reliable aggregations

---

## DATA CLEANING – 4-PHASE PROCESS

Data cleaning was done in MySQL Workbench, focusing on formatting consistency and removing invalid entries.

**Phase 1 – Date Standardization**  
Some date columns came in mixed formats (MM/DD/YYYY, YYYY-MM-DD, etc.), which caused import errors and inconsistent sorting(Used STR_TO_DATE() to unify formats).

**Phase 2 – Numeric Corrections**  
`line_item_blended_cost` contained text and negatives. We cast to FLOAT and applied `ABS()`.

**Phase 3 – Text Standardization**  
Team names and environments were upper-cased and trimmed to ensure consistent joins

**Phase 4 – Logical Integrity**  
Removed null CPU values and flagged resources active after decommission dates (“zombie” servers)

---

## HYPOTHESIS EXPLORATION

Before analysis, the team tested three hypotheses:

1. **Budget Overshoot → False** – Teams were under budget
2. **Under-utilized Large Servers → False** – All Project Titan servers > 5 % CPU
3. **Waste Outside Titan → True** – Idle resources in other teams drove waste

We mapped our reasoning using **BAIIR** (*Baseline, Analysis, Insight, Impact, Recommendation*).

---

## ANALYSIS

### Queries Used
```sql
-- Baseline trend
SELECT usage_date, SUM(blended_cost) AS total_cost
FROM cost_and_usage_report
GROUP BY usage_date;

-- Budget variance per team
SELECT t.resource_tag_team,
  SUM(c.blended_cost) AS actual_spend,
  b.quarterly_budgeted_amount AS budget,
  ((SUM(c.blended_cost)-b.quarterly_budgeted_amount)
/ b.quarterly_budgeted_amount)*100 AS budget_variance
FROM cost_and_usage_report c
JOIN resource_tags t ON c.line_item_resource_id=t.line_item_resource_id
JOIN quarterly_budgets b ON t.resource_tag_team=b.team_name
GROUP BY t.resource_tag_team,b.quarterly_budgeted_amount;
```

---

## RESULTS AND VISUALS

### VISUAL 1 — Cloud Spend Overview
![Visual 1](https://github.com/favour-ui/SQL-Project/blob/main/Technova%20Cloud%20Cost%20Optimization/Visual%201.png)
Cloud costs spiked **37 % in August** while teams used only **17–32 % of budgets**.  
Waste concentrated in **User Front-End (21 %)** and **Marketing API (22 %)**.

### VISUAL 2 — Strategic Project Variance
![Visual 2](https://github.com/favour-ui/SQL-Project/blob/main/Technova%20Cloud%20Cost%20Optimization/Visual%202.png)
**Project Titan** = 35 % of total spend but only 1 % waste.  
CPU > 5 % across all large instances → efficient usage (≈ 41 % of budget).  
→ The cost spike was **legitimate scaling**, not inefficiency

### VISUAL 3 — Resources to Fix & Recommendations
![Visual 3](https://github.com/favour-ui/SQL-Project/blob/main/Technova%20Cloud%20Cost%20Optimization/Visual%203.png)
**2 593** inefficient resources found outside Titan; **50 critical double-offenders** (post-decommission + idle).  
Potential savings: ≈ $120 K per quarter

---

## ROOT CAUSE SUMMARY

- The 37 % cost increase was driven by **Project Titan’s scaling**, not waste
- Waste came from idle resources in other teams ( CPU < 5 % )
- Budget allocations were too generous, masking inefficiency
- Refined SQL joins and CTEs pinpointed where waste occurred

---

## RECOMMENDATIONS

| Focus Area | Action | Owner | Priority |
|-------------|---------|--------|-----------|
| Idle Servers (< 5 % CPU) | Right-size or terminate | Data Platform Team | 🔴 High |
| Zombie Servers | Enforce auto-decommission | Infra Ops | 🟠 Medium |
| Budget Planning | Align budgets with utilization | Finance + CTO | 🟢 High |
| Project Titan | Continue efficiency monitoring | AI Division | 🟢 High |

---

## WHY WE’RE CONFIDENT THE FIX WILL WORK

- **Waste definition is data-driven:** CPU < 5 %.  
- **Right-sizing** addresses ≈ 70 % of waste with no service risk.  
- **Automation** prevents recurrence.  
- **Budget realignment** stabilizes future variance.  
- **Immediate terminations** save 5–7 % instantly.

Together, these steps eliminate unnecessary costs while protecting strategic investments like Project Titan





