# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{turn}
  s.version = "0.8.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Pease"]
  s.date = %q{2011-10-10}
  s.default_executable = %q{turn}
  s.description = %q{}
  s.email = %q{tim.pease@gmail.com}
  s.executables = ["turn"]
  s.files = ["test/test_framework.rb", "test/test_reporters.rb", "test/test_runners.rb", "bin/turn"]
  s.homepage = %q{http://gemcutter.org/gems/turn}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{turn}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Test::Unit Reporter (New) -- new output format for Test::Unit}
  s.test_files = ["test/test_framework.rb", "test/test_reporters.rb", "test/test_runners.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ansi>, [">= 0"])
      s.add_development_dependency(%q<bones-git>, [">= 1.2.4"])
      s.add_development_dependency(%q<bones>, [">= 3.7.1"])
    else
      s.add_dependency(%q<ansi>, [">= 0"])
      s.add_dependency(%q<bones-git>, [">= 1.2.4"])
      s.add_dependency(%q<bones>, [">= 3.7.1"])
    end
  else
    s.add_dependency(%q<ansi>, [">= 0"])
    s.add_dependency(%q<bones-git>, [">= 1.2.4"])
    s.add_dependency(%q<bones>, [">= 3.7.1"])
  end
end
