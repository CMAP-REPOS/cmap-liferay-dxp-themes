# README #

### What is this repository for? ###

This repository contains theme projects for the CMAP Liferay DXP instance.

### How do I get set up? ###

1. Clone this repository into your Liferay "themes" directory.

        git clone git@bitbucket.org:workstate-code/cmap-liferay-dxp-themes.git .

    or

        git clone https://[user]@bitbucket.org/workstate-code/cmap-liferay-dxp-themes.git .

    The "." at the end will clone the project into your current directory, without creating the "cmap-liferay-dxp-themes" directory.

2. Check out [Liferay Themes and Layout Templates](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/introduction-to-themes) in the Liferay documentation.

3. Install [Node.js](https://nodejs.org/en/), [Yeoman](http://yeoman.io/), and [gulp](https://gulpjs.com/). See [Install the Liferay Theme Generator](https://dev.liferay.com/develop/tutorials/-/knowledge_base/7-0/introduction-to-themes) for more info.

### How do I manually publish themes? ###

1. Update the "deployPath" value in the theme's liferay-theme.json file, if the it is not already your local liferay-dxp-digital-enterprise-7.0-sp4/deploy directory. For example:

    > {
    >   "LiferayTheme": {
    >     "deployPath": "/Workstate/Projects/CMAP/LiferayDeveloperStudio/liferay-dxp-digital-enterprise-7.0-sp4/deploy",
    >     "themeName": "cmap-2017-theme",
    >     "appServerPathTheme": "/Workstate/Projects/CMAP/LiferayDeveloperStudio/liferay-workspace/bundles/tomcat-8.0.32/webapps/cmap-2017-theme",
    >     "deployed": true,
    >     "appServerPath": "/Workstate/Projects/CMAP/LiferayDeveloperStudio/liferay-workspace/bundles/tomcat-8.0.32"
    >   }
    > }

2. To build a theme, run `gulp build` in the theme's root directory.

3. To deploy a theme, run `gulp deploy` in the theme's root directory.

    The theme's WAR file will be generated in the theme's "dist" directory, then deployed to the deployPath specified in the theme's "liferay-theme.json" file. Liferay will automatically publish the theme.

### How do I auto-publish themes? ###

1. Add the theme project to your server's published resources.

    You can drag the project from the Project Explorer to the server in the Servers pane, or right-click the server in the Servers pane and select "Add and Remove..." from the context menu.

2. Once the theme is a published resource, Liferay Developer Studio will automatically rebuild and republish it any time files in the "src" directory are updated.

### How do I deploy a theme to the server? ###

1. Run `gulp deploy` in the theme's root directory.
2. Copy the theme's WAR file from the theme's "dist" directory to the "deploy" directory on the server. For the DXP sandbox, the path is /webapps/liferay-2p/liferay-dxp-digital-enterprise-7.0-sp2/deploy.
3. Update permissions on the remote WAR file to make it writable -- 646 should work.
4. Watch the logs to make sure the theme has been successfully deployed. You should see a line similar to this in the logs:

    > 17:36:29,050 INFO  [Refresh Thread: Equinox Container: a0e0c2f0-0a73-0017-15d1-964ebca560be][BundleStartStopLogger:35] STARTED cmap-2017-theme_1.0.0 [533]

### Contribution guidelines ###

### Who do I talk to? ###
