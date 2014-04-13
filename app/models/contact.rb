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

  def update_spreadsheet
    connection = GoogleDrive.login(Rails.application.secrets.gmail_username, Rails.application.secrets.gmail_password)
    ss = connection.spreadsheet_by_title('Learn-Rails-Example')
   
    if ss.nil?
      ss = connection.create_spreadsheet('Learn-Rails-Example')
    end
    ws = ss.worksheets[0]
    last_row = 1 + ws.num_rows
    ws[last_row, 1] = Time.new
    ws[last_row, 2] = self.name
    ws[last_row, 3] = self.email
    ws[last_row, 4] = self.content
    ws.save
  end
end