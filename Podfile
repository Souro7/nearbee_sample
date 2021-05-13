# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'NearBeeSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'NearBee', '3.2.12'
  pod 'Imaginary'
  pod 'EddystoneScanner'
  pod 'Socket.IO-Client-Swift', '15.2.0'

end

post_install do |installer|
        installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
          end
        end
      end
