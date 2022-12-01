head -c -1 | sed -z 's/\n\n/;/g' | sed -z 's/\n/+/g' | sed 's/;/\n/g' | while read exp; do echo $exp | bc; done | sort -gr | head -n 3 | head -c -1 | paste -s -d+ | bc
