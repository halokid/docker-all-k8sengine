FROM nginx:latest

MAINTAINER Max McCarty

VOLUME /var/cache/nginx

# Copy custom nginx config
COPY ./.docker/config/nginx.development.conf /etc/nginx/nginx.conf

# Copy custom nginx config
COPY ./shared/assets /var/app/dist

EXPOSE 80

#We can use CMD with ENTRYPOINT which could provide a clear way for users to provide overriding
#parameters in CMD to the ENTRYPOINT command
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]