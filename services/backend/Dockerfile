FROM public.ecr.aws/docker/library/ruby:3.2-alpine

WORKDIR /work

RUN <<EOF
apk update && apk add --no-cache bash gcompat postgresql-dev \
  postgresql-client tzdata git vim nodejs npm nginx

apk add --virtual build-dependencies build-base

adduser -D -s /bin/bash ubuntu
chown -R ubuntu:ubuntu /work
EOF

USER ubuntu

ARG BUNDLE_WITHOUT=development:test
ARG RAILS_ENV=production

ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV RAILS_ENV ${RAILS_ENV}
ENV NODE_ENV ${RAILS_ENV}

COPY --chown=ubuntu:ubuntu ./Gemfile* ./
RUN bundle install

COPY --chown=ubuntu:ubuntu . ./
RUN npm install
RUN rails assets:precompile

ENTRYPOINT ["/work/bin/entrypoint"]
