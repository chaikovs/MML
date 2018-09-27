<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
                "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
  <title>Matlab Search Engine</title>
  <meta name="keywords" content="search, engine, matlab, documentation">
  <meta name="description" content="Matlab documentation search engine with M2HTML">
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta name="generator" content="m2html v1.5 &copy; 2003-2005 Guillaume Flandin">
  <meta name="robots" content="index, follow">
  <link type="text/css" rel="stylesheet" href="./m2html.css">
</head>
<body>
<a name="_top"></a>
<h1>Search Engine</h1>

<form class="search" action="search.php" method="get">
Search for <input class="search" type="text" name="query" value="<?php echo $query; ?>" size="20" accesskey="s"/>
<input type="submit" name="submit" value="Search">
</form>

<?php
	include('doxysearch.php');
	main('search.idx');
?>

<hr><address>Generated on Fri 23-Jul-2010 00:42:04 by <strong><a href="http://www.artefact.tk/software/matlab/m2html/" title="Matlab Documentation in HTML">m2html</a></strong> &copy; 2005</address>
</body>
</html>