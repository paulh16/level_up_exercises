require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "Create new user" do

    it "validates a new valid user" do
      user = User.new
      user.first_name = "Paul"
      user.last_name = "Haddad"
      user.email = "paul@example.com"
      user.password = "secret"
      user.password_confirmation = "secret"

      expect(user).to be_valid
    end

    it "does not validate a new invalid user" do
      user = User.new
      user.first_name = ""
      user.last_name = ""
      user.email = "haddad"
      user.password = ""
      user.password_confirmation = ""

      user.valid?

      expect(user).not_to be_valid
    end

    it "does not validate a user with an invalid email address" do
      user = User.new
      user.first_name = "Paul"
      user.last_name = "Haddad"
      user.email = "paul"
      user.password = "secret"
      user.password_confirmation = "secret"

      expect(user).not_to be_valid
    end

    # Validations

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }

  end
end
