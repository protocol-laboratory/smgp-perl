package Smgp::BoundAtomic;

use strict;
use warnings FATAL => 'all';

sub new {
    my ($class, %args) = @_;
    my $self = {
        min     => $args{min},
        max     => $args{max},
        value   => $args{min},
    };
    bless $self, $class;
    return $self;
}

sub increment {
    my ($self) = @_;
    if ($self->{value} >= $self->{max}) {
        $self->{value} = $self->{min};
    } else {
        $self->{value}++;
    }
    return $self->{value};
}

sub get {
    my ($self) = @_;
    return $self->{value};
}

1;
