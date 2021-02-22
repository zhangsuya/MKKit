Pod::Spec.new do |s|

  s.name         = 'MKKit'
  s.version      = '0.1.0'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/zhangsuya/MKKit'
  s.authors      = {'suya' => 'zhangsuya@peilian.cn'}
  s.summary      = 'MKKit'

  s.platform     =  :ios, '8.0'
  s.source       =  { git: 'https://github.com/zhangsuya/MKKit.git', :tag => s.version }
  s.requires_arc = true
  
  s.source_files = 'Source/**/*.{h,m}'

  s.dependency 'YYKit'


  
end
