include_attribute "jetty"

expand!

default[:solr][:version]   = "4.4.0"
default[:solr][:link]      = "https://archive.apache.org/dist/lucene/solr/#{solr.version}/solr-#{solr.version}.tgz"
default[:solr][:checksum]  = "99c27527122fdc0d6eba83ced9598bf5cd3584954188b32cb2f655f1e810886b" #sha265
default[:solr][:directory] = "/usr/local/src"
default[:solr][:download]  = "#{solr.directory}/solr-#{solr.version}.tgz"
default[:solr][:extracted] = "#{solr.directory}/solr-#{solr.version}"
default[:solr][:war]       = "#{solr.extracted}/dist/solr-#{solr.version}.war"

default[:solr][:context_path]  = 'solr'
default[:solr][:home]          = "#{node.jetty.home}/#{node.solr.context_path}"
default[:solr][:core]          = "#{node.solr.home}/collection1"
default[:solr][:config]            = "#{node.solr.core}/conf"
default[:solr][:lib]               = "#{node.solr.core}/lib"
default[:solr][:data]          = "#{node.solr.core}/data"
default[:solr][:custom_config] = nil
default[:solr][:custom_lib]    = nil

default[:solr][:log4j][:email]         = "org.apache.log4j.net.SMTPAppender"
default[:solr][:log4j][:smtp_host]     = "smtp.gmail.com"
default[:solr][:log4j][:smtp_protocol] = "smtps"
default[:solr][:log4j][:smtp_username] = "alerts@email.com"
default[:solr][:log4j][:smtp_password] = "password"
default[:solr][:log4j][:from]          = "alerts@email.com"
default[:solr][:log4j][:to]            = "alertees@email.com"
default[:solr][:log4j][:subject]       = "Solr Error - #{node['hostname']}"
default[:solr][:log4j][:buffer_size]   = "1"
default[:solr][:log4j][:layout]        = "org.apache.log4j.PatternLayout"
default[:solr][:log4j][:layout_conversion_pattern] = "%m"
