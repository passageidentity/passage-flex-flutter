Pod::Spec.new do |s|
  s.name             = 'passage_flex_flutter'
  s.version          = '0.1.1'
  s.summary          = 'Passkey authentication for your Flutter app'
  s.description      = <<-DESC
  Passkey authentication for your Flutter app
                       DESC
  s.homepage         = 'http://passage.id'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Passage' => 'hello@passage.id' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'PassageFlex', '1.0.0'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
