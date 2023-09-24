# Dockerized Jupyter Notebook Environment
## Description:

This repository provides instructions and configuration files to set up a Dockerized Jupyter Notebook environment in Aarch64. It's based on Mambaforge and allows you to run Jupyter Notebooks within a secure Docker container, isolating your work.

## Prerequisites:

Before you begin, make sure you have the following:

- Docker installed on your system.
- A basic understanding of Docker and command-line usage.
## Usage:

Follow these steps to set up and use the Dockerized Jupyter Notebook environment:

## 1. Create a directory:
```bash
mkdir /home/yourUserName/docker/jupyter
cd jupyter-docker
```
## 2. Clone this Repository:
```bash
git clone https://github.com/geobla/miniconda3-aarch64-docker.git
```
## 3. Build the Docker Image:
Build the Docker image using the provided Dockerfile:
```bash
docker build -t my-miniconda-image .
```

## 4. Create a Docker volume:
- When you run a Jupyter Notebook inside a Docker container, any notebooks or files you create or modify are typically saved within the container's filesystem. 
- This means that if you stop and remove the container or if the container is deleted for any reason, your notebooks and files within that container will be lost.
- To persist your Jupyter notebooks and data across container restarts or deletions, you should consider using Docker volumes. 
- Docker volumes allow you to store data outside of the container's filesystem and make it accessible even if the container is removed.

Here's how you can use Docker volumes to save your Jupyter notebooks:
```bash
docker volume create jupyter-data
```


## 5. Start a Jupyter Notebook server and interact with Anaconda via your browser::
```bash
docker run -it -d -p 4350:8888 -v jupyter-data:/opt/notebooks --name jupyter my-miniconda-image:latest /bin/sh -c "/opt/mambaforge/bin/conda install jupyter -y --quiet && mkdir -p /opt/notebooks && /opt/mambaforge/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root"

```
This command maps port 4350 on your host machine to port 8888 inside the container. Feel free to choose a different host port.
## 6. Access Jupyter Notebook:
Once the container is running, access the Jupyter Notebook server in your web browser by visiting:
```bash
http://localhost:4350/
```
- You may be prompted to enter a token for authentication. The token can be found in the container logs or by running docker logs <container_id>. Optionally, you can configure a password for added security.

### This is what you will see in your console:
`To access the server, open this file in a browser:
file:///root/.local/share/jupyter/runtime/jpserver-559-open.html Or copy and paste one of these URLs: http://localhost:8888/tree?token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`
- Copy - paste the URL to your browser and you are good to go!!
- You can also create a password for additional security (Optional).
## 7. Start Using Jupyter:
You can now create and run Jupyter Notebooks within the Docker container. All your notebooks and data will be isolated within the container.
## Customization:
You have the flexibility to customize the Dockerfile to include any additional Python packages or libraries required for your specific projects.
## Acknowledgments:
This setup is built upon the use of [conda-forge/miniforge](https://github.com/conda-forge/miniforge), a fast Python package manager, and Docker for containerization.

Feel free to fork this repository and tailor it to your needs. If you encounter any issues or have suggestions for improvements, please don't hesitate to open an issue or submit a pull request.


