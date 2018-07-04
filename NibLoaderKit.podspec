Pod::Spec.new do |s|
  s.name         = "NibLoaderKit"
  s.version      = "3.0.0"
  s.summary      = "Tiny utility to load UIView/NSView from nibs"
  s.homepage     = "https://github.com/giginet/NibLoaderKit"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author             = { "giginet" => "giginet.net@gmail.com" }
  s.social_media_url   = "http://twitter.com/giginet"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/giginet/NibLoaderKit.git", :tag => s.version }

  s.source_files  = "Sources/*.{h,swift}"
  s.ios.source_files = s.tvos.source_files = "Sources/iOS/*.{h,swift}"
  s.osx.source_files  = "Sources/macOS/*.{h,swift}"
  s.swift_version = 4.1

  s.requires_arc = true
end
