# frozen_string_literal: true

class Validators::Barter::GivenItemValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:given_items, :is_nil) if record.given_items.nil?

    if record.given_items[:items].nil? || record.given_items[:items].empty?
      return record.errors.add(:given_items,
                               :is_empty)
    end
    return record.errors.add(:given_items, :is_not_an_array) if record.given_items[:items].is_a?(Array) == false
    return record.errors.add(:given_items, :empty) if record.given_items[:items].empty?

    if record.given_items[:user_id] == record.receiven_items[:user_id]
      return record.errors.add(:given_items,
                               :equal_users)
    end
    return record.errors.add(:given_items, :infected_user) if infected_user?(record)
  end

  private

  def infected_user?(record)
    user = User.find(record.given_items[:user_id])
    user.infected
  end
end
