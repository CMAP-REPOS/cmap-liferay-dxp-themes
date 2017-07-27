# README #

### What is this repository for? ###

This repository contains theme projects for the CMAP Liferay DXP instance.

### How do I get set up? ###

* Clone this repository into your Liferay "themes" directory.

  `clone git@bitbucket.org:workstate-code/cmap-liferay-dxp-themes.git .`

* Check out [Liferay Themes and Layout Templates](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/introduction-to-themes) in the Liferay documentation.
 
* Install [Node.js](https://nodejs.org/en/), [Yeoman](http://yeoman.io/), and [gulp](https://gulpjs.com/). See [Install the Liferay Theme Generator](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/introduction-to-themes) for more info.

* Run `npm install` in each theme's root directory. The node_modules directory is in .gitignore.

* Add a "liferay-theme.json" file to each theme's root directory: 

       {
         "LiferayTheme": {
          "appServerPath": "[bundle path]/tomcat-8.0.32",
          "deployPath": "[bundle path]/deploy",
          "url": "http://localhost:8080",
          "appServerPathPlugin": "[bundle path]/webapps/[theme project name]",
          "deployed": false,
          "pluginName": "[theme project name]"
        }
      }

  This file is part of Liferay's default .gitignore for theme projects and should be different for each local environment.

  The "[bundle path]" value is the path to Tomcat's parent directory.
  
  The "[theme project name]" value is the same as the theme's root folder (e.g., "cmap-2017-theme"). 

### How do I build and deploy themes? ###

* To build a theme, run `gulp build` in the theme's root directory.

* To deply a theme, run `gulp deploy` in the theme's root directory. The theme's WAR file will be deployed to the deployPath specified in the theme's "liferay-theme.json" file.

### Contribution guidelines ###

### Who do I talk to? ###