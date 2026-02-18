#! /bin/bash

set -Eeuxo pipefail

: "${SIREUM_DIR:=Sireum}"
: "${SIREUM_V:=4.20260115.7c92e7f9}"

mkdir -p $SIREUM_DIR/bin
pushd $SIREUM_DIR/bin
curl -JLso init.sh https://raw.githubusercontent.com/sireum/kekinian/$SIREUM_V/bin/init.sh
bash init.sh
popd
