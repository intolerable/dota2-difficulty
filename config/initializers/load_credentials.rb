ENV["CREDENTIALS_PASSWORD"] = YAML.load_file("#{Rails.root}/config/credentials.yml")["password"]
ENV["CREDENTIALS_USERNAME"] = YAML.load_file("#{Rails.root}/config/credentials.yml")["username"]
