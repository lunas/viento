class StartSweeper < ActionController::Caching::Sweeper
  observe Sale

  def sweep(sale)
    expire_page root_path
    #FileUtils.rm_rf "#{page_cache_directory}/products/page"
  end

  alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep
end