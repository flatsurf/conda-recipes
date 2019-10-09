# ##########################################################
# Work around https://github.com/conda/conda-build/pull/3765
# ##########################################################

cd ..
mv work/work real_work
mv work/* real_work/
rmdir work
mv real_work work
cd work
