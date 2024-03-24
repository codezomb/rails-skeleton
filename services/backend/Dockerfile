FROM public.ecr.aws/docker/library/ruby:3.2-alpine

RUN <<EOF
apk update && apk add --no-cache bash gcompat postgresql-dev postgresql-client tzdata git vim
apk add --virtual build-dependencies build-base
EOF

COPY ./Gemfile* ./
RUN bundle install

WORKDIR /opt/app
COPY . ./

ENTRYPOINT ["/opt/app/bin/docker-entrypoint"]
