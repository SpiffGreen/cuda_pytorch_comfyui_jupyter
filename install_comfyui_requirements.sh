#!/bin/bash

mkdir -p /workspace

apt-get update
apt-get install -y wget curl git python3 python3-pip python3-dev build-essential
pip3 install notebook
pip3 install torch==2.3.0 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
cd /workspace && git clone https://github.com/comfyanonymous/ComfyUI.git

mkdir -p /workspace/ComfyUI/custom_nodes
cd /workspace/ComfyUI/custom_nodes

git clone https://github.com/jags111/ComfyUI_Jags_VectorMagic
cd /workspace/ComfyUI/custom_nodes/ComfyUI_Jags_VectorMagic && pip3 install -r requirements.txt

git clone https://github.com/WASasquatch/was-node-suite-comfyui
cd /workspace/ComfyUI/custom_nodes/was-node-suite-comfyui && pip3 install -r requirements.txt

git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus

git clone https://github.com/pythongosssss/ComfyUI-WD14-Tagger
cd /workspace/ComfyUI/custom_nodes/ComfyUI-WD14-Tagger && pip3 install -r requirements.txt

git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts

git clone https://github.com/Jordach/comfy-plasma

git clone https://github.com/melMass/comfy_mtb
cd /workspace/ComfyUI/custom_nodes/comfy_mtb && pip3 install -r requirements.txt

git clone https://github.com/sipherxyz/comfyui-art-venture
cd /workspace/ComfyUI/custom_nodes/comfyui-art-venture && pip3 install -r requirements.txt

git clone https://github.com/twri/sdxl_prompt_styler
git clone https://github.com/hylarucoder/comfyui-copilot
git clone https://github.com/theUpsider/ComfyUI-Logic
git clone https://github.com/alsritter/asymmetric-tiling-comfyui
git clone https://github.com/spinagon/ComfyUI-seamless-tiling

git clone https://github.com/cubiq/ComfyUI_essentials
cd /workspace/ComfyUI/custom_nodes/ComfyUI_essentials && pip3 install -r requirements.txt

git clone https://github.com/kijai/ComfyUI-KJNodes
cd /workspace/ComfyUI/custom_nodes/ComfyUI-KJNodes && pip3 install -r requirements.txt

git clone https://github.com/FlyingFireCo/tiled_ksampler

git clone https://github.com/gokayfem/ComfyUI-Texture-Simple
cd /workspace/ComfyUI/custom_nodes/ComfyUI-Texture-Simple && pip3 install -r requirements.txt

git clone https://github.com/KoreTeknology/ComfyUI-Universal-Styler

git clone https://github.com/jakechai/ComfyUI-JakeUpgrade
cd /workspace/ComfyUI/custom_nodes/ComfyUI-JakeUpgrade && pip3 install -r requirements.txt

git clone https://github.com/rgthree/rgthree-comfy
cd /workspace/ComfyUI/custom_nodes/rgthree-comfy && pip3 install -r requirements.txt

# Create necessary directories
mkdir -p /workspace/ComfyUI/models/ipadapter
mkdir -p /workspace/ComfyUI/models/deepbump

# Download deepbump model
cd /workspace/ComfyUI/models/deepbump/
wget https://github.com/HugoTini/DeepBump/blob/master/deepbump256.onnx

# Download IP-Adapter model
cd /workspace/ComfyUI/models/ipadapter/
wget https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors

# Download CLIP vision model
cd /workspace/ComfyUI/models/clip_vision/
wget https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors
mv model.safetensors CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors

# Download upscale model
cd /workspace/ComfyUI/models/upscale_models/
wget https://huggingface.co/gemasai/4x_NMKD-Siax_200k/resolve/main/4x_NMKD-Siax_200k.pth

# Download checkpoints
cd /workspace/ComfyUI/models/checkpoints/
wget https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors
wget https://civitai.com/api/download/models/456538 -O Juggernaut-XL_inpaint.safetensors

# Download VAE model
cd /workspace/ComfyUI/models/vae/
wget https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors

cd /workspace/ComfyUI
pip3 install -r requirements.txt
pip3 install ultralytics
nohup jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token='${JUPYTER_PASSWORD}' &
python3 main.py --listen --port=80