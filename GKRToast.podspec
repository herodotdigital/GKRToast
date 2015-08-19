Pod::Spec.new do |s|
  s.name         = "GKRToast"
  s.version      = "0.0.4"
  s.summary      = "iOS replay for Android Toast massages, made with easy customization in mind."
  s.homepage     = "https://github.com/AllinMobile/GKRToast"
  s.screenshots  = "https://raw.githubusercontent.com/AllinMobile/GKRToast/master/Assets/GKRToast.gif", "https://raw.githubusercontent.com/AllinMobile/GKRToast/master/Assets/AIMToast.gif", "https://raw.githubusercontent.com/AllinMobile/GKRToast/master/Assets/AIMFancyToast.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Maciej Gad" => "https://github.com/MaciejGad" }
  s.social_media_url   = "https://twitter.com/maciej_gad"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/AllinMobile/GKRToast.git", :tag => '0.0.4' }
  s.source_files  =  "*Toast.{h,m}"
  s.requires_arc = true
  s.dependency "Masonry", "~> 0.6.2"
end
