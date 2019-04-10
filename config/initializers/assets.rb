# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( lbd4/demo.js lbd4/bootstrap.min.css lbd4/plugins/bootstrap-notify.js lbd4/plugins/jquery.sharrre.js lbd4/plugins/bootstrap-switch.js lbd4/demo.css lbd4/plugins/chartist.min.js lbd4/light-bootstrap-dashboard.js lbd4/light-bootstrap-dashboard.css.erb lbd4/plugins/bootstrap-select.js lbd4/plugins/bootstrap-notify.js communities.coffee lbd/bootstrap.min.js lbd/bootstrap.min.css lbd/demo.css communities.scss noty.css noty.min.js lbd/animate.min.css lbd/light-bootstrap-dashboard.css lbd/pe-icon-7-stroke.css lbd/bootstrap-notify.js lbd/bootstrap-select.js lbd/chartist.min.js lbd/light-bootstrap-dashboard.js )

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
