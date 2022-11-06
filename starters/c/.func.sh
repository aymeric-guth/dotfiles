#!/bin/sh

clean() {
  c_project_clean || return 1
  c_clean || return 1
}

build() {
  c_clean || return 1
  c_build_cmake || return 1
}

gen() {
  c_tools_gen || return 1
}

run() {
  c_deploy || return 1
  c_project_run || return 1
}

