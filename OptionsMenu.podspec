Pod::Spec.new do |s|
  s.name         = "OptionsMenu"
  s.version      = "1.0"
  s.summary      = "(Swift / iOS) Material design style options menu opening from bar button item."
  s.homepage     = "https://github.com/uacaps/OptionsMenu"
  s.license      = { :type => 'UA', :file => 'LICENSE' }
  s.author       = { "uacaps" => "care@cs.ua.edu" }
  s.source       = { :git => "https://github.com/uacaps/OptionsMenu.git", :tag => '1.0' }
  s.platform     = :ios, '8.0'
  s.source_files = 'Classes/*'
  s.requires_arc = true
end
