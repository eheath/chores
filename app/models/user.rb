class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :chores, dependent: :destroy
  has_many :doers, dependent: :destroy
  has_many :chore_trackers, dependent: :destroy
end
