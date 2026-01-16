FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Install Python and PyTorch with CUDA support
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

RUN cd / \
&& git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui \
&& cd stable-diffusion-webui \
&& python -m pip install --upgrade pip wheel \
&& sed -i '/fastapi/c\fastapi==0.90.1' requirements.txt \
&& sed -i '/pytorch_lightning/c\pytorch_lightning==1.6.5' requirements.txt \
&& echo >> requirements.txt \
&& echo timm >> requirements.txt

WORKDIR /stable-diffusion-webui

ENV REQS_FILE='requirements.txt'

CMD ["python", "launch.py", "--listen", "--api", "--data", "/data/stable-diffusion-webui/models"]