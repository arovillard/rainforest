class Product < ActiveRecord::Base
  validates :name, :description, :price_in_cents, :presence => true
  # validates :price_in_cents, :numericality => {:only_integer => true}

  before_update :tocents

  def tocents
    (self.price_in_cents *= 100).to_i
  end

  def formatted_price
    price_in_dollars = price_in_cents.to_f / 100
    sprintf("%.2f", price_in_dollars)
  end

  has_many :reviews
  has_many :reviewers, :through => :reviews, :class_name =>'User'
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
end
