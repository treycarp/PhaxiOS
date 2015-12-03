
Pod::Spec.new do |s|

  s.name         = "PhaxiOS"
  s.version      = "0.1.0"
  s.summary      = "A simple library for sending faxes through Phaxio"
  s.license      = "MIT"
  s.platform     = :ios, "7.0"
  s.description  = <<-DESC
This library will send a fax through the Phaxio service.  You can also look up the status of a fax.
                   DESC
  s.homepage     = "http://github.com/treycarp/PhaxiOS"
  s.author             = { "Trey Carpenter" => "trey.carpenter@gmail.com" }
  s.source       = { :git => "https://github.com/treycarp/PhaxiOS.git", :tag => "0.1.0" }
  s.source_files  = "Classes", "PhaxiOS/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.dependency "AFNetworking", "~> 2.4"
end
