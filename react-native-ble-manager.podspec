require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.authors      = package['author']
  s.homepage     = package['homepage']
  s.license      = package['license']
  s.platform     = :ios, '10.0'
  s.source       = { :git => "https://github.com/barakataboujreich/react-native-ble-advertise.git", :tag => "#{s.version}" }
  s.source_files	= "ios/**/*.{h,m}"

  s.dependency 'React-Core'
end
