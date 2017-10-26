class User < ApplicationRecord
	has_one  :ship_address
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  self.per_page = 20
  WillPaginate.per_page = 20

  

  def self.search(search_params)
    if search_params && search_params != ""
      where("email ILIKE ?", "%#{search_params}%")
    else
      order('created_at')
    end
          
  end
end
