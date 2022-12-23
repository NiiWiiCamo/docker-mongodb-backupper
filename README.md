# Create and store MongoDB backups via mongodump

Based on linuxserver/baseimage-ubuntu with s6-overlay.

### Features
- connects to a MongoDB instance to create mongodump backups
- works with MongoDB Atlas
- (untested) works with self hosted MongoDB instances
- either stores backups locally or in an online git repository

### Tested scenario
- MonoDB Atlas free instance
- GitHub private repo, auth via ed25519 key
- local repo gets cleaned up before each dump (unsure)
- versioning should only persist in repo

### Volumes
| /data | output for backups, subfolder per database |
| ----- | ----- |
| /config | optional volume for ssh keys to import |

| ENV | Default | Description |
| ----- | ----- | ----- |
| PUID | 911 | User ID to run the container with |
| PGID | 1000 | Group ID |
| TZ | GMT | Timezone |
| MONGODB_DATABASE | database | database name |
| MONGODB_USER | admin | database user |
| MONGODB_PASS | admin | database password |
| MONGODB_URI | mongodb://localhost | mongo connection string, e.g. mongodb+srv://cluster1337.abc1234.mongodb.net |
| ----- | ----- | ----- |
| GIT_REPONAME | (only for git) | git repository name |
| GIT_USEREMAIL | (only for git) | email for git config |
| GIT_USERNAME | (only for git) | username for git config |
| GIT_REPOURI | (only for git) | git connection URI, e.g. git@github.com:myuser/mongobackups.git