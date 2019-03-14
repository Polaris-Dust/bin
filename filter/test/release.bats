#!/usr/bin/env bats

load bootstrap

PATH="$PATH:$BATS_TEST_DIRNAME/../bin"

export GITHUB_EVENT_PATH="$BATS_TEST_DIRNAME/fixtures/release_event.json"

@test "release: noop" {
  run release
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}

@test "release: matches draft" {
  run release draft=false
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}

@test "release: does not match draft" {
  run release draft=true
  [ "$status" -eq 78 ]
  [ "$output" = "Release properties don't match the draft filter" ]
}

@test "release: matches prerelease" {
  run release prerelease=true
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}

@test "release: does not match prerelease" {
  run release prerelease=false
  [ "$status" -eq 78 ]
  [ "$output" = "Release properties don't match the prerelease filter" ]
}

@test "release: matches both" {
  run release draft=false prerelease=true
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}
