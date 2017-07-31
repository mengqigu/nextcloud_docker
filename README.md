# Docker Compose Image for Nextcloud
This is a simplified version of nextcloud docker image for local development,
based on [the official Nextcloud docker image](https://github.com/nextcloud/docker)


## Set up
1. Download nextcloud source code and set up the submodules following the
[documentation](https://docs.nextcloud.com/server/11/developer_manual/general/devenv.html)
2. Change ownership of the `/nextcloud/source/code/folder/` to `www-data:www-data` and change permissions accordingly
3. Create a directory `db_data` in this project's root folder
  * You can technically create the `db_data` directory anywhere
4. Generate the `docker-compose.yml` by running the shell script:
```
./generate-docker-compose-file.sh
```
  * You will be prompted to enter an absolute unix path for `/nextcloud/source/code/folder/` and for `db_data`
  * The `docker-compose.yml` file will be generated in this project's root folder
5. Run `docker-compose up`
6. Visit http://localhost:8000/nextcloud/ to set up your Nextcloud instance
  * During setup, set the database name to `db`

## Note
If you change the database password in `docker-compose.yml`, you may need to remove `/nextcloud/source/code/folder/` and `db_data` and re-do the setup process
