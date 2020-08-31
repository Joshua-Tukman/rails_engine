desc 'import all csv files' do 
  namespace :db do 
    task :import_customers_csv => [:environment] do 

      info = { Customer => './db/csv_seeds/customers.csv' }
      binding.pry
    end 
  end 
end 