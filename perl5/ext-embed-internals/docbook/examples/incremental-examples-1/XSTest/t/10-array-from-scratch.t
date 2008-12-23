use strict;
use warnings;

use Test::More tests => 2;

use XSTest;

{
    my @array1 = (0, 1, 200, 33);
    my @array2 = (4004, 50);

    my $combined = XSTest::concat_two_array_refs(\@array1, \@array2);
    # TEST
    is_deeply(
        $combined,
        [0, 1, 200, 33, 4004, 50],
        "concat_two_array_refs - 1"
    );
}

{
    my $combined;

    {
        my @array1 = ("Hon", "Ton", "Gorgon");
        my @array2 = ("Look", "Mook", "Crook");

        $combined = XSTest::concat_two_array_refs(\@array1, \@array2);
    }

    # TEST
    is_deeply(
        $combined,
        [qw(Hon Ton Gorgon Look Mook Crook)],
        "concat_two_array_refs - original go out of scope"
    );
}
