# bin/bash

echo "fetching transkriptions and registers from data_repo"
rm -rf data && mkdir data
curl -LO https://github.com/austrian-baroque-corpus/abc-data/archive/refs/heads/main.zip
unzip main

mkdir data/editions
mv ./abc-data-main/data/editions/* data/editions

mkdir data/register
mv ./abc-data-main/data/index/output/* data/register

mv ./abc-data-main/data/corpus/abacus.xml data/register/abacus.xml

rm -rf abc-data-main
rm main.zip
