# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "akashiyaki/version"

Gem::Specification.new do |spec|
  spec.name          = "akashiyaki"
  spec.version       = Akashiyaki::VERSION
  spec.authors       = ["nownabe"]
  spec.email         = ["nownabe@gmail.com"]

  spec.summary       = %q{Automation for AKASHI https://ak4.jp .}
  spec.homepage      = "https://github.com/nownabe/akashiyaki"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency "mechanize", "~> 2.7.5"
end
