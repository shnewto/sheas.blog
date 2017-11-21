extends: default.liquid
---
## Blog!

{% for post in posts %}
#### {{post.title}}

#### [{{ post.title }}]({{ post.path }})
{% endfor %}
