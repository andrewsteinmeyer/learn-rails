class Contact < ActiveRecord::Base
  has_no_table

  column :name, :string
  column :email, :string
  column :content, :string

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true 
  validates :content, presence: true, length: {maximum: 500}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end