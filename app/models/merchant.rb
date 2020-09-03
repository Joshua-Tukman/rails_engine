class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices

  def self.most_money(limit)
    merchants = Merchant.select("merchants.*, sum(quantity * unit_price) as revenue")
                        .joins(invoices: [:invoice_items, :transactions])
                        .where("invoices.status = 'shipped' AND transactions.result = 'success'")
                        .group(:id)
                        .order("revenue desc")
                        .limit(limit)
    # Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").joins(:invoices).joins(:invoice_items).joins(:transactions).where("transactions.result = 'success' AND invoices.status = 'shipped'").group(:id).order('revenue desc').limit(7)                     
  end
  
  def self.most_items(limit)
    merchants = Merchant.joins(invoices: [:invoice_items, :transactions])
                        .where("transactions.result = 'success'")
                        .group('merchants.id')
                        .select('merchants.id, merchants.name, sum(invoice_items.quantity) AS number_items')
                        .order('number_items DESC')
                        .limit(limit)
  end
  
  def self.revenue(id)
    merchant = Merchant.select('merchants.id, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').joins(items: :invoice_items).where('merchants.id = ?', id).group(:id)
    merchant.first.revenue
  end
  
  def self.find_names(fragment)
    Merchant.where('LOWER(merchants.name) LIKE ?', fragment)
  end

  def self.find_one(fragment)
    Merchant.find_by('LOWER(merchants.name) LIKE ?', fragment)
  end 
end
    
    