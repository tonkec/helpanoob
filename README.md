# SETUP

### STEP 1
````rails s````

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
````bin/rake db:migrate RAILS_ENV=development````

### STEP 7
rails s

# Git workflow
## NEVER WORK ON MASTER BRANCH AND NEVER MERGE YOUR CODE TO MASTER

#### Don't fork this repo just clone it to your machine

```` https://github.com/tonkec/helpanoob.git ```` 

### STEP 1
* create your branch from master <br />
 ````git checkout master```` <br />
 ````git checkout -b name-of-your-branch````

### STEP 1
* work on your branch

### STEP 2
* commit your work

### STEP 3
* push your branch to github repo <br />
 ````git push -u name-of-origin name-of-your-branch````

### STEP 4
* create pull request to staging branch on github pages


# Sign up process
* emails are disabled in dev mode

### STEP 1
* sign up via form here http://localhost:3000/users/new

### STEP 2
* type ````rails c```` in terminal/command line

### STEP 3
````User.first ````
* you should see yourself

### STEP 4
```` User.first.confirm ````

### STEP 5
 ```` User.first.save ````

### STEP 5
* go to localhost:3000/users/sign_in and login with your credentials
