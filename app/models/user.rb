# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email , :name
  validates :name,presence: true ,length: {maximum: 13}
  VALID_EMAIL_REGX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true, format:{ with:VALID_EMAIL_REGX},
 					uniqueness:{ case_sensitive: false}
end
