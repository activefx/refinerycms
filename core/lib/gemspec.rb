require 'pathname'
gempath = Pathname.new(File.expand_path('../../', __FILE__))
require gempath.join('..', 'base', 'lib', 'base', 'refinery')

gemspec = <<EOF
# DO NOT EDIT THIS FILE DIRECTLY! Instead, use lib/gemspec.rb to generate it.

Gem::Specification.new do |s|
  s.name              = %q{#{gemname = 'refinerycms-core'}}
  s.version           = %q{#{::Refinery.version}}
  s.summary           = %q{Core engine for Refinery CMS}
  s.description       = %q{The core of Refinery CMS. This handles the common functionality and is required by most engines}
  s.date              = %q{#{Time.now.strftime('%Y-%m-%d')}}
  s.email             = %q{info@refinerycms.com}
  s.homepage          = %q{http://refinerycms.com}
  s.rubyforge_project = %q{refinerycms}
  s.authors           = ['Resolve Digital', 'Philip Arndt', 'David Jones', 'Steven Heidel']
  s.license           = %q{MIT}
  s.require_paths     = %w(lib)
  s.executables       = %w(#{Pathname.glob(gempath.join('bin/*')).map{|d| d.relative_path_from(gempath)}.sort.join(" ")})

  s.add_dependency 'refinerycms-base',            '~> #{::Refinery::Version}'
  s.add_dependency 'refinerycms-settings',        '~> #{::Refinery::Version}'
  s.add_dependency 'refinerycms-generators',      '>= 0.9.9.3'
  s.add_dependency 'mongoid',                     '~> 2.0.1'
  s.add_dependency 'mongoid_search',              '~> 0.1.2'
  s.add_dependency 'mongoid_slug',                '~> 0.7.2'
  s.add_dependency 'mongoid_nested_set',          '~> 0.1.2'
  s.add_dependency 'dragonfly',                   '~> 0.8.2'
  s.add_dependency 'rails',                       '~> 3.0.5'
  s.add_dependency 'rdoc',                        '>= 2.5.11' # helps fix ubuntu
  s.add_dependency 'truncate_html',               '~> 0.5'
  s.add_dependency 'will_paginate',               '~> 3.0.pre'
  s.add_dependency 'show_for',                    '>= 0.2.4'
  s.add_dependency 'app',                         '>= 1.0.3'
  s.add_dependency 'haml',                        '>= 3.0.25'
  s.add_dependency 'haml-rails',                  '>= 0.3.4'

  s.files             = [
    '#{%w( **/{*,.rspec,.gitignore,.yardopts} ).map { |file| Pathname.glob(gempath.join(file)) }.flatten.reject{|f|
      !f.exist? or f.to_s =~ /\.gem$/ or (f.directory? and f.children.empty?)
    }.map{|d| d.relative_path_from(gempath)}.uniq.sort.join("',\n    '")}'
  ]
end
EOF

(gemfile = gempath.join("#{gemname}.gemspec")).open('w') {|f| f.puts(gemspec)}
puts `cd #{gempath} && gem build #{gemfile}` if ARGV.any?{|a| a == "BUILD=true"}

