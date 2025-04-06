FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y mysql-server supervisor python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV MYSQL_ROOT_PASSWORD=Azeem@123
ENV MYSQL_DATABASE=aptipro

COPY init.sql /docker-entrypoint-initdb.d/
RUN echo "from http.server import SimpleHTTPRequestHandler; from socketserver import TCPServer; TCPServer(('0.0.0.0', 10000), SimpleHTTPRequestHandler).serve_forever()" > /http_server.py

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 10000 3306

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]