<!DOCTYPE html>

<html>

<head>

<meta charset="utf-8" />
<meta name="generator" content="pandoc" />
<meta http-equiv="X-UA-Compatible" content="IE=EDGE" />

<meta name="viewport" content="width=device-width, initial-scale=1" />



<title>What is the gibble</title>



<style type="text/css">code{white-space: pre;}</style>
<style type="text/css" data-origin="pandoc">
a.sourceLine { display: inline-block; line-height: 1.25; }
a.sourceLine { pointer-events: none; color: inherit; text-decoration: inherit; }
a.sourceLine:empty { height: 1.2em; }
.sourceCode { overflow: visible; }
code.sourceCode { white-space: pre; position: relative; }
div.sourceCode { margin: 1em 0; }
pre.sourceCode { margin: 0; }
@media screen {
div.sourceCode { overflow: auto; }
}
@media print {
code.sourceCode { white-space: pre-wrap; }
a.sourceLine { text-indent: -1em; padding-left: 1em; }
}
pre.numberSource a.sourceLine
  { position: relative; left: -4em; }
pre.numberSource a.sourceLine::before
  { content: attr(data-line-number);
    position: relative; left: -1em; text-align: right; vertical-align: baseline;
    border: none; pointer-events: all; display: inline-block;
    -webkit-touch-callout: none; -webkit-user-select: none;
    -khtml-user-select: none; -moz-user-select: none;
    -ms-user-select: none; user-select: none;
    padding: 0 4px; width: 4em;
    color: #aaaaaa;
  }
