class Carpool < ActiveRecord::Base
  has_many :joined_carpools, dependent: :destroy
  has_many :users, through: :joined_carpools
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
end
