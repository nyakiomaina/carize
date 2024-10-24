#!/bin/sh

ipfs init
ipfs add --cid-version=1 --raw-leaves=false -r -Q /data > /output/output.cid

if [ ! -s /output/output.cid ]; then
    echo "Error: Failed to retrieve CID."
    exit 1
fi

CID=$(cat /output/output.cid)

ipfs dag export "$CID" > /output/output.car

if ipfs --enc=json files stat "/ipfs/$CID" > /output/output.car.json; then
    echo "CAR and JSON files successfully created!"
else
    echo "Error: Failed to generate JSON file."
    exit 1
fi

if jq -r '.CumulativeSize' /output/output.car.json > /output/output.size; then
    echo " Cumulative size extracted to output.size successfully!"
else
    echo "Error: Failed to extract TotalSize."
    exit 1
fi
