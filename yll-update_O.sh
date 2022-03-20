#!/bin/sh
# chmod +x yll-update_O.sh

iName=$(find / -iname upgrade.sh | xargs grep -li 'checkoutConfirm()')
iPath=$(echo $iName | sed 's_upgrade.sh__')
cd $iPath; echo "yes" | bash upgrade.sh;
composer install;composer update;php think migrate:run;cd #防止报错
