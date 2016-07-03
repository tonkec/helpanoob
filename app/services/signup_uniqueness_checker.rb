class SignupUniquenessChecker
  def validate_email(email)
    if User.find_by_email(email).present?
      "taken"
    else
      "available"
    end
  end

  def validate_username(username)
    if User.find_by_username(username).present?
      "taken"
    else
      "available"
    end
  end
end
