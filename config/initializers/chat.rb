Thread.new do
  system("RAILS_ENV=production rackup private_pub.ru -s thin -D -E production") if Rails.env == "production"
  system("rackup private_pub.ru -s thin -E production") if Rails.env == "development"
end