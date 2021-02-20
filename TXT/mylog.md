---
layout: page
title: My Log
permalink: /TXT/mylog
---

## My Log
---
<script>function redirectRAW() { window.location ="mylog.txt" }</script>
<button class="btn js-toggle-dark-mode" onclick="redirectRAW()">View raw</button>
<div id="log">Loading <code>/mylog.txt</code></div>

<script id="loading">
function build(content) { return `<div class="language-bash highlighter-rouge"><div class="highlight"><pre class="highlight"><code id="mylog">${content}</code></pre></div></div>`}
function getText(){
	var request = new XMLHttpRequest();
	request.open('GET', 'mylog.txt', true);
	request.send(null);
	request.onreadystatechange = function () {
		if (request.readyState === 4 && request.status === 200) {
			document.getElementById('log').innerHTML = build(request.responseText);
		}
	}
}
getText();
document.getElementById('loading').remove()
</script>
