#!/bin/bash
sudo addgroup --system buildbot
sudo adduser buildbot_worker --system --ingroup buildbot --shell /bin/bash
#sudo --login --user buildbot_worker
