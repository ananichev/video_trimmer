class User
  include Mongoid::Document
  field :token, type: String

  has_many :videos, inverse_of: :user
end
