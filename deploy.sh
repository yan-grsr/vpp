#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 

echo -e "${BLUE}Configuration d'asterisk...${NC}"

if [ "$EUID" -ne 0 ]; then
  echo "utilisez sudo: sudo ./deploy.sh"
  exit 1
fi

cp pjsip.conf /etc/asterisk/pjsip.conf
cp extensions.conf /etc/asterisk/extensions.conf

chown asterisk:asterisk /etc/asterisk/pjsip.conf /etc/asterisk/extensions.conf 2>/dev/null || true

asterisk -rx "dialplan reload"
asterisk -rx "pjsip reload"

echo -e "${GREEN}success.${NC}"
