Pod::Spec.new do |s|
s.name = 'CHEnvirSwitcherDemo'
s.version = '0.0.3'
s.license = 'MIT'
s.summary = 'EnvironmentSwitcher for  iOS.'
s.homepage = 'https://github.com/ChaussonORG/CHEnvirSwitcherDemo'
s.authors = { 'Daxiongzyj' => '13761057550@163.com' }
s.source = { :git => "https://github.com/ChaussonORG/CHEnvirSwitcherDemo.git", :tag => "0.0.3"}
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = "CHEnvirSwitcherService", "*,{m,h,plist}"
s.dependency 'CHWebView'
end
