class Validators::InfectedUserValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:user, :infected_user) if infected_user?(record)
  end

  def infected_user?(record)
    record.user.infected
  end
end
