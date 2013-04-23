class ConfigurationController < ApplicationController

  before_filter :authenticate_user!

  def backup
    Backup.perform_async
    redirect_to users_path, notice: t('config.backup.scheduled')
  end

end
