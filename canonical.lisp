(in-package #:org.shirakumo.multilang-documentation)

(defgeneric canonicalize-doctype (object type))

(defmethod canonicalize-doctype (object type)
  (list object type))

(defmethod canonicalize-doctype ((object function) type)
  object)

(defmethod canonicalize-doctype ((object package) type)
  object)

(defmethod canonicalize-doctype ((object method-combination) type)
  object)

(defmethod canonicalize-doctype ((object standard-method) type)
  object)

(defmethod canonicalize-doctype ((object standard-class) type)
  object)

(defmethod canonicalize-doctype ((object structure-class) type)
  object)

(defmethod canonicalize-doctype ((object symbol) (type (eql 'function)))
  (fdefinition object))

(defmethod canonicalize-doctype ((object symbol) (type (eql 'compiler-macro)))
  (compiler-macro-function object))

(defmethod canonicalize-doctype ((object list) (type (eql 'function)))
  (fdefinition object))

(defmethod canonicalize-doctype ((object list) (type (eql 'compiler-macro)))
  (fdefinition object))

(defmethod canonicalize-doctype ((object symbol) (type (eql 'structure)))
  (find-class object))

(defmethod canonicalize-doctype ((object symbol) (type (eql 'type)))
  (or (find-class object NIL)
      ;; If it's not a class-defined type, it might be a deftype-type,
      ;; which we can't retrieve. Fall back to the list, then.
      (list object type)))
