# Docker Compose Image for Nextcloud
This is a simplified version of nextcloud docker image for local development, based on https://github.com/nextcloud/docker

## Set up
* Download nextcloud source code and set up the submodules: https://docs.nextcloud.com/server/11/developer_manual/general/devenv.html
* Change ownership of the /nextcloud/source/code/folder/ to www-data:www-data
** Unless specified with a leading "/", all file/directory names are relative to the current directory
* Symlink src to /nextcloud/source/code/folder/
* Create a directory db_data
* Run docker-compose up
* Visit http://localhost:8000/nextcloud/ to set up your nextcloud instance
** During setup, set the database name to "db" (without the quotes)
** __Note__: if you change the database password in docker-compose.yml, you may need to remove /nextcloud/source/code/folder/ and db_data and re-do the setup process.
