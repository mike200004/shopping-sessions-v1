# Shopping Sessions (Rust)

Fast pipeline for the Builders Buildathon Shopping Sessions track. It reads the
CSV inputs from `$DATA_DIR`, sessionizes events per person, attributes sessions
to clicks, and writes `user_daily/` and `campaign_daily/` Parquet tables to
`$OUTPUT_DIR`. It uses `$NCPU` threads.

No third-party code or libraries; std only (including a small hand-written Parquet writer).

Build and run:

    docker build --platform linux/amd64 -t shopping-sessions .
    docker run --rm --network none --read-only --user 1000:1000 \
      -v /path/to/data:/data:ro -v /path/to/out:/output shopping-sessions

`.github/workflows/validate.yml` builds the image and checks it against the
organizers' fixtures and dev answer (downloaded at CI time).
