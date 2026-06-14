# Project setup

1. Install Docker
2. Install PSQL shell
3. Install Git
4. Clone Repo
5. Create .env file with `POSTGRES_USER=your_username_here` and `POSTGRES_PASSWORD=your_password_here`
6. Run `docker compose up` to launch the server
7. Connect to the server and enter the interactive PSQL shell with the command `psql -U your_username_here -d librarydb`, and enter your password when prompted.
8. Close the server with `docker compose down` when you are finished.

# Setting up the database

1. With the server up, run `setup.sql` from outside of the shell with the command `psql -U your_username_here -d librarydb -f setup.sql` or from within the interactive shell with `\i setup.sql`.