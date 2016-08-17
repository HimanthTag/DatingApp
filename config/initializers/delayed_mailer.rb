Thread.new do
  system("RAILS_ENV=production script/delayed_job start")
end