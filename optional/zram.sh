#!/bin/bash
# zram: swap that lives compressed in RAM instead of on disk.
# When memory runs out, rarely used pages get compressed (about 3:1) instead of
# programs being killed. No swap partition needed, so nothing unencrypted on disk.
# With plenty of RAM (16 GB+) you will rarely need it. Hibernation doesn't work with it.

# zram-generator creates the zram device at every boot from the config below.
sudo pacman -S --needed zram-generator

# Size: half of your RAM, compressed with zstd.
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF

# Start it now; after a reboot it starts by itself. Check with: zramctl or swapon
sudo systemctl daemon-reload
sudo systemctl start systemd-zram-setup@zram0.service
