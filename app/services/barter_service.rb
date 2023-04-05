# frozen_string_literal: true

class BarterService
  attr_accessor :barter

  def initialize(barter)
    @barter = barter
  end

  def call
    return false unless barter.valid?

    barter_items
  end

  private

  def barter_items
    ActiveRecord::Base.transaction do
      user_given = User.find(barter.given_items[:user_id])
      user_receiven = User.find(barter.receiven_items[:user_id])

      items_user_given_ids = extract_items_ids(barter.given_items[:items], user_given)
      items_user_receiven_ids = extract_items_ids(barter.receiven_items[:items], user_receiven)

      Item.where(id: items_user_given_ids).update_all(user_id: user_receiven.id)
      Item.where(id: items_user_receiven_ids).update_all(user_id: user_given.id)
    end
  rescue ActiveRecord::StatementInvalid => e
    barter.errors.add(:database, e)
    false
  end

  def extract_items_ids(items, user)
    items_user_ids = []

    items.map do |item|
      items_user_ids += user.items.where(name: item[:name]).limit(item[:quantity]).map(&:id)
    end

    items_user_ids
  end
end
