paperclip_defaults = Rails.application.config_for :paperclip
paperclip_defaults.symbolize_keys!

Paperclip::Attachment.default_options[:default_url] = ActionController::Base.helpers.asset_path('/assets/missing.png')

Paperclip::Attachment.default_options.merge! paperclip_defaults
