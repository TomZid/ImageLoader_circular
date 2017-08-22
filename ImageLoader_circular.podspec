
Pod::Spec.new do |s|
  s.name             = 'ImageLoader_circular'
  s.version          = '0.1.0'
  s.summary          = 'ImageLoader_circular.'

  s.homepage         = 'https://github.com/zhb111lizhb111xi@gmail.com/ImageLoader_circular'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhb111lizhb111xi@gmail.com' => 'TomZid@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/zhb111lizhb111xi@gmail.com/ImageLoader_circular.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ImageLoader_circular/Classes/*'
  
end
