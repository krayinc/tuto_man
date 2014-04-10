# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tuto_man/version'

Gem::Specification.new do |spec|
  spec.name          = "tuto_man"
  spec.version       = TutoMan::VERSION
  spec.authors       = ["Hiroki Yoshioka"]
  spec.email         = ["irohiroki@gmail.com"]
  spec.summary       = %q{A tutorial view or reminder manager for rails applications.}
  spec.description   = %q{TutoMan manages diplays of tutorial views or reminders in a rails application.}
  spec.homepage      = "https://github.com/krayinc/tuto_man"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
