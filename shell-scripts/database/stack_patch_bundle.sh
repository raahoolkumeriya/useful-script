#!/bin/bash

# ------------------------------------------------------------------
#   Author          :   CODELOCKED
#   Description     :   Patch bundle for stack
#                       Product Patched: Oracle Weblogic Server
#                       Product version: 12.2.1.4.0
#   Change_log      :
#       01JAN2022       CODELOCKED      Initial draft version
# ------------------------------------------------------------------

SCRIPT_PATH=$PWD
DATE_YMDHMS=$(date '+%Y%m%d%H%M%S')
# Check configuration file avilablility
CONFIG_FILE=${SCRIPT_PATH}/stack_patch_bundle.conf
BACKUP_DIR=${SCRIPT_PATH}/backup_$(date '+%Y%m%d')

if [ ! -f ${CONFIG_FILE} ]; then
    echo "Configuration file not found: ${CONFIG_FILE}"
    exit 1
else
    ORACLE_HOME=$(grep ORACLE_HOME= ${CONFIG_FILE} | cut -d= -f2)
    OPATCH_MIN_VER=$(grep OPATCH_MIN_VER= ${CONFIG_FILE} | cut -d= -f2)
    WLSER_SCRIPT_DIR=$(grep WLSER_SCRIPT_DIR= ${CONFIG_FILE} | cut -d= -f2)
    JAVA_HOME=$(grep JAVA_HOME= ${CONFIG_FILE} | cut -d= -f2)
    JAVA_MIN_VERSION=$(grep JAVA_MIN_VERSION= ${CONFIG_FILE} | cut -d= -f2)
    CENTRAL_INVENTORY_PATH=$(grep CENTRAL_INVENTORY_PATH= ${CONFIG_FILE} | cut -d= -f2)
    GENERIC_ZIP_FILE=$(grep GENERIC_ZIP_FILE= ${CONFIG_FILE} | cut -d= -f2)
fi

validate_source_env_variables() {
    if [ -z $2 ]; then
        echo "ERROR: ConfigVariableMissing: $1 is not set in configuration file"
        exit 1
    fi
}

optach_or_servenv_setup_check(){
    echo "INFO: Spinning Pre-requisites task for Oracle Weblogic Server on server $(hostname)..."
    if [[ -e $ORACLE_HOME/OPatch/optach ]]; then
        echo "INFO: Trying minimum Opatch version requirement..."
        CURRENT_OPATACH_VER=$($ORACLE_HOME/OPatch/opatch version)
        SERVER_OPATCH_MIN_VER=$(echo $OPATCH_MIN_VER | perl -lne 'print $& if /(\d+.{10}/')

        echo "-------------------------------------"
        echo "INFO: Current OPatch version: $CURRENT_OPATACH_VER"
        echo "INFO: Minimum OPatch version: $SERVER_OPATCH_MIN_VER"
        echo "-------------------------------------"

        MAJOR_CONF_VER=$(echo $CURRENT_OPATACH_VER | cut -d. -f1)
        MINOR_CONF_VER=$(echo $CURRENT_OPATACH_VER | cut -d. -f2)
        MAJOR_SERVER_VER=$(echo $SERVER_OPATCH_MIN_VER | cut -d. -f1)
        MINOR_SERVER_VER=$(echo $SERVER_OPATCH_MIN_VER | cut -d. -f2)
        RELEASE_CONF_VER=$(echo $CURRENT_OPATACH_VER | cut -d. -f3)
        RELEASE_SERVER_VER=$(echo $SERVER_OPATCH_MIN_VER | cut -d. -f3)

        if [[ $MAJOR_CONF_VER -gt $MAJOR_SERVER_VER ]]; then
            echo "INFO: OPatch version requirement met"
        elif [[ $MAJOR_CONF_VER -eq $MAJOR_SERVER_VER ]]; then
            if [[ $MINOR_CONF_VER -gt $MINOR_SERVER_VER ]]; then
                echo "INFO: OPatch version requirement met"
            elif [[ $MINOR_CONF_VER -eq $MINOR_SERVER_VER ]]; then
                if [[ $RELEASE_CONF_VER -ge $RELEASE_SERVER_VER ]]; then
                    echo "INFO: OPatch version requirement met"
                else
                    echo "ERROR: OPatch version requirement not met"
                    exit 1
                fi
            else
                echo "ERROR: OPatch version requirement not met"
                exit 1
            fi
        else
            echo "ERROR: OPatch version requirement not met"
            exit 1
        fi

    elif [[ -e $WLSER_SCRIPT_DIR/setWLSEnv.sh ]]; then
        echo "INFO: Spinning wlserver script to set environment..."
        $WLSER_SCRIPT_DIR/setWLSEnv.sh
        if [[ $? -ne 0 ]]; then
            echo "ERROR: Failed to set environment"
            exit 1
        fi
        echo "INFO: Environment set successfully"
    fi
}


