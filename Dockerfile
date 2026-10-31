FROM ghcr.io/mhsanaei/3x-ui:latest

RUN apk add --no-cache nginx gettext

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
CMD []
