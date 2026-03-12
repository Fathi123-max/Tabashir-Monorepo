#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_pdf_text.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_pdf_text'
  s.version          = '0.0.1'
  s.summary          = 'Extract text from PDF files directly on-device.'
  s.description      = <<-DESC
Flutter plugin exposing PDF text extraction utilities powered by PDFKit on iOS.
                       DESC
  s.homepage         = 'https://github.com/AlessioLuciani/flutter-pdf-text'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Alessio Luciani' => 'alessio@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
