class Reports::LostPointsByInfectedUser
  def self.points
    valid_items = Item::VALID_ITEMS.keys
    query_item_by_user(valid_items).sum(:points)
  end

  # Criar indices para user e items
  def self.query_item_by_user(items)
    Item.includes(:user).where(user: { infected: true }).and(Item.where(name: items))
  end
end

