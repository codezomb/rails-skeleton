FROM public.ecr.aws/docker/library/ruby:3.2-alpine

RUN apk update && apk add --no-cache nginx nodejs npm

COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./ /tmp/hydra/

WORKDIR "/opt/app"
RUN <<EOT
cd /tmp/hydra && npm install && npm run build
mv ./dist /opt/app/ && rm -rf /tmp/hydra
EOT

CMD ["/usr/sbin/nginx"]
