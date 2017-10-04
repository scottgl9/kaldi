#!/bin/bash

# Switchboard-1 training data preparation customized for Edinburgh
# Author:  Arnab Ghoshal (Jan 2013)

# To be run from one directory above this script.

## The input is some directory containing the switchboard-1 release 2
## corpus (LDC97S62).  Note: we don't make many assumptions about how
## you unpacked this.  We are just doing a "find" command to locate
## the .sph files.

. path.sh

#check existing directories
#if [ $# != 1 ]; then
#  echo "Usage: swbd1_data_download.sh /path/to/SWBD"
#  exit 1; 
#fi 

#SWBD_DIR=$1

mkdir -p db

cd db  ### Note: the rest of this script is executed from the directory 'db'.

if [ ! -f switchboard_icsi_ws97.tar.gz ]; then
  wget https://www.isip.piconepress.com/projects/switchboard/releases/switchboard_icsi_ws97.tar.gz
fi

if [ ! -e switchboard_icsi_ws97 ]; then
  mkdir -p switchboard_icsi_ws97
  tar -xf switchboard_icsi_ws97.tar.gz -C switchboard_icsi_ws97 #&& rm -rf ./*/com ./*/file_generation ./*/lexicon ./*/mfc ./*/mlf ./*/phn ./*/syl ./*/wrd
  find switchboard_icsi_ws97 -type f -name '*.wav' -print0 | xargs -0 rename 's/.wav$/.sph/'
  mkdir -p sph
  find switchboard_icsi_ws97 -name "*.sph" -exec mv {} sph \;
  mv sph switchboard_icsi_ws97/sph
  mkdir -p stm
  find switchboard_icsi_ws97 -name "*trans.text" -exec mv {} stm \;
  find switchboard_icsi_ws97 -name "lexicon_v1.sh" -exec mv {} stm \;

  mv stm switchboard_icsi_ws97/stm

  #find switchboard_icsi_ws97 -type f -name "*trans.text" -exec cat {} \; | sed -r "s/\\//g" | sed -r "s/\[/(/g" | sed -r "s/\]/)/g" | sed -r "s/[0-9]{4}[AB]([\t ]*)([0-9.]*)([\t ]*)([0-9.]*)([\t ]*)([A-Za-z0-9_\->\/@&#?{}\!(\),.\'\" ]*)[(](\S*)[)]$/\7 \L\6/g" > transcript.text

  # cat db/switchboard_icsi_ws97/stm/misc-ws97-a-trans.text | sed -r 's/\[(\S+)\]/(\1)/g' | sed -r "s/[0-9]{4}[AB]\t([0-9AB.\t ]*)(\S*)(\s*)([A-Zm_#?!()\,.\'\" ]*) [(](\S*)[)]$/\5 \4/g"
  # find $SWBD_DIR -type f -name 'lexicon_v1_htk.text' -exec cat {} \; | tr '[:upper:]' '[:lower:]' > $SWBD_DIR/swb_ms98_transcriptions/sw-ms98-dict.text
fi

find switchboard_icsi_ws97 -type f -name "*trans.text" -exec cat {} \; | sed "s/\[/(/g" | sed "s/\]/)/g" | sed 's/\///g' | sed 's/"//g' | sed -r "s/([0-9]{4}[AB])([\t ]*)([0-9.]*)([\t ]*)([0-9.]*)([\t ]*)([A-Za-z0-9_\-\>\/@&#?{}!\(\),.\'\" ]*)[(](\S*)[)]/\1 \8 \3 \5 \L\7/" > stm
sed -i 's/h# //g' stm
sed -i 's/_#//g' stm
sed -i 's/_?//g' stm
sed -i 's/ ? / /g' stm
sed -i 's/!//g' stm
sed -r -i 's/([a-z]*)_([a-z]*)/\1 \2/g' stm
sed -i 's/ sil / (sil) /g' stm
sed -i 's/ mouthnoise / (mouthnoise) /g' stm
sed -i 's/ breath / (breath) /g' stm
sed -i 's/ crosstalk / (crosstalk) /g' stm
sed -i 's/ click / (click) /g' stm
sed -i 's/ backgroundnoise / (backgroundnoise) /g' stm
cat stm | sed -r "s/([0-9]{4}[AB])([\t ]*)(\S*)([\t ]*)([0-9.]*)([\t ]*)([0-9.]*)([\t ]*)([A-Za-z0-9_\-\>\/@&#?{}!\(\),.\'\" ]*)/\3 \9/" > text
cat stm | sed -r "s/([0-9]{4}[AB])([\t ]*)(\S*)([\t ]*)([0-9.]*)([\t ]*)([0-9.]*)([\t ]*)([A-Za-z0-9_\-\>\/@&#?{}!\(\),.\'\" ]*)/\3 \1/" > utt2spk
cat stm | sed -r "s/([0-9]{4}[AB])([\t ]*)(\S*)([\t ]*)([0-9.]*)([\t ]*)([0-9.]*)([\t ]*)([A-Za-z0-9_\-\>\/@&#?{}!\(\),.\'\" ]*)/\3 \1 \5 \7/" > segments

