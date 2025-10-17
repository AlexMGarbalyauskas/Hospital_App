#email string 
#password_digest string 

#password:string virtual 
#password_confirmation:string virtual 
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_secure_password 

    validates :email, presence: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a validate email address"} 
end
