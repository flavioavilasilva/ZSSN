# frozen_string_literal: true

class Validators::InfectedAlert::WarnedByValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:warned_by, :cant_be_nil) if record.warned_by.nil?
    return record.errors.add(:warned_by, :infected_user) if infected_user?(record)
  end

  private

  def infected_user?(record)
    record.warned_by.infected
  end
end
