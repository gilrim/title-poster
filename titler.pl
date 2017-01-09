#!/etc/perl
# Fetches titles
use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
require HTML::HeadParser;

$VERSION = '0.1';
%IRSSI   = (
    authors     => 'egilh, Monk',
    name        => 'title-poster',
    description => 'Fetches and posts titles',
    license     => 'GNU General Public License 3.0'
);

my $chan = '#channel';
my $word;
my $useragent = 'Mozilla';
my $url;
my $urlfound = 0;
my $title;
my $html;
my $p;
my @denied_titles = ();

sub get_title {
    my ( $server, $msg, $target, $channel, $chatnet ) = @_;

    $_ = $msg;
    if ( $chatnet eq $chan ) {
      $url = ( /https?\:\/\/[\.a-zA-Z0-9\/+:\?\=\&\w_-]{0,500}/i )
        if $url {
          $head = (`curl -A $useragent -H 'Accept-Charset: utf-8' -H 'Accept-Language: nb-no, en-us' -I $url`);
          $content = ( /(Content-Type\: ).*\n /)
          if $content "#¤&%"#&"¤%&/Y"¤%&"#¤%"
        }
    }
    if ( $urlfound eq 1 ) {
        $p    = HTML::HeadParser->new;
        $html = (`wget -U $useragent --header='Accept-Charset: utf-8' --header='Accept-Language: nb-no, en-us' -q -O- $url`);
        $p->parse($html);
        $title = $p->header('Title');
        $title = substr( $title, 0, 250 );
        foreach my $d_title (@denied_titles) {
            if ( index( $title, $d_title ) ne -1 ) {
                return;
            }
        }
        if ( $title ne '' ) {
            $server->command("msg $chan $title");
        }
        $urlfound = 0;
    }
  }
}
}
Irssi::signal_add( 'message public', 'get_title' );