checking_java_version(){
    echo "INFO: Checking Java version..."
    JAVA_VERSION=$($JAVA_HOME/bin/java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    # --- DELETE ME ----
    JAVA_VERSION="1.8.0_131"
    # --- DELETE ME ----
    echo "INFO: Current Java version: $JAVA_VERSION"
    MAJOR_CONFIG_JV=$(echo $JAVA_MIN_VERSION | cut -d. -f1)
    MINOR_CONFIG_JV=$(echo $JAVA_MIN_VERSION | cut -d. -f2)
    MAJOR_SERVER_JV=$(echo $JAVA_VERSION | cut -d. -f1)
    MINOR_SERVER_JV=$(echo $JAVA_VERSION | cut -d. -f2)
    RELEASE_CONFIG_JV=$(echo $JAVA_MIN_VERSION | cut -d_ -f2)
    RELEASE_SERVER_JV=$(echo $JAVA_VERSION | cut -d_ -f2)

    if [[ $MAJOR_CONFIG_JV -gt $MAJOR_SERVER_JV ]]; then
        echo "ERROR: Java version requirement not met"
        exit 1
    elif [[ $MAJOR_CONFIG_JV -eq $MAJOR_SERVER_JV ]]; then
        if [[ $MINOR_CONFIG_JV -gt $MINOR_SERVER_JV ]]; then
            echo "ERROR: Java version requirement not met"
            exit 1
        elif [[ $MINOR_CONFIG_JV -eq $MINOR_SERVER_JV ]]; then
            if [[ $RELEASE_CONFIG_JV -ge $RELEASE_SERVER_JV ]]; then
                echo "INFO: Java version requirement met"
            else
                echo "ERROR: Java version requirement not met"
                exit 1
            fi
        else
            echo "ERROR: Java version requirement not met"
            exit 1
        fi
    else
        echo "ERROR: Java version requirement not met"
        exit 1
    fi   
}

check_minimum_space_on_tmp(){
    echo "INFO: Checking minimum space on tmp directory..."
    TMP_DIR_SIZE=$(df -k /tmp | awk 'NR==2 {print $4}')
    echo "INFO: Current size of /tmp directory: $TMP_DIR_SIZE"
    if [[ $TMP_DIR_SIZE -lt 2097152 ]]; then
        echo "ERROR: Minimum space requirement not met"
        exit 1
    fi
}

verify_java_in_global_properties(){
    echo "INFO: Verifying java in global properties..."
    echo $ORACLE_HOME

    if [[ -e $ORACLE_HOME/oui/.globalEnv.properties ]]; then
        echo "INFO: Global properties file found"
        JAVA_HOME_IN_GLOBAL_PROPERTIES=$(grep JAVA_HOME= $ORACLE_HOME/oui/.globalEnv.properties | cut -d= -f2)
        
        if [[ -z $JAVA_HOME_IN_GLOBAL_PROPERTIES ]]; then
            echo "INFO: JAVA_HOME not found in global properties file"
            echo "INFO: Setting JAVA_HOME in global properties file..."
            echo "JAVA_HOME=$JAVA_HOME" >> $ORACLE_HOME/oui/.globalEnv.properties
            echo "INFO: JAVA_HOME set successfully"
        else
            echo "INFO: JAVA_HOME found in global properties file"
            if [[ $JAVA_HOME_IN_GLOBAL_PROPERTIES != $JAVA_MIN_VERSION ]]; then
                echo "ERROR: JAVA_HOME in global properties file does not match with the one in configuration file"
                exit 1
            fi
        fi
    else
        echo "INFO: Global properties file not found"
        echo "INFO: Creating global properties file..."
        echo "JAVA_HOME=$JAVA_HOME" > $ORACLE_HOME/oui/.globalEnv.properties
        echo "INFO: Global properties file created successfully"
    fi
}

take_backup(){
    echo "INFO: Taking backup of $ORACLE_HOME and $CENTRAL_INVENTORY_PATH"
    if [[ -d $ORACLE_HOME ]]; then
        cp -r $ORACLE_HOME $ORACLE_HOME.$DATE_YMDHMS
        ls -latrd $ORACLE_HOME.$DATE_YMDHMS 
    else
        echo "ERROR: $ORACLE_HOME does not exist"
        exit 1
    fi

    if [[ -d $CENTRAL_INVENTORY_PATH ]]; then
        cp -r $CENTRAL_INVENTORY_PATH $CENTRAL_INVENTORY_PATH.$DATE_YMDHMS
        ls -latrd $CENTRAL_INVENTORY_PATH.$DATE_YMDHMS
    else
        echo "ERROR: $CENTRAL_INVENTORY_PATH does not exist"
        exit 1
    fi
}

checking_patch_user(){
    echo "INFO: Checking patch user..."
    PATCH_USER=$(ls -ld $ORACLE_HOME | awk '{print $3}')
    echo "INFO: Current patch user: $PATCH_USER"
    if [[ $PATCH_USER != $(whoami) ]]; then
        echo "ERROR: Patch user does not match with the current user"
        exit 1
    fi
}

check_weblogic_server_status(){
    echo "INFO: Checking weblogic server status..."
    PROCESS_COUNT=$(ps aux | grep -v grep | grep -c "weblogic" | wc -l)
    if [[ $PROCESS_COUNT -gt 0 ]]; then
        echo "INFO: Weblogic server is running"
    else
        echo "ERROR: Weblogic server is not running"
        exit 1
    fi
}


patch_installation(){
    echo "INFO: Patch installation..."

    ZIP_DIR=$(dirname $GENERIC_ZIP_FILE)
    FILE_NAME=$(basename $GENERIC_ZIP_FILE)

    if [[ -d $ZIP_DIR ]]; then
        echo "INFO: $ZIP_DIR directory found"
        if [[ -e $GENERIC_ZIP_FILE ]]; then
            cd $ZIP_DIR
            unzip $FILE_NAME
            cd $ZIP_DIR/WLS_SPB*/binanry_patches

            echo "INFO: Patching weblogic server..."
            $ORACLE_HOME/OPatch/opatch apply -silent -oh $ORACLE_HOME -ocmrf $ORACLE_HOME/patch_list.txt
            if [[ $? -eq 0 ]]; then
                echo "INFO: Patching weblogic server completed successfully"
            else
                echo "ERROR: Patching weblogic server failed"
                exit 1
            fi
        else
            echo "ERROR: $GENERIC_ZIP_FILE does not exist"
            exit 1
        fi
    else
        echo "INFO: $ZIP_DIR directory not found"
        mkdir -p $ZIP_DIR
        echo "INFO: $ZIP_DIR directory created successfully"
    fi
}


main(){
    echo " ----- S T A C K  ---  P A T C H  --- B U N D L E -----"
    echo "Validating Source variables..."
    validate_source_env_variables ORACLE_HOME $ORACLE_HOME
    validate_source_env_variables WLSER_SCRIPT_DIR $WLSER_SCRIPT_DIR
    validate_source_env_variables OPATCH_MIN_VER $OPATCH_MIN_VER
    validate_source_env_variables JAVA_HOME $JAVA_HOME
    validate_source_env_variables JAVA_MIN_VERSION $JAVA_MIN_VERSION
    validate_source_env_variables CENTRAL_INVENTORY_PATH $CENTRAL_INVENTORY_PATH
    validate_source_env_variables GENERIC_ZIP_FILE $GENERIC_ZIP_FILE

    echo "Validating weblogic process..."
    check_weblogic_server_status

    echo ;echo "------  P R E - R E Q U I S I T I E S ------"
    echo "Optach version check..."
    optach_or_servenv_setup_check
    echo "Java version check..."
    checking_java_version
    echo "Minimum space on tmp directory check..."
    check_minimum_space_on_tmp
    echo "Verifying java in global properties..."
    verify_java_in_global_properties
    echo "Checking patch user..."
    checking_patch_user

    echo; echo "------  B A C K U P ------"
    echo "Taking backup of $ORACLE_HOME and $CENTRAL_INVENTORY_PATH..."
    take_backup
    echo "export ORACLE_HOME"
    export ORACLE_HOME=$ORACLE_HOME

    echo; echo "------  P A T C H   I N S T A L L A T I O N ------"
    echo "Patch installation..."
    patch_installation

    echo "INFO: Patching completed successfully"

    echo "------  P O S T - R E Q U I S I T I E S ------"
    echo "Post-verification..."
    $ORACLE_HOME/OPatch/opatch lspatches
}

main