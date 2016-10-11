#source="https://www.blackhat.com/us-16/briefings.html"
source=$1
#echo $#
if [ $# != 1 ];then
	echo 'USAGE: $0 BLACKHAT_URL'
	echo 'e.g.: $0 https://www.blackhat.com/us-16/briefings.html'
	exit 1;
fi
echo '[+] check url: '$source
for url in $(curl -s $source | grep -a "pdf\|zip" | awk -F '"' '{printf ("%s ",$4)}');
do
	echo '[+] find: '$url
	pdf=`echo $url | awk -F "/" '{printf $NF}'`
	if [ -f "$pdf" ]; then
		echo "[-] pdf: $pdf exists"
		continue
	fi
	wget -c -v $url
	echo -e "done"
done
