require 'yaml'
require 'singleton'

class Settings
  include Singleton

  @@config_file = ''

  attr_reader :config_file, :settings

  def self.config_file= fn
    @@config_file = fn
  end

  def initialize
    @config_file = @@config_file.empty? ? "#{Rails.root}/config/config.yml" : @@config_file
    @settings = YAML.load_file(@config_file)
  end

  def method_missing(name, *args, &block)
    if assignment?(name)
      set(name, args.first)
    else
      get(name)
    end
  end

  def assignment?(method_name)
    method_name =~ /=$/
  end

  def set(key, value)
    key = key.to_s
    key.gsub!(/[ =]/, '')
    @settings[key] = value
    write
  end

  def get(key)
    value = @settings[key.to_s]
    raise KeyNotFoundError unless value
    value
  end

  def write
    File.open(@config_file, "w") {|f| f.write(@settings.to_yaml) }
  end
end

class KeyNotFoundError < StandardError
end