#!/bin/bash -e
#
# Package wav files in a directory to embed in a dustcloud image or upload to Valetudo for xiaomi gen1 and gen2.
# Requires ccrypt.

dir=output/result
sound_password="this_is_a_password" # This value doesn't matter because it does not provide any security.

mkdir -p $dir

cd $dir
tar zc *.wav | ccrypt -e -K "$sound_password" > voicepack.pkg

# Clean up.
mv voicepack.pkg ..
rm -rf $dir

# Inform the user that the packaging is complete.
echo "Packaging complete. The voicepack.pkg file is located in the output directory."