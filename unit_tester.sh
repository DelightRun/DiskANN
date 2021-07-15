#!/bin/sh

if [ "$#" -ne "2" ]; then
  echo "usage: ./unit_test.sh [path_build_folder] [working_folder]"
else

BUILD_FOLDER=${1}
WORK_FOLDER=${2}

echo Running unit testing on various files, with build folder as ${BUILD_FOLDER} and working folder as ${WORK_FOLDER}
# download all unit test files

#iterate over them and run the corresponding test
CATALOG1="${WORK_FOLDER}/catalog.txt"
CATALOG="${WORK_FOLDER}/catalog_formatted.txt"
sed -e '/^$/d' ${CATALOG1} > ${CATALOG}


while IFS= read -r line; do
  BASE=$line
  read -r QUERY
  read -r TYPE
  read -r METRIC
  echo "Going to run test on ${BASE} base, ${QUERY} query, ${TYPE} datatype, ${METRIC} metric"
  echo "Computing Groundtruth"
  ${BUILD_FOLDER}/tests/utils/compute_groundtruth ${TYPE} 

done < "${CATALOG}"

fi