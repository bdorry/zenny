Gem::Specification.new do |gem|
  gem.name = "zenny"
  gem.version = '0.0.2'
  gem.date		= Date.today.to_s
  gem.platform = Gem::Platform::RUBY
  gem.rubyforge_project  = nil

  gem.author = "Brian Dorry"
  gem.email = "brian@bdorry.com"
  gem.homepage = "http://github.com/bdorry/zenny"

  gem.summary = "A wrapper around the Zenoss JSON API"
  gem.description	= <<-EOF

  EOF

  gem.files = `git ls-files`.split(/\n/)
  gem.require_path = "lib"
  gem.rdoc_options	= %w(-x test/ -x examples/)
  gem.extra_rdoc_files = %w(README.md COPYING.txt)

  gem.required_ruby_version	= '>= 1.8.7'
  gem.add_runtime_dependency  'httpclient', '~> 2.2.0'
  gem.add_runtime_dependency  'tzinfo', '~> 0.3.20'
  gem.add_runtime_dependency  'multi_json', '~> 1.0'
end
