## WIP: ApiController Generator

Generates a API controller with fully functioning endpoints for basic crud operations of a model.

Note: The model should already exist.

**Installation**

Add below line to your `Gemfile` and run `bundle install`.

 ```
 gem 'rails-api_controller_generator'
 ```



**Usage**

1. Initialize the generator.

 ```
 rails generate api_controller:install
 ```

2. Generate your controller

 ```
 rails generate api_controller <your-model-name>
 ```
