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
default[:solr][:home]          = "#{node.jetty.home}/webapps/#{node.solr.context_path}"
set[:solr][:config]            = "#{node.solr.home}/conf"
set[:solr][:lib]               = "#{node.solr.home}/lib"
default[:solr][:data]          = "#{node.solr.home}/data"
default[:solr][:custom_config] = nil
default[:solr][:custom_lib]    = nil
