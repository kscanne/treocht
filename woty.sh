#!/bin/bash
if [ $# -ne 1 ]
then
	echo "Usage: bash woty.sh 2017"
	exit 1
fi

# filter that generates a frequency list
tofreq() {
	bash ${HOME}/seal/caighdean/alltokens.sh | sed "s/^'*//" | sed "s/'*$//" | egrep "^[A-Za-z'-]+$" | demut | sort | uniq -c | sort -r -n | sed 's/^ *//'
}

find glan -name "${1}-??" | xargs cat | tofreq > "${1}-freq.txt" 
# note that if we run this for, say, 2017 in 2019, it will include
# 2018 and 2019 in the "prefreq" data!  So looking for spikes versus
# emergent words
find glan -name "????-??" | sort | sed "/${1}/,\$d" | xargs cat | tofreq > "${1}-prefreq.txt"
echo "0 xx" | bayes.pl -d "${1}-freq.txt" "${1}-prefreq.txt" > "${1}-innovations.txt"
