class EmailUniquenessChecker
  def validate(email)
    if User.find_by_email(email).present?
      "taken"
    else
      "available"
    end
  end
end
