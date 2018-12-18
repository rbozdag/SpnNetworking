#
# Be sure to run `pod lib lint SPModel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#  pod spec validate:
#     -gem install fourflusher to test
#     -pod repo add SpnNetworking https://github.com/rbozdag/SpnNetworking.git
#     -pod repo push SpnNetworking SpnNetworking.podspec
#     -git commit
#     -git pull
#     -git push
#     -pod repo update SpnNetworking || pod repo remove SpnNetworking

Pod::Spec.new do |s|
  s.name             = 'SpnNetworking'
  s.version          = '1.1.8'
  s.summary          = 'SpinYarnOnAWheel Networking Library'

  s.description      = <<-DESC
                      SpinYarnOnAWheel Network Library is a Endpoint router layer. You can configure with Alamofire or URL Session.
                       DESC

  s.homepage         = 'http://www.spinyarnonawheel.com/'
  s.license          = { :type => "BSD", :file => "LICENSE.md" }
  s.author           = { 'RahmiBozdag' => 'bozdag.rahmi@.gmail.com' }
  s.source           = { :git => "https://github.com/rbozdag/SpnNetworking.git", :tag => "#{s.version}" }

  s.swift_version = '4.2'
  s.source_files = 'SpnNetworking/**/*.{swift,h,m}'

  s.ios.deployment_target = '9.0'
  s.platform     = :ios, "9.0"

  s.dependency 'Alamofire'
  s.dependency 'AlamofireObjectMapper'
end
