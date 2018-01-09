
Pod::Spec.new do |s|


  s.name                  = "iOSKitFramework"
  s.version               = "1.0.0"
  s.summary               = "This framework is a collection of dailylife generic code."
  s.description           = "This framework is a collection of dailylife generic code, such as Networking, BlurView, etc."
  s.homepage              = "https://github.com/sawanmind/iOSKit-Framework"
  s.license               = "MIT"
  s.author                = { "Sawan Kumar" => "sawanmind@gmail.com" }
  s.social_media_url      = "http://twitter.com/sawanmind"
  s.platform              = :ios, "11.0"
  s.source                = { :git => "https://github.com/sawanmind/iOSKit-Framework.git", :tag => "#{s.version}" }
  s.source_files          = "iOSKitFramework/**/*"
  s.frameworks            = "UIKit", "Foundation", "SystemConfiguration"

end
