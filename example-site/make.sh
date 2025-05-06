#!/bin/bash

### Will migrate out most stuff to generator app


case "$1" in
    usersdata/ )
        tomlq . manifest.toml > dist/manifest.json
        (cd usersdata && ls) | while read -r username; do
            mkdir -p "dist/u/$username"
            cat config/user.H.toml "usersdata/$username/$username.toml" | tomlq . > "dist/u/$username/profile.json"
            cp -a config/profile.html "dist/u/$username/index.html"
            bash utils/posts_to_feed.sh "usersdata/$username"
            mv "usersdata/$username/main.xml" "dist/u/$username/main.xml"
        done
        ;;
esac
