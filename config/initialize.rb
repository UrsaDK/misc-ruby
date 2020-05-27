# frozen_string_literal: true

(APP_ENV ||= (ENV['APP_ENV'] || 'development')).freeze
(APP_ROOT ||= File.expand_path('..', __dir__)).freeze

# Synchronise environment variables to match APP_ENV
%w[RACK_ENV RAILS_ENV RAKE_ENV].each do |key|
  warn "warning: updating ENV['#{key}'] " \
        "from '#{ENV[key]}' " \
        "to '#{ENV[key] = APP_ENV}'" if ENV.key?(key) && ENV[key] != APP_ENV
  Object.const_set(key.to_sym, APP_ENV) if Object.const_defined?(key.to_sym)
end

# Auto-require environment specific gems
require 'bundler/setup'
Bundler.require(APP_ENV.to_sym)

# Check if app environment matched the supplied name.
# Usage: app_env?('development')
#        app_env?(:production)
def app_env?(env_name)
  APP_ENV.casecmp(env_name.to_s).zero?
end

# Expand the supplied path relative to the APP_ROOT directory.
# Usage:  app_path('lib/project1', 'lib/project2')
#         app_path(%w[lib project1], %w[lib project2])
def app_path(path)
  File.expand_path(File.join(path), APP_ROOT)
end

# Prepend APP_ROOT relative directory to LOAD_PATH, if it isn't already in it.
# Usage:  app_load_path('lib/project1', 'lib/project2')
#         app_load_path(%w[lib project1], %w[lib project2])
def app_load_path(*paths)
  paths.each do |path|
    dir = app_path(path)
    $LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)
  end
end

# Require APP_ROOT relative files matching the glob pattern. With a block,
# each file is yielded to it and is required if the block returns true.
# Usage:  app_require('lib/**/*.rb', 'tasks/**/*.rb')
#         app_require(%w[lib ** *.rb], %w[tasks ** *.rb])
#         app_require('lib/**/*') { |f| f.end_with?('.rb') }
def app_require(*patterns)
  patterns = ["#{APP_ROOT}/**/*.rb"] if patterns.empty?
  abs_paths = patterns.map { |p| app_path(p) }
  Dir.glob(abs_paths).sort.each do |file|
    require file if !block_given? || yield(file)
  end
end

# Parse APP_ROOT relative config files (YAML) into hashes with symbolised keys.
# Hashes from multiple files are merged. Files are pre-processed with ERB.
# Config values can be manipulated by adding an optional block to the method.
# Usage:  config = app_config('config/file1.yml', config/file2.yml)
#         config = app_config(%w[config file1.yml], %w[config file2.yml]) do |c|
#           c[:key_decrypted] = decrypt(c[:key_encrypted])
#         end
%w[erb yaml].each { |gem| require gem }
def app_config(*paths)
  env_yaml = paths.each_with_object({}) do |path, result|
    file = app_path(path)
    data = YAML.safe_load(File.read(file), aliases: true, filename: file)
    result.merge!(data[APP_ENV])
  end.to_yaml
  YAML.safe_load(ERB.new(env_yaml).result(binding), symbolize_names: true)
      .tap { |c| yield(c) if block_given? }.freeze
end
