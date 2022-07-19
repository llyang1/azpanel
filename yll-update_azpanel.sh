#!/bin/sh
# chmod +x update_azpanel.sh

iName=$(find / -iname upgrade.sh | xargs grep -li 'checkoutConfirm()')
iPath=$(echo $iName | sed 's_upgrade.sh__')
cd $iPath; echo "yes" | bash upgrade.sh;
composer install;composer update;php think migrate:run;cd #防止报错

#使用英文win11/win10
myPHP=$(find / -iname "AzureList.php"); echo $myPHP
sed -i 's_win11-21h2-pro-zh-cn_win11-21h2-entn_' $myPHP
sed -i 's_win10-21h2-pro-zh-cn-g2_win10-21h2-entn-g2_' $myPHP
sed -i 's|Ubuntu_20_04|Ubuntu_22_04|' $myPHP
sed -i 's|Ubuntu 20.04|Ubuntu 22.04|' $myPHP
sed -i 's|20_04-lts-gen2|22_04-lts-gen2|' $myPHP
sed -i 's|0001-com-ubuntu-server-focal|0001-com-ubuntu-server-jammy|' $myPHP
#lnmp restart

#json格式修改
myPHP=$(find / -iname "*.php" | xargs grep -li "subscriptionId" | grep -v temp)
sed -i "/configs[[]/s_appId[']_clientId\'_" $myPHP
sed -i "/configs[[]/s_tenant[']_tenantId\'_" $myPHP
sed -i "/configs[[]/s_password[']_clientSecret\'_" $myPHP
grep "clientId" $myPHP;grep "tenantId" $myPHP;grep "clientSecret" $myPHP

#让每行显示100条。默认15
iName=$(find / -iname .env | xargs grep -li 'APP_NAME')
sed -i '/PAGINATE/d' $iName
sed -i '/APP_NAME/ s;$;\nPAGINATE = 100;' $iName

lnmp restart

