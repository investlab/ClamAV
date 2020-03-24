#!/bin/bash
# by ThaoPT form NextSec.vn (.io)
mkdir -p /var/log/clamav/
LOGFILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').log";
EMAIL_MSG="Xem log trong file dinh kem.";
EMAIL_FROM="system@peacesoft.net";
EMAIL_TO="thaopt@peacesoft.net";
DIRTOSCAN="/var/www /var/vmail";

for S in ${DIRTOSCAN}; do
 DIRSIZE=$(du -sh "$S" 2>/dev/null | cut -f1);

 echo "Bat dau quet hang ngay cua thu muc "$S" .
 Luong du lieu can quet la "$DIRSIZE".";

 clamscan -ri "$S" >> "$LOGFILE";

 # Mau du lieu bi lay nhiem - "Infected lines"
 MALWARE=$(tail "$LOGFILE"|grep Infected|cut -d" " -f3);

 # Gui mail va file.
 if [ "$MALWARE" -ne "0" ];then
 # using heirloom-mailx below
 echo "$EMAIL_MSG"|mail -a "$LOGFILE" -s "Malware Found" -r "$EMAIL_FROM" "$EMAIL_TO";
 fi 
done

exit 0