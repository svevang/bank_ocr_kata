
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bank_ocr_kata/version"

Gem::Specification.new do |spec|
  spec.name          = "bank_ocr_kata"
  spec.version       = BankOcrKata::VERSION
  spec.authors       = ["Sam Vevang"]
  spec.email         = ["sam.vevang@gmail.com"]

  spec.summary       = "Parse and validate account numbers encoded as ascii art."
  spec.description   = "A small gem that parses and validates numerals encoded as multiline ascii art"
  spec.homepage      = "http://github.com/svevang/bank_orc_kata"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "pry", "~> 0.11.3"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
