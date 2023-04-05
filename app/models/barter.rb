# frozen_string_literal: true

class Barter
  include ActiveModel::Validations

  validates_with Validators::Barter::GivenItemValidator
  validates_with Validators::Barter::GivenItemPointValidator
  validates_with Validators::Barter::ReceivenItemValidator
  validates_with Validators::Barter::GivenItemPointValidator

  attr_accessor :given_items, :receiven_items

  def initialize(given_items, receiven_items)
    @given_items = given_items
    @receiven_items = receiven_items
  end

  def given_items_points
    return if given_items.nil?

    sum_items(given_items[:items])
  end

  def receiven_items_points
    return if receiven_items.nil?

    sum_items(receiven_items[:items])
  end

  private

  def sum_items(items)
    return if items.nil?

    sum = 0

    items.map do |item|
      sum += (Item::VALID_ITEMS[item[:name].to_sym] * item[:quantity])
    end

    sum
  end
end
