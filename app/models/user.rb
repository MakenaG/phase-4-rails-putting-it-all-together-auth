class User < ApplicationRecord
    has_many :recipes 
    has_secure_password 
    validates :username,{
        # length: {minimum:5,maximum:8},
        uniqueness: true,
        presence: true
    }
end