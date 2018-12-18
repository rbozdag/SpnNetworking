# Uncomment the next line to define a global platform for your project

platform :ios, '9.0'

def shared_pods
    pod 'Alamofire'
    pod 'AlamofireObjectMapper'
    pod 'OHHTTPStubs/Swift'
end

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'SpnNetworking' do
  use_frameworks!
  inhibit_all_warnings!
  shared_pods
end

target 'SpnNetworkingTests' do
    inhibit_all_warnings!
    use_frameworks!
    shared_pods
    testing_pods
end
