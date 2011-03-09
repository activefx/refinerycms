run 'rm .gitignore'
#create_file '.gitignore' do
#<<-FILE
## Rails
#.bundle
#db/*.sqlite3
#db/*.sqlite3-journal
#*.log
#tmp/**/*

## Database
#config/database.yml
#config/mongoid.yml

## Configuration Files
#config/amazon_s3.yml
#config/rackspace_cloudfiles.yml
#config/app.rb

## Documentation
#doc/api
#doc/app
#.yardoc
#.yardopts

## Public Uploads
##public/system/**/**/**/*
#public/system/*
#public/themes/*

## Public Cache
#public/javascripts/cache
#public/stylesheets/cache

## Vendor Cache
#vendor/cache

## Mac
#.DS_Store

## Windows
#Thumbs.db

## NetBeans
#nbproject

## Eclipse
#.project

## Redcar
#.redcar

## Rubinius
#*.rbc

## Vim
#*.swp
#*.swo

## RubyMine
#.idea

## Backup
#*~

## Capybara Bug
#capybara-*html

## sass
#.sass-cache
#.sass-cache/*

##rvm
#.rvmrc
#.rvmrc.*
#FILE
#end

