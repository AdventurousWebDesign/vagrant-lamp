include_recipe "apt"
include_recipe "build-essential"
include_recipe "git"
include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_ssl"
include_recipe "php53"
include_recipe "apache2::mod_env"
include_recipe "apache2::mod_mime"
include_recipe "apache2::mod_actions"
include_recipe "apache2::mod_cgi"
include_recipe "apache2::mod_alias"
include_recipe "mailhog"
include_recipe "postfix"

# Initialize php extensions list
php_extensions = []

# Install packages
%w{ debconf vim tmux mc subversion curl make g++ libsqlite3-dev graphviz libxml2-utils links }.each do |a_package|
  package a_package
end

# Generate selfsigned ssl
execute "make-ssl-cert" do
  command "make-ssl-cert generate-default-snakeoil --force-overwrite"
end

# Initialize sites data bag
sites = []
begin
  sites = data_bag("sites")
rescue
  puts "Unable to load sites data bag."
end

# Configure sites
sites.each do |name|
  site = data_bag_item("sites", name)

  # Add site to apache config
  web_app site["host"] do
    template "web_app.conf.erb"
    server_name site["host"]
    server_aliases site["aliases"]
    server_include site["include"]
    cgi_path node["php"]["cgi_path"]
    cgi_dir node["php"]["cgi_dir"]
    docroot site["docroot"]?site["docroot"]:"/vagrant/public/#{site["host"]}"
    notifies :restart, resources("service[apache2]"), :delayed
  end

   # Add site info in /etc/hosts
   bash "hosts" do
     code "echo 127.0.0.1 #{site["host"]} #{site["aliases"].join(' ')} >> /etc/hosts"
   end
end

# Disable default site
apache_site "default" do
  enable false
end

# Enable installed php extensions
case node['platform']
  when 'ubuntu'
    if node['platform_version'].to_f >= 14.04
      php_extensions.each do |extension|
        execute 'enable_php_extension' do
          command "php5enmod #{extension}"
        end
      end
    end
  else
end
