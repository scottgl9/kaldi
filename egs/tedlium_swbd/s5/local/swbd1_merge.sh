#!/bin/bash
mv data/train.orig/wav.scp data/train.orig/wav.scp.orig
mv data/train.orig/stm data/train.orig/stm.orig
mv data/train.orig/text data/train.orig/text.orig
mv data/train.orig/segments data/train.orig/segments.orig
mv data/train.orig/spk2utt data/train.orig/spk2utt.orig
mv data/train.orig/utt2spk data/train.orig/utt2spk.orig
mv data/train.orig/reco2file_and_channel data/train.orig/reco2file_and_channel.orig

cat db/wav.scp >> data/train.orig/wav.scp.orig
cat db/stm >> data/train.orig/stm.orig
cat db/text >> data/train.orig/text.orig
cat db/segments >> data/train.orig/segments.orig
cat db/spk2utt >> data/train.orig/spk2utt.orig
cat db/utt2spk >> data/train.orig/utt2spk.orig
cat db/reco2file_and_channel >> data/train.orig/reco2file_and_channel.orig

sort data/train.orig/wav.scp.orig | uniq -u > data/train.orig/wav.scp
sort data/train.orig/stm.orig | uniq -u > data/train.orig/stm
sort data/train.orig/text.orig | uniq -u > data/train.orig/text
sort data/train.orig/segments.orig | uniq -u > data/train.orig/segments
sort data/train.orig/spk2utt.orig | uniq -u > data/train.orig/spk2utt
sort data/train.orig/utt2spk.orig | uniq -u > data/train.orig/utt2spk
sort data/train.orig/reco2file_and_channel.orig | uniq -u > data/train.orig/reco2file_and_channel
rm -f data/train.orig/*.orig

