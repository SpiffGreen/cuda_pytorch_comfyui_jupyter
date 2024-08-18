# Use the NVIDIA CUDA base image
FROM nvidia/cuda:12.1.0-base-ubuntu22.04

# Set environment variables
ENV JUPYTER_PASSWORD=Kfeij149EAhna14a

# Expose ports
EXPOSE 80
EXPOSE 8888

# Set the working directory
WORKDIR /workspace

# Copy the installation script into the container
COPY install_comfyui_requirements.sh /workspace/install_comfyui_requirements.sh

# Make the script executable
RUN chmod +x /workspace/install_comfyui_requirements.sh

# Run the installation script
RUN /workspace/install_comfyui_requirements.sh

# Start Jupyter Notebook and ComfyUI
CMD ["bash", "-c", "nohup jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token='${JUPYTER_PASSWORD}' & python3 main.py --listen --port=80"]