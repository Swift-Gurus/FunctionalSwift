#
#  Be sure to run `pod spec lint FunctionalSwift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name             = 'AHFunctionalSwift'
s.version          = '0.2.5'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.homepage         = 'https://github.com/Swift-Gurus/FunctionalSwift.git'
s.author           = { 'AlexHmelevskiAG' => 'alex.hmelevski@gmail.com' }
s.summary          = 'Easy framework for EitherMonad'
s.source           = { :git => 'https://github.com/Swift-Gurus/FunctionalSwift.git', :tag => s.version.to_s }
s.module_name  = 'AHFunctionalSwift'

s.ios.deployment_target = '11.0'
s.osx.deployment_target  = '12.0'
s.swift_version = '5.0'
s.source_files = 'Sources/**/*'
end
