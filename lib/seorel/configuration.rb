# frozen_string_literal: true
# encoding: utf-8
require 'active_support/configurable'

module Seorel
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :default_prepend_title
    config_accessor :default_title
    config_accessor :default_append_title
    config_accessor :default_prepend_description
    config_accessor :default_description
    config_accessor :default_append_description
    config_accessor :default_keywords
    config_accessor :default_image
    config_accessor :store_seorel_if
    config_accessor :default_og_metas
    config_accessor :default_twitter_metas

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line

    def initialize_defaults
      self.default_prepend_title = nil
      self.default_title = nil
      self.default_append_title  = nil
      self.default_prepend_description = nil
      self.default_description = nil
      self.default_append_description  = nil
      self.default_keywords = {}
      self.default_image = nil
      self.store_seorel_if = :empty
      self.default_og_metas = {}
      self.default_twitter_metas = {}
    end
  end

  # Global settings for Seorel
  def self.config
    @config ||= ::Seorel::Configuration.new.tap do |conf|
      conf.initialize_defaults
    end
  end

  # Configures global settings for Seorel
  #   Seorel.configure do |config|
  #     config.default_default_title = 'Default website title'
  #   end
  def self.configure(&block)
    yield(config)
  end

  # Reset global settings for Seorel
  def self.reset!
    @config = nil
  end
end
