export CUDA_VER=11.8
apt install -y libopencv-dev
git clone -b release/8.6 https://github.com/NVIDIA/TensorRT.git
cd TensorRT
git submodule update --init --recursive
mkdir build && cd build
# On X86 platform
cmake ..
# On Jetson platform
# cmake .. -DTRT_LIB_DIR=/usr/lib/aarch64-linux-gnu/
make nvinfer_plugin -j4
cp libnvinfer_plugin.so.8.6.0 /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.8.5.3
# On Jetson platform:
# cp libnvinfer_plugin.so.8.6.0 /usr/lib/aarch64-linux-gnu/libnvinfer_plugin.so.8.5.2

/usr/src/tensorrt/bin/trtexec --onnx=/host/ocr/dcn_resnet50.onnx --minShapes=input:1x3x736x1280 --optShapes=input:1x3x736x1280 --maxShapes=input:4x3x736x1280 --fp16 --saveEngine=ocdnet.fp16.engine
/usr/src/tensorrt/bin/trtexec --onnx=/host/ocr/ocrnet_resnet50.onnx --minShapes=input:1x1x32x100 --optShapes=input:32x1x32x100 --maxShapes=input:32x1x32x100 --fp16 --saveEngine=ocrnet.fp16.engine

mkdir /ocr-app ; cd /ocr-app && git clone https://github.com/NVIDIA-AI-IOT/NVIDIA-Optical-Character-Detection-and-Recognition-Solution.git
cd NVIDIA-Optical-Character-Detection-and-Recognition-Solution
make
export LD_LIBRARY_PATH=$(pwd)
cd deepstream
make