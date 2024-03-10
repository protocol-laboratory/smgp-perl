package Smgp::Constant;

use strict;
use warnings FATAL => 'all';

use constant {
    LOGIN_ID               => 0x00000001,
    LOGIN_RESP_ID          => 0x80000001,
    SUBMIT_ID              => 0x00000002,
    SUBMIT_RESP_ID         => 0x80000002,
    DELIVER_ID             => 0x00000003,
    DELIVER_RESP_ID        => 0x80000003,
    ACTIVE_TEST_ID         => 0x00000004,
    ACTIVE_TEST_RESP_ID    => 0x80000004,
    FORWARD_ID             => 0x00000005,
    FORWARD_RESP_ID        => 0x80000005,
    EXIT_ID                => 0x00000006,
    EXIT_RESP_ID           => 0x80000006,
    QUERY_ID               => 0x00000007,
    QUERY_RESP_ID          => 0x80000007,
    MT_ROUTE_UPDATE_ID     => 0x00000008,
    MT_ROUTE_UPDATE_RESP_ID => 0x80000008,
};

1;
