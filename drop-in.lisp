#|
 This file is a part of multilang-documentation
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.multilang-documentation)

(defgeneric documentation* (object type lang))

(defmethod documentation* (object type (language language))
  (gethash (canonicalize-doctype object type) (documentation-storage language)))

(defmethod documentation* (object type identifier)
  (let ((language (language identifier :if-does-not-exist NIL)))
    (if language
        (documentation* object type language)
        (values NIL (make-condition 'no-such-language :identifier identifier)))))

(defmethod (setf documentation*) (docstring object type (language language))
  (setf (gethash (canonicalize-doctype object type) (documentation-storage language))
        docstring))

(defmethod (setf documentation*) (docstring object type identifier)
  (setf (documentation* object type (language identifier :if-does-not-exist :create))
        docstring))

(defun documentation (object type &key (lang *language*))
  (or (documentation* object type lang)
      (cl:documentation object type)))

(defun (setf documentation) (docstring object type &key (lang *language*))
  (when (eq lang *language*)
    (setf (cl:documentation object type) docstring))
  (setf (documentation* object type lang) docstring))
