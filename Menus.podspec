Pod::Spec.new do |s|
    s.name = "Menus"
    s.version = "0.3"
    s.summary = "Lightweight protocol-oriented framework for creating interactive iOS side menus"

    s.homepage = "https://github.com/MobilionOSS/Menus"
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.social_media_url = "http://twitter.com/omaralbeik"

    s.authors = {
        "Mobilion" => "https://github.com/MobilionOSS",
        "Omar Albeik" => "https://twitter.com/omaralbeik"
    }

    s.module_name  = 'Menus'
    s.source = { :git => "https://github.com/MobilionOSS/Menus.git", :tag => s.version }
    s.source_files = "Sources/**/*.swift"
    s.swift_version = "4.1"
    s.requires_arc = true

    s.ios.deployment_target = "9.0"
    s.ios.framework  = "UIKit"
end
