#!/bin/sh

if [ "$(mysql -h $HOSTNAME -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SELECT 1 as 'OK'" | grep OK)" != "OK" ]; then
  echo "BAD"
  exit 1
fi

echo "GOOD"
exit 0