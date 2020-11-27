FROM nginx:latest
RUN rm -f /etc/nginx/conf.d/*

COPY nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./views/ /app/
CMD nginx -g 'daemon off;' -c /etc/nginx/nginx.conf