test egl: 

```bash
gst-launch-1.0 videotestsrc ! nveglglessink
```

test x11: 
```bash
gst-launch-1.0 videotestsrc ! autovideosink
```

test deepstream-app with egl display:
```bash 
/opt/nvidia/deepstream/deepstream/samples/configs/deepstream-app# deepstream-app -c source4_1080p_dec_infer-resnet_tracker_sgie_tiled_display_int8.yml
```

test gstreamer pipeline with egl backend display from gst-launch:

```bash 
gst-launch-1.0 filesrc location=/opt/nvidia/deepstream/deepstream/samples/streams/sample_720p.mp4 \
! qtdemux ! h264parse ! nvv4l2decoder ! m.sink_0 nvstreammux name=m batch-size=1 width=1920 height=1080 \
! nvinfer config-file-path=/opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/deepstream-test1/dstest1_pgie_config.txt \
! nvtracker ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so \
! nvvideoconvert ! nvdsosd ! nvvideoconvert ! nveglglessink
```

test gstreamer pipeline with gtk backend X11 display from gst-launch:
```bash
gst-launch-1.0 filesrc location=/opt/nvidia/deepstream/deepstream/samples/streams/sample_720p.mp4 \
! qtdemux ! h264parse ! nvv4l2decoder ! m.sink_0 nvstreammux name=m batch-size=1 width=1920 height=1080 \
! nvinfer config-file-path=/opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/deepstream-test1/dstest1_pgie_config.txt \
! nvtracker ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so \
! nvvideoconvert ! nvdsosd ! nvvideoconvert ! xvimagesink
``