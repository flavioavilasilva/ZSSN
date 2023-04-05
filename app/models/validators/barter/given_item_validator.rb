# frozen_string_literal: true

class Validators::Barter::GivenItemValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:given_items, :blank_or_nil) if blank_or_nil?(record)
    return record.errors.add(:given_items, :is_not_an_array) if not_an_array?(record)
    return record.errors.add(:given_items, :same_users_id) if same_users_id?(record)
    return record.errors.add(:given_items, :infected_user) if infected_user?(record)
  end

  private

  def same_users_id?(record)
    record.given_items[:user_id] == record.receiven_items[:user_id]
  end

  def not_an_array?(record)
    record.given_items[:items].is_a?(Array) == false
  end

  def blank_or_nil?(record)
    record.given_items.nil? || record.given_items[:items].blank?
  end

  def infected_user?(record)
    user = User.find(record.given_items[:user_id])
    user.infected
  end
end
