# frozen_string_literal: true

class Validators::Barter::ReceivenItemValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:receiven_items, :blank_or_nil) if blank_or_nil?(record)
    return record.errors.add(:receiven_items, :is_not_an_array) if not_an_array?(record)
    return record.errors.add(:receiven_items, :same_users_id) if same_users_id?(record)
    return record.errors.add(:receiven_items, :infected_user) if infected_user?(record)
  end

  private

  def same_users_id?(record)
    record.receiven_items[:user_id] == record.given_items[:user_id]
  end

  def not_an_array?(record)
    record.receiven_items[:items].is_a?(Array) == false
  end

  def blank_or_nil?(record)
    record.receiven_items.nil? || record.receiven_items[:items].blank?
  end

  def infected_user?(record)
    user = User.find(record.receiven_items[:user_id])
    user.infected
  end
end
