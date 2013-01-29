module Seorel
  module Base
    module InstanceMethods
      def seorel?
        self.try(:seorel).present?
      end

      def set_seorel_default_values
        if seorel_default_value?
          self.seorel.title ||= seorel_default_value
          self.seorel.description ||= seorel_default_value
        end
      end

      def seorel_default_value
        self.send @seorel_base_field if seorel_default_value?
      end

      def seorel_default_value?
        @seorel_base_field.present?
      end
    end
  end
end
