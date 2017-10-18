#!/bin/bash
mv data/train.orig/wav.scp data/train.orig/wav.scp.orig
mv data/train.orig/stm data/train.orig/stm.orig
mv data/train.orig/text data/train.orig/text.orig
mv data/train.orig/segments data/train.orig/segments.orig
mv data/train.orig/spk2utt data/train.orig/spk2utt.orig
mv data/train.orig/utt2spk data/train.orig/utt2spk.orig
mv data/train.orig/reco2file_and_channel data/train.orig/reco2file_and_channel.orig

cat db/wav.scp data/train.orig/wav.scp.orig > data/train.orig/wav.scp
cat db/stm data/train.orig/stm.orig > data/train.orig/stm
cat db/text data/train.orig/text.orig > data/train.orig/text
cat db/segments data/train.orig/segments.orig > data/train.orig/segments
cat db/spk2utt data/train.orig/spk2utt.orig > data/train.orig/spk2utt
cat db/utt2spk data/train.orig/utt2spk.orig > data/train.orig/utt2spk
cat db/reco2file_and_channel data/train.orig/reco2file_and_channel.orig > data/train.orig/reco2file_and_channel

#sort data/train.orig/wav.scp
sort data/train.orig/segments > data/train.orig/segments
sort data/train.orig/spk2utt > data/train.orig/spk2utt
sort data/train.orig/utt2spk > data/train.orig/utt2spk
sort data/train.orig/reco2file_and_channel > data/train.orig/reco2file_and_channel



