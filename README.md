#zipe-cms

##Objective: Develop a Zype CMS Web App##

###Background
Zype provides a platform that allows content creators to publish and monetize all of their video content using a single interface. The creator can better understand how their content is consumed in order to expand their audiences and optimize it for monitization. Zype also provides the ability to distribute their video content across their own branded video destinations on all devices and platforms.

###Create an Example Web Channel App
The goal of this project is to create a an exmaple application using the latest features and benfits Rails 5. The app will leverage an open-source version of the zype-cli to make accessing Zype API easy and extensible for special client needs. Finally to make creation and editing of the client specific look and feel, creatives, custom subscriptoin managemement and other needs easy to customize, the Fae-cms is use to make the Zype app a Zype-CMS. 

###Architecture Overview
Zype has a very robust and full features API. This allow the clients to use any or all parts of the Zype platform they want while leaving the flexibility to continue to use their own custom system or 3rd parties to perform desired functions.

####Functionality
1. Responsive videos homepage and about page with customizable copy.
2. A paywall that requires the consumer to login in order to see content on the video details pages. This page will also have a registration link for new users.
3. A video details page that shows some of the video meta-data and a player to view the video. Videos that require a subscription will be not play but rather directed the consumer to purchase page if they do not have a subscription.

####Zype API
1. Zype-cli: This is a gem that wraps the Zype restful API using httparty as the client. 
2. The 1.0.0 version of the gem provides a decent range of the models and enpoints availble in the Zype API. 
3. Rahter than re-invent the wheel, we fork off Zipe-cli and extend it as needed. 
4. The Zype-cli was designed to support clients editing and accessing their content. So , the only major change required for this initial implementation of Zype-CMS is to support consumer use as well.

####Service
While most of the functionality we need is avilable in the Zype-cli, in order to insulate the Zype-cms from changes and provide a more customizable interface for the Zype-Cms, the cli will be wrapped in a zype service class. Needed endponts will be wrapped in easy to use methods of type zype service.

1. Login
2. Video List
3. Video Detail

####Directory Structure
The main directory being used in the Rails 5 app directory include:

* assets (leverages ConfeeCup and Foundataion.js)
   * fonts
   * images
   * javascript
   * sytlesheets 
* controllers
   * admin (Fae-cms controllers for admin functions)
   * videos (wrap the zype-cli video endpoints)
   * static_pages (leverage the fae-cms content) 
   	   * index (home page)
   	   * show (detail page)
   	   * login (super simple login route)
   	   * logout
   	   * Very basic auth stuff. Should be changed to leverage the Devise that comes with fae-cms...
   	   
* models
  * Simple Video and ZypeModel to begin abstracting the model and business logic out of the controllers. Much more to be done....
* services
	* ZypeCli (wrapper for Zype-cli) 	
* views
  * admin (Fae-cms views for admin)
  * static_pages
    * These don't yet leverage the fae-cms capabilities but a little work would make the content configurable use fae admin screens. Admin is found at /admin and requires a user and password to access.


####Controllers
The most important controller for this implementation will be the video controller which provides both the index and show (detail) view of a video. The controller will call the Zype service and manage access and subscriptions for the views.

####Fae CMS
The Fae CMS provides the framework for any administration, user setup and static page content management. In addition to an admin namespace where all the admin models and controllers are placed, we add a static_pages_controller to manage the static  pages and navigation for the Zype-cms.

####Tools
1. This app uses Slim templating in palce of the default Erb.
2. For testing, Rspec is used along with factory-girl, faker and database_cleaner to make it easy!
3. Capistrano is added and configured for deploying. 

####What you need to get started

* A Ruby development environment with Ruby version >=2.4.0
* A database ready to migrate tables into
* Some basic site assets (HTML and CSS) for your home and about page. We use a CoffeCup Responsive Site Deisnger to quickly create the content for the Zype-cms . 


##How this was built

1. Create a new project locally   
`rails new  zype-cms`
2. Add the *fae-rails* gem to the Gemfile   
`# The Rails CMS`  
`gem 'fae-rails'`
4. Add the *slim* gem to generate slim rather than erb views. `# Use SLIM for HTML`   
`gem 'slim-rails', '~> 3.1'`
5. Add *redcarpet*, to allow us to use markdown in our text field content. Fae-cms provides a markdown editor out of the box.   
`# Used to render markup text fields as HTML`
`gem 'redcarpet', '~> 3.4'`
6. Add *capistrano* for deploying to a server.
`group :development do`
`# deploying`
  `gem 'capistrano', '~> 3.6'`
  `gem 'capistrano-rails', '~> 1.1'`
  `gem 'capistrano-rvm'`
  `gem 'capistrano3-puma'`
  `gem 'capistrano3-nginx'`
  `gem 'capistrano-upload-config'`
