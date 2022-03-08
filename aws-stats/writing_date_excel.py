"""
    __date__: 2022-MAR-07
    __author__: CODELOCKED
    __description__: Script will run aws process and write the data to an excel file
    __change_log__: Draft version of the script
    __version__: 0.1
"""


# Import libraries
import csv
import xlwt
from optparse import OptionParser
from datetime import datetime


def write_data_excel_file(filename, sheet_name, outputfile):
    """
    Write data to excel sheets
    """
    # Create a workbook and add a worksheet
    sheet = workbook.add_sheet(sheet_name)
    # Open the csv file
    with open(filename, 'r') as csv_file:
        csv_reader = csv.reader(csv_file)

        # Write the content of the csv file to the different sheets
        for row_index, row in enumerate(csv_reader):
            for col_index, col in enumerate(row):
                sheet.write(row_index, col_index, col)
    # Save the workbook
    workbook.save(outputfile)

def log(string):
    """
    Log printing
    """
    formated_date = datetime.now().strftime("[%y-%m-%d %H:%M:%S]")
    print(f"{formated_date} [PYTHON]: {string}")
    return 0

def main(workbook):
    """
    Main function
    """
    parser = OptionParser(usage="%prog [-c] arg1 [-s] arg2 [-f] arg3 [-l] arg4 [-e] arg5 [-v] arg6 [-o] arg7", version="%prog 0.1")
    parser.add_option("-c", "--ec2", dest="instances",
                        help="Describe instances")
    parser.add_option("-s", "--s3api", dest="buckets",
                        help="List Buckets")
    parser.add_option("-f", "--firehose", dest="firehose",
                        help="Firehose List Delivery Streams")
    parser.add_option("-l", "--lambdafunction", dest="lambdafunction",
                        help="Lambda List Functions")
    parser.add_option("-e", "--elb", dest="loadbalancer",
                        help="ELB Describe Load Balancers")
    parser.add_option("-v", "--elbv2", dest="traget",
                        help="ELBv2 Describe target Groups")
    parser.add_option("-o", "--output", dest="output",
                        help="Final Output excel document")
    
    (options, args) = parser.parse_args()
    
    if options.instances and options.buckets and options.firehose and options.lambdafunction and options.loadbalancer and options.traget and options.output:
        log('Rolling workbook writing...')
        log(' - writing EC2 describe instances')
        write_data_excel_file(options.instances, 'EC2 Describe instances', options.output)
        log(' - writing S2API List buckets content')
        write_data_excel_file(options.buckets, 'S2api List Buckets', options.output)
        log(' - writing Firehose list delivery Streams')
        write_data_excel_file(options.firehose, 'Firehose List Delivery Streams', options.output)
        log(' - writing Lambda List functions')
        write_data_excel_file(options.lambdafunction, 'Lambda List Functions', options.output)
        log(' - writing ELB describe load balancers')
        write_data_excel_file(options.loadbalancer, 'ELB Describe Load Balancer', options.output)
        log(' - writing ELBv2 describe traget groups')
        write_data_excel_file(options.traget, 'ELBv2 Describe Target Groups', options.output)
        log('Writing data to CSV file completed')
    else:
        print(parser.format_help())
        parser.error("Please select all options")

if __name__ == '__main__':
    workbook = xlwt.Workbook()
    main(workbook)
