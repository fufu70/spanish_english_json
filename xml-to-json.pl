#!/usr/bin/perl

use strict;
use warnings;
use JSON;
use XML::Simple;

# Path to your XML file
my $xml_file_path = $ARGV[0]; #"workdir/en-es-en-Dic/src/main/resources/dic/verbs/en-es.xml"; 

# Create an object of XML::Simple. 
# KeepRoot => 1 ensures the root element of the XML is included in the resulting data structure.
my $xml_simple_obj = XML::Simple->new(KeepRoot => 1);

# Load the XML file into a Perl data structure (hashref).
# XMLin() parses the XML and returns a representation of its content.
my $data_xml = $xml_simple_obj->XMLin($xml_file_path);

# Encode the Perl data structure into a JSON string.
my $json_string = encode_json($data_xml);

# Print the resulting JSON string.
print $json_string;