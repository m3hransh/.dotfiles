#!/bin/bash

cd /tmp/
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.2.zip
# sha1sum: d1038e6d62cac6f60b0dd8caa8d5849c79065a7b
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo ./install-client
sudo ./install-video
