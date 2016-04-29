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

* see an example of that file [here](https://bitbucket.org/antonija_simic/my_rails_app/src/e5bd90d7b65ee245bbb9b4ed5dfafb7a738f45ff/config/secrets.yml?at=master&fileviewer=file-view-default)
* yml is very sensitive to spaces and tabs!

### STEP 6
bin/rake db:migrate RAILS_ENV=development

### STEP 7
rails s
