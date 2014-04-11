require "tuto_man/version"
require "active_support/core_ext"

module TutoManager
  mattr_reader :tutos
  @@tutos = {}

  module Register
    def TutoMan(id, options = {})
      TutoManager.tutos[id] = options
    end
  end

  module Helpers
    class Tuto
      def initialize(id, session)
        @id = id
        @session = session
      end

      def off
        @session[:"_#{@id}_disabled"] = true
      end

      def on?
        enabled? && (options[:days_after] ? day_after? : elapsed?)
      end

      def shown
        now = Time.now
        if options[:days_after]
          @session[:"_next_#{@id}_at"] = (now.mday < options[:days_after] ? now : now.next_month).change(day: options[:days_after]).to_s
        else
          @session[:"_#{@id}_shown_at"] = now.to_s
        end
      end

      private

      def day_after?
        now = Time.now
        @session[:"_next_#{@id}_at"] ||= (now.mday < options[:days_after] ? now.change(day: options[:days_after]) : now).to_s
        now >= @session[:"_next_#{@id}_at"]
      end

      def elapsed?
        shown_at.nil? || Time.parse(shown_at) + interval < Time.now
      end

      def enabled?
        !@session[:"_#{@id}_disabled"]
      end

      def interval
        options[:interval] ||= 24 * 60 * 60
      end

      def options
        TutoManager.tutos[@id]
      end

      def shown_at
        @session[:"_#{@id}_shown_at"]
      end
    end

    def tuto(id)
      Tuto.new(id, session)
    end
  end
end

Object.class_eval do
  include TutoManager::Register
end

if defined?(ActionController)
  ActionController::Base.class_eval do
    include TutoManager::Helpers
    helper_method :tuto
  end
end
