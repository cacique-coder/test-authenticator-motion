# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

require 'motion-cocoapods'

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

  app.info_plist['FacebookAppID'] = "492234074208492"
  app.info_plist['Application requires iPhone environment']=true
  app.info_plist['URL types'] = { 'URL Schemes' =>'fc6931292f8b4c2528f060f321adae28'}
  app.info_plist['CFBundleURLTypes'] = [
     { 'CFBundleURLSchemes' => ["fc6931292f8b4c2528f060f321adae28"] }
   ]
  app.pods do
    pod 'Facebook-iOS-SDK'
  end

end
