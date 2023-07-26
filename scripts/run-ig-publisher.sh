#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# download cpg-on-ebm-on-fhir package
/bin/bash $SCRIPT_DIR/download-cpg-package.sh

# run sushi
sushi .

# download & run publisher
curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o ./input-cache/publisher.jar --create-dirs
java -jar input-cache/publisher.jar publisher -ig . -no-sushi
