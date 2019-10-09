# ##########################################################
# Work around https://github.com/conda/conda-build/pull/3765
# ##########################################################

mv $SRC_DIR/work $SRC_DIR/../real_work
mv $SRC_DIR/* $SRC_DIR/../real_work/
rmdir $SRC_DIR
mv $SRC_DIR/../real_work $SRC_DIR
cd `pwd`
