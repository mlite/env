#!/bin/bash
sudo addgroup --system buildbot
sudo adduser buildbot --system --ingroup buildbot --shell /bin/bash
sudo --login --user buildbot
