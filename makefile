.PHONY : help
help :
	cat makefile

.PHONY : clean
clean :
	rm -rf data

data :
	mkdir data

data/data_150.txt : | data
	seq 1 16839793 > $@

data/data_150.trie1.bin : data/data_150.txt
	python build-trie1.py $@ < $<

data/data_150.trie2.bin : data/data_150.txt
	python build-trie2.py $@ < $<

data/data_150.bsearch.bin : data/data_150.txt
	python build-bsearch.py $@ < $<

data/random_requests.txt : | data
	python gen-random-requests.py 4242 7 11 1000000 > $@

data/result-data_150.trie1.txt : \
	data/data_150.trie1.bin data/random_requests.txt

	python use-trie1.py $< < data/random_requests.txt > $@

data/result-data_150.trie2.txt : \
	data/data_150.trie2.bin data/random_requests.txt

	python use-trie2.py $< < data/random_requests.txt > $@

data/result-data_150.bsearch.txt : \
	data/data_150.bsearch.bin data/random_requests.txt

	python use-bsearch.py $< < data/random_requests.txt > $@

.PHONY : benchmark-data_150.trie1
benchmark-data_150.trie1 : data/data_150.trie1.bin data/random_requests.txt
	 bash -c "time cat data/random_requests.txt | python use-trie1.py data/data_150.trie1.bin | wc -l"
	 bash -c "time cat data/random_requests.txt data/random_requests.txt | python use-trie1.py data/data_150.trie1.bin | wc -l"

.PHONY : benchmark-data_150.trie2
benchmark-data_150.trie2 : data/data_150.trie2.bin data/random_requests.txt
	 bash -c "time cat data/random_requests.txt | python use-trie2.py data/data_150.trie2.bin | wc -l"
	 bash -c "time cat data/random_requests.txt data/random_requests.txt | python use-trie2.py data/data_150.trie2.bin | wc -l"

.PHONY : benchmark-data_150.bsearch
benchmark-data_150.bsearch : data/data_150.bsearch.bin data/random_requests.txt
	 bash -c "time cat data/random_requests.txt | python use-bsearch.py data/data_150.bsearch.bin | wc -l"
	 bash -c "time cat data/random_requests.txt data/random_requests.txt | python use-bsearch.py data/data_150.bsearch.bin | wc -l"

data/random_prefixes_150.txt : | data
	python gen-random-prefixes.py 42 2 0.25 150_000_000 > $@

data/random_prefixes_150.trie1.bin : data/random_prefixes_150.txt
	python build-trie1.py $@ < $<

data/random_prefixes_150.trie2.bin : data/random_prefixes_150.txt
	python build-trie2.py $@ < $<

data/random_prefixes_150.bsearch.bin : data/random_prefixes_150.txt
	python build-bsearch.py $@ < $<

data/result-random_prefixes_150.trie1.txt : \
	data/random_prefixes_150.trie1.bin data/random_requests.txt

	python use-trie1.py $< < data/random_requests.txt > $@

data/result-random_prefixes_150.trie2.txt : \
	data/random_prefixes_150.trie2.bin data/random_requests.txt

	python use-trie2.py $< < data/random_requests.txt > $@

data/result-random_prefixes_150.bsearch.txt : \
	data/random_prefixes_150.bsearch.bin data/random_requests.txt

	python use-bsearch.py $< < data/random_requests.txt > $@

.PHONY : benchmark-random_prefixes_150.trie1
benchmark-random_prefixes_150.trie1 : data/random_prefixes_150.trie1.bin data/random_requests.txt
	 bash -c "time cat data/random_requests.txt | python use-trie1.py data/random_prefixes_150.trie1.bin | wc -l"
	 bash -c "time cat data/random_requests.txt data/random_requests.txt | python use-trie1.py data/random_prefixes_150.trie1.bin | wc -l"

.PHONY : benchmark-random_prefixes_150.trie2
benchmark-random_prefixes_150.trie2 : data/random_prefixes_150.trie2.bin data/random_requests.txt
	 bash -c "time cat data/random_requests.txt | python use-trie2.py data/random_prefixes_150.trie2.bin | wc -l"
	 bash -c "time cat data/random_requests.txt data/random_requests.txt | python use-trie2.py data/random_prefixes_150.trie2.bin | wc -l"

.PHONY : benchmark-random_prefixes_150.bsearch
benchmark-random_prefixes_150.bsearch : data/random_prefixes_150.bsearch.bin data/random_requests.txt
	 bash -c "time cat data/random_requests.txt | python use-bsearch.py data/random_prefixes_150.bsearch.bin | wc -l"
	 bash -c "time cat data/random_requests.txt data/random_requests.txt | python use-bsearch.py data/random_prefixes_150.bsearch.bin | wc -l"
