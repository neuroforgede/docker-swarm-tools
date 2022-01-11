FROM nginx:1.21.5-alpine

RUN mkdir -p /etc/nginx/templates

COPY ./nginx.conf /etc/nginx/templates/nginx.conf
COPY ./run.sh /etc/nginx/run.sh

RUN chmod +x /etc/nginx/run.sh

ENV WORKER_CONNECTIONS=768
ENV DNS_RESOLVER=127.0.0.11
ENV DNS_RESOLVER_VALID=10s

CMD /etc/nginx/run.sh