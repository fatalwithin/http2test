FROM nginx:latest

# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx && chmod -R g+w /etc/nginx

# users are not allowed to listen on privileged ports
RUN sed -i.bak 's/listen\(.*\)80;/listen 8081;/' /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl/

COPY http2test-key.pem /etc/nginx/ssl/http2test-key.pem

COPY http2test.pem /etc/nginx/ssl/http2test.pem

RUN mkdir -p /var/www/static/

COPY index.html /var/www/static/index.html

COPY index_http2.html /usr/share/nginx/html/index.html

EXPOSE 4443

EXPOSE 8081

# comment user directive as master process is run as user in OpenShift anyhow
# RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

# RUN addgroup nginx root

# USER nginx
