Pod::Spec.new do |spec|
  spec.name         = "LBMultilevelSelecterView"
  spec.version      = "1.0.0"
  spec.summary      = "iOS多级选择，例如地址，选择级数可完美自定义，支持单选、多选"
  spec.description  = "iOS多级选择，例如地址，选择级数可完美自定义，支持单选、多选。"
  spec.homepage     = "https://github.com/A1129434577/LBMultilevelSelecterView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "刘彬" => "1129434577@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'
  spec.source       = { :git => 'https://github.com/A1129434577/LBMultilevelSelecterView.git', :tag => spec.version.to_s }
  spec.source_files = "LBMultilevelSelecterView/**/*.{h,m}"
  spec.requires_arc = true
end
