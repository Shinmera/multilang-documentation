#|
 This file is a part of multilang-documentation
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(defpackage #:multilang-documentation
  (:nicknames #:org.shirakumo.multilang-documentation)
  (:use #:cl)
  (:shadow #:documentation)
  ;; canonical.lisp
  (:export
   #:canonicalize-doctype)
  ;; language.lisp
  (:export
   #:*language*
   #:no-such-language
   #:identifier
   #:language
   #:documentation-storage
   #:simple-language
   #:language)
  ;; drop-in.lisp
  (:export
   #:documentation*
   #:documentation))
