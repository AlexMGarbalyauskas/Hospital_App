# app/models/current.rb

#used to store attributes for the current request
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
