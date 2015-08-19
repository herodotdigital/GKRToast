Pod::Spec.new do |s|
  s.name         = "AIMLoader"
  s.version      = "0.0.4"
  s.summary      = "iOS gif loader build on top of GKRToast and FLAnimatedImage"
  s.homepage     = "https://github.com/AllinMobile/GKRToast"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Maciej Gad" => "https://github.com/MaciejGad" }
  s.social_media_url   = "https://twitter.com/maciej_gad"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/AllinMobile/GKRToast.git", :tag => '0.0.4' }
  s.source_files  =  "AIMLoader.{h,m}"
  s.requires_arc = true
  s.dependency "GKRToast", "~> 0.0.3"
  s.dependency "FLAnimatedImage", "~> 1.0"
end
