class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def backup
    Backup.perform_async
    flash[:no_fade] = t('settings.backup.scheduled', path: Rails.configuration.backup_folder)
    redirect_to users_path
  end

  def show
    render
  end

  def update

    @errors = []

    check_range_and_set(:understate_threshold, (0..100000))
    check_range_and_set(:understate_factor, (1..20))
    check_range_and_set(:per_page, [5,10,15,20,25,50,100,500,1000,9999])
    check_range_and_set(:default_status, Client::STATES)
    check_range_and_set(:default_role, Client::ROLES)
    check_range_and_set(:show_revenue, User::ROLES)

    if @errors.empty?
      flash[:success] = t('settings.saved')
    else
      flash[:error] = @errors.join('. ')
    end
    redirect_to users_path(anchor: 'settings')
  end

  protected

  def check_range_and_set(key, valid_range)
    value = params[:settings][key]
    value = value.to_i if valid_range.first.is_a? Fixnum
    if valid_range.include? value
      Settings.instance.send("#{key.to_s}=", value)
      true
    else
      @errors << "'#{t("settings.#{key}")}' #{t('settings.update_error')}"
      false
    end
  end

end
