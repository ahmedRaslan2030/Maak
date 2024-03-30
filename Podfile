# Uncomment the next line to define a global platform for your project
 platform :ios, '15.0'

source 'https://github.com/CocoaPods/Specs.git'



target 'Maak' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UIKit Tempelate app

pod 'Alamofire', '~> 5.2'
pod 'Kingfisher', '~> 6.0'
pod 'Firebase/Messaging'
pod 'IQKeyboardManagerSwift'
pod 'IQKeyboardManager'
pod 'CombineCocoa'
pod 'CombineDataSources'
pod 'SkeletonView'
pod 'lottie-ios'
pod 'MaterialComponents'
pod 'GoogleMaps'
pod 'GooglePlaces'
pod 'Socket.IO-Client-Swift'

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end

end
