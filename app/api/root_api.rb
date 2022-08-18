class RootAPI < Grape::API
  helpers ApiAuthHelper
  helpers SerializersHelper
  include ApiLocaleConcerns

  format :json

  namespace :auth do
    mount Auth::SignInAPI
    mount Auth::SignOutAPI
    mount Auth::SignUpAPI
  end
  mount CurrentUserAPI
  mount ProfileAPI
  mount UsersAPI
  mount SearchAPI

  add_swagger_documentation(
    hide_documentation_path: true,
    mount_path: '/swagger_doc',
    hide_format: true
  )
end
