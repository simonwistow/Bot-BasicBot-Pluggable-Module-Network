package Bot::BasicBot::Pluggable::Module::Tlds;

use strict;
use Bot::BasicBot::Pluggable::Module; 
use base qw(Bot::BasicBot::Pluggable::Module);

sub said { 
    my ($self, $mess, $pri) = @_;

    my $body = $mess->{body}; 
    my $who  = $mess->{who};

    return unless ($pri == 2);

    return unless $body =~ /^(tld|country)(?: for)?\s+(\S+)$/i;

    my $what  = $1;
    my $where = $2;

    my $pos = tell DATA;
    my %tlds;
    my %countries;
    for (<DATA>) {
        chomp;
        next if /^\s*$/;
        next if /^#/;
	s/\s+/ /g;
	s/(^\s*|\s*$)//g;
	my ($tld, $country) = split ' ', $_, 2;
	$tlds{lc($tld)} = $country;
	$countries{lc($country)} = $tld;
    }
    seek DATA, $pos,0;

    if (lc($what) eq 'tld') {
	my $t = $countries{lc($where)};
	return "No such country '$where'" unless defined $t;
	return "The tld for $where is $t";
    } else {
	my $t = $tlds{lc($where)};
	return "No such TLD $where" unless defined $t;
	return "$where is the TLD for $t";
    }

	


}

sub help {
    return "Commands: 'country for <tld>? or tld for <country>?'";
}

1;

=head1 NAME

Bot::BasicBot::Pluggable::Module::Tld - tld utility methods.


=head1 SYNOPSIS

Uses the tld list from http://ftp.ics.uci.edu/pub/websoft/wwwstat/country-codes.txt to provide help on tlds

=head1 IRC USAGE

	country for <tld>? 
	tld for <country>?

=head1 AUTHOR

Simon Wistow, <simon@thegestalt.org>

=head1 COPYRIGHT

Copyright 2006, Simon Wistow

Distributed under the same terms as Perl itself.

=head1 SEE ALSO


=cut 

