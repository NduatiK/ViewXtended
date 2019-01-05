
Pod::Spec.new do |s|
  s.name             = 'ViewXtended'
  s.version          = '0.1.2'
  s.summary          = 'A collection of my favourite view extensions'

  s.description      = <<-DESC
Description: A collection of my favourite view extensions
                       DESC

  s.homepage         = 'https://github.com/NduatiK/Encompass'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NduatiK' => '' }
  s.source           = { :git => 'https://github.com/NduatiK/ViewXtended.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files  = "Classes", "ViewXtended/**/*.swift"

end
