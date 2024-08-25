#!/usr/bin/env zsh
(crontab -l 2>/dev/null; echo "0 0 * * * archive=\$(ls -t ~/*/server/backups/*.zip | head -1) ; mkdir -p daily-backups ; cp \$archive daily-backups") | crontab -
