# AWS Status Report

#### Execution of AWS commnads and writing data to single Excel file
-   `aws_stats.sh` is a shell script that executes AWS commands and writes the output data to csv files
-   `write_to_excel.py` is a python script that reads the csv files and writes the data to a single Excel file

#### Execuition
-   `bash aws_stats.sh [OPTIONS] [ARGUMENTS]` to execute the script

#### Position parameters
-  `aws_stats.sh` accepts the following positional parameters:
    -   `-a` or `--account` : Account ID
    -   `-b` or `--bsci` : BSCI
    -   `-v` or `--version` : Script version
    -   `-h` or `--help` : help

#### Output and LOG files
-   The output of the script is written to the `stats-[ACCOUNT_ID]-[BSCI]-<date-YYYY-MM-DD>.xls` file
-   The log file is written to the `aws_stats_<date_YYYYMMDDHHMMSS>.log` file