__DATA__
AD   Andorra
AE   United Arab Emirates
AF   Afghanistan
AG   Antigua and Barbuda
AI   Anguilla
AL   Albania
AM   Armenia
AN   Netherlands Antilles
AO   Angola
AQ   Antarctica
AR   Argentina
AS   American Samoa
AT   Austria
AU   Australia
AW   Aruba
AX   Aland Islands
AZ   Azerbaijan
BA   Bosnia and Herzegovina
BB   Barbados
BD   Bangladesh
BE   Belgium
BF   Burkina Faso
BG   Bulgaria
BH   Bahrain
BI   Burundi
BJ   Benin
BM   Bermuda
BN   Brunei Darussalam
BO   Bolivia
BR   Brazil
BS   Bahamas
BT   Bhutan
BV   Bouvet Island
BW   Botswana
BY   Belarus
BZ   Belize
CA   Canada
CC   Cocos (Keeling) Islands
CD   Democratic Republic of the Congo
CF   Central African Republic
CG   Congo
CH   Switzerland
CI   Cote D'Ivoire (Ivory Coast)
CK   Cook Islands
CL   Chile
CM   Cameroon
CN   China
CO   Colombia
CR   Costa Rica
CS   Serbia and Montenegro
CU   Cuba
CV   Cape Verde
CX   Christmas Island
CY   Cyprus
CZ   Czech Republic
DE   Germany
DJ   Djibouti
DK   Denmark
DM   Dominica
DO   Dominican Republic
DZ   Algeria
EC   Ecuador
EE   Estonia
EG   Egypt
EH   Western Sahara
ER   Eritrea
ES   Spain
ET   Ethiopia
FI   Finland
FJ   Fiji
FK   Falkland Islands (Malvinas)
FM   Federated States of Micronesia
FO   Faroe Islands
FR   France
FX   France, Metropolitan
GA   Gabon
GB   Great Britain (UK)
GD   Grenada
GE   Georgia
GF   French Guiana
GH   Ghana
GI   Gibraltar
GL   Greenland
GM   Gambia
GN   Guinea
GP   Guadeloupe
GQ   Equatorial Guinea
GR   Greece
GS   S. Georgia and S. Sandwich Islands
GT   Guatemala
GU   Guam
GW   Guinea-Bissau
GY   Guyana
HK   Hong Kong
HM   Heard Island and McDonald Islands
HN   Honduras
HR   Croatia (Hrvatska)
HT   Haiti
HU   Hungary
ID   Indonesia
IE   Ireland
IL   Israel
IN   India
IO   British Indian Ocean Territory
IQ   Iraq
IR   Iran
IS   Iceland
IT   Italy
JM   Jamaica
JO   Jordan
JP   Japan
KE   Kenya
KG   Kyrgyzstan
KH   Cambodia
KI   Kiribati
KM   Comoros
KN   Saint Kitts and Nevis
KP   Korea (North)
KR   Korea (South)
KW   Kuwait
KY   Cayman Islands
KZ   Kazakhstan
LA   Laos
LB   Lebanon
LC   Saint Lucia
LI   Liechtenstein
LK   Sri Lanka
LR   Liberia
LS   Lesotho
LT   Lithuania
LU   Luxembourg
LV   Latvia
LY   Libya
MA   Morocco
MC   Monaco
MD   Moldova
MG   Madagascar
MH   Marshall Islands
MK   Macedonia
ML   Mali
MM   Myanmar
MN   Mongolia
MO   Macao
MP   Northern Mariana Islands
MQ   Martinique
MR   Mauritania
MS   Montserrat
MT   Malta
MU   Mauritius
MV   Maldives
MW   Malawi
MX   Mexico
MY   Malaysia
MZ   Mozambique
NA   Namibia
NC   New Caledonia
NE   Niger
NF   Norfolk Island
NG   Nigeria
NI   Nicaragua
NL   Netherlands
NO   Norway
NP   Nepal
NR   Nauru
NU   Niue
NZ   New Zealand (Aotearoa)
OM   Oman
PA   Panama
PE   Peru
PF   French Polynesia
PG   Papua New Guinea
PH   Philippines
PK   Pakistan
PL   Poland
PM   Saint Pierre and Miquelon
PN   Pitcairn
PR   Puerto Rico
PS   Palestinian Territory
PT   Portugal
PW   Palau
PY   Paraguay
QA   Qatar
RE   Reunion
RO   Romania
RU   Russian Federation
RW   Rwanda
SA   Saudi Arabia
SB   Solomon Islands
SC   Seychelles
SD   Sudan
SE   Sweden
SG   Singapore
SH   Saint Helena
SI   Slovenia
SJ   Svalbard and Jan Mayen
SK   Slovakia
SL   Sierra Leone
SM   San Marino
SN   Senegal
SO   Somalia
SR   Suriname
ST   Sao Tome and Principe
SU   USSR (former)
SV   El Salvador
SY   Syria
SZ   Swaziland
TC   Turks and Caicos Islands
TD   Chad
TF   French Southern Territories
TG   Togo
TH   Thailand
TJ   Tajikistan
TK   Tokelau
TL   Timor-Leste
TM   Turkmenistan
TN   Tunisia
TO   Tonga
TP   East Timor
TR   Turkey
TT   Trinidad and Tobago
TV   Tuvalu
TW   Taiwan
TZ   Tanzania
UA   Ukraine
UG   Uganda
UK   United Kingdom
UM   United States Minor Outlying Islands
US   United States
UY   Uruguay
UZ   Uzbekistan
VA   Vatican City State (Holy See)
VC   Saint Vincent and the Grenadines
VE   Venezuela
VG   Virgin Islands (British)
VI   Virgin Islands (U.S.)
VN   Viet Nam
VU   Vanuatu
WF   Wallis and Futuna
WS   Samoa
YE   Yemen
YT   Mayotte
YU   Yugoslavia (former)
ZA   South Africa
ZM   Zambia
ZR   Zaire (former)
ZW   Zimbabwe
BIZ   Business
COM   Commercial
EDU   US Educational
GOV   US Government
INT   International
MIL   US Military
NET   Network
ORG   Nonprofit Organization
PRO   Professional Services
AERO   Aeronautic
ARPA   Arpanet Technical Infrastructure
COOP   Cooperative
INFO   Info Domain
NAME   Personal Name
NATO   North Atlantic Treaty Organization
