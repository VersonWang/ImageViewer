Pod::Spec.new do |s|

  s.name         = "GQImageViewer"
  s.version      = "1.2.4"
  s.summary      = "一款多图文浏览器，支持图文混合浏览和单图片浏览，增加底部文字，仿今日头条效果，图片原尺寸显示，不会变形，双击放大缩小，单击消失，支持多张本地及网络图片混合查看，支持链式调用，支持WebP图片浏览。"

  s.homepage     = "https://github.com/g763007297/ImageViewer"
  # s.screenshots  = "https://github.com/g763007297/ImageViewer/blob/master/Screenshot/demo.gif"

  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "developer_高" => "763007297@qq.com" }
  
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/g763007297/ImageViewer.git" , :tag => s.version}

  s.requires_arc = true

  s.default_subspec = 'Core'

  s.pod_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

  s.subspec 'Core' do |core|
    core.source_files = "GQImageViewer/**/*.{h,m}"
    core.dependency "GQImageDownloader"
  end

  s.subspec 'WebP' do |webp|
    webp.source_files = "GQImageViewer/**/*.{h,m}"
    webp.dependency 'GQImageDownloader/WebP'
  end

  s.subspec 'CoreSD' do |coresd|
    coresd.source_files = "GQImageViewer/**/*.{h,m}"
    coresd.dependency 'SDWebImage/Core'
  end

  s.subspec 'WebPSD' do |webpsd|
    webpsd.source_files = "GQImageViewer/**/*.{h,m}"
    webpsd.dependency 'SDWebImage/WebP'
  end

end
