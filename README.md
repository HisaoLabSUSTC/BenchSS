# BenchSS

Benchmarking Subset Selection in Evolutionary Multi-objective Optimization

#### Candidate Solution Sets

The candidate solution sets on Pareto fronts are in **Data/PF**. The candidate solution sets from EMO algorithms are in **Data/EMOA**

#### Subset Selection Method 

| Method  | Files               |
| ------- | ------------------- |
| GHSS    | LazyHVSelection.m   |
| GAHSS   | selSolAHV.m         |
| GIGDSS  | LazyIGDSelection.m  |
| GIGD+SS | LazyIGDpSelection.m |
| DSS     | selSolDSS_GI.m      |
| IDSS    | selSolDSS_I.m       |
| CSS-MEA | K_means_S.m         |
| CSS-MED | K_medoid_S.m        |
| RVSS-PD | selSolRVSS_PD.m     |
| RVSS-AD | selSolRVSS_AD.m     |

#### Performance metric

- newHV.m, newIGD.m, newIGDp.m are used for the  candidate solution sets from EMO algorithms.
- HV.m, IGD.m, IGDp.m are used for the candidate solution sets on Pareto fronts.
- uniformLevel.m is used for both sets.

#### Experiment Reuslt

- The experiemnt results are saved in **Result/PF** and **Result/EMOA**.
- The naming rule is **Subset Selection Method** **Name** _ **Candidate Solution Set Name**  _  **Random Seed**.
- The organized tables are in **Table/PF** and **Table/EMOA**.



