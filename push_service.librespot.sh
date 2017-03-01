#!/bin/bash

cp -pu /home/shane/build_dir/LibreELEC.tv/packages/addons/service/librespot/* /home/shane/build_dir/service.librespot/

git add .

echo "Enter commit title"
read title

git commit -m "$title"

git push origin master
