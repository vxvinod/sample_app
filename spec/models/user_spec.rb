# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before do 
  	@user = User.new(name: "Example User", email: "user@example.com",password: "password",password_confirmation: "password") 
	
	end  	

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to (:password)}
  it { should respond_to(:password_confirmation)}

  describe "when name is not present" do
  	before { @user.name=""}
  	it{ should_not be_valid}
  end

  describe "when email is not present" do
  	before {@user.email=""}
  	it{ should_not be_valid }
  end

  describe "when name is too long" do
  	before {@user.name="a"*50}
  	it{ should_not be_valid }
  end

  describe " when email is invalid" do
	  	it "should be invalid" do
	  	address=%w[user@foo,com user_at_foo.org example.user@foo.
	                     foo@bar_baz.com foo@bar+baz.com]
		    address.each do |a|
		    @user.email=a
		    @user.should_not be_valid
			end
		end
	end

	describe "when email is valid"do
			it "should be valid" do
				address=%w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
				address.each do |a|
					@user.email=a
					@user.should be_valid
				end
			end
		end

	describe "email address should be unique" do
		before do
		user_same_email=@user.dup
		user_same_email.email=@user.email.upcase
		user_same_email.save
		end
		it {should_not be_valid}
	end

	describe "password is not present" do
		before do
			@user.password=@user.password_confirmation""
		end
		it { should_not be_valid }
		end	
		
		describe "password doesn't match confirmation" do
		before {@user.password_confirmation="mismatch"}
		it { should_npt be_valid }
	end

	describe "password  confirmation is nill" do
		before { @user.password_confirmation=nil}
		it{ should_not be_valid}
	end
end
