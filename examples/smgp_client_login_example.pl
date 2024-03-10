package smgp_client_login_example;

use strict;
use warnings FATAL => 'all';

use Smgp::Client;
use Smgp::Protocol;
use Smgp::Constant;

sub main {
    my $client = Smgp::Client->new(
        host => 'localhost',
        port => 9000,
    );

    $client->connect();

    my $login = Smgp::Protocol->new_login(
        clientId            => '12345678',
        authenticatorClient => '1234567890123456',
        loginMode           => 1,
        timeStamp           => time(),
        version             => 0,
    );

    my $response = $client->login($login);

    if ($response->{status} == 0) {
        print "Login successful!\n";
    }
    else {
        print "Login failed! Status: ", (defined $response->{status} ? $response->{status} : 'undefined'), "\n";
    }

    $client->disconnect();
}

main() unless caller;

1;
