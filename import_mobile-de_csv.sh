#!/bin/bash

source ./config.txt

# mobile.de backup CSV
MOBILE_DE_BACKUP_DIR=/root/t

while read line; do
	# parse file
	ID=`echo $line | cut -d ';' -f1 | tr -d '"'`
	TYP=`echo $line | cut -d ';' -f3 | tr -d '"'`
	MANUFACTURER=`echo $line | cut -d ';' -f4 | tr -d '"'`
	NAME=`echo $line | cut -d ';' -f5 | tr -d '"'`
	KW=`echo $line | cut -d ';' -f6 | tr -d '"'`
	EZ=`echo $line | cut -d ';' -f9 | tr -d '"'`
	MILEAGE=`echo $line | cut -d ';' -f10 | tr -d '"'`
	PRICE=`echo $line | cut -d ';' -f11 | tr -d '"'`
	COLOR=`echo $line | cut -d ';' -f17 | tr -d '"'`
	DESC=`echo $line | cut -d ';' -f26 | tr -d '"'`
	FUEL_ID=`echo $line | cut -d ';' -f110 | tr -d '"'` # diesel 2, benzin 1, 7 hybrid ?
	TRANSMISSION_ID=`echo $line | cut -d ';' -f111 | tr -d '"'` # automatik 1, schaltgetriebe 3 ? 

	# get db stuff
	NEXT_ID=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWD opencart -se "select max(product_id)+1 from oc_product" | cut -f1)

	# map manufacturer to ID
	MANUFACTURER_ID=$(mysql -u $MYSQL_USER -p$MYSQL_PASSWD opencart -se "select ifnull((select manufacturer_id from oc_manufacturer where name like '`echo $MANUFACTURER`'), 15)" | cut -f1)
	#MANUFACTURER_ID=12
	
	# map fuel type
	FUEL='fuel'
	TRANSMISSION='manuell'
	CATEGORY_ID=65
	
	# copy image
#	cp $MOBILE_DE_BACKUP_DIR/`echo $ID`_1.jpg /home/opencart/www.auto-auction-germany.com/image/catalog/aager-demo/$NEXT_ID.jpg
	IMAGE_PATH="catalog/aager-demo/$NEXT_ID.jpg"
	
	# insert new product
#	./add_oc_product.sh $NEXT_ID "" "$MANUFACTURER $NAME" "$MANUFACTURER $NAME" "$DESC" "$DESC" "$NAME" "$NAME" \
#		"$IMAGE_PATH" $PRICE $MANUFACTURER_ID $CATEGORY_ID "$COLOR" "$COLOR" "$MILEAGE" "$MILEAGE" "$KW" "$KW" \
#		"$TRANSMISSION" "$TRANSMISSION" "$FUEL" "$FUEL" "$EZ" "$EZ"

	# insert new banner item
	./add_oc_product_to_banner.sh "$NAME" "index.php?route=product/product&amp;product_id=$NEXT_ID" "$IMAGE_PATH"
	
done < "$MOBILE_DE_BACKUP_DIR/mobile.csv"
