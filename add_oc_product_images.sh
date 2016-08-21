#!/bin/bash

MOBILE_DE_ID=$1
ID=$2
BACKUP_PATH=$3

source ./config.txt

for i in `2 3 4 5 6 7 8 9`; do
	IMAGE=$MOBILE_DE_BACKUP_DIR/`echo $MOBILE_DE_ID`_`echo $i`.jpg
	if [ -s $IMAGE ]; then
		cp $IMAGE /home/opencart/www.auto-auction-germany.com/image/catalog/aager-demo/$ID-$i.jpg
		IMAGE_PATH="catalog/aager-demo/$ID-$i.jpg"

		mysql -u $MYSQL_USER -p$MYSQL_PASSWD opencart <<EOF
INSERT INTO oc_product_image SET product_id=$ID, image="$IMAGE_PATH", sort_order=0;
EOF
	fi
done

