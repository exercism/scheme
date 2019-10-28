#!/usr/bin/env bash

grep 'href=\"/tracks' $1 | awk -F '(=| |>|<|"|/)' '{print $11}' > $2
