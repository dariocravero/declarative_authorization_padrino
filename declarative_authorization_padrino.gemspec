# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "declarative_authorization_padrino"
  s.version = "0.1.1"
  s.required_ruby_version = ">= 1.8.6"
  s.authors = ["Dario Javier Cravero"]
  s.summary = "declarative_authorization_padrino is a Padrino's wrapper around declarative_authorization's Rails plugin for maintainable authorization based on readable authorization rules."
  s.email = "dario@qinnova.com.ar"
  s.files = %w{MIT-LICENSE README.rdoc Rakefile} + Dir["lib/*.rb"] + Dir["lib/**/*.rb"] + Dir["test/*"]
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc']
  s.add_dependency 'declarative_authorization', '>= 0.5.2'
  s.homepage = %q{http://github.com/dariocravero/declarative_authorization_padrino}
end
