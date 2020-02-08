#
#  Be sure to run `pod spec lint BaseMVP.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

spec.name         = "BaseMVP"
spec.version      = "0.0.1"
spec.summary      = "BaseMVP is an MVP Base template used to simplifiy MVP Architectured Apps."
spec.swift_version = "4.2"

spec.description  = "BaseMVP is an MVP Base template used to simplifiy MVP Architectured Apps, which can be implemented in a matter of seconds."

spec.homepage     = "https://github.com/Sanadbarjawi/BaseMVP"
# spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

spec.license      = "MIT"
spec.license      = { :type => "MIT", :file => "LICENSE" }
spec.author       = "Sanad Barjawi"

spec.platform     = :ios
spec.ios.deployment_target = "11.0"
spec.source = { :git => "https://github.com/Sanadbarjawi/BaseMVP.git",:branch => "master", :tag => "#{spec.version}" }

spec.ios.vendored_frameworks = 'output/BaseMVP.framework'
spec.exclude_files = "BaseMVP/**/*.plist"
#spec.source_files  = "BaseMVP/**/*", "BaseMVP/**/*.{h,m}"
end
