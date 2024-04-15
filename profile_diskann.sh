#!/bin/bash
set -ex

DISKANN_HOME=/mnt/workspace/DiskANN
DISKANN_DATA=${DISKANN_HOME}/data

${DISKANN_HOME}/build/apps/utils/fvecs_to_bin float ${DISKANN_DATA}/gist/gist_learn.fvecs ${DISKANN_DATA}/gist/gist_learn.fbin
${DISKANN_HOME}/build/apps/utils/fvecs_to_bin float ${DISKANN_DATA}/gist/gist_query.fvecs ${DISKANN_DATA}/gist/gist_query.fbin

${DISKANN_HOME}/build/apps/build_memory_index  --data_type float --dist_fn l2 --data_path ${DISKANN_DATA}/gist/gist_learn.fbin --index_path_prefix ${DISKANN_DATA}/gist/gist_index -R 32 -L 50 --alpha 1.2
${DISKANN_HOME}/build/apps/search_memory_index  --data_type float --dist_fn l2 --index_path_prefix ${DISKANN_DATA}/gist/gist_index --query_file ${DISKANN_DATA}/gist/gist_query.fbin  --gt_file ${DISKANN_DATA}/gist/gist_groundtruth.ivecs -K 10 -L 10 20 30 40 50 100 --result_path ${DISKANN_DATA}/gist/res