Pod::Spec.new do |s|
  s.name         = 'MHTabBarController'
  s.version      = '2.0.1'
  s.platform 	 = :ios
  s.ios.deployment_target = '6.0'
  s.summary      = 'Fork from https://github.com/mhaddl/MHCustomTabBarController. Implement the iOS native hidesBottomBarWhenPushed property'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/Vienta/MHCustomTabBarController'
  s.requires_arc = true
  s.author = {
    'Vienta' => 'vienta.me'
  }
  s.source = {
    :git => 'https://github.com/Vienta/MHCustomTabBarController.git',
    :tag => '2.0.1'
  }
  s.source_files = 'MHCustomTabBarController/*.{m,h}'
end
