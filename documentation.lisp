(in-package #:org.shirakumo.multilang-documentation)

(docs:define-docs
  (function canonicalize-doctype
    "This function should return a canonical representation for the given documentation specifier.

Some documentation strings can be referred to by different
specifiers. For instance:

- (#<function foo> T)
- (#<function foo> 'function)
- ('foo 'function)

All refer to the same documentation string. This function
should return a value that identifies a docstring for the
given object and type. The same (under EQUAL) value must
be returned for any object and type combinations that
should refer to the same docstring.

You should add appropriate methods to this function for
custom documentation specifiers / types.

See CL:EQUAL")

  (variable *languages*
    "This hash table keeps records of language identifiers to language instances.

Language identifiers are the same under EQUALP.

See LANGUAGE")

  (variable *language*
    "This variable holds the user's chosen language.

Its default value is automatically chosen according to
the system's configured language.

The value held by this should be a LANGUAGE instance.

See SYSTEM-LOCALE:LANGUAGE
See LANGUAGE")

  (type no-such-language
    "Error signalled when an inexistent language is referenced.

See IDENTIFIER
See LANGUAGE")

  (function identifier
    "Returns the identifier of the object.

See NO-SUCH-LANGUAGE
See SIMPLE-LANGUAGE")

  (type language
    "Superclass for all languages that can store docstrings.

Instances of this class can be used to store documentation
strings.

See DOCUMENTATION-STORAGE
See LANGUAGE
See DOCUMENTATION*")

  (function documentation-storage
    "Returns the hash-table for the docstring storage of the language.

This hash-table must be using the EQUAL test.
Keys are canonical docstring identifiers as returned by
CANONICALIZE-DOCTYPE. Values are docstrings.

See CANONICALIZE-DOCTYPE
See DOCUMENTATION*")

  (type simple-language
    "A simple language object that keeps its identifier and a docstring storage.

See LANGUAGE
See IDENTIFIER
See DOCUMENTATION-STORAGE
See LANGUAGE")
  
  (function prompt-language
    "Prompts for a new language object.

Reads and evaluates a value from *QUERY-IO*, then passes
it to LANGUAGE, and finally returns that result in a list.

This should be used as an interactive restart function.

See CL:*QUERY-IO*
See LANGUAGE")

  (function language
    "Returns the language object referred to by the given identifier.

If a LANGUAGE instance is passed, the language instance is
simply returned directly.

IF-DOES-NOT-EXIST can be one of the following values,
designating the behaviour if no language for the given
identifier can be found:

    :CREATE  --- A new SIMPLE-LANGUAGE instance is created
                 and associated with the identifier.
    :ERROR   --- An error of type NO-SUCH-LANGUAGE is
                 signalled. The following restarts will be
                 available:
       USE-VALUE     --- Return the given restart value.
       STORE-VALUE   --- Associate the given restart value
                         with the identifier and return it.
       MAKE-INSTANCE --- This behaviour is the same as
                         :if-does-not-exist :create
    NIL      --- Returns NIL.

When USE-VALUE or STORE-VALUE are called interactively, the
value is read and evaluated, and then passed through LANGUAGE
to potentially coerce it to an existing language object.

See *LANGUAGES*
See SIMPLE-LANGUAGE")

  (function documentation*
    "Access the docstring for the given object, type and language.

If LANGUAGE is not an instance of LANGUAGE, the value is
coerced to a LANGUAGE instance by way of the LANGUAGE
function.

When reading a docstring from an inexistent language, NIL
is returned as well as a NO-SUCH-LANGUAGE instance as the
secondary value.

When writing a docstring to an inexistent language, a new
language instance is automatically created by way of the
:IF-DOES-NOT-EXIST :CREATE argument to the LANGUAGE function.

If you are implementing your own subclass of LANGUAGE that
bypasses the DOCUMENTATION-STORAGE mechanism, you should
add methods to this function that provide the desired
behaviour.

See LANGUAGE
See CANONICALIZE-DOCTYPE
See DOCUMENTATION-STORAGE
See DOCUMENTATION")

  (function documentation
    "Retrieve the documentation string for the given object and type.

You may optionally specify the language that the docstring
should be in. The default language is *LANGUAGE*, which
will typically be automatically configured according to your
system's locale settings.

When reading a docstring, if there is no documentation stored
specifically for the given language, and the language is eq
to *LANGUAGE*, CL:DOCUMENTATION is consulted instead.

When writing a docstring, if the language is eq to *LANGUAGE*,
the docstring is also written to CL:DOCUMENTATION. Note that
your implementation might not store docstrings for unknown
documentation specifiers, but the language object will always
do so regardless. Either way, this mechanism is mostly provided
as a best-effort backwards compatibility to users of
CL:DOCUMENTATION.

See CL:DOCUMENTATION
See DOCUMENTATION*
See *LANGUAGE*"))
