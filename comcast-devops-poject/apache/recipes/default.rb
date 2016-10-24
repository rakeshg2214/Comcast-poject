#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#to update the packages
execute "update" do
  command "yum update all -y"
  action :run
end

package "httpd" do
  action :install
end

service "httpd" do
  action [:enable, :start]
end

cookbook_file '/var/www/html/index.html' do
source 'index.html'
  owner 'apache'
  group 'apache'
  mode '0755'
  action :create
end

include_recipe 'apache2'
include_recipe 'apache2::mod_ssl'
include_recipe 'apache2::mod_rewrite'


%w{proxy proxy_http}.each do |apache_mod|
  apache_module apache_mod do
    conf false
  end
end

cert_file = node['apache']['ssl']['cert_file']
priv_file = node['apache']['ssl']['key_file']

web_app "jenkins-proxy" do
  template 'jenkins-proxy.conf.erb'
  certificate_file cert_file
  private_file priv_file
end

