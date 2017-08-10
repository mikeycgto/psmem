# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "psmem/version"

Gem::Specification.new do |spec|
  spec.name          = "psmem"
  spec.version       = Psmem::VERSION
  spec.authors       = ["Michael Coyne"]
  spec.email         = ["mikeycgto@gmail.com"]

  spec.summary       = %q{CLI utility to check and print the total memory used by one or more processes}
  spec.description   = %q{This gem provides a small executable CLI utility to check and print the total memory used by one or more processes.}
  spec.homepage      = "https://github.com/mikeycgto/psmem-ruby"
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
end
