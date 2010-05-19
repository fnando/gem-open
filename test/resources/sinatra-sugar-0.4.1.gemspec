# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sinatra-sugar}
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Konstantin Haase"]
  s.date = %q{2010-04-15}
  s.description = %q{Some extensions to the sinatra default behavior (usefull for other Sintatra extensions, part of BigBand).}
  s.email = %q{konstantin.mailinglists@googlemail.com}
  s.files = ["lib/sinatra/sugar.rb", "spec/sinatra/sugar_spec.rb", "spec/spec_helper.rb", "README.md"]
  s.homepage = %q{http://github.com/rkh/sinatra-sugar}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Some extensions to the sinatra default behavior (usefull for other Sintatra extensions, part of BigBand).}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<monkey-lib>, ["~> 0.4.0"])
      s.add_development_dependency(%q<sinatra-test-helper>, ["~> 0.4.0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
    else
      s.add_dependency(%q<monkey-lib>, ["~> 0.4.0"])
      s.add_dependency(%q<sinatra-test-helper>, ["~> 0.4.0"])
      s.add_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<monkey-lib>, ["~> 0.4.0"])
    s.add_dependency(%q<sinatra-test-helper>, ["~> 0.4.0"])
    s.add_dependency(%q<sinatra>, [">= 0.9.4"])
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
  end
end
