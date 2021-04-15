#!/bin/bash

echo "Installing requirements for bots in dev repository"
for file in $(find /opt/dev/mybots -name "*REQUIREMENTS.txt"); do pip3 install -r $file; done

if [ test -f /opt/intelmq/intelmq/bots/BOTS ]; then 
    if [ "${AUTO_MIX_BOTS}" = "true" ]; then
        # Backup Original BOTS
        cp /opt/intelmq/intelmq/bots/BOTS /opt/intelmq/intelmq/bots/BOTS.bk
        echo "Merge your BOTS file with BOTS"
        python3 /opt/dev/merge_BOTS.py "/opt/dev/mybots/BOTS" "/opt/intelmq/intelmq/bots/BOTS" "/opt/intelmq/intelmq/bots/BOTS"
        cp /opt/intelmq/intelmq/bots/BOTS /opt/intelmq/etc/BOTS
        echo "Copying BOTS"
        cp -a /opt/dev/mybots/bots/* /opt/intelmq/intelmq/bots/
        # Restore original BOTS
        mv /opt/intelmq/intelmq/bots/BOTS.bk /opt/intelmq/intelmq/bots/BOTS
    else
        cp /opt/intelmq/etc/BOTS /opt/intelmq/intelmq/bots/BOTS
    fi
fi

echo "Installing new BOTS"
cd /opt/intelmq && pip3 install -e . --user && python3 setup.py install --user



