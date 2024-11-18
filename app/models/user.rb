class User < ApplicationRecord
    validates :uid, presence: true, uniqueness: true
    validates :email, presence: true
    validates :name, presence: true
  end