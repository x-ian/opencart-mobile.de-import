#!/bin/bash

# bash -x ./a.sh 60 '' 'name_en' 'name_de' 'desc en' 'desc de' 'meta_en' 'meta_de' 'image' 888888 12 -1 'coloren' 'color_de' 'miles en' 'miles de' 'ps en' 'ps de' 'transmission en' 'transmission de' 'fuel en' 'fuel de' 'jahr en' 'jahr de'

if [ "$#" -ne 24 ]; then
    echo "Illegal number of parameters"
    exit
fi

source ./config.txt

mysql -u $MYSQL_USER -p$MYSQL_PASSWD opencart <<EOF

SET @id := $1;
SET @inventory_id := '$2';
SET @name_en := '$3';
SET @name_de := '$4';
SET @desc_en := '$5';
SET @desc_de := '$6';
SET @metatag_en := '$7';
SET @metatag_de := '$8';
SET @image_path := '$9'; 
SET @price := ${10};

SET @manufacturer_id := ${11};
SET @category := ${12};	
SET @color_en := '${13}';
SET @color_de := '${14}';
SET @mileage_en := '${15}';
SET @mileage_de := '${16}';
SET @kw_en := '${17}';
SET @kw_de := '${18}';
SET @transmission_en := '${19}';
SET @transmission_de := '${20}';

SET @fueltype_en := '${21}';
SET @fueltype_de := '${22}';
SET @baujahr_en := '${23}';
SET @baujahr_de := '${24}';

INSERT INTO oc_product VALUES 
  (@id,@inventory_id,'','','','','','','',1,7,@image_path,
  @manufacturer_id,0,@price,0,0,CURDATE(),0.00000000,1,
  0.00000000,0.00000000,0.00000000,1,1,0,1,1,475,NOW(),NOW());
INSERT INTO oc_product_attribute VALUES 
  (@id,17,1,@baujahr_en), (@id,17,2,@baujahr_de),
  (@id,18,1,@mileage_en), (@id,18,2,@mileage_de),
  (@id,19,1,@kw_en), (@id,19,2,@kw_de),
  (@id,20,1,@transmission_en), (@id,20,2,@transmission_de),
  (@id,21,1,@color_en), (@id,21,2,@color_de);
INSERT INTO oc_product_description VALUES 
  (@id,1,@name_en,@desc_en,'',@metatag_en,'',''),
  (@id,2,@name_de,@desc_de,'',@metatag_de,'','');
INSERT INTO oc_product_to_category VALUES (@id,@category);
INSERT INTO oc_product_to_layout VALUES (@id,0,0);
INSERT INTO oc_product_to_store VALUES (@id,0);

EOF
