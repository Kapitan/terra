server {
    listen 80;
    server_name ${serverip};
     
    location / {
      proxy_set_header        Host $host:$server_port;
      proxy_set_header        X-Real-IP $remote_addr;
      proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header        X-Forwarded-Proto $scheme;
 
      # Fix the "It appears that your reverse proxy set up is broken" error.
      proxy_pass          http://127.0.0.1:8080;
      proxy_read_timeout  90;
 
      #proxy_redirect      http://127.0.0.1:8080 https://jenkins.domain.tld;
  
      # Required for new HTTP-based CLI
      proxy_http_version 1.1;
      proxy_request_buffering off;
      # workaround for https://issues.jenkins-ci.org/browse/JENKINS-45651
      add_header 'X-SSH-Endpoint' always;
    }
    
    location ^~ /rundeck/ {
      
      # Fix the "It appears that your reverse proxy set up is broken" error.
      proxy_pass          http://127.0.0.1:4440;
      proxy_read_timeout  90;
      rewrite ^/rundeck/?(/rundeck)?$ /rundeck/menu/home redirect;
    }
  }


  