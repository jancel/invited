# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{json_spec}
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steve Richert"]
  s.date = %q{2011-08-19}
  s.description = %q{Easily handle JSON in RSpec and Cucumber}
  s.email = ["steve.richert@gmail.com"]
  s.files = ["features/equivalence.feature", "features/inclusion.feature", "features/memory.feature", "features/paths.feature", "features/sizes.feature", "features/step_definitions/steps.rb", "features/support/env.rb", "features/types.feature", "spec/json_spec/configuration_spec.rb", "spec/json_spec/helpers_spec.rb", "spec/json_spec/matchers_spec.rb", "spec/json_spec/memory_spec.rb", "spec/spec_helper.rb"]
  s.homepage = %q{https://github.com/collectiveidea/json_spec}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{json_spec}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Easily handle JSON in RSpec and Cucumber}
  s.test_files = ["features/equivalence.feature", "features/inclusion.feature", "features/memory.feature", "features/paths.feature", "features/sizes.feature", "features/step_definitions/steps.rb", "features/support/env.rb", "features/types.feature", "spec/json_spec/configuration_spec.rb", "spec/json_spec/helpers_spec.rb", "spec/json_spec/matchers_spec.rb", "spec/json_spec/memory_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9"])
      s.add_development_dependency(%q<cucumber>, ["~> 1.0"])
    else
      s.add_dependency(%q<multi_json>, ["~> 1.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<rake>, ["~> 0.9"])
      s.add_dependency(%q<cucumber>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<multi_json>, ["~> 1.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<rake>, ["~> 0.9"])
    s.add_dependency(%q<cucumber>, ["~> 1.0"])
  end
end
