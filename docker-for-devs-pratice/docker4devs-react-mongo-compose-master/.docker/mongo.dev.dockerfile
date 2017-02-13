FROM mongo:latest

MAINTAINER Max McCarty

RUN apt-get update && apt-get install -y netcat-traditional netcat-openbsd

COPY ./.docker/mongo_scripts /mongo_scripts

RUN touch /.runonce

RUN chmod +rx /mongo_scripts/*.sh

EXPOSE 27017

CMD ["/mongo_scripts/start.sh"]