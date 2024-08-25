# Stage 1: Download models
FROM spiffgreen/cpcj-models AS downloader

# Stage 2: Store files in one build stage to reduce layers
FROM scratch AS tmp
COPY start.sh /start.sh
COPY requirements.txt /alldeps.txt

    
# Stage 3: Main build    
FROM nvidia/cuda:12.1.0-base-ubuntu22.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV JUPYTER_PASSWORD=admin
ENV SHELL=/bin/bash

# Set the working directory
WORKDIR /workspace

# Update, upgrade, install packages, install python if PYTHON_VERSION is specified, clean up
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt install --yes --no-install-recommends git wget curl bash libgl1 software-properties-common openssh-server && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

# Set up Python and pip
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip python3-dev python3.9-venv build-essential

# Install ComfyUI and ComfyUI Manager
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && mkdir -p /workspace/ComfyUI/models

# Copy models
COPY --from=downloader /workspace/ComfyUI/models ./ComfyUI/models

# Start Scripts
COPY --from=tmp / ./ComfyUI
RUN chmod +x /workspace/ComfyUI/start.sh && /workspace/ComfyUI/start.sh

# Set the default command for the container
CMD ["bash", "-c", "nohup jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token=${JUPYTER_PASSWORD} & python3 /workspace/ComfyUI/main.py --listen --port=3000"]
