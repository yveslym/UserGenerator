Pod::Spec.new do |s|
  s.name             = 'userGenerator'
  s.version          = '0.1.0'
  s.summary          = 'with one line of code, genrate genrate infinite number of user you want for testing'
 
  s.description      = <<-DESC
This pod, user generator help you to test your app by populatiing with multiple users within a single line. Also, you can give a geo location and get addresses arround that location.
                       DESC
 
  s.homepage         = 'https://github.com/yveslym/UserGenerator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<Yves Songolo>' => '<yves.songolo@gmail.com>' }
  s.source           = { :git => 'https://github.com/yveslym/UserGenerator.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'UserGenerator/*'
 
end