cd deep-learning-raman-spectroscopy
git pull origin master
cd ..
bash deep-learning-raman-spectroscopy/server_configs/pytorch_conda_config/docker_clean.sh
cp deep-learning-raman-spectroscopy/server_configs/pytorch_conda_config/environment.yml ./workdir/
cd workdir
curr_uid=`id -u`
curr_gid=`id -g`
echo ARG UID=${curr_uid} |cat - Dockerfile > /tmp/out && mv /tmp/out Dockerfile
echo ARG GID=${curr_gid} |cat - Dockerfile > /tmp/out && mv /tmp/out Dockerfile
echo FROM nvidia/cuda:11.0.3-devel-ubuntu20.04 |cat - Dockerfile > /tmp/out && mv /tmp/out Dockerfile
nvidia-docker build -t pytorchconda .
nvidia-docker run -d --name pytorchconda --shm-size=5gb -p 52022:22 -it --init -u $(id -u):$(id -g) -v /home/nina.singlan/workdir:/home/newuser pytorchconda