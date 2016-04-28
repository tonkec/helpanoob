# SETUP

### STEP 1
rails s

* copy paste config.secret_key = 'SOME LONG STRING' into config/initializers/devise.rb

### STEP 2
* stop the server

### STEP 3
* create file secrets.yml in config/secrets.yml

### STEP 4
rake secret

### STEP 5
* copy paste output into secrets.yml

development: <br />
 secret_key_base: COPY_PASTED_OUTPUT_NOT_IN_QOUTES

### STEP 6
bin/rake db:migrate RAILS_ENV=development

### STEP 7
rails s
