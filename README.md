# Build Project

To generate the charts you need:
- Install R  
- Install RStudio
- Export Mintos transactions
- Open project and run scripts

## Install R

Download and install R language from the official site:
- https://cran.r-project.org/

## Install RStudio

Download and install RStudio IDE from the official site:
- https://posit.co/downloads/

## Export Mintos transactions

**Step 1: Login into you Mintos account.**

**Step 2: Export current investments**
- Navigate to: `User Icon -> Statement`
- Select the date range for the entire 2023 year and click `Search`
- Generate and save the Excel file: `/data-raw/account statement - 2023.xlsx`
- Repeat for 2024

## Open project and run scripts

**Step 1: Open the project**
- Open the `Mintos Charts.Rproj` into RStudio.

**Step 2: Run scripts**
- `/scripts/00-set-environment.R`
- `/scripts/01-import-all.R`
- `/scripts/03-generate-all-charts.R`
