# PHP 5.3
# Copied from https://github.com/r8/vagrant-lamp
#

configure_options = node['php']['configure_options'].join(" ")

include_recipe "build-essential"
include_recipe "xml"

# Install Mysql
mysql_service 'default' do
  port node['mysql']['port']
  version node['mysql']['version']
  socket node['mysql']['socket']
  initial_root_password node['mysql']['initial_root_password']
  action [:create, :start]
end
mysql_client 'default' do
  action :create
end

pkgs = %w{ libc-client2007e-dev libfreetype6-dev libgmp3-dev libkrb5-dev libmcrypt-dev libssl-dev libt1-dev php5 php5-common php5-cli php5-mysql php5-gd php5-mcrypt php5-curl libapache2-mod-php5 php5-xmlrpc libapache2-mod-fastcgi php5-dev libbz2-dev libmysqlclient-dev libxpm-dev libmcrypt-dev libcurl4-gnutls-dev libxml2-dev libjpeg-dev libpng12-dev }

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

version = node['php']['version']

remote_file "#{Chef::Config[:file_cache_path]}/php-#{version}.tar.gz" do
  source "#{node['php']['url']}/php-#{version}.tar.gz"
  # checksum node['php']['checksum']
  mode "0644"
  not_if do ::File.exists?("/usr/bin/php53/php-cgi") end
end

execute "build php" do
  cwd Chef::Config[:file_cache_path]
  command <<-EOF
  tar -zxvf php-#{version}.tar.gz
  (cd php-#{version} && ./configure #{configure_options})
  (cd php-#{version} && make && make install)
  EOF
  not_if do ::File.exists?("/usr/bin/php53/php-cgi") end
end

directory node['php']['cgi_dir'] do
  owner "www-data"
  group "www-data"
  mode "0755"
end

directory node['php']['conf_dir'] do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

directory node['php']['ext_conf_dir'] do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "#{node['php']['cgi_dir']}/php53-cgi" do
  source "php53-cgi.erb"
  owner "www-data"
  group "www-data"
  mode "0755"
end
