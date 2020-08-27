# HOMESRCS := $(wildcard *.md)
# POSTSRCS := $(wildcard post/*.md)

# HOMEHTML := $(patsubst %.md,%.html,$(HOMESRCS))
# POSTHTML := $(patsubst %.md,%.html,$(POSTSRCS))

# INDEX_HTML_PRE = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><link rel=\"stylesheet\" href=\"style/style.css\"></head><body>"

# INDEX_HTML_POST = "</body></html>"

# INDEX = build/index.html
# README = build/README.html

# PANDOC = /usr/local/bin/pandoc

# $(HOMEHTML): $(HOMESRCS)
# 	$(PANDOC) $< -o build/$@

# $(POSTHTML): $(POSTSRCS)
# 	$(PANDOC) $< -o build/post/$@

# dirs: 
# 	mkdir -p build
# 	mkdir -p build/post

# index: 
# 	touch $(INDEX)

# html: dirs index $(HOMEHTML) $(POSTHTML)

# all: html
# 	$(shell echo $(INDEX_HTML_PRE) > $(INDEX))
# 	$(shell cat $(README) >> $(INDEX))
# 	$(shell echo  $(INDEX_HTML_POST) >> $(INDEX))
# 	$(shell find . -type f -iname '*.html' -exec sed -i.bak 's@\.md"@\.html"@' "{}" +;)

# clean:
# 	rm -rf build *.html*

	
# README.html: README.md
# 	$(PANDOC) $< -o build/$@

# blog.html: blog.md
# 	$(PANDOC) $< -o build/$@

# about.html: about.md
# 	$(PANDOC) $< -o build/$@

# publications.html: publications.md
# 	$(PANDOC) $< -o build/$@

# talks.html: talks.md
# 	$(PANDOC) $< -o build/$@

# byo-standard.html: post/byo-standard.md
# 	$(PANDOC) $< -o build/post/$@

# impl-fromstr.html: post/impl-fromstr.md
# 	$(PANDOC) $< -o build/post/$@

# svg-curves.html: post/svg-curves.md
# 	$(PANDOC) $< -o build/post/$@

# cobalt-and-now.html: post/cobalt-and-now.md
# 	$(PANDOC) $< -o build/post/$@

# embedded-elm.html: post/embedded-elm.md
# 	$(PANDOC) $< -o build/post/$@

# rust-impl-period.html: post/rust-impl-period.md
# 	$(PANDOC) $< -o build/post/$@


PANDOC = /usr/local/bin/pandoc

HTML_PRE = \
"<!DOCTYPE html><html lang=\"en\">\
	<head>\
		<meta charset=\"UTF-8\">\
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\
		<link rel=\"stylesheet\" href=\"style/style.css\">\
	</head>\
<body>"

HTML_POST = \
"	</body>\
</html>"

HOMESRCS := $(wildcard *.md)
HOMEHTML := $(patsubst %.md,%.html,$(HOMESRCS))

POSTSRCS := $(wildcard post/*.md)
POSTHTML := $(patsubst %.md,%.html,$(POSTSRCS))

all: dirs home post index
	
dirs: 
	mkdir -p build/post
	cp -a papers slides style img build

$(HOMEHTML): $(HOMESRCS)
	$(PANDOC) $< -o build/$@

$(POSTHTML): $(POSTSRCS)
	$(PANDOC) $< -o build/$@

home: dirs $(HOMEHTML)

post: dirs $(POSTHTML)

index: dirs home
	$(shell echo $(HTML_PRE) > build/index.html)
	$(shell cat build/README.html >> build/index.html)
	$(shell echo  $(HTML_POST) >> build/index.html)
	$(shell find . -type f -iname '*.html' -exec sed -i '' 's/.md/.html/' "{}" +;)

clean: 
	rm -rf build *.html*