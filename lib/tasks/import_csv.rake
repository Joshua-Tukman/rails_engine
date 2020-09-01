require 'csv'
desc "import all csv files"
namespace :db do 
  task :import_customers => [:environment] do 

    info = { Customer => './db/csv_seeds/customers.csv' }

    Customer.destroy_all

    info.each do |object, path|
      CSV.foreach(path, headers: true) do |row|
        Customer.create! row.to_hash
      end 
    end 
  end
  task :import_merchants => [:environment] do 
    
    info = { Merchant => './db/csv_seeds/merchants.csv' }

    Merchant.destroy_all 

    info.each do |object, path|
      CSV.foreach(path, headers: true) do |row|
        Merchant.create!(row.to_hash)
      end 
    end 
  end
  task :import_invoices => [:environment] do 
    info = { Invoice: './db/csv_seeds/invoices.csv' }

    Invoice.destroy_all 

    info.each do |object, path|
      CSV.foreach(path, headers: true) do |row|
        Invoice.create!(row.to_hash)
      end 
    end 
  end
  task :import_items => [:environment] do
    info = { Item: './db/csv_seeds/items.csv'}
    Item.destroy_all
    info.each do |object, path|
      CSV.foreach(path, headers: true) do |row|
        if row['unit_price']
          row['unit_price'] = row['unit_price'].to_f / 100 
        end
        Item.create!(row.to_hash)
      end
    end
  end 
  task :import_invoice_items => [:environment] do
    info = { :InvoiceItems => './db/csv_seeds/invoice_items.csv' }
    InvoiceItem.destroy_all 
    info.each do |object, path|
      CSV.foreach(path, headers:true) do |row|
        if row['unit_price'] 
          row['unit_price'] = row['unit_price'].to_f / 100
        end  
      InvoiceItem.create!(row.to_hash)
      end
    end 
  end
  task :import_transactions => [:environment] do 
    info = { :transations => './db/csv_seeds/transactions.csv' }
  
    Transaction.destroy_all 
    info.each do |object, path|
      CSV.foreach(path, headers: true) do |row|
        Transaction.create!(row.to_hash)
      end
    end 
  end 
  task :all => [:import_merchants, :import_customers, :import_invoices, :import_items, :import_invoice_items, :import_transactions ]
end
  