class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, :through => :line_items
  belongs_to :user

  def total
    self.line_items.inject(0) { |sum, li| sum + (li.quantity * li.item.price)}
  end

  def add_item(item)
    new_line_item = self.line_items.find_by(item_id: item)
    if new_line_item
      new_line_item.quantity += 1
    else
      new_line_item = self.line_items.build(item_id: item)
    end
    new_line_item
  end

  def checkout
    line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
      line_item.destroy
    end
    user.remove_current_cart
    self.update(status: 'submitted')
  end
end
