class Validators::Item::NameItemValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:name, :is_not_a_valid_item) if invalid_item?(record.name)
  end

  def invalid_item?(name)
    return true if name.nil?
    
    Item::VALID_ITEMS.include?(name.to_sym) == false
  end
end
