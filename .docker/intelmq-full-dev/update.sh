#!/bin/bash
echo "Installing requirements for bots in dev repository"
for file in $(find /opt/dev/mybots -name "*REQUIREMENTS.txt"); do pip3 install -r $file; done

echo "Merge your BOTS file with BOTS"
python3 /opt/dev/merge_BOTS.py

echo "Copying BOTS"
cp -a /opt/dev/mybots/bots/* /opt/intelmq/intelmq/bots/
cp /opt/intelmq/intelmq/bots/BOTS /opt/intelmq/etc/BOTS


echo "Installing new BOTS"
cd /opt/intelmq && pip3 install -e . --user && python3 setup.py install --user


