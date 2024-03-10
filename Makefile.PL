use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Smgp',
    VERSION_FROM => 'lib/Smgp.pm',
    PREREQ_PM    => {},
    ABSTRACT     => 'SMGP protocol implementation',
    AUTHOR       => 'ZhangJian He <shoothzj@gmail.com>',
    LIBS         => [ '' ],
    DEFINE       => '',
    INC          => '-I.',
    PM           => {
        'lib/Smgp.pm'             => 'blib/lib/Smgp.pm',
        'lib/Smgp/Constant.pm'    => 'blib/lib/Smgp/Constant.pm',
        'lib/Smgp/Protocol.pm'    => 'blib/lib/Smgp/Protocol.pm',
        'lib/Smgp/Client.pm'      => 'blib/lib/Smgp/Client.pm',
        'lib/Smgp/BoundAtomic.pm' => 'blib/lib/Smgp/BoundAtomic.pm',
    },
);
