#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

LOG_DIRECTORY='/tmp'

ADMIN_USER='mysqladmin@wso2isdb'
ADMIN_PASSWORD='${db_admin_password}'
CONNECTION_STRING='${db_connection_strings}'
DB_HOME='/tmp/dbscripts'
USER_PASSWORD="BEstr11ng_#12"


mysql -s  <<EOF  > $LOG_DIRECTORY/query.log -h $CONNECTION_STRING -u mysqladmin@wso2isdb -p$ADMIN_PASSWORD

CREATE DATABASE shared_db;
CREATE USER shared_user IDENTIFIED BY "$USER_PASSWORD";
GRANT ALL ON shared_db.* TO shared_user@'%' IDENTIFIED BY "$USER_PASSWORD";

CREATE DATABASE identity_db;
CREATE USER identity_user IDENTIFIED BY "$USER_PASSWORD";
GRANT ALL ON identity_db.* TO identity_user@'%' IDENTIFIED BY "$USER_PASSWORD";

FLUSH PRIVILEGES;
EOF

mysql -s  <<EOF  > $LOG_DIRECTORY/query.log -h $CONNECTION_STRING -u shared_user@wso2isdb -p$USER_PASSWORD

USE shared_db;
SOURCE $DB_HOME/mysql-shared.sql

EOF

mysql -s  <<EOF  > $LOG_DIRECTORY/query.log -h $CONNECTION_STRING -u identity_user@wso2isdb -p$USER_PASSWORD

USE identity_db;
SOURCE $DB_HOME/mysql-identity.sql

EOF
