FROM public.ecr.aws/docker/library/ruby:3.2-alpine

COPY docker-install.sh /tmp/docker-install.sh
RUN /tmp/docker-install.sh

COPY ./Gemfile* ./
RUN bundle install

WORKDIR /opt/app
COPY . ./

ENTRYPOINT ["/opt/app/bin/docker-entrypoint"]
