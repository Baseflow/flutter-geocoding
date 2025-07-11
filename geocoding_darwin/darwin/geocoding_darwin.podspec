#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint geocoding_darwin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'geocoding_darwin'
  s.version          = '0.0.1'
  s.summary          = 'Flutter Geocoding.'
  s.description      = <<-DESC
A Flutter plugin to convert an address into geocoordinates (geocoding) and reverse.
Downloaded by pub (not CocoaPods).
                       DESC
  s.homepage         = 'http://github.com/baseflow/flutter-geocoding'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Baseflow' => 'hello@baseflow.com' }
  s.source           = { :http => 'https://github.com/baseflow/flutter-geocoding/tree/main/geocoding_darwin' }
  s.source_files = 'geocoding_darwin/Sources/geocoding_darwin/**/*.swift'
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.15'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.xcconfig = {
    'LIBRARY_SEARCH_PATHS' => '$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)/ $(SDKROOT)/usr/lib/swift',
    'LD_RUNPATH_SEARCH_PATHS' => '/usr/lib/swift',
  }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  s.resource_bundles = {'geocoding_darwin_privacy' => ['geocoding_darwin/Sources/geocoding_darwin/PrivacyInfo.xcprivacy']}
end

