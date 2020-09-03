class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_names(fragment)
    Item.where('LOWER(items.name) LIKE ?', fragment)
  end

  def self.find_one(fragment)
    item = Item.find_by('LOWER(items.name) LIKE ?', fragment)
  end
end