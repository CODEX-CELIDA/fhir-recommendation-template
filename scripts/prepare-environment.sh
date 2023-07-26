#!/bin/bash

# this script prepares the environment for the CELIDA project

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/..

function box_out()
{
  local s=("$@") b w
  for l in "${s[@]}"; do
    ((w<${#l})) && { b="$l"; w="${#l}"; }
  done
  tput setaf 3
  echo " -${b//?/-}-
| ${b//?/ } |"
  for l in "${s[@]}"; do
    printf '| %s%*s%s |\n' "$(tput setaf 4)" "-$w" "$l" "$(tput setaf 3)"
  done
  echo "| ${b//?/ } |
 -${b//?/-}-"
  tput sgr 0
}

#box_out 'Downloading FHIR R5 CI build'
#/bin/bash $SCRIPT_DIR/download-fhir-r5-ci.sh

box_out 'Downloading CPG-on-EBMonFHIR package'
/bin/bash $SCRIPT_DIR/download-cpg-package.sh

box_out 'Installing SUSHI'
npm install -g fsh-sushi

box_out 'Downloading FHIR validator'
curl -L https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar -o ./validator_cli.jar

box_out 'Downloading IG Publisher'
curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o ./input-cache/publisher.jar --create-dirs
