class CustomAuthenticationFailure < Devise::FailureApp
protected
  def redirect_url
    new_customer_registration_path
  end
end