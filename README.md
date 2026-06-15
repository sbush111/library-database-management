# Prerequisities
- Install Docker
- Install PSQL Shell
- Install Git

# Project setup

1. Clone Repo
2. Create a text file called `.env`. Inside you will define a username and password to use with the PostreSQL server. See `.env.example` for an example of how the file should look.
3. Start the Docker engine with `docker start`.
3. Run `docker compose up` to launch the PostreSQL server.
4. Connect to the server and enter the interactive PSQL shell with the command `psql -U your_username_here -d librarydb`, and enter your password when prompted.
5. Setup the database and import the relevant data by running `\i setup.sql` within the PSQL shell.

# Project stopping

1. Run `\q` to exit the PSQL shell.
2. Close the server with `docker compose down`.
3. If you want to fully delete the server, run `docker compose down -v`. 
4. Stop the Docker engine with `docker stop`.