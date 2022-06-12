# frozen_string_literal: true

require_relative "lib/mithraic_events/version"

Gem::Specification.new do |spec|
  spec.name = "mithraic_events"
  spec.version = MithraicEvents::VERSION
  spec.authors = ["callyca"]
  spec.email = ["thiago.callyxz@gmail.com"]

  spec.summary = "Modules of the HTTParty and more stuff"
  spec.description = "Mithraic Event is a tool to help in the API testing with HTTParty"
  spec.homepage = "https://github.com/CallyCa/MithraicEvents"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/CallyCa/MithraicEvents"
  spec.metadata["changelog_uri"] = "https://github.com/CallyCa/MithraicEvents/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httmultiparty"
  spec.add_dependency "httparty"
  spec.add_dependency "jmespath"
  spec.add_dependency "net-sftp"
  spec.add_dependency "nokogiri"
  spec.add_dependency "os"
  spec.add_dependency "poltergeist"
  spec.add_dependency "pry"
  spec.add_dependency "rake"
  spec.add_dependency "rspec"
  spec.add_dependency "rspec-retry"
  spec.add_dependency "savon"
  spec.add_dependency "without_accents"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-checkstyle_formatter"
end
