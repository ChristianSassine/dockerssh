# Dockerssh
A dockerfile for an alpine ssh server

## Running the Alpine ssh server
To the run the Dockerfile you'll to put your public key under the name `id_rsa.pub` in the same location as the Dockerfile (the name can be changed inside the Dockerfile). You'll additionally need to follow the following steps:

1. Start Docker

2. Open a terminal and navigate to the Dockerfile

3. Build an image with the following command: `docker build -t alpinessh .`

4. Run the container with the following command: `docker run -d --name ssh -p 5554:22 alpinessh`

+ **Note**: This will map the container to the port 5554, you can change that by changing the port above.

You should now be able to access your Docker container by ssh
