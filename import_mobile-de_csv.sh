#!/bin/bash

source ./config.txt

# mobile.de backup CSV
FILE=mobile.csv

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
	NEXT_ID=$(mysql -u $MYSQLUSER -p$MYSQL_PASSWD opencart -se "select max(product_id)+1 from oc_product" | cut -f1)

	# map manufacturer to ID
	MANUFACTURER_ID=12
	
	# map fuel type
	FUEL='fuel'
	TRANSMISSION='manuell'
	CATEGORY_ID=12
	
	# copy image
	cp $ID_1.jpg /home/opencart/www.auto-auction-germany.com/image/catalog/aager-demo/$NEXT_ID.jpg
	IMAGE_PATH="catalog/aager-demo/$NEXT_ID.jpg"
	
	# insert new product
	./add_oc_product.sh $NEXT_ID '' '$NAME' '$NAME' '$DESC' '$DESC' 'meta_en' 'meta_de' \
		'$IMAGE_PATH' $PRICE $MANUFACTURER_ID $CATEGORY_ID '$COLOR' '$COLOR' '$MILEAGE' '$MILEAGE' '$KW' '$KW' \
		'$TRANSMISSION' '$TRANSMISSION' '$FUEL' '$FUEL' '$EZ' '$EZ'

done < "$FILE"

