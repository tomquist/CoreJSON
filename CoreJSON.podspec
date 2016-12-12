Pod::Spec.new do |s|
  s.name         = "CoreJSON"
  s.version      = "1.0.0"
  s.summary      = "Core JSON data model and utilities"
  s.description  = <<-DESC
    CoreJSON provides a simple JSON data model and on top of it serveral extension modules
    like convenience value accessors, subscripting support, literal initializers, JSON
    pointers (rfc6901) and conversion from/to Foundation JSON produced and consumed by
    JSONSerialization.
  DESC
  s.homepage     = "https://github.com/tomquist/CoreJSON"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Tom Quist" => "" }
  s.social_media_url   = "https://twitter.com/tomqueue"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/tomquist/CoreJSON.git", :tag => s.version.to_s }
  s.default_subspec = 'Core'

  s.subspec 'Core' do |sp|
    sp.source_files = "Sources/CoreJSON/*.swift"
  end

  s.subspec 'Convenience' do |sp|
    sp.source_files = "Sources/CoreJSONConvenience/*.swift"
    sp.dependency 'CoreJSON/Core'
  end

  s.subspec 'Foundation' do |sp|
    sp.frameworks  = "Foundation"
    sp.source_files = "Sources/CoreJSONFoundation/*.swift"
    sp.dependency 'CoreJSON/Core'
  end

  s.subspec 'Literals' do |sp|
    sp.source_files = "Sources/CoreJSONLiterals/*.swift"
    sp.dependency 'CoreJSON/Core'
  end

  s.subspec 'Pointer' do |sp|
    sp.frameworks  = "Foundation"
    sp.source_files = "Sources/CoreJSONPointer/*.swift"
    sp.dependency 'CoreJSON/Core'
  end

  s.subspec 'Subscript' do |sp|
    sp.source_files = "Sources/CoreJSONSubscript/*.swift"
    sp.dependency 'CoreJSON/Core'
  end

end
