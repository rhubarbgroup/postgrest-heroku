FROM ubuntu:20.04

ARG CONFD_VERSION=0.16.0

ENV DATABASE_URL ${DATABASE_URL:-"postgres://app_user:password@db:5432/app_db"}
ENV PGRST_DB_SCHEMA ${PGRST_DB_SCHEMA:-public}
ENV PORT ${PORT:-80}
ENV DEBIAN_FRONTEND noninteractive

COPY --from=postgrest/postgrest:v8.0.0 /bin/postgrest /bin/postgrest
COPY confd /etc/confd
COPY bin/generate.sh /bin/generate.sh

RUN apt-get update \
    && apt-get install -y --no-install-recommends tzdata curl supervisor nginx apache2-utils \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get -y autoremove \
    && apt-get clean \
    && echo "UTC" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
    && curl -fsSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /bin/confd \
    && chmod +x /bin/postgrest /bin/confd /bin/generate.sh

ENTRYPOINT ["/bin/generate.sh"]

CMD ["supervisord"]
