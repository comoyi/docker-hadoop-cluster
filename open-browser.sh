#!/bin/bash

# Open browser

which google-chrome > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    nohup google-chrome --new-window 127.0.0.1:8088 127.0.0.1:9870 127.0.0.1:19888 > /dev/null 2>&1 &
    exit 0
fi

which google-chrome-stable > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    nohup google-chrome-stable --new-window 127.0.0.1:8088 127.0.0.1:9870 127.0.0.1:19888 > /dev/null 2>&1 &
    exit 0
fi

printf "\033[31mNo browser found!\033[0m\n"
exit 1
