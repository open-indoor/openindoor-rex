#!/bin/bash

cat /var/data/in/myconfig_tmpl.toml | envsubst | tee /var/data/in/myconfig.toml

t_rex serve --openbrowser=false --config=myconfig.toml
