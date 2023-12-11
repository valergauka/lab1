require_relative 'main_application'

app = MainApplication.new

app.setup_data_storage

app.run
