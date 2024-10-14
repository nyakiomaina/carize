#!/bin/sh
ipfs init
ipfs add --cid-version=1 --raw-leaves=false -r -Q /data > /output/output.cid
ipfs dag export `cat /output/output.cid` > /output/output.car