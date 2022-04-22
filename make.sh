#!/usr/bin/env bash
docker build -t testing/local_stack/buildbase -f build.Dockerfile .
docker build -t testing/local_stack/runbase -f run.Dockerfile .
pack -vv builder create test_builder --config --pull-poliyc=if-not-present --config builder.toml
