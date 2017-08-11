# README #

### What is this repository for? ###

This repository contains theme projects for the CMAP Liferay DXP instance.

### How do I get set up? ###

* Clone this repository into your Liferay "themes" directory.

        git clone git@bitbucket.org:workstate-code/cmap-liferay-dxp-themes.git .

    or

        git clone https://[user]@bitbucket.org/workstate-code/cmap-liferay-dxp-themes.git .

    The . at the end will clone the project into your current directory, without creating the "cmap-liferay-dxp-modules" directory.

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

* To deploy a theme locally, run `gulp deploy` in the theme's root directory. 
   
    The theme's WAR file will be generated in the theme's "dist" directory, then deployed to the deployPath specified in the theme's "liferay-theme.json" file.

* To deploy a theme to the server:

    1. Run `gulp deploy` in the theme's root directory. 
    2. Copy the theme's WAR file from the theme's "dist" directory to the "deploy" directory on the server. For the DXP sandbox, the path is /webapps/liferay-2p/liferay-dxp-digital-enterprise-7.0-sp2/deploy.
    3. Update permissions on the remote WAR file to make it writable -- 646 should work. 
    4. Watch the logs to make sure the theme has been successfully deployed. You should see a line similar to this in the logs: 
        
        > 17:36:29,050 INFO  [Refresh Thread: Equinox Container: a0e0c2f0-0a73-0017-15d1-964ebca560be][BundleStartStopLogger:35] STARTED cmap-2017-theme_1.0.0 [533]

### Contribution guidelines ###

### Who do I talk to? ###
