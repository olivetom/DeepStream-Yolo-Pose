test egl: gst-launch-1.0 videotestsrc ! nveglglessink
test x11: gst-launch-1.0 videotestsrc ! autovideosink
/opt/nvidia/deepstream/deepstream/samples/configs/deepstream-app# deepstream-app -c source2_1080p_dec_infer-resnet_demux_int8.txt