7. Add *rspec-rails* 
`group :development, :test do`
`  gem 'rspec-rails', '~> 3.5'`
8. Add other *testing* gems
`group :test do`
  `gem 'factory_girl_rails', '~> 4.0'`
  `gem 'shoulda-matchers', '~> 3.1'`
  `gem 'faker'`
  `gem 'database_cleaner'`
end
7. Run bundler   
`bundle`
`Note I had some issues on OSX and had to install an older version of image magic to get the native builds to succeed`
8. Initialize rspec 
`rails g rspec:install`
9. Initialize and generate the fae-cms code and tables.   
`rails g fae:install` 
`rails fae:seed_db`  
10. Convert the `app/views/layouts` generated as `*.html.erb` to `.html.slim`. This releates to three files: `application.html.slim, mailer.html.slim, mailer.text.slim` 
11. Started up the server.   
`rails s`
12. Setup the fae-cms super-user in the browser. Fae-cms has a first time init user page.
`http://localhost:3000/admin`
`user: Daniel Brandt, dbbrandt@gmail.com:password`

####Add in the generated CofeeCup Design Assets
1. Design the site in Responsive Site Designer by CoffeeCup
2. Save and Export the site to the *design* folder int he project
3. Copy the CoffeeCup font files to assets/fonts
    * Add link to google fonts to the laytout/application.html.slim header    `link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Luckiest+Guy%7CMontserrat%7CMouse+Memoirs%7COxygen+Mono"`

4. Copy the javascript files to *assets/javascript*
   * foundation.js
   * outofview.js
   * picturefill.js
   * what-input.js
5. Copy the style sheets to *assets/stylesheets*
   * foundation.css
   * main.css
   * wirefream-theme.css
6. Create the *views/static_pages* directory and migrate the html content to slim files
    * home.html.slim
    * show.html.slim
    * _feature.html.slim
    * _video.html.slim
7. Create the *views/shared* directory for the menu and footer partials.
    * _menu.html.slim
    * _footer.html.slim
8. Convert the css to scss in order to add asset pipline functions.
    * For example:
    `src: url('../fonts/coffeecup-font-icons.eot?#iefixcc-w484d8'`  
    `becomes: `   
    `src: asset_url('coffeecup-font-icons.eot?#iefixcc-w484d8')`

#### Complete basic navigation and screens
Complete basic navigation and flow for subscriptions
   * Home page 
   * Detail Page
   * Subscription logic

#### Integrate zype-cli
1. Install zype-cli version forked to dbbrandt, branch 'app-cli' which adds some functionality to support an app_key in addition to an api_key.   
2. Add zype.rb to initializers to setup zype configuration.
3. Set the app_key in the environment.
`export ZYPE_APP_KEY=<your app key`
4. Create a .zype config file (YAML format) in the rails root directory.
`---`
`api_key:`
`app_key:`
`client_id:` 
`client_secret: 
`host: api.zype.com
`oauth_host: login.zype.com
`port: 443
`use_ssl: true
5. Set the HOME environment variable to point to the rails root directory.
`export HOME=<Rails.root> # replace Rails.root with the actual path`
6. While testing change to the zype-cli branch without version changes you need to do `bundle update zype` to get the latest changes from the repo.
7. Create ZypeCli service which encapsulates calls to zype-cli, handles exeptions other details.
8. Create ZypeModel, a base class for videos and other models generated from zype. The next step would be to conver the zype video records into more useful model objects with appropirate attributes and business methods as funtionality grows.
9. Create the Video model which handles the video requests from the controllers.    

    
####Setup Capistrano Deploy
1. Run `cap install`
2. Modify `Capfile` in the root directory
Uncomment:  
require 'capistrano/rvm'  
require 'capistrano/bundler'  
require 'capistrano/rails/migrations'  
require 'capistrano/rails/assets’  
Add:  
require 'capistrano/nginx'  
require 'capistrano/puma'  
require 'capistrano/puma/nginx'  
require 'capistrano/upload-config’  
Add:  
the following plugins to the bottom of the Capfile  
install_plugin Capistrano::Puma  # Default puma tasks  
workers (in cluster mode)
install_plugin Capistrano::Puma::Jungle # if you need the jungle tasks  
install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template  
3. Modify config/deploy.rb for the app details.
4. Generate the nginx_puma config files  
`rails g capistrano:nginx_puma:config`    
`Running via Spring preloader in process 36719`  
`      create  config/deploy/templates/puma.rb.erb`  
`      create  config/deploy/templates/nginx_conf.erb`  
5. Create the database.production.yml, secrets.production.yml and puma.production.yml config files
6. Create the nginx config file on the server (/etc/nginx/conf.d/zype-cms_production.conf)
7. Check the productioncap  config
`cap production config:check`   
8. Update 'config/deploy/production.rb' for the server and role
`server "www.precidix.com", user: "precidix", roles: %w{app db web}`
`role   :app,  %w{precidix@www.precidix.com}`  
9. Create config/database.yml.example and config/database.yml.production.example
10. Run cap production config:push to copy the shared config files.
11.  
