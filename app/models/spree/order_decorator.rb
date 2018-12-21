module Spree
  module OrderDecorator
    require 'date'
    require 'spree/order/checkout'

    include SolidusDeliveryOptions::DeliveryOptionsService

    class << self
      def prepended(klass)
        klass.validate :valid_delivery_options?
      end
    end

    def valid_delivery_instructions?
      if delivery_instructions && delivery_instructions.length > 500
        errors[:delivery_instructions] << I18n.t('activerecord.errors.models.spree/order.attributes.delivery_instructions.cannot_be_longer_than_500_charachters')
        return false
      end
      true
    end

    def delivery_date_present?
      errors[:delivery_date] << I18n.t('activerecord.errors.messages.blank') unless delivery_date
      errors[:delivery_date] << I18n.t('activerecord.errors.models.spree/order.attributes.delivery_date.cannot_be_today_or_in_the_past') if delivery_date <= Date.current
      errors[:delivery_date].empty?
    end

    def delivery_time_present?
      return if delivery_date_present?

      errors[:delivery_time] << I18n.t('activerecord.errors.messages.blank') unless delivery_time
      errors[:delivery_time].empty?
    end

    def valid_delivery_options?
      if (delivery_date && delivery_date_changed?) && (delivery_time && delivery_time_changed?)
        options = current_delivery_options_for_date(delivery_date)
        if options.present?
          errors[:delivery_time] << I18n.t('activerecord.errors.messages.invalid') unless options.include?(delivery_time)
        else
          errors[:delivery_date] << I18n.t('activerecord.errors.models.spree/order.attributes.delivery_date.not_available_on_selected_date')
        end
      end

      errors[:delivery_date].empty? && errors[:delivery_time].empty?
    end
  end
end

Spree::Order.prepend Spree::OrderDecorator

Spree::PermittedAttributes.checkout_attributes << :delivery_date
Spree::PermittedAttributes.checkout_attributes << :delivery_time
Spree::PermittedAttributes.checkout_attributes << :delivery_instructions

Spree::Order.state_machine.before_transition to: :payment, do: :valid_delivery_instructions?

Spree::Order.state_machine.before_transition to: :payment, do: :delivery_date_present?
Spree::Order.state_machine.before_transition to: :payment, do: :delivery_time_present?
Spree::Order.state_machine.before_transition to: :payment, do: :valid_delivery_options?
