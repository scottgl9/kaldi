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
if [ $# != 1 ]; then
  echo "Usage: swbd1_data_download.sh /path/to/SWBD"
  exit 1; 
fi 

SWBD_DIR=$1

dir=data/local/train
mkdir -p $dir

# Audio data directory check
#if [ ! -d $SWBD_DIR ]; then
#  echo "Error: run.sh requires a directory argument"
#  exit 1; 
#fi  
echo $dir
# Trans directory check
if [ ! -f $dir/switchboard_icsi_ws97.tar.gz ]; then
  ( 
    cd $dir;
    if [ ! -d "train-ws97-i" ]; then
      echo " *** Downloading trascriptions and dictionary ***" 
      wget https://www.isip.piconepress.com/projects/switchboard/releases/switchboard_icsi_ws97.tar.gz
      wget https://web.stanford.edu/~jurafsky/swb1_dialogact_annot.tar.gz
      #wget https://www.isip.piconepress.com/projects/switchboard/releases/switchboard_icsi_phone.tar.gz
      #wget http://www.openslr.org/resources/5/switchboard_word_alignments.tar.gz ||
      #wget http://www.isip.piconepress.com/projects/switchboard/releases/switchboard_word_alignments.tar.gz
      #tar -xf switchboard_word_alignments.tar.gz
    fi
  )
else
  echo "Directory with transcriptions exists, skipping downloading"
  tar -xf switchboard_icsi_ws97.tar.gz
  rm -rf $dir/*/com $dir/*/file_generation $dir/*/lexicon $dir/*/mfc $dir/*/mlf $dir/*/phn $dir/*/syl $dir/*/wrd
  mkdir $dir/annot
  cd $dir/annot; tar -xf ../swb1_dialogact_annot.tar.gz
  #[ -f "$dir/train-ws97-i" ] \
  #  || ln -sf $SWBD_DIR/transcriptions/swb_ms98_transcriptions $dir/
fi
