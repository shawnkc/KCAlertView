Pod::Spec.new do |s|
  s.name         = "KCAlertView"
  s.version      = "1.0.0"
  s.summary      = "A simple iOS8/iOS7 wrapper for UIAlertViewController/UIAlertView."
  s.homepage     = "https://github.com/shawnkc/KCAlertView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "ShawnKC"
  s.source       = { :git => "https://github.com/shawnkc/KCAlertView.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.source_files = 'KCAlertView.{h,m}'
  s.frameworks   = 'UIKit'
  s.requires_arc = true
end