# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{imgur2}
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Aaron Patterson}]
  s.date = %q{2011-03-28}
  s.description = %q{Upload stuff to imgur.  Yay.}
  s.email = [%q{aaron@tenderlovemaking.com}]
  s.executables = [%q{imgur2}]
  s.extra_rdoc_files = [%q{Manifest.txt}, %q{CHANGELOG.rdoc}, %q{README.rdoc}]
  s.files = [%q{bin/imgur2}, %q{Manifest.txt}, %q{CHANGELOG.rdoc}, %q{README.rdoc}]
  s.homepage = %q{http://github.com/tenderlove/imgur2}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{imgur2}
  s.rubygems_version = %q{1.8.1}
  s.summary = %q{Upload stuff to imgur}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.9.1"])
    else
      s.add_dependency(%q<hoe>, [">= 2.9.1"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.9.1"])
  end
end
