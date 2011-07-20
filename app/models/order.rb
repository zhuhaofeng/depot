class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  #add validations
  validates :name, :address, :email, :pay_type, :presence => true
  validates :email, :format => {
    :with    => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    :message => "The email address is invalid!"
  }
  validates :pay_type, :inclusion => PAYMENT_TYPES
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
