# moni-server-builder

This builds the server directory from Forge and Moni
releases, applies custom configuration, and deploys
server directory to a remote server.

## Release Flow

Upon new Moni release:

1. Upgrade builder
2. `rm -r server && ./build.zsh`
3. `./sync.zsh pink.bingecraft.net:moni.$(uuidgen)`
4. Backup currently running server
5. Stop currently running server
6. Change directory to next server
7. Unpack latest backup `./restore-latest-backup.zsh ~/moni.*/server/backups/*.zip`
8. Login to server and check if things are working
9. Chat an upgrade notice from the client
10. Update nebula #moni-intro entry
10. Update Pansmith #servers-parties entry
