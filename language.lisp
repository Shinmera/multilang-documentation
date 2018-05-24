#|
 This file is a part of multilang-documentation
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.multilang-documentation)

(defvar *languages* (make-hash-table :test 'equalp))
(defvar *language* ())

(define-condition no-such-language (error)
  ((identifier :initarg :identifier :reader identifier))
  (:report (lambda (c s) (format s "No language with identifier ~s is known."
                                 (identifier c)))))

(defclass language ()
  ())

(defgeneric documentation-storage (language))

(defclass simple-language (language)
  ((%identifier :initarg :identifier :reader identifier)
   (%documentation-storage :initform (make-hash-table :test 'equal) :reader documentation-storage))
  (:default-initargs :identifier (error "IDENTIFIER required.")))

(defmethod print-object ((language simple-language) stream)
  (print-unreadable-object (language stream :type T)
    (format stream "~s~@[ (~{~s~^ ~})~]"
            (identifier language) (language-codes:codes (identifier language)))))

(defgeneric language (identifier &key if-does-not-exist))

(defun read-language ()
  (format *query-io* "~& Enter a new language (evaluated): ~%")
  (language (eval (read *query-io*))))

(defmethod language ((identifier string) &key (if-does-not-exist :error))
  (or (gethash identifier *languages*)
      (ecase if-does-not-exist
        (:create
         (setf (gethash identifier *languages*)
                       (make-instance 'simple-language :identifier identifier)))
        (:error
         (restart-case
             (error 'no-such-language :identifier identifier)
           (store-value (value)
             :interactive read-language
             :report "Provide a language object to associate with the identifier."
             (setf (gethash identifier *languages*) value))
           (use-value (value)
             :interactive read-language
             :report "Provide a language object to use."
             value)
           (make-instance ()
             :report "Create a new simple-language object to use."
             (language identifier :if-does-not-exist :create))))
        ((NIL)
         NIL))))

(defmethod language ((identifier symbol) &key (if-does-not-exist :error))
  (language (or (first (language-codes:names identifier))
                (string identifier))
            :if-does-not-exist if-does-not-exist))

(defmethod language ((language language) &key if-does-not-exist)
  (declare (ignore if-does-not-exist))
  language)

(defmethod (setf language) ((language language) (identifier string))
  (setf (gethash identifier *languages*) language))

(defmethod (setf language) (language (identifier symbol))
  (setf (language (or (first (language-codes:names identifier))
                      (string identifier)))
        language))

(setf *language* (language (intern (string-upcase (system-locale:language)) "KEYWORD")
                           :if-does-not-exist :create))
