#
#  Be sure to run `pod spec lint Sakai.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#

Pod::Spec.new do |s|

  s.name         = "Sakai"
  s.version      = "0.0.6"
  s.summary      = "Sakai-iOS provides an easy way to build out a Sakai LMS learning experience."
  s.description  = <<-DESC
Sakai-iOS provides an easy way to build out a Sakai LMS learning experience within an iOS app.
Sakai-iOS is currently in Alpha and has limited support for the Sakai `/direct` API. Refer to the docs and issues for more informations.
                    DESC

  s.homepage     = "https://github.com/alihen/Sakai-iOS"

  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = "Alastair Hendricks"
  s.social_media_url = "http://twitter.com/ali_hen"

  s.platform = :ios, "11.0"

  s.source = { :git => 'https://github.com/alihen/Sakai-iOS.git', :tag => s.version.to_s }
  s.source_files  = "Sakai/**/*.{swift}"
  
  s.dependency "Moya", "13.0.1"
  s.swift_version = "5.0"

end
