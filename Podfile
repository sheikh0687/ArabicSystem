# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ArabicSystem' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ArabicSystem

pod 'R.swift', '~> 5.4.0'
  
pod 'IQKeyboardManagerSwift'
pod 'CountryPickerView'

pod 'DropDown'
pod 'Cosmos'

pod 'Alamofire', '~> 4.9.1'

#pod 'PayTabsSDK', '~> 6.6.9'
pod 'PaylinkGateway', :git => 'https://github.com/Paylink-sa/PLPaymentGatewayPod.git'

pod 'SDWebImage/WebP'

pod 'LanguageManager-iOS'

pod 'Firebase/Core'
pod 'Firebase/Messaging'
pod 'Firebase/Storage'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    # Fix libarclite_xxx.a file not found.
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
