#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint geocoding.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'geocoding_darwin'
  s.version          = '1.0.5'
  s.summary          = 'A Flutter Geocoding plugin which provides easy geocoding and reverse-geocoding features.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Baseflow' => 'hello@baseflow.com' }
  s.source           = { :path => '.' }
  s.source_files = 'geocoding_darwin/Sources/**/*'
  s.public_header_files = 'geocoding_darwin/Sources/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.resource_bundles = {'geocoding_darwin_privacy' => ['geocoding_darwin/Sources/PrivacyInfo.xcprivacy']}
end
