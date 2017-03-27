# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'danger/semantic_commit/version'

Gem::Specification.new do |spec|
  spec.name          = "danger-semantic_commit"
  spec.version       = Danger::SemanticCommit::VERSION
  spec.authors       = ["Michael Stock"]
  spec.email         = ["mikeastock@gmail.com"]

  spec.summary       = "A Danger plugin for linting semantic commits"
  spec.description   = "A Danger plugin for linting semantic commits"
  spec.homepage      = "https://github.com/mikeastock/danger-semantic-commit"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "danger-rubocop"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
