#|
 This file is a part of multilang-documentation
 (c) 2018 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(asdf:defsystem multilang-documentation
  :version "1.0.0"
  :license "Artistic"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "A drop-in replacement for CL:DOCUMENTATION providing multi-language docstrings"
  :homepage "https://github.com/Shinmera/multilang-documentation"
  :serial T
  :components ((:file "package")
               (:file "canonical")
               (:file "language")
               (:file "drop-in")
               (:file "documentation"))
  :depends-on (:documentation-utils
               :language-codes
               :system-locale))
