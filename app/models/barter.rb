class Barter
  include ActiveModel::Validations

  validates_with Validators::GivenItemsValidator
  validates_with Validators::GivenItemsPointsValidator
  validates_with Validators::ReceivenItemsValidator
  validates_with Validators::GivenItemsPointsValidator
  
  attr_accessor :given_items, :given_items_points, :receiven_items, :receiven_items_points

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