## About Multilang-Documentation
This library provides a drop-in replacement function for `cl:documentation` that supports multiple docstrings per-language, allowing you to write documentation that can be internationalised.

## How To
If you want to use this library's `documentation` function instead of `cl`'s, you can simply add this to your package definition:

    (:shadowing-import-from #:multilang-documentation #:documentation)

You can also do this at the REPL using `shadowing-import`:

    (shadowing-import 'multilang-documentation:documentation)

The new `documentation` introduces a `:lang` keyword argument with which you can specify the language of the docstring. The default language of your system is determined automatically via the available system information. Please consult [system-locale](https://shinmera.github.io/system-locale) for this mechanism. If you would like to force a specific language as the default, you can set the `*language*` variable like so:


    (setf multilang-documentation:*language* 
          (multilang-documentation:language "Japanese" :if-does-not-exist :create))

You may either use a two or three-letter [ISO-639 language code keyword](https://shinmera.github.io/language-codes), or a full language name as a string to identify the language.

Note that `cl:documentation` is used as fallback lookup mechanism if the language passed to `documentation` is `*LANGUAGE*` (the default).

Also note that `documentation` can be used as a storage for arbitrary documentation types, unlike `cl:documentation` which is free to ignore documentation types it doesn't know about. If you do save your own documentation types you should however make sure that the library can canonically identify your docstrings:

Some docstrings can be identified in multiple ways, like `(#<function foo> T)` and `('foo 'function)`. `canonicalize-doctype` exists in order to fix this problem and coerce any kind of combination of object and type parameters into a single, canonical value. This value should be `equal` to other values be considered the same. For instance, if you have a custom documentation object, you can add a canonicalisation by using something like the following:

    (defmethod multilang-documentation:canonicalize-doctype ((object my-type) type)
      object)
    
    (defmethod multilang-documentation:canonicalize-doctype ((name symbol) (type (eql 'my-type)))
      (find-my-type-instance name))

In case you have your own system that deals with languages and would like to integrate this library with it, you should make your languages subclass `language`, and either add a method to `documentation-storage`, or to `documentation*` and `(setf documentation*)` to handle the docstring lookup and storage. Finally, if you would like to override the language lookup mechanism, you should override the `string`-specialised method on `language` as well.
