# CMAP ON TO 2050 Theme

Server lifecycle:
-----------------
systemctl stop qa-liferay-4p
systemctl start qa-liferay-4p

server login:
-------------
ssh thirst@localhost -p 26

locally:
--------
scp -P 26 dist/cmap-onto-2050-theme.war thirst@localhost:~

on server:
----------
sudo chown jboss:adm cmap-onto-2050-theme.war && sudo mv cmap-onto-2050-theme.war /webapps/qa-liferay-4p/liferay-dxp-digital-enterprise-7.0-sp4/deploy