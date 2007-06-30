package XSTest;

use warnings;
use strict;

=head1 NAME

XSTest - Module that serves as a playground for writing XS code.

=head1 VERSION

Version 0.0004

=cut

our $VERSION = '0.0004';

require XSLoader;
XSLoader::load('XSTest', $VERSION);

=head1 SYNOPSIS

Perhaps a little code snippet.

    use XSTest;

    my $foo = XSTest->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 new

Creates a new XSTest object.  Takes the following optional parameters:

=over 4

=item value

If you pass a single numeric value, it will be stored in the 'value' slot
of the object hash.

=item key/value pair

A generic input method which takes an unlimited number of key/value pairs
and stores them in the object hash.  Performs no validation.

=back

=cut

#sub new {
# Defined in the XS code
#}

=head2 increment

An object method which increments the 'value' slot of the the object hash,
if it exists.  Called like this:

  my $obj = XSTest->new(5);
  $obj->increment(); # now equal to 6

=cut

=head2 hello

A function that prints "C<Hello, World!\n>" to the (C) stdout filehandle.

=head2 get_24

A function that returns the 24 integer implemented as XS.

=head2 get_xs_string

Returns an XS String constant - C<"Hello">.

=head1 AUTHOR

Shlomi Fish, C<< <shlomif@iglu.org.il> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-xstest@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=XSTest>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2007 Shlomi Fish, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of XSTest
