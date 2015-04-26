module ApplicationHelper
  class << self
    def verify_admin_password(pw)
      BCrypt::Password.new(Granguerra::Application::CRYPTED_PASSWORD) == pw.to_s+Granguerra::Application::SALT
    end
  end
end
