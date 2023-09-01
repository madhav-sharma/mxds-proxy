
on the cloud instance configure nginx with this config:

```
load_module /usr/lib/nginx/modules/ngx_stream_module.so;

events {
    worker_connections 1024;
}

stream {
    server {
        listen 80;
        proxy_pass 127.0.0.1:8080;
    }

    server {
        listen 443;
        proxy_pass 127.0.0.1:8443;
    }

    log_format basic '$remote_addr [$time_local] '
             '$protocol $status $bytes_sent $bytes_received '
             '$session_time "$upstream_addr" '
             '"$upstream_bytes_sent" "$upstream_bytes_received" "$upstream_connect_time"';

    access_log /var/log/nginx/stream.access.log basic;
    error_log /var/log/nginx/stream.error.log;
}

```
create a SSH tunnel using this:

```
ssh -R [cloud_instance_port_80]:localhost:80 -R [cloud_instance_port_443]:localhost:443 [cloud_user]@[cloud_instance_ip]
ssh -R 8080:localhost:8080 -R 8443:localhost:8443 root@170.187.185.157
```

useful nginx commands:

```
sudo systemctl restart nginx
sudo systemctl status nginx
sudo systemctl stop nginx
sudo systemctl start nginx
sudo systemctl reload nginx

cat /etc/nginx/nginx.conf

nginx -t

sudo nginx -s reload
sudo nginx -s stop
sudo nginx -s quit
sudo nginx -s reopen

tail -f /var/log/nginx/stream.error.log 
tail -f /var/log/nginx/stream.error.log

nginx -V 2>&1 | grep 'stream'
``` 
