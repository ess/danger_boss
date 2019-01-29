
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "danger_boss/version"

Gem::Specification.new do |spec|
  spec.name          = "danger_boss"
  spec.version       = DangerBoss::VERSION
  spec.authors       = ["Dennis Walters"]
  spec.email         = ["pooster@gmail.com"]

  spec.summary       = %q{A client for the alertmanager v1 API.}
  spec.homepage      = "https://github.com/ess/danger_boss"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'webmock', '~> 3.5'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_dependency 'faraday', '~> 0.15'
  spec.add_dependency 'dry-struct', '~> 0.6'
  spec.add_dependency 'dry-types', '~> 0.14'
  spec.add_dependency 'dry-monads', '~> 1.2'
  spec.add_dependency 'dry-matcher', '~> 0.7'
end
