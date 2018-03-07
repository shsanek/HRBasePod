#
#  Be sure to run `pod spec lint HRBasePod.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.ios.deployment_target = '10.0'
  s.name         = "HRBasePod"
  s.version      = "0.1.0"
  s.summary      = "HRLog pof for custom loger"
  s.description  = "HRLog pod for custom log and visual debuger and sending bag reports"
  s.license      = "MIT"
  s.author             = { "shsanek" => "ssanek212@gmail.com" }
  s.source       = { :git => "https://github.com/shsanek/HRBasePod.git", :tag => "0.3.4" }
  s.source_files  = "HRBasePod", "HRBasePod/**/*.{h,m}"
  s.resources = ["HRLog/**/*.storyboard"]
  s.public_header_files = "HRBasePod/**/*.h"
  s.homepage = "https://github.com/shsanek/HRBasePod";
  s.prefix_header_contents = '#import <HRBasePod/HRCore.h>'

end
