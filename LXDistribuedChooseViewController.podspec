#
#  Be sure to run `pod spec lint LXDistribuedChooseViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LXDistribuedChooseViewController"
  s.version      = "0.0.1"
  s.summary      = "LXDistribuedChooseViewController."
  s.homepage     = "https://github.com/livesxu/LXDistribuedChooseViewController"
  s.license      = "MIT"
  s.author       = { "livesxu" => "livesxu@163.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/livesxu/LXDistribuedChooseViewController.git", :tag => s.version }
  s.source_files  = "LXDistribuedChooseViewController"
  s.frameworks = "UIKit"
  s.requires_arc = true
  
end
