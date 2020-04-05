#
# Be sure to run `pod lib lint LocationSimulator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'LocationSimulator'
    s.version          = '0.1.0'
    s.summary          = 'A Location Simulator with CLLocationManager Interface'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    LocationSimulator is a CLLocationManager replacement that feeds positions in GPX files. It's very simple to use. Just replace `CLLocationManager` with `LSLocationManager`!
    
    When you are developing location basd app, you may want to test it with different location feeds. The builtin Xcode position simulator is not easy to use and cannot be customized in run time. It also misses some important information such as accuracy, heading and altitude. LocationSimulator is a testing library that feeds realistic location information to your app.
    DESC
    
    s.homepage         = 'https://github.com/strongwillow/LocationSimulator'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'strongwillow' => 'clear.tsai@gmail.com' }
    s.source           = { :git => 'https://github.com/strongwillow/LocationSimulator.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    s.source_files = 'LocationSimulator/Classes/**/*'
    
    s.resource_bundles = {
        'LocationSimulator' => ['GPX/*.gpx']
    }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    #   s.dependency ''
end
