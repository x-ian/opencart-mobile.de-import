#!/bin/bash

source ./config.txt

mysql -u $MYSQL_USER -p$MYSQL_PASSWD opencart <<EOF

SET @id := $1;
SET @category := $2;	

INSERT INTO oc_product_to_category VALUES (@id,@category);

EOF
