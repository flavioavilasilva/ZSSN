# frozen_string_literal: true

class BarterService
  attr_accessor :barter

  def initialize(barter)
    @barter = barter
    @user_given = User.find(barter.given_items[:user_id]) if barter.given_items.present?
    @user_receiven = User.find(barter.receiven_items[:user_id]) if barter.receiven_items.present?
  end

  def call
    return false unless barter.valid?

    barter_items
  end

  private

  def barter_items
    ActiveRecord::Base.transaction do
      apply_the_barter(items_ids(barter.given_items[:items], @user_given), @user_receiven)
      apply_the_barter(items_ids(barter.receiven_items[:items], @user_receiven), @user_given)
    end
  rescue ActiveRecord::StatementInvalid => e
    barter.errors.add(:database, e)
    false
  end

  def apply_the_barter(items_ids, user_to)
    Item.where(id: items_ids)
        .update_all(user_id: user_to.id)
  end

  def items_ids(items, user)
    items_user_ids = []

    items.map do |item|
      items_user_ids += user.items.where(name: item[:name]).limit(item[:quantity]).map(&:id)
    end

    items_user_ids
  end
end
