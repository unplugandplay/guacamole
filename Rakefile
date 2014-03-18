# -*- encoding : utf-8 -*-
require 'bundler/gem_tasks'

require 'devtools'
Devtools.init_rake_tasks

import('./tasks/adjustments.rake')

desc 'Start a REPL with guacamole loaded (not the Rails part)'
task :console do
  require 'bundler/setup'

  require 'pry'
  require 'guacamole'
  ARGV.clear
  Pry.start
end
