package Smgp::Protocol;

use strict;
use warnings FATAL => 'all';

use Smgp::Constant;

sub new_login {
    my ($class, %args) = @_;
    my $self = {
        clientId            => $args{clientId},
        authenticatorClient => $args{authenticatorClient},
        loginMode           => $args{loginMode},
        timeStamp           => $args{timeStamp},
        version             => $args{version},
    };
    return bless $self, $class;
}

sub encode_login {
    my ($self) = @_;
    return pack("A8A16CNC", @{$self}{qw(clientId authenticatorClient loginMode timeStamp version)});
}

sub decode_login_resp {
    my ($class, $buffer) = @_;
    my ($status, $authenticatorServer, $version) = unpack("N4A16C", $buffer);
    return bless {
        status              => $status,
        authenticatorServer => $authenticatorServer,
        version             => $version,
    }, $class;
}

sub new_header {
    my ($class, %args) = @_;
    my $self = {
        total_length   => $args{total_length},
        request_id     => $args{request_id},
        command_status => $args{command_status},
        sequence_id    => $args{sequence_id},
    };
    return bless $self, $class;
}

sub encode_header {
    my ($self, $total_length) = @_;
    return pack("N3", $total_length, @{$self}{qw(request_id sequence_id)});
}

sub new_pdu {
    my ($class, %args) = @_;
    my $self = {
        header => $args{header},
        body   => $args{body},
    };
    return bless $self, $class;
}

sub encode_login_pdu {
    my ($self) = @_;
    my $encoded_body = $self->{body}->encode_login();
    return $self->{header}->encode_header(length($encoded_body) + 12) . $encoded_body;
}

sub decode_pdu {
    my ($class, $buffer) = @_;
    my ($request_id, $sequence_id) = unpack("N2", substr($buffer, 0, 8));
    my $body_buffer = substr($buffer, 8);

    my $header = $class->new_header(
        total_length   => 0,
        request_id     => $request_id,
        sequence_id    => $sequence_id,
    );

    my $body;
    if ($request_id == Smgp::Constant::LOGIN_RESP_ID) {
        $body = $class->decode_login_resp($body_buffer);
    } else {
        die "Unsupported request_id: $request_id";
    }

    return $class->new_pdu(
        header => $header,
        body   => $body,
    );
}

1;
