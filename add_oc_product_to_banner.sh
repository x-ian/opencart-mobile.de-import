#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
    exit
fi

source ./config.txt

mysql -u $MYSQL_USER -p$MYSQL_PASSWD opencart <<EOF

SET @title := '$1';
SET @link := '$2'; 
SET @image := '$3';

select max(banner_image_id)+1 into @next_banner_image_id from oc_banner_image;

INSERT INTO oc_banner_image SET banner_image_id=@next_banner_image_id, banner_id=7, link=@link, image=@image, sort_order=0;
INSERT INTO oc_banner_image_description SET banner_image_id=@next_banner_image_id, language_id=1, banner_id=7, title=@title;
INSERT INTO oc_banner_image_description SET banner_image_id=@next_banner_image_id, language_id=2, banner_id=7, title=@title;

EOF
