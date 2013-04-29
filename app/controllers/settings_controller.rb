class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def backup
    Backup.perform_async
    redirect_to users_path, notice: t('settings.backup.scheduled',
                                      path: Rails.configuration.backup_folder)
  end

  def show
    render
  end

  def update

  end

end
