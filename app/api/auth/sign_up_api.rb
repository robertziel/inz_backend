module Auth
  class SignUpAPI < Grape::API
    resource :sign_up do
      desc 'Sign up' do
        headers ApiDescHelper.with_common_headers(auth: false)
      end

      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
        requires :password_confirmation, type: String, desc: 'User confirmation'
      end

      post do
        user = ::User.new(params)

        if user.save
          {
            success: true,
            errors: []
          }
        else
          {
            success: false,
            errors: user.errors.messages
          }
        end
      end
    end
  end
end
