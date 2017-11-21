extends: default.liquid
---
## Shea Newton

{% for post in posts %}
#### [{{ post.title }}]({{ post.path }})
{% endfor %}
