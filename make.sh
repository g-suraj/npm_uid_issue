#!/usr/bin/env bash
docker build -t testing/local_stack/buildbase -f stack/build.Dockerfile .
docker build -t testing/local_stack/runbase -f stack/run.Dockerfile .
pack -vv builder create test_builder --config --pull-poliyc=if-not-present --config builder.toml
pack build test_image -p ./application --builder test_builder --trust-builder
