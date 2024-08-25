#!/bin/bash

cd /workspace/ComfyUI

mkdir -p /workspace/ComfyUI/custom_nodes
cd /workspace/ComfyUI/custom_nodes
git clone --depth 1 https://github.com/jags111/ComfyUI_Jags_VectorMagic
git clone --depth 1 https://github.com/WASasquatch/was-node-suite-comfyui
git clone --depth 1 https://github.com/cubiq/ComfyUI_IPAdapter_plus
git clone --depth 1 https://github.com/pythongosssss/ComfyUI-WD14-Tagger
git clone --depth 1 https://github.com/pythongosssss/ComfyUI-Custom-Scripts
git clone --depth 1 https://github.com/Jordach/comfy-plasma
git clone --depth 1 https://github.com/melMass/comfy_mtb
git clone --depth 1 https://github.com/sipherxyz/comfyui-art-venture
git clone --depth 1 https://github.com/twri/sdxl_prompt_styler
git clone --depth 1 https://github.com/hylarucoder/comfyui-copilot
git clone --depth 1 https://github.com/theUpsider/ComfyUI-Logic
git clone --depth 1 https://github.com/alsritter/asymmetric-tiling-comfyui
git clone --depth 1 https://github.com/spinagon/ComfyUI-seamless-tiling
git clone --depth 1 https://github.com/cubiq/ComfyUI_essentials
git clone --depth 1 https://github.com/kijai/ComfyUI-KJNodes
git clone --depth 1 https://github.com/FlyingFireCo/tiled_ksampler
git clone --depth 1 https://github.com/gokayfem/ComfyUI-Texture-Simple
git clone --depth 1 https://github.com/KoreTeknology/ComfyUI-Universal-Styler
git clone --depth 1 https://github.com/jakechai/ComfyUI-JakeUpgrade
git clone --depth 1 https://github.com/rgthree/rgthree-comfy
git clone --depth 1 https://github.com/ltdrdata/ComfyUI-Manager

# Install dependencies
cd /workspace/ComfyUI

python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
pip3 install --no-cache-dir notebook torch==2.3.0 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI-WD14-Tagger/requirements.txt
pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI_Jags_VectorMagic/requirements.txt
pip3 install -r /workspace/ComfyUI/custom_nodes/ComfyUI-JakeUpgrade/requirements.txt
pip3 install -r /workspace/ComfyUI/custom_nodes/was-node-suite-comfyui/requirements.txt
pip3 install -r /workspace/ComfyUI/custom_nodes/comfyui-art-venture/requirements.txt

# Create necessary directories
mkdir -p /workspace/ComfyUI/models
mkdir -p /workspace/ComfyUI/models/deepbump
mkdir -p /workspace/ComfyUI/models/ipadapter
mkdir -p /workspace/ComfyUI/models/clip_vision
mkdir -p /workspace/ComfyUI/models/upscale_models
mkdir -p /workspace/ComfyUI/models/checkpoints
mkdir -p /workspace/ComfyUI/models/vae

