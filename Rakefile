# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

require 'motion-cocoapods'
require 'yaml'
begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'auth-motion'
  app.identifier = "auth-motion"  
  app.weak_frameworks += %w{ AdSupport Accounts Social }
  social_config = YAML.load_file(File.join(File.dirname(__FILE__),'social.yaml'))
  app.info_plist['FacebookAppID'] = social_config['facebook']['app_id']
  app.info_plist['Application requires iPhone environment']=true
  app.info_plist['URL types'] = { 'URL Schemes' =>social_config['facebook']['url_scheme']}
  app.info_plist['CFBundleURLTypes'] = [
     { 'CFBundleURLSchemes' => [social_config['facebook']['url_scheme']] }
   ]
  app.pods do
    pod 'Facebook-iOS-SDK'
  end

end
