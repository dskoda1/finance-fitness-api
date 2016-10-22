#Rails auth app  

## Installation:  

- update config/database.yml to use your apps name  
```bash
bundle install  
bundle exec rails db:reset  
bundle exec rails db:migrate  
bundle exec rails s  
```

To test this works, lets create a user and access a simple resource  

Go into the rails console with `bundle exec rails c`, and create a user:  
```ruby
User.create!(email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123')
```

Now lets generate a basic scaffold and see if we can access it.  

```bash
bundle exec rails g scaffold Item name:string description:text
bundle exec rails db:migrate

# Start the server in another terminal, and run:
curl -H "Content-Type: application/json" -X POST -d '{"email":"example@mail.com","password":"123123123"}' http://localhost:3000/authenticate
# {"auth_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NjA2NTgxODZ9.xsSwcPC22IR71OBv6bU_OGCSyfE89DvEzWfDU0iybMA"}

# Try to access items..
curl http://localhost:3000/items
# {"error":"Not Authorized"}

# now with the token you received earlier
curl -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NjA2NTgxODZ9.xsSwcPC22IR71OBv6bU_OGCSyfE89DvEzWfDU0iybMA" http://localhost:3000/items
# []



