#!/bin/bash
set -e

rm -rf /etc/nginx/conf.d/*
BASEDIR=$(dirname "$0")
MAGENTO_SERVER_FILE=$BASEDIR/nginx/sites-enabled/"${SERVER_NAME}".conf
cp $BASEDIR/nginx/sites-enabled/default.m2.conf $MAGENTO_SERVER_FILE

[ ! -z "${PHP_HOST}" ]                 && sed -i "s%_PHP_HOST_%${PHP_HOST}%g" $MAGENTO_SERVER_FILE
[ ! -z "${PHP_PORT}" ]                 && sed -i "s%_PHP_PORT_%${PHP_PORT}%g" $MAGENTO_SERVER_FILE
[ ! -z "${APP_MAGE_MODE}" ]            && sed -i "s%_APP_MAGE_MODE_%${APP_MAGE_MODE}%g" $MAGENTO_SERVER_FILE
[ ! -z "${PROJECT_ROOT}" ]                && sed -i "s%_PROJECT_ROOT_%${PROJECT_ROOT}%g" $MAGENTO_SERVER_FILE
[ ! -z "${SERVER_NAME}" ]      && sed -i "s%_SERVER_NAME_%${SERVER_NAME}%g" $MAGENTO_SERVER_FILE

mkdir -p /etc/nginx/sites-enabled/
ln -s $MAGENTO_SERVER_FILE /etc/nginx/sites-enabled/"${SERVER_NAME}".conf

/usr/sbin/nginx -g "daemon off;"