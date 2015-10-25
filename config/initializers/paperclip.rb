paperclip_defaults = Rails.application.config_for :paperclip
paperclip_defaults.symbolize_keys!

Paperclip::Attachment.default_options.merge! paperclip_defaults
