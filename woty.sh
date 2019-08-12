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
find glan -name "????-??" | sort | sed "/${1}/,\$d" | xargs cat | tofreq > "${1}-prefreq.txt"
echo "0 xx" | bayes.pl -d "${1}-freq.txt" "${1}-prefreq.txt" > "${1}-innovations.txt"
