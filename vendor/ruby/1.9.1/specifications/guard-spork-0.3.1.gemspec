# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{guard-spork}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thibaud Guillaume-Gentil"]
  s.date = %q{2011-10-08}
  s.description = %q{Guard::Spork automatically manage Spork DRb servers.}
  s.email = ["thibaud@thibaud.me"]
  s.homepage = %q{http://rubygems.org/gems/guard-spork}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{guard-spork}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Guard gem for Spork}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>, [">= 0.8.4"])
      s.add_runtime_dependency(%q<spork>, [">= 0.8.4"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 0.4"])
    else
      s.add_dependency(%q<guard>, [">= 0.8.4"])
      s.add_dependency(%q<spork>, [">= 0.8.4"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.6"])
      s.add_dependency(%q<guard-rspec>, ["~> 0.4"])
    end
  else
    s.add_dependency(%q<guard>, [">= 0.8.4"])
    s.add_dependency(%q<spork>, [">= 0.8.4"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.6"])
    s.add_dependency(%q<guard-rspec>, ["~> 0.4"])
  end
end
