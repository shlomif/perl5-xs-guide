use strict;
use warnings;

use Test::More tests => 3;

use XSTest;

{
    my $value = XSTest::lookup_mystring_in_hash({ 'mystring' => "Hello" });

    # TEST
    is ($value, "Hello", "Lookup is OK.")
}

{
    my $value = XSTest::lookup_mystring_in_hash(
        { 'mystring' => "Hello", 'author' => "Jane", }
    );

    # TEST
    is ($value, "Hello", "Lookup is OK with other value.")
}


{
    my $value = XSTest::lookup_mystring_in_hash(
        { 'author' => "Jane", year => 1950, }
    );

    # TEST
    ok (!defined($value), "Return undef if value not found.")
}

