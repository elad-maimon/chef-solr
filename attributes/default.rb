include_attribute "jetty"

expand!

default[:solr][:version]   = "4.3.1"
default[:solr][:link]      = "http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/#{solr.version}/solr-#{solr.version}.tgz"
default[:solr][:checksum]  = "99c27527122fdc0d6eba83ced9598bf5cd3584954188b32cb2f655f1e810886b" #sha265
default[:solr][:directory] = "/usr/local/src"
default[:solr][:download]  = "#{solr.directory}/solr-#{solr.version}.tgz"
default[:solr][:extracted] = "#{solr.directory}/solr-#{solr.version}"
default[:solr][:war]       = "#{solr.extracted}/dist/solr-#{solr.version}.war"

default[:solr][:context_path]  = 'solr'
default[:solr][:home]          = "#{node.jetty.home}/#{node.solr.context_path}"
default[:solr][:core]          = "#{node.solr.home}/collection1"
set[:solr][:config]            = "#{node.solr.core}/conf"
set[:solr][:lib]               = "#{node.solr.core}/lib"
default[:solr][:data]          = "#{node.solr.core}/data"
default[:solr][:custom_config] = nil
default[:solr][:custom_lib]    = nil
