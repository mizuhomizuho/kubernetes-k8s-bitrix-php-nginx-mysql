#!/bin/sh

if [ "$(php-fpm -v | grep "^PHP\s" | sed "s@PHP\s.*@OK@")" != "OK" ]; then
  echo "BAD"
  exit 1
fi

echo "GOOD"
exit 0