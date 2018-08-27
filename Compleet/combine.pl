use strict;

my $saxon = "java -jar D:\\Users\\Jeroen\\Documents\\eLibrary\\Tools\\tei2html\\tools\\lib\\saxon9he.jar";

print "Combine parts...\n";

chdir "../Deel 1";
system ("perl -S tei2html.pl -x");
chdir "../Deel 2";
system ("perl -S tei2html.pl -x");
chdir "../Deel 3";
system ("perl -S tei2html.pl -x");
chdir "../Deel 4";
system ("perl -S tei2html.pl -x");
chdir "../Deel 5";
system ("perl -S tei2html.pl -x");
chdir "../Compleet";


print "Create complete XML version...\n";
system ("$saxon Ellendigen.xsl Ellendigen.xsl > Ellendigen.xml");
system ("perl -S tei2html.pl -e -v -h Ellendigen.xml");
