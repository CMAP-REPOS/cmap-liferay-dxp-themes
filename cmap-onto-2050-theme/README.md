# CMAP ON TO 2050 Theme

Welcome to the jungle.

server login:
-------------
ssh thirst@localhost -p 26


locally:
--------
scp -P 26 dist/cmap-onto-2050-theme.war thirst@localhost:/webapps/qa-liferay-4p/liferay-dxp-digital-enterprise-7.0-sp4

on server:
----------
sudo chown jboss:adm cmap-onto-2050-theme.war && sudo mv cmap-onto-2050-theme.war deploy

=========================================================================================

locally:
--------
scp -P 26 build/libs/com.cmap.ckeditor-1.0.0.jar thirst@localhost:/webapps/qa-liferay-4p/liferay-dxp-digital-enterprise-7.0-sp4

on server:
----------
sudo chown jboss:adm com.cmap.ckeditor-1.0.0.jar && sudo mv com.cmap.ckeditor-1.0.0.jar deploy
