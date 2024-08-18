# Stage 1: Build Stage
FROM nvidia/cuda:12.1.0-base-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV JUPYTER_PASSWORD=Kfeij149EAhna14a

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget curl git

# Clone the ComfyUI repository and additional nodes
RUN mkdir /workspace && cd /workspace && git clone https://github.com/comfyanonymous/ComfyUI.git && \
    mkdir -p /workspace/ComfyUI/custom_nodes && \
    cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/jags111/ComfyUI_Jags_VectorMagic && \
    git clone https://github.com/WASasquatch/was-node-suite-comfyui && \
    git clone https://github.com/pythongosssss/ComfyUI-WD14-Tagger && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts && \
    git clone https://github.com/Jordach/comfy-plasma && \
    git clone https://github.com/melMass/comfy_mtb && \
    git clone https://github.com/sipherxyz/comfyui-art-venture && \
    git clone https://github.com/cubiq/ComfyUI_essentials && \
    git clone https://github.com/kijai/ComfyUI-KJNodes && \
    git clone https://github.com/FlyingFireCo/tiled_ksampler && \
    git clone https://github.com/gokayfem/ComfyUI-Texture-Simple && \
    git clone https://github.com/KoreTeknology/ComfyUI-Universal-Styler && \
    git clone https://github.com/jakechai/ComfyUI-JakeUpgrade && \
    git clone https://github.com/rgthree/rgthree-comfy

RUN apt-get install -y python3 python3-pip python3-dev build-essential && \
    pip3 install notebook torch==2.3.0 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121

# Install requirements for cloned repositories
# RUN pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI_Jags_VectorMagic/requirements.txt
    #pip3 install -r /workspace/ComfyUI/custom_nodes/was-node-suite-comfyui/requirements.txt && \
    #pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI-WD14-Tagger/requirements.txt && \
    #pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI_essentials/requirements.txt && \
    #pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI-KJNodes/requirements.txt && \
    #pip3 install -r /workspace/ComfyUI/custom_nodes/comfy_mtb/requirements.txt && \
    #pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI-Texture-Simple/requirements.txt && \
    #pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI-JakeUpgrade/requirements.txt && \
    #pip3 install -r /workspace/ComfyUI/custom_nodes/rgthree-comfy/requirements.txt
    #pip3 install ultralytics

# Create necessary directories for models
RUN mkdir -p /workspace/ComfyUI/models/{ipadapter,deepbump,clip_vision,upscale_models,checkpoints,vae}

# Download models
#RUN wget -O /workspace/ComfyUI/models/deepbump/deepbump256.onnx https://github.com/HugoTini/DeepBump/blob/master/deepbump256.onnx && \
#    wget -O /workspace/ComfyUI/models/ipadapter/ip-adapter-plus_sdxl_vit-h.safetensors https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors && \
#    wget -O /workspace/ComfyUI/models/clip_vision/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors && \
#    wget -O /workspace/ComfyUI/models/upscale_models/4x_NMKD-Siax_200k.pth https://huggingface.co/gemasai/4x_NMKD-Siax_200k/resolve/main/4x_NMKD-Siax_200k.pth && \
#    wget -O /workspace/ComfyUI/models/checkpoints/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors && \
#    wget -O /workspace/ComfyUI/models/checkpoints/Juggernaut-XL_inpaint.safetensors https://civitai.com/api/download/models/456538 && \
#    wget -O /workspace/ComfyUI/models/vae/sdxl_vae.safetensors https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors

# Install remaining requirements for ComfyUI
RUN pip3 install -r /workspace/ComfyUI/requirements.txt

# Start Jupyter Notebook and the main application
CMD ["bash", "-c", "nohup jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token=${JUPYTER_PASSWORD} & python main.py --listen --port=80"]