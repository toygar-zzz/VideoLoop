#
# Be sure to run `pod lib lint youtube-parser.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "VideoLoop"
  s.version          = "1.0"
  s.summary          = "Video loops and cut library"
  s.homepage         = "https://github.com/toygar/VideoLoop"
  s.license          = 'MIT'
  s.author           = { "Toygar Dündaralp" => "tdundaralp@gmail.com" }
  s.social_media_url = 'https://twitter.com/ToygarDndaralp'
  s.source           = { :git => "https://github.com/toygar/VideoLoop.git", :tag => s.version.to_s }
  s.platforms        = { :ios => "9.0", :tvos => "9.0" }
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc     = true
  s.source_files     = 'VideoLoop/Source/*.swift'
end
