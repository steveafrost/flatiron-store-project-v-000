class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  has_many :orders
  belongs_to :current_cart, class_name: "Cart"

  def create_current_cart
    self.update(current_cart_id: carts.create.id)
  end

  def remove_current_cart
    self.update(current_cart_id: nil)
  end
end
