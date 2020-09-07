#
# Be sure to run `pod lib lint TTAppearceKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TTAppearceKit'
  s.version          = '0.1.0'
  s.summary          = 'TTAppearceKit is a simple tools to help you to change the appearce when theme changed'
  s.description      = <<-DESC
TTAppearceKit is a simple tools to help you to change the appearce when theme changed                       DESC

  s.homepage         = 'https://github.com/itanchao/TTAppearceKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'itanchao' => 'itanchao@gmail.com' }
  s.source           = { :git => 'https://github.com/itanchao/TTAppearceKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.source_files = 'TTAppearceKit/Classes/**/*'

end
