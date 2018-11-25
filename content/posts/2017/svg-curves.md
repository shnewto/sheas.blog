---
title: "SVG Curves"
draft: false
date: 2017-11-26T21:45:00-08:00
---

Exploring how to incorporate some JavaScript into a blog post.

<!--more-->

{{< html >}}
<head>
<script>
function drawPath() {
    var path = document.getElementById('svgpath')
    path.setAttribute(
        "d",
        "M10 80 Q 52.5 10, 95 80 T 180 80"
  );
}
function togglePathVisibility() {
    var path = document.getElementById('svgpath')
    path.style.display = path.style.display == "none" ? "block" : "none";
}
</script>
</head>

{{< /html >}}
Click the space below to toggle the Bezier curve.
{{< html >}}
<br>
<svg class="SvgArea" onclick="togglePathVisibility();" xmlns="http://www.w3.org/2000/svg;">
    <path class="Path" id="svgpath"/>
    <script>drawPath()</script>
</svg>
<br><br>
{{< /html >}}

{{< html >}}
<style>
.Path {
    display: block;
    stroke: black;
    stroke-width: 5;
    stroke-dasharray: 15000;
    stroke-dashoffset: 15000;
    animation: dash 30s linear forwards;
    fill: none;
    opacity: 0.3;
}
.SvgArea {
    width: 190;
    height: 160;
}
@keyframes dash {
    to {
        stroke-dashoffset: 0;
    }
}
</style>

{{< /html >}}


Source available [here](https://github.com/shnewto/sheas.blog/blob/master/content/posts/2017/svg-curves.md).
