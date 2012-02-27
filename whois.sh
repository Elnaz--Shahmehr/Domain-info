_domain=$@

# Die if no domains are given
[ $# -eq 0 ] &&
{
	echo "Usage: $0 example1.com example2.net ....";
	exit 1;
}
for dom in $_domain
do
	_ipaddress=$(host $dom | grep 'has add' | head -1 | awk '{ print $4}')
	[ "$_ipaddress" == "" ] &&
	{
		echo "Error: $dom is not valid domain or dns error OR Check your firewall settings.";
		continue;
	}
	echo "Getting information for domain: $dom [ $_ipaddress ]..."
	whois "$_ipaddress" | egrep -w 'OrgName:|City:|State:|Country:|OriginAS:|NetRange:'
	echo ""
done
