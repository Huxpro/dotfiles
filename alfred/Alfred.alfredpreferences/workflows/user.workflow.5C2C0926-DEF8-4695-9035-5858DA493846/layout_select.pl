#!/usr/bin/perl

use strict;
use YAML::Syck;
use XML::Writer;
use Data::Dumper;

$YAML::Syck::ImplicitTyping = 1;

sub expand_tilde {
  my( $file ) = shift;
  $file =~ s{^~([^/]*)}{
    $1 ? (getpwnam($1))[7] : ( $ENV{HOME} || $ENV{LOGDIR} )
  }ex;

  $file
}

my $pattern = '.*';
my @layouts;
my $layouts_file_user = $ENV{'LAYOUTS_FILE'};
my $layouts_file_legacy = $ENV{'HOME'} . '/Library/Application Support/Alfred 2/Workflow Data/de.leanovate.alfred.layout/layouts.yaml';
my $layouts_file = './Data/de.leanovate.alfred.layout/layouts.yaml';

$layouts_file_legacy = expand_tilde($layouts_file_legacy);

if ( -f $layouts_file_user ) {
    print STDERR "Reading user layout options from: " . $layouts_file_user . "\n";

	@layouts = @{LoadFile($layouts_file_user)}
} elsif ( -f $layouts_file ) {
	print STDERR "Reading layout options from: " . $layouts_file . "\n";

	@layouts = @{LoadFile($layouts_file)}
} elsif ( -f $layouts_file_legacy ) {
    print STDERR "Using legacy path for layout options: " . $layouts_file_legacy . "\n";

    @layouts = @{LoadFile($layouts_file_legacy)}
} else {
	print STDERR "Using default layout options\n";

	@layouts = @{LoadFile('default_layouts.yaml')};
}

if ( scalar(@ARGV) > 0 ) {
	$pattern = quotemeta(@ARGV[0]);
}

my @filtered;
my $screenOffset = '';

if ( scalar(@ARGV) > 1 ) {
  @filtered = grep { $_->{'name'} =~ /$pattern/ && $_->{'forOtherScreen'} } @layouts;
  $screenOffset = ':' . @ARGV[1];
} else {
  @filtered = grep { $_->{'name'} =~ /$pattern/ } @layouts;
}

my $writer = XML::Writer->new();

$writer->startTag('items');
foreach my $layout (@filtered) {
	$writer->startTag('item', "valid" => "yes", "arg" => $layout->{'command'} . $screenOffset, "uid" => $layout->{'name'});
	$writer->startTag('title');
	$writer->characters($layout->{'display'});
	$writer->endTag('title');
	$writer->startTag('icon');
	$writer->characters(sprintf('icon_%s.png',$layout->{'name'}));
	$writer->endTag('icon');
	$writer->endTag('item');
}
$writer->endTag('items');
$writer->end();
