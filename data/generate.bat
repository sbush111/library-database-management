docker build -t generate_script .
docker run -v ./:/app generate_script --seed 0 --write