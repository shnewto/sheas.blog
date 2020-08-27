# HTML_PRE = \
# "<!DOCTYPE html><html lang=\"en\">\
# 	<head>\
# 		<meta charset=\"UTF-8\">\
# 		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\
# 		<link rel=\"stylesheet\" href=\"style/style.css\">\
# 	</head>\
# <body>"

# HTML_POST = \
# "	</body>\
# </html>"

PANDOC=/usr/local/bin/pandoc

HTML_PRE="<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\"><link rel=\"stylesheet\" href=\"style/style.css\"></head><body>"

HTML_POST="</body></html>"

HOMESRCS := $(wildcard *.md)
HOMEHTML := $(patsubst %.md,%.html,$(HOMESRCS))

POSTSRCS := $(wildcard post/*.md)
POSTHTML := $(patsubst %.md,%.html,$(POSTSRCS))

all: dirs post home index

dirs: 
	mkdir -p build/post
	cp -a papers slides style img build

home: $(HOMEHTML) 
post: $(POSTHTML)

$(HOMEHTML): $(HOMESRCS)
	$(PANDOC) $(basename $@).md -o build/$@

$(POSTHTML): $(POSTSRCS)
	$(PANDOC) $(basename $@).md -o build/$@

index: dirs home
	$(shell echo $(HTML_PRE) > build/index.html)
	$(shell cat build/README.html >> build/index.html)
	$(shell echo  $(HTML_POST) >> build/index.html)
	$(shell find . -type f -iname '*.html' -exec sed -i '' 's/.md/.html/' "{}" +;)

clean: 
	rm -rf build *.html* post/*.html*