$LOAD_PATH.unshift File.expand_path '../lib', __FILE__
require 'active_ingredients/version'


Gem::Specification.new do |s|
	s.name          = 'active-ingredients'
	s.summary       = 'Simple Value Objects For Active Model'
	s.description   = 'Compose big Active Model classes with smaller ingredients that map directly to values on the original'
	s.version       =  ActiveIngredients::VERSION
	s.date          = '2014-03-13'
	s.homepage      = 'http://www.dablweb.com'
	s.authors       = [ 'Brett Richardson' ]
	s.email         = [ 'Brett.Richardson.NZ@gmail.com' ]
	s.require_path  =  'lib'
	s.files         = Dir.glob( 'lib/**/*' ) + %w{ Gemfile Guardfile MIT-LICENSE README.md }

	s.add_dependency 'activemodel'
	s.add_dependency 'activerecord'

	s.add_development_dependency 'bundler'
	s.add_development_dependency 'sqlite3'
	s.add_development_dependency 'rake'
	s.add_development_dependency 'guard'
	s.add_development_dependency 'guard-rspec'
	s.add_development_dependency 'guard-bundler'
	s.add_development_dependency 'rspec-nc'
	s.add_development_dependency 'fuubar'
end
