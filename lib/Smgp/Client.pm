package Smgp::Client;
use strict;
use warnings FATAL => 'all';
use IO::Socket::INET;

use Smgp::Protocol;
use Smgp::Constant;

sub new {
    my ($class, %args) = @_;
    my $self = {
        host => $args{host} // 'localhost',
        port => $args{port} // 9000,
        socket => undef,
        sequence_id => 1,
    };
    bless $self, $class;
    return $self;
}

sub connect {
    my ($self) = @_;
    $self->{socket} = IO::Socket::INET->new(
        PeerHost => $self->{host},
        PeerPort => $self->{port},
        Proto => 'tcp',
    ) or die "Cannot connect to $self->{host}:$self->{port} $!";
}

sub login {
    my ($self, $body) = @_;
    my $header = Smgp::Protocol->new_header(
        request_id     => Smgp::Constant::LOGIN_ID,
        sequence_id    => 1,
    );

    my $pdu = Smgp::Protocol->new_pdu(
        header => $header,
        body   => $body,
    );

    $self->{socket}->send($pdu->encode_login_pdu());

    $self->{socket}->recv(my $response_length_bytes, 4);

    my $total_length = unpack("N", $response_length_bytes);
    my $remain_length = $total_length - 4;
    $self->{socket}->recv(my $response_data, $remain_length);

    return Smgp::Protocol->decode_pdu($response_data)->{body};
}

sub disconnect {
    my ($self) = @_;
    close($self->{socket}) if $self->{socket};
}

1;
