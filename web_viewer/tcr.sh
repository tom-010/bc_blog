./scripts/buildIt.sh && \
(./scripts/test.sh && ./scripts/commit.sh || ./scripts/revert.sh)
