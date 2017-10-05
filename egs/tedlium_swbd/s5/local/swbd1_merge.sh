#!/bin/bash
glm  reco2file_and_channel  segments  spk2utt  stm  text  utt2dur  utt2spk  wav.scp

cat db/wav.scp data/train.orig/wav.scp > data/train.orig/wav.scp
cat db/stm data/train.orig/stm > data/train.orig/stm
cat db/text data/train.orig/text > data/train.orig/text
cat db/segments data/train.orig/segments > data/train.orig/segments
cat db/spk2utt data/train.orig/spk2utt > data/train.orig/spk2utt
cat db/utt2spk data/train.orig/utt2spk > data/train.orig/utt2spk
cat db/reco2file_and_channel data/train.orig/reco2file_and_channel > data/train.orig/reco2file_and_channel





