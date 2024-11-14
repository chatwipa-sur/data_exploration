## Project title 
Analysis of "Cyber Security" Course Provided by Newcastle University

## Brief project overview
- This project primarily focuses on how to improve the course to reduce student unenrollment and enhance course quality.
- The dataset in this analysis comes from the “Cyber Security: Safety At Home, Online, and in Life” course created by Newcastle University, which was publicly available and collected data through `FutureLearn`, a virtual learning provider.

## Author
Chatwipa Surapat

## Repository Overview
- The repository below contains all of the main files used in this project.

```
coursework_CSC8631/
|-- README.md
|-- reports
|   |-- AnalysisReport.pdf
|   |-- AnalysisReport.html
|   |-- AnalysisReport.RMD
|
|-- data
|   |-- README.txt
|   |-- cyber-security-1_archetype-survey-responses.csv
|   |-- cyber-security-1_enrolments.csv
|   .
|   .
|   .
|   
|-- munge
|   |-- 01-Combined_leave.R
|   |-- 02-Combined_sentiment.R
|
|-- renv.lock
|-- git_log.txt
```

## How to reproduce the analysis result
1. Download the "coursework_CSC8631" zip file and unzip the file
2. Open the `coursework_CSC8631.Rproj` through R studio
3. Run `install.packages("renv")` in the console
4. Run `renv::activate()` in the console to restart the R session
5. Run `renv::restore()` in the console to match the version of library to the `renv` lock file
6. Open `AnalysisReport.RMD` and select `knit` (Recommended knit to `html` format)
