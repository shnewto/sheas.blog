MUSTACHE=mustache
PANDOC=pandoc

HTML_PRE="\
<!DOCTYPE html> \
<html lang=\"en\"> \
    <head> \
		<!-- Global site tag (gtag.js) - Google Analytics --> \
		<script async src="https://www.googletagmanager.com/gtag/js?id=G-LB9P37G2G1"></script> \
		<script> \
			window.dataLayer = window.dataLayer || []; \
			function gtag(){dataLayer.push(arguments);} \
			gtag('js', new Date()); \
 \
			gtag('config', 'G-LB9P37G2G1'); \
		</script> \
 \
        <meta charset=\"UTF-8\"> \
        <meta name=\"viewport\" content=\"width=device-width initial-scale=1.0\"> \
		<link rel="icon" href="/img/favicon.ico"> \
		<title>shea's blog</title> \
        <link rel=\"stylesheet\" href=\"/style/style.css\"> \
    </head> \
<body> \
"

HTML_NAV_BAR="\
    <p> \
        [ <a href=\"/talks.html\">talks</a> ]  \
        [ <a href=\"/about.html\">about</a> ]  \
        [ <a href=\"/publications.html\">publications</a> ] \
        [ <a href=\"/posts.html\">posts</a> ]  \
        [ <a href=\"/home.html\">home</a> ] \
    </p> \
"

HTML_POST="\
</body> \
</html> \
"

CONFIG_PRE='{"routes":['

CONFIG_POST="]}"

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

PAGESRCS := $(wildcard *.md)
PAGEHTML := $(patsubst %.md,%.html,$(PAGESRCS))

POSTSRCS := $(wildcard post/*.md)
POSTHTML := $(patsubst %.md,%.html,$(POSTSRCS))

all: dirs page post process index
	$(shell truncate -s-2 build/vercel.json)
	@echo $(CONFIG_POST) >> build/vercel.json

dirs: 
	mkdir -p build/post
	cp -a papers slides style img res build
	@echo $(CONFIG_PRE) > build/vercel.json

page: $(PAGEHTML)
post: $(POSTHTML)

$(PAGEHTML): $(PAGESRCS)
	@echo $(HTML_PRE) > build/$@
	@echo  $(HTML_NAV_BAR) >> build/$@
	$(PANDOC) $(basename $@).md >> build/$@
	@echo  $(HTML_POST) >> build/$@
	@echo '{ "src": "/$(basename $@)", "dest" : "/$@" },' >> build/vercel.json

$(POSTHTML): $(POSTSRCS)
	@echo $(HTML_PRE) > build/$@
	@echo  $(HTML_NAV_BAR) >> build/$@
	$(PANDOC) $(basename $@).md >> build/$@
	@echo  $(HTML_POST) >> build/$@
	@echo '{ "src": "/$(basename $@)", "dest" : "/$@" },' >> build/vercel.json

process: dirs
	$(shell find . -type f -iname '*.html' -exec sed -i '' 's/.md/.html/' "{}" +;)

index:
	@echo $(INDEX) > build/index.html


clean: 
	rm -rf build *.html* post/*.html*