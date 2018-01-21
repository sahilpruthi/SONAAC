class UserMailer < ApplicationMailer

	default from: "service@sonaac.com"
	def forgot_password(user)
		@user = user
		mail(to: @user.email, subject: 'Forgot Password')
	end

	def driver_forgot_password(driver)
		@driver = driver
		mail(to: @driver.email, subject: 'Forgot Unique Key')
	end
end
