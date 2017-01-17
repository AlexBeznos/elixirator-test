class User < ApplicationRecord
  authenticates_with_sorcery!
  enum role: {
    employee: 0,
    management: 10,
    admin: 20
  }

  def self.avarage_managment_age
    management.average(:age).to_f
  end
end
