# README #

### What is this repository for? ###

This repository contains theme projects for the CMAP Liferay DXP instance.

### How do I get set up? ###

* Clone this repository into your Liferay `themes` directory.
* Check out [Liferay Themes and Layout Templates](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/introduction-to-themes) in the Liferay documentation.
* Install Node.js, Yeoman, and gulp. See [Install the Liferay Theme Generator](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/introduction-to-themes) for more info.
* Run `npm install` in each theme's root directory.
* Add a `liferay-theme.json` file to each theme's root directory: 

>     {
>       "LiferayTheme": {
>         "appServerPath": "[bundle path]/tomcat-8.0.32",
>         "deployPath": "[bundle path]/deploy",
>         "url": "http://localhost:8080",
>         "appServerPathPlugin": "[bundle path]/webapps/[theme project name]",
>         "deployed": false,
>         "pluginName": "[theme project name]"
>       }
>     }

### Contribution guidelines ###

### Who do I talk to? ###