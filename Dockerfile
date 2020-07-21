FROM openjdk:8
RUN groupadd -r app \
  && useradd --no-log-init -m -g app app
USER app
WORKDIR /home/app
ENV PATH=$PATH:/home/app/.embulk/bin:/home/app/google-cloud-sdk/bin
ADD google-cloud-sdk.tar.gz /home/app/
COPY --chown=app:app embulk /home/app/.embulk/bin/embulk
# COPY embulk_run.sh /home/app/embulk_run.sh
RUN embulk gem install embulk-input-gcs embulk-output-bigquery embulk-decoder-commons-compress embulk-parser-poi_excel embulk-filter-row
RUN mkdir /home/app/work
WORKDIR /home/app/work
#ENTRYPOINT ["/bin/bash", "/home/app/embulk_run.sh"]
ENTRYPOINT ["java", "-jar", "/home/app/.embulk/bin/embulk"]
