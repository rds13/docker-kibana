#!/bin/bash

# check for link configuration via -link elasticsearch:es
if [ -n "$ES_PORT_9200_TCP" ] ; then
    ES_HOST="window.location.hostname"
    # redirect via haproxy
    ES_PORT="80"
else
  ES_HOST=${ES_HOST:-window.location.hostname}
  ES_PORT=${ES_PORT:-9200}
fi

cat << EOF > /usr/share/nginx/www/config.js
define(['settings'],
function (Settings) {
  return new Settings(
{
  elasticsearch:    "http://"  + $ES_HOST + ":" + "$ES_PORT",
  default_route:    '/dashboard/file/default.json',
  kibana_index:     'kibana-int',
  modules:          ['histogram','map','pie','table','filtering',
                    'timepicker','text','hits',
                    'column','trends','bettermap',
                    'query', 'terms', 'stats','sparklines'],
  }
);
});
EOF

nginx -c /etc/nginx/nginx.conf
