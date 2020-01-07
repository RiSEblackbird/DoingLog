# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :doing_logs, dependent: :destroy

  validates :username, presence: true,
                       length: { minimum: 2, maximum: 30, allow_blank: true },
                       uniqueness: { case_sensitive: false }
    

  validates :profile, length: { maximum: 150 }
  validates :password, length: { maximum: 20 }
end
