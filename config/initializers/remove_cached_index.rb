# public/index.html is cached. When the application starts, it's possible
# that there is an old index.html file, so invalidate this cached file on app startup.

FileUtils.rm_rf "#{Viento::Application.config.root}/public/index.html"