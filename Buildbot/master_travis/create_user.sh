#!/bin/bash
sudo addgroup --system buildbot
sudo adduser buildbot_master --system --ingroup buildbot --shell /bin/bash
#sudo --login --user buildbot_master
