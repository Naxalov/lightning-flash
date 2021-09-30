# Start FROM Nvidia PyTorch image https://ngc.nvidia.com/catalog/containers/nvidia:pytorch
# FROM nvcr.io/nvidia/pytorch:21.09-py3
FROM nvidia/cuda:11.4.2-base-ubuntu20.04 

# Install linux packages
RUN apt update && apt install -y 


# Python install
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

RUN python3 -m pip --no-cache-dir install --upgrade \
    "pip<20.3" \
    setuptools

# Some TF tools expect a "python" binary
RUN ln -s $(which python3) /usr/local/bin/python


# Install python dependencies
# COPY requirements.txt .
RUN python -m pip install --upgrade pip
# RUN pip uninstall -y nvidia-tensorboard nvidia-tensorboard-plugin-dlprof
# RUN pip install --no-cache -r requirements.txt coremltools onnx gsutil notebook wandb>=0.12.2
# RUN pip install --no-cache -U torch torchvision numpy
RUN pip install icevision
RUN pip install lightning-flash[image]
RUN pip install lightning-flash
# RUN  pip install 'icevision' 'lightning-flash[image]'
# RUN pip install --no-cache torch==1.9.1+cu111 torchvision==0.10.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html

