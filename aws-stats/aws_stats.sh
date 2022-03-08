#!/bin/bash

#------------------------------------------------------------------------------------
#   Date: Monday 7 March 2022 08:15:21 AM IST
#   Author: CODELOCKED
#   Description: Script to create AWS stats processing
#       o Python script for processing excel sheet
#       o Account parameter needed
#       o BSCI parameter needed
#   Execution: ./aws_stack.sh [-a|--account] [ACCOUNT] [-b|--bsci] [BSCI]
#
#   Change_log:
#       CODELOCKED  1.0.0   07-MAR-2022     Initial Draft of the Script
#       CODELOCKED  1.0.1   08-MAR-2022     Logging and File validations
#------------------------------------------------------------------------------------

SCRIPT_VERSION="1.0.1"
SCRIPT_DIR=$PWD  # Change Me
OUTPUT_FILE_DIR=$SCRIPT_DIR/Output # Change Me
DATE_YYDDMM=$(date +%Y-%m-%d)
DATE_YMDHS=$(date +%Y%m%d%H%M%S)


if [[ $# -eq 0 ]]; then
    echo "UsageError: No arguments supplied"
    echo "Usage: ./aws_stack.sh [OPTIONS] [ARGUMENTS]"
    echo "Options:"
    echo "  -h, --help"
    echo "  -v, --version"
    echo "  -a, --account"
    echo "  -b, --bsci"
    exit 1
elif [[ $# -eq 1 ]]; then
    echo "Script Version $SCRIPT_VERSION"
    echo "Script Execution examples :"
    echo "./aws_stack.sh -a <ACCOUNT> -b <BSCI>"
    exit 1;
else
    while [[ $# -gt 1 ]]; 
    do
    case $1 in 
        "-a"|"--account")
            shift
            ACCOUNT="$1"
            shift
            ;;
        "-b"|"--bsci")
            shift
            BSCI="$1"
            shift
            ;;
        *)
            echo "UsageError: Unknown option $1"
            exit 1
    esac
    done
fi

executing_aws_command(){
    # Function will execute aws command checks output and return the status
    # Usage: executing_aws_command <aws_command>
    # Example: executing_aws_command "aws ec2 describe-instances --filters "Name=tag:BusinessServiceCI,Values=${BSCI}" --query "Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,LaunchDate:LaunchTime,AssetCI:Tags[?Key=='AssetCI']|[0].Value}" --output text | tr  '\t' ',' | tee ec2-accounts-${ACCOUNT}-${BSCI}-${DATE_YYDDMM}.csv"
    $1
    if [ $? -ne 0 ]; then
        echo "AWSCommandError: $1 is not executed. Please check the logs"
        return 1
    fi
}

log(){
    # Logging Function
    echo "[$(date '+%y-%m-%d %H:%M:%S')] [MAIN]: $@" | tee -a $SCRIPT_LOG
}

# Create Log Directory
if [[ ! -d $SCRIPT_DIR/LOGS ]]; then
    mkdir $SCRIPT_DIR/LOGS
fi

SCRIPT_LOG=$SCRIPT_DIR/LOGS/aws_stats_$DATE_YMDHS.log
echo "Script Log File name : $SCRIPT_LOG"
touch $SCRIPT_LOG


log "-------------------------------------------------------------------"
log "               AWS Stats Report: $DATE_YYDDMM"
log "Script running for Account [$ACCOUNT] and BSCI [$BSCI] value"
log "-------------------------------------------------------------------"

log "Executing describe-instances command"
executing_aws_command "aws --profile $ACCOUNT ec2 describe-instances --filters 'Name=tag:BusinessServiceCI,Values=${BSCI}' --query 'Reservations[*].Instances[*].{PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,LaunchDate:LaunchTime,AssetCI:Tags[?Key=='AssetCI']|[0].Value}' --output text | tr  '\t' ',' > ec2-accounts-${ACCOUNT}-${BSCI}-${DATE_YYDDMM}.csv"

log "Executing list-buckets command"
executing_aws_command "aws --profile $ACCOUNT s3api list-buckets --query 'Buckets[].Name' --output text | tr '\t' '\n' > s3-buckets-${ACCOUNT}-${DATE_YYDDMM}.csv"

log "Executing firehouse command"
executing_aws_command "aws --profile $ACCOUNT firehose list-delivery-streams --query 'DeliveryStreamNames[]' --output text | tr '\t' '\n' > firehose-streams-${ACCOUNT}-${DATE_YYDDMM}.csv"

log "Executing list-funcions command"
executing_aws_command "aws --profile $ACCOUNT lambda list-functions --query 'Functions[].FunctionName' --output text | tr '\t' '\n' > lambda-functions-${ACCOUNT}-${DATE_YYDDMM}.csv"

log "Executing elb-describe-load-balancers command"
executing_aws_command "aws --profile $ACCOUNT elb describe-load-balancers --region ap-southeast-2 --output text | tr '\t' '\n' > load3-balancers-${ACCOUNT}-${DATE_YYDDMM}.csv"

log "Executing elbv2-describe-load-balancers command"
executing_aws_command "aws --profile $ACCOUNT elbv2 describe-target-groups --region ap-southeast-2 --output text | tr '\t' '\n' > target-groups-${ACCOUNT}-${DATE_YYDDMM}.csv"

# Final output Excel file
OUTPUT_FILE=$OUTPUT_FILE_DIR/stats-${ACCOUNT}-${BSCI}-${DATE_YYDDMM}.xls

verify_file_exits(){
    # Function will verify the file exists and return the status
    # Usage: verify_file_exits <file_name>
    # Example: verify_file_exits ec2-accounts-${ACCOUNT}-${BSCI}-${DATE_YYDDMM}.csv
    if [ -f $1 ]; then
        log "File $1 exists"
        return 0
    else
        log "FileMissingError: $1"
        return 1
    fi
}

verify_file_exits $SCRIPT_DIR/writing_date_excel.py
verify_file_exits $OUTPUT_FILE_DIR/ec2-accounts-${ACCOUNT}-${BSCI}-${DATE_YYDDMM}.csv
verify_file_exits $OUTPUT_FILE_DIR/s3-buckets-${ACCOUNT}-${DATE_YYDDMM}.csv 
verify_file_exits $OUTPUT_FILE_DIR/firehose-streams-${ACCOUNT}-${DATE_YYDDMM}.csv
verify_file_exits $OUTPUT_FILE_DIR/lambda-functions-${ACCOUNT}-${DATE_YYDDMM}.csv
verify_file_exits $OUTPUT_FILE_DIR/load3-balancers-${ACCOUNT}-${DATE_YYDDMM}.csv
verify_file_exits $OUTPUT_FILE_DIR/target-groups-${ACCOUNT}-${DATE_YYDDMM}.csv

if [[ -f $OUTPUT_FILE_DIR/ec2-accounts-${ACCOUNT}-${BSCI}-${DATE_YYDDMM}.csv && \
    -f $OUTPUT_FILE_DIR/s3-buckets-${ACCOUNT}-${DATE_YYDDMM}.csv  && \
    -f $OUTPUT_FILE_DIR/firehose-streams-${ACCOUNT}-${DATE_YYDDMM}.csv && \
    -f $OUTPUT_FILE_DIR/lambda-functions-${ACCOUNT}-${DATE_YYDDMM}.csv && \
    -f $OUTPUT_FILE_DIR/load3-balancers-${ACCOUNT}-${DATE_YYDDMM}.csv && \
    -f $OUTPUT_FILE_DIR/target-groups-${ACCOUNT}-${DATE_YYDDMM}.csv ]]; then
    log "All file exists in output directory"
# Writing files to the output file with python script
    python $SCRIPT_DIR/writing_date_excel.py \
        --ec2 $OUTPUT_FILE_DIR/ec2-accounts-${ACCOUNT}-${BSCI}-${DATE_YYDDMM}.csv \
        --s3api $OUTPUT_FILE_DIR/s3-buckets-${ACCOUNT}-${DATE_YYDDMM}.csv \
        --firehose $OUTPUT_FILE_DIR/firehose-streams-${ACCOUNT}-${DATE_YYDDMM}.csv \
        --lambdafunction $OUTPUT_FILE_DIR/lambda-functions-${ACCOUNT}-${DATE_YYDDMM}.csv \
        --elb $OUTPUT_FILE_DIR/load3-balancers-${ACCOUNT}-${DATE_YYDDMM}.csv \
        --elbv2 $OUTPUT_FILE_DIR/target-groups-${ACCOUNT}-${DATE_YYDDMM}.csv \
        --output $OUTPUT_FILE 
    if [[ $? -eq 0 ]]; then
        log "Successfully write to final output file: $OUTPUT_FILE"
    else
        log "ExcelWriteError: Operation halt for output file: $OUTPUT_FILE"
        exit 1;
    fi
else
    log "AWSOutputFileMissingError: Final file generate error"
fi