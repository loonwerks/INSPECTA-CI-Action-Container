#! /bin/bash

set -Eeuxo pipefail

: "${SIREUM_DIR:=Sireum}"
: "${SIREUM_V:=4.20250721.f13c8b0e}"

mkdir -p $SIREUM_DIR/bin
pushd $SIREUM_DIR/bin
curl -JLso init.sh https://raw.githubusercontent.com/sireum/kekinian/$SIREUM_V/bin/init.sh
bash init.sh
install/fmide.cmd
#linux/fmide/osate -nosplash -console -consoleLog -application org.eclipse.equinox.p2.director -uninstallIU com.collins.trustedsystems.briefcase.feature.feature.group
popd
