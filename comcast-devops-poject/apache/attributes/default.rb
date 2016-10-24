    default['apache']['log_path'] = '/var/log/httpd'
    default['apache']['ssl_path'] = '/etc/pki/tls'
    default['apache']['ssl']['cert_file'] = "#{node['apache']['ssl_path']}/certs/localhost.crt"
    default['apache']['ssl']['key_file'] = "#{node['apache']['ssl_path']}/private/localhost.key"
