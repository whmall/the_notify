require 'active_support/configurable'

module TheNotify
  include ActiveSupport::Configurable

  configure do |config|
    config.admin_class = 'Admin::BaseController'
    config.my_class = 'Admin::BaseController'
    config.user_message_class = 'MyWhmallController'
  end

end