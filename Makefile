MUSTACHE=mustache
PANDOC=pandoc

HTML_PRE="\
<!DOCTYPE html> \
<html lang=\"en\"> \
    <head> \
        <meta charset=\"UTF-8\"> \
        <meta name=\"viewport\" content=\"width=device-width initial-scale=1.0\"> \
		<link rel="icon" href="/img/favicon.ico"> \
		<title>shea's blog</title> \
        <link rel=\"stylesheet\" href=\"/style/style.css\"> \
    </head> \
<body> \
    <p> \
        <a href=\"/home.html\">home</a>  \
        | <a href=\"/about.html\">about</a>  \
        | <a href=\"/talks.html\">talks</a>  \
        | <a href=\"/publications.html\">publications</a> \
    </p> \
"

HTML_POST="\
</body> \
</html> \
"

INDEX="\
<!DOCTYPE html> \
<html lang=\"en\"> \
    <head> \
        <meta charset=\"UTF-8\"> \
		<meta http-equiv=\"refresh\" content=\"0; url=/home.html\" /> \
    </head> \
<body> \
</body> \
</html> \
"

HOMESRCS := $(wildcard *.md)
HOMEHTML := $(patsubst %.md,%.html,$(HOMESRCS))

POSTSRCS := $(wildcard post/*.md)
POSTHTML := $(patsubst %.md,%.html,$(POSTSRCS))

all: dirs post home process index

dirs: 
	mkdir -p build/post
	cp -a papers slides style img build

home: $(HOMEHTML) 
post: $(POSTHTML)

$(HOMEHTML): $(HOMESRCS)
	@echo $(HTML_PRE) > build/$@
	$(PANDOC) $(basename $@).md >> build/$@
	@echo  $(HTML_POST) >> build/$@

$(POSTHTML): $(POSTSRCS)
	@echo $(HTML_PRE) > build/$@
	$(PANDOC) $(basename $@).md >> build/$@
	@echo  $(HTML_POST) >> build/$@

process: dirs
	$(shell find . -type f -iname '*.html' -exec sed -i '' 's/.md/.html/' "{}" +;)

index:
	@echo $(INDEX) > build/index.html

clean: 
	rm -rf build *.html* post/*.html*