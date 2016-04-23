Pod::Spec.new do |spec|
  spec.name = "BGStatePicker"
  spec.version = "0.2.0"
  spec.summary = "iOS Framework for picking states"
  spec.homepage = "https://github.com/grimabe/BGStatePicker"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Benjamin Grima" => 'benjamin@grima.info' }
  spec.social_media_url = "http://twitter.com/grimabe"
  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/grimabe/BGStatePicker.git", tag: "#{spec.version}", submodules: true }
  spec.source_files = "BGStatePicker/*.{h,swift}"
end
