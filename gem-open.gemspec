Gem::Specification.new do |s|
  s.name        = "gem-open"
  s.version     = "0.1.8"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://github.com/fnando/gem-open"
  s.summary     = "Open gems on your favorite editor by running a specific gem command like `gem open nokogiri`."
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "mocha"
  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-utils"
  s.add_development_dependency "rake"
end
