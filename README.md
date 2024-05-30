# moni-server-builder
This builds the server directory from Forge and Moni
releases, applies custom configuration, and deploys
server directory to a remote server.

## Release Flow
1. Event: new Moni release
2. Upgrade builder
3. Deploy server directory
4. Pack/unpack backup
5. Optionally set alternate port and start server dark
6. Test server dark
7. Switch server dark and server live
8. Notify Discord and update Pansmith #servers-parties entry
