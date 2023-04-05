# frozen_string_literal: true

class Reports::AverageOfItemsByUser
  def self.items
    Item::VALID_ITEMS.map do |k, _v|
      { "#{k}": average_item_by_user(k) }
    end
  end

  def self.average_item_by_user(item)
    total_users = User.not_infected_users.count
    total_item = query_item_by_user(item).count

    return 'Dados insuficientes' if total_users < 1

    total_item / total_users
  end

  # Criar indices para user e items
  def self.query_item_by_user(item)
    Item.includes(:user)
        .where(user: { infected: false })
        .and(Item.where(name: item))
  end
end
