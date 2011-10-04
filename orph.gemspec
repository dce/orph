# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "orph/version"

Gem::Specification.new do |s|
  s.name        = "orph"
  s.version     = Orph::VERSION
  s.authors     = ["David Eisinger"]
  s.email       = ["david.eisinger@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Orph is a library for removing typographic orphans}
  s.description = %q{Orphans (commonly referred to as 'widows') are
                     single-word lines at the end of paragraphs. This
                     library removes them with non-breaking spaces.}

  s.rubyforge_project = "orph"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
