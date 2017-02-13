FROM maxmccarty/hackershall-prod-i

ENV NODE_ENV=development DEBUG_PORT=5858

EXPOSE $DEBUG_PORT

CMD ["./.docker/node_scripts/initialize.sh"]