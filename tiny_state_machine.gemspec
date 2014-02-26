# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tiny_state_machine/version'

Gem::Specification.new do |spec|
  spec.name          = "tiny_state_machine"
  spec.version       = TinyStateMachine::VERSION
  spec.authors       = ["Geoffroy Montel"]
  spec.email         = ["g_montel@yahoo.com"]
  spec.description   = "Tiny State Machine for Ruby"
  spec.summary       = "A tiny (few dozen lines) state machine with callback for Ruby"
  spec.homepage      = "https://github.com/geoffroymontel/tiny_state_machine"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