pre.numberSource { margin-left: 3em; border-left: 1px solid #aaaaaa;  padding-left: 4px; }
div.sourceCode
  {  }
@media screen {
a.sourceLine::before { text-decoration: underline; }
}
code span.al { color: #ff0000; font-weight: bold; } /* Alert */
code span.an { color: #60a0b0; font-weight: bold; font-style: italic; } /* Annotation */
code span.at { color: #7d9029; } /* Attribute */
code span.bn { color: #40a070; } /* BaseN */
code span.bu { } /* BuiltIn */
code span.cf { color: #007020; font-weight: bold; } /* ControlFlow */
code span.ch { color: #4070a0; } /* Char */
code span.cn { color: #880000; } /* Constant */
code span.co { color: #60a0b0; font-style: italic; } /* Comment */
code span.cv { color: #60a0b0; font-weight: bold; font-style: italic; } /* CommentVar */
code span.do { color: #ba2121; font-style: italic; } /* Documentation */
code span.dt { color: #902000; } /* DataType */
code span.dv { color: #40a070; } /* DecVal */
code span.er { color: #ff0000; font-weight: bold; } /* Error */
code span.ex { } /* Extension */
code span.fl { color: #40a070; } /* Float */
code span.fu { color: #06287e; } /* Function */
code span.im { } /* Import */
code span.in { color: #60a0b0; font-weight: bold; font-style: italic; } /* Information */
code span.kw { color: #007020; font-weight: bold; } /* Keyword */
code span.op { color: #666666; } /* Operator */
code span.ot { color: #007020; } /* Other */
code span.pp { color: #bc7a00; } /* Preprocessor */
code span.sc { color: #4070a0; } /* SpecialChar */
code span.ss { color: #bb6688; } /* SpecialString */
code span.st { color: #4070a0; } /* String */
code span.va { color: #19177c; } /* Variable */
code span.vs { color: #4070a0; } /* VerbatimString */
code span.wa { color: #60a0b0; font-weight: bold; font-style: italic; } /* Warning */

</style>
<script>
// apply pandoc div.sourceCode style to pre.sourceCode instead
(function() {
  var sheets = document.styleSheets;
  for (var i = 0; i < sheets.length; i++) {
    if (sheets[i].ownerNode.dataset["origin"] !== "pandoc") continue;
    try { var rules = sheets[i].cssRules; } catch (e) { continue; }
    for (var j = 0; j < rules.length; j++) {
      var rule = rules[j];
      // check if there is a div.sourceCode rule
      if (rule.type !== rule.STYLE_RULE || rule.selectorText !== "div.sourceCode") continue;
      var style = rule.style.cssText;
      // check if color or background-color is set
      if (rule.style.color === '' && rule.style.backgroundColor === '') continue;
      // replace div.sourceCode by a pre.sourceCode rule
      sheets[i].deleteRule(j);
      sheets[i].insertRule('pre.sourceCode{' + style + '}', j);
    }
  }
})();
</script>



<style type="text/css">body {
background-color: #fff;
margin: 1em auto;
max-width: 700px;
overflow: visible;
padding-left: 2em;
padding-right: 2em;
font-family: "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
font-size: 14px;
line-height: 1.35;
}
#TOC {
clear: both;
margin: 0 0 10px 10px;
padding: 4px;
width: 400px;
border: 1px solid #CCCCCC;
border-radius: 5px;
background-color: #f6f6f6;
font-size: 13px;
line-height: 1.3;
}
#TOC .toctitle {
font-weight: bold;
font-size: 15px;
margin-left: 5px;
}
#TOC ul {
padding-left: 40px;
margin-left: -1.5em;
margin-top: 5px;
margin-bottom: 5px;
}
#TOC ul ul {
margin-left: -2em;
}
#TOC li {
line-height: 16px;
}
table {
margin: 1em auto;
border-width: 1px;
border-color: #DDDDDD;
border-style: outset;
border-collapse: collapse;
}
table th {
border-width: 2px;
padding: 5px;
border-style: inset;
}
table td {
border-width: 1px;
border-style: inset;
line-height: 18px;
padding: 5px 5px;
}
table, table th, table td {
border-left-style: none;
border-right-style: none;
}
table thead, table tr.even {
background-color: #f7f7f7;
}
p {
margin: 0.5em 0;
}
blockquote {
background-color: #f6f6f6;
padding: 0.25em 0.75em;
}
hr {
border-style: solid;
border: none;
border-top: 1px solid #777;
margin: 28px 0;
}
dl {
margin-left: 0;
}
dl dd {
margin-bottom: 13px;
margin-left: 13px;
}
dl dt {
font-weight: bold;
}
ul {
margin-top: 0;
}
ul li {
list-style: circle outside;
}
ul ul {
margin-bottom: 0;
}
pre, code {
background-color: #f7f7f7;
border-radius: 3px;
color: #333;
white-space: pre-wrap; 
}
pre {
border-radius: 3px;
margin: 5px 0px 10px 0px;
padding: 10px;
}
pre:not([class]) {
background-color: #f7f7f7;
}
code {
font-family: Consolas, Monaco, 'Courier New', monospace;
font-size: 85%;
}
p > code, li > code {
padding: 2px 0px;
}
div.figure {
text-align: center;
}
img {
background-color: #FFFFFF;
padding: 2px;
border: 1px solid #DDDDDD;
border-radius: 3px;
border: 1px solid #CCCCCC;
margin: 0 5px;
}
h1 {
margin-top: 0;
font-size: 35px;
line-height: 40px;
}
h2 {
border-bottom: 4px solid #f7f7f7;
padding-top: 10px;
padding-bottom: 2px;
font-size: 145%;
}
h3 {
border-bottom: 2px solid #f7f7f7;
padding-top: 10px;
font-size: 120%;
}
h4 {
border-bottom: 1px solid #f7f7f7;
margin-left: 8px;
font-size: 105%;
}
h5, h6 {
border-bottom: 1px solid #ccc;
font-size: 105%;
}
a {
color: #0033dd;
text-decoration: none;
}
a:hover {
color: #6666ff; }
a:visited {
color: #800080; }
a:visited:hover {
color: #BB00BB; }
a[href^="http:"] {
text-decoration: underline; }
a[href^="https:"] {
text-decoration: underline; }

code > span.kw { color: #555; font-weight: bold; } 
code > span.dt { color: #902000; } 
code > span.dv { color: #40a070; } 
code > span.bn { color: #d14; } 
code > span.fl { color: #d14; } 
code > span.ch { color: #d14; } 
code > span.st { color: #d14; } 
code > span.co { color: #888888; font-style: italic; } 
code > span.ot { color: #007020; } 
code > span.al { color: #ff0000; font-weight: bold; } 
code > span.fu { color: #900; font-weight: bold; } 
code > span.er { color: #a61717; background-color: #e3d2d2; } 
</style>




</head>

<body>




<h1 class="title toc-ignore">What is the gibble</h1>



<div class="sourceCode" id="cb1"><pre class="sourceCode r"><code class="sourceCode r"><a class="sourceLine" id="cb1-1" data-line-number="1"><span class="kw">library</span>(gibble)</a></code></pre></div>
<p>The gibble package provides a basic unit of information about the structure of a spatial data set. The key idea is of a <em>part</em> of spatial data, and the ways these are arranged hierarchically in spatial formats.</p>
<p>If we consider a very simple polygon layer, as understood by the sf package the structure is pretty simple.</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode r"><code class="sourceCode r"><a class="sourceLine" id="cb2-1" data-line-number="1"><span class="kw">library</span>(sf)</a>
<a class="sourceLine" id="cb2-2" data-line-number="2"><span class="kw">plot</span>(minimal_mesh)</a></code></pre></div>
<p><img src="data:image/png;base64,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" /><!-- --></p>



<!-- code folding -->


<!-- dynamically load mathjax for compatibility with self-contained -->
<script>
  (function () {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src  = "https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
    document.getElementsByTagName("head")[0].appendChild(script);
  })();
</script>

</body>
</html>
