#
# Be sure to run `pod lib lint Alison.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Alison'
  s.version          = '0.1.3'
  s.summary          = 'Alison the bot. A bot animation in SpriteKit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Alison is a cool bot animation written with SpriteKit. It can be used for a chatbot icon for example.
                       DESC

  s.homepage         = 'https://github.com/bpisano/Alison'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bpisano' => 'benjamin.pisano@icloud.com' }
  s.source           = { :git => 'https://github.com/bpisano/Alison.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/benjamin_pisano'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'Alison/Classes/**/*'
  #s.resources = 'Alison/Assets/*.xcassets'
  
  s.resource_bundles = {
    'Alison' => ['Alison/Assets/**']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
