# BenchSS

Benchmarking Subset Selection from Large Candidate Solution Sets in Evolutionary Multi-objective Optimization

#### Candidate Solution Sets

- The whole test suite is available at https://github.com/HisaoLabSUSTC/BenchWhole
- The small test suite is available at https://github.com/HisaoLabSUSTC/BenchSmall

#### Subset Selection Algorithms 

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
| POHSS   | POHVSS.m            |
| POIGDSS | POIGDSS.m           |
| POIGD+SS| POIGDpSS.m          |

#### Performance indicators

- newHV.m, newIGD.m, newIGDp.m are used for the  candidate solution sets from EMO algorithms.
- HV.m, IGD.m, IGDp.m are used for the candidate solution sets on Pareto fronts.

#### Experimental Results

- The selected subsets are saved in **Result/PF** and **Result/EMOA**.
- The naming rule is **Subset Selection Method** **Name** _ **Candidate Solution Set Name**  _  **Random Seed**.
- The tables are in **Table/PF** and **Table/EMOA**.
