#!/bin/bash
# Sample script to demonstrate the creation of an HTML report using shell scripting
# ps aux | head -1 | awk '{print $1, $2, $3, $4, $11}'; ps aux | sort -rnk 4 | head -5 | awk '{print $1, $2, $3, $4, $11}'
# Web directory
WEB_DIR=/var/www/my_app/public
# A little CSS and table layout to make the report look a little nicer
echo "<HTML>
<HEAD>
<style>
.titulo{font-size: 1em; color: white; background:#0863CE; padding: 0.1em 4.5em;}
table
{
border-collapse:collapse;
}
table, td, th
{
border:1px solid black;
}
</style>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
</HEAD>
<BODY>" > $WEB_DIR/report.html
# View hostname and insert it at the top of the html body
HOST=$(hostname)
echo "Top 10 process resources for host <strong>$HOST</strong><br>
Last updated: <strong>$(date)</strong><br><br>
<table border='1'>
<tr><th class='titulo'>User</td>
<th class='titulo'>PID</td>
<th class='titulo'>KiB Mem</td>
<th class='titulo'>CPU</td>
<th class='titulo'>Command</td>
</tr>" >> $WEB_DIR/report.html
# Read the output of df -h line by line
while read line; do
   echo "<tr><td align='center'>" >> $WEB_DIR/report.html
   echo $line | awk '{print $1}' >> $WEB_DIR/report.html
   echo "</td><td align='center'>" >> $WEB_DIR/report.html
   echo $line | awk '{print $2}' >> $WEB_DIR/report.html
   echo "</td><td align='center'>" >> $WEB_DIR/report.html
   echo $line | awk '{print $3}' >> $WEB_DIR/report.html
   echo "</td><td align='center'>" >> $WEB_DIR/report.html
   echo $line | awk '{print $4}' >> $WEB_DIR/report.html
   echo "</td><td align='center'>" >> $WEB_DIR/report.html
   echo $line | awk '{print $11}' >> $WEB_DIR/report.html
   echo "</td><td align='center'>" >> $WEB_DIR/report.html
   echo "</td></tr>" >> $WEB_DIR/report.html
done < <(ps aux | sort -rnk 4 | head -10)
echo "</table></BODY></HTML>" >> $WEB_DIR/report.html
