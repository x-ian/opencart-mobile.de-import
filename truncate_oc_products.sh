#!/bin/bash

source ./config.txt

mysql -u $MYSQL_USER -p$MYSQL_PASSWD opencart <<EOF

truncate oc_product;
truncate oc_product_description;
truncate oc_product_to_category;
truncate oc_product_to_layout;
truncate oc_product_to_store;

EOF