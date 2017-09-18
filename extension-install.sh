#!/bin/sh

cd ./vendor/publiux/stripe-payments
rsync -Rarz admin ../../../
rsync -Rarz catalog ../../../
rm -Rf vendor
