class Product < ActiveRecord::Base
  validates :name, :description, :price_in_cents, :presence => true
  validates :price_in_cents, :numericality => {:only_integer => true}

  def formatted_price
    price_in_dollars = price_in_cents.to_f / 100
    sprintf("%.2f", price_in_dollars)
  end

  has_many :reviews
  has_many :users, :through => :reviews
end
