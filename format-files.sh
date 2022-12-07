#!/usr/bin/env bash

(set -x; ls NotificationHubs/*.[hm] | xargs clang-format -i -style=file;)
