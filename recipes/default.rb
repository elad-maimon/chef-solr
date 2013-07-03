#
# Cookbook Name:: solr
# Recipe:: default
#
# Copyright 2010, Jiva Technology Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "jetty"

remote_file node.solr.download do
  action :create_if_missing
  source   node.solr.link
  checksum node.solr.checksum
  mode     0644
end

bash 'unpack solr' do
  code   "tar xzf #{node.solr.download} -C #{node.solr.directory}"
  not_if "test -d #{node.solr.extracted}"
end

bash 'install solr war into jetty' do
  code   "cp #{node.solr.war} #{node.jetty.home}/webapps/solr.war"
  not_if "test `sha256sum #{node.jetty.home}/webapps/solr.war | cut -d ' ' -f 1` = `sha256sum #{node.solr.war} | cut -d ' ' -f 1`"
  notifies :restart, resources(:service => "jetty")
end

bash 'copy logging jars into jetty' do
  code "cp #{node.solr.extracted}/example/lib/ext/* #{node.jetty.home}/lib/ext"
  notifies :restart, resources(:service => "jetty")
end

bash 'copy logging configuration into jetty' do
  code "mkdir #{node.jetty.home}/resources; cp #{node.solr.extracted}/example/resources/log4j.properties #{node.jetty.home}/resources"
  notifies :restart, resources(:service => "jetty")
end

directory node.solr.lib do
  owner     node.jetty.user
  group     node.jetty.group
  recursive true
  mode      "750"
  notifies :restart, resources(:service => "jetty")
end

directory node.solr.config do
  owner node.jetty.user
  group node.jetty.group
  recursive true
  mode "750"
  notifies :restart, resources(:service => "jetty")
end

directory node.solr.data do
  owner     node.jetty.user
  group     node.jetty.group
  recursive true
  mode      "750"
end

bash 'copy dist folder into solr home' do
  code "cp -r #{node.solr.extracted}/dist #{node.solr.lib}"
  notifies :restart, resources(:service => "jetty")
end

bash 'copy contrib folder into solr home' do
  code "cp -r #{node.solr.extracted}/contrib #{node.solr.lib}"
  notifies :restart, resources(:service => "jetty")
end

directory "#{node.jetty.home}/webapps" do
  owner     node.jetty.user
  group     node.jetty.group
  recursive true
  mode      "750"
end

remote_file "#{node.solr.lib}/postgresql-9.2-1002.jdbc4.jar" do
  action :create_if_missing
  source "http://jdbc.postgresql.org/download/postgresql-9.2-1002.jdbc4.jar"
  backup 0
  mode "640"
  owner node.jetty.user
  group node.jetty.group
end

template "#{node.jetty.home}/contexts/solr.xml" do
  owner  node.jetty.user
  source "solr.context.erb"
  notifies :restart, resources(:service => "jetty")
end

template "#{node.jetty.home}/resources/log4j.properties" do
  owner  node.jetty.user
  source "log4j.properties.erb"
  notifies :restart, resources(:service => "jetty")
end
