# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'collage_magic/version'

Gem::Specification.new do |spec|
  spec.name          = 'collage_magic'
  spec.version       = CollageMagic::VERSION
  spec.authors       = ['Chiara Sarta', 'Szilard Magyar', 'Christian Woerle', 'David Piegza']
  spec.email         = ['jobs@devolute.org']

  spec.summary       = 'Creates a collage from ten Flickr images related to user input.'
  spec.description   = 'Flickr_img_parser is  command line tool with which you can make an API request to Flickr and save the response as a collage in an image file'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency 'webmock', '~> 2.3', '>= 2.3.1'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'guard'

  spec.add_dependency 'httparty', '~> 0.14.0'
  spec.add_dependency 'thor', '~> 0.19.4'
end
