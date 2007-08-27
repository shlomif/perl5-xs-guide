#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

typedef SV * XSTest;

MODULE = XSTest		PACKAGE = XSTest		

XSTest
new(...)
    INIT:
    	char *classname;
	/* get the class name if called as an object method */
	if ( sv_isobject(ST(0)) ) {
	    classname = HvNAME(SvSTASH(SvRV(ST(0))));
	}
	else {
	    classname = (char *)SvPV_nolen(ST(0));
	}

    CODE:
    	/* This is a standard hash-based object */
    	RETVAL = (XSTest)newHV();

	/* Single init value */
	if ( items == 2 ) 
	    hv_store((HV *)RETVAL, "value", 5, newSVsv(ST(1)), 0);
	/* name/value pairs */
	else if ( (items-1)%2 == 0 ) {
	    int i;
	    for ( i=1; i < items; i += 2 ) {
		hv_store_ent((HV *)RETVAL, ST(i), newSVsv(ST(i+1)), 0);
	    }
	}
	/* odd number of parameters */
	else {
	    Perl_croak(aTHX_
		"Usage: XSTest->new()\n"
		"    or XSTest->new(number)\n"
		"    or XSTest->new(key => value, ...)\n"
	    );
	}

    OUTPUT:
    	RETVAL

IV
increment(obj)
    XSTest obj

    INIT:
    	RETVAL = 0;
	if ( items > 1 )
	    Perl_croak(aTHX_ "Usage: XSTest->increment()");

    CODE:
    	SV **svp;
	if ((svp = hv_fetch((HV*)obj, "value", 5, FALSE))) {
	    RETVAL = SvIV(*svp);
	    RETVAL++;
	    hv_store((HV *)obj, "value", 5, newSViv(RETVAL), 0);
	}
    OUTPUT:
    	RETVAL

void
hello()
    CODE:
        printf("%s", "Hello World!\n");

IV
get_24()
    CODE:
        RETVAL = 24;
    OUTPUT:
        RETVAL

SV *
get_xs_string()
    INIT:
        /* Initialize RETVAL to NULL, so we'll know something is wrong
         * if this indeed the case*/
        RETVAL = NULL;
    CODE:
        /* newSVpv creates a new SV (= scalar value) and copies a string into 
         * it. The reference count for it is equal to 1 which is suitable
         * for returning from a function.
         *
         * First argument is the string buffer.
         * Second argument is the length or 0 for using strlen().
         *
         * Also see newSVpvn.
         * */
        RETVAL = newSVpv("Hello", 0);
    OUTPUT:
        RETVAL

SV *
get_xs_binary_string()
    INIT:
        /* Initialize RETVAL to NULL, so we'll know something is wrong
         * if this indeed the case*/
        RETVAL = NULL;
    CODE:
        /* newSVpvn (buffer, len) creates a new SV (= scalar value) from
         * a buffer and a length. Like newSVpv, the reference count for it is 
         * equal to 1 which is suitable for returning from a function.
         *
         * */
        {
            char buf[5];
            buf[0] = 'a';
            buf[1] = '\0';
            buf[2] = 'b';
            buf[3] = '\0';
            buf[4] = 'c';
            RETVAL = newSVpvn(buf, 5);
        }
    OUTPUT:
        RETVAL

void
assign_string_to_ref(myref)
    SV * myref

    CODE:
        {
            /*
             * If we call assign_string_to_ref(\$myvar) in Perl, then
             * myref will contain the XS equivalent of \$myvar.
             * */

            /*
             * Now let's check if it's indeed a reference, and if so
             * do our thing.
             * */
            if (SvROK(myref))
            {
                SV * var;
                
                /* 
                 * SvRV(myref) dereferences myref. var will be the XS 
                 * equivalent of the Perl $myvar itself.
                 * */
                var = SvRV(myref);

                /*
                 * Now let's change the variable in place to the string we 
                 * desire.
                 *
                 * Aside from sv_setpv there's also sv_setpv_mg() which
                 * handles 'set' magic:
                 *
                 * http://perldoc.perl.org/perlguts.html#Assigning-Magic
                 *
                 * set magic is something that happens when the variable
                 * is assigned.
                 * */
                sv_setpv(var, "XSTest was here.");
            }
        }

NV
sum(my_array)
    AV * my_array

    INIT:
        RETVAL = 0;
    CODE:
        {
            /* NV is a numeric value - a floating point double */
            NV ret;
            I32 max_index;
            I32 i;

            ret = 0.0;

            /* av_len() returns the maximal element in the array. */
            max_index = av_len(my_array);

            for (i=0;i<=max_index;i++)
            {
                SV * * elem;

                /* av_fetch() fetches the element of my_array at position
                 * i
                 * */
                elem = av_fetch(my_array, i, 0);
                if (elem == NULL)
                {
                    continue;
                }

                if (SvNOK(*elem))
                {
                    ret += SvNV(*elem);
                }
                else if (SvIOK(*elem))
                {
                    ret += SvIV(*elem);
                }
            }

            RETVAL = ret;
        }
    OUTPUT:
        RETVAL