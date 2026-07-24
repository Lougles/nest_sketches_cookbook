#!/bin/bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

cd /var/www/{{ project_name }}/current || exit 1
npm run cron:remove-products
