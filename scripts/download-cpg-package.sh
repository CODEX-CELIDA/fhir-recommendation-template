#!/bin/bash

# this script downloads the latest package version of CPG-on-EBMonFHIR from github

cpg_version=$(grep -A1 'de.netzwerk-universitaetsmedizin.ebm-cpg:' sushi-config.yaml | tail -n1 | awk '{ print $2}')
echo $cpg_version

# Check if the string was found
if [ -z "$cpg_version" ]; then
    echo "ebm-cpg package version not found in sushi-config.yaml"
    exit 1  # Exit the script with a non-zero exit code
fi

filename="de.netzwerk-universitaetsmedizin.ebm-cpg-$cpg_version.tgz"
package_url="https://github.com/CEOsys/cpg-on-ebm-on-fhir/releases/download/v$cpg_version/$filename"
echo $package_url

mkdir -p $HOME/.fhir
mkdir -p $HOME/.fhir/packages

path="$HOME/.fhir/packages/de.netzwerk-universitaetsmedizin.ebm-cpg#$cpg_version"
echo $path
mkdir -p $path
cd $path

echo $filename
curl -L -o $filename -s $package_url
tar -zxf $filename
rm $filename

#ls -al $HOME/.fhir/packages
