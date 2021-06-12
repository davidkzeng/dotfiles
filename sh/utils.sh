#!/bin/bash

function has_cmd() {
    [[ -x "$(command -v "$1")" ]]
}
