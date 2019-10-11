# this is the central file so here go the ideas: k-means cluster the
# programming languages?  assign a vector to each indexed by problems
# with values in the normalized difficulty space. distance between two
# data points will be agreement on points in common? doesn't sound
# valid...
langs = haskell erlang scheme pharo-smalltalk c racket r cpp clojure \
	scala common-lisp elisp go java javascript kotlin ocaml sml \
	d

table.png : chart.gp get-configs.ss
	echo "(write-problems)" | scheme -q get-configs.ss | gnuplot $< > $@

%.png : chart.gp get-configs.ss
	echo "(chart-track '$(@F:.png=))" | scheme -q get-configs.ss | gnuplot $< > $@

tracks.txt : tracks.html 
	./fetch-tracks.sh

tracks.html :
	wget https://exercism.io/tracks -O $@

exercism.dot : get-configs.ss Makefile
	echo "(dot-graph '($(langs)))" | scheme -q $<

exercism.ps : exercism.dot Makefile
	neato -Tps -Gstart=rand -Goverlap=true -Gscale=true -Gsep=3 $< > $@

clean :
	rm *json
	rm *html

.PHONY : clean



