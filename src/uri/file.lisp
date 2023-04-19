(in-package :cl-user)
(defpackage quri.uri.file
  (:use :cl)
  (:import-from :quri.uri
                :uri
                :scheme
                :port
                :uri-path)
  (:export :uri-file
           :uri-file-p
           :make-uri-file
           :uri-file-pathname))
(in-package :quri.uri.file)

(defstruct (uri-file (:include uri (scheme "file") (port nil))
                     (:constructor %make-uri-file)))

(defun make-uri-file (&rest initargs)
  (let ((uri (apply #'%make-uri-file initargs)))
    (when (pathnamep (uri-path uri))
      (setf (uri-path uri)
            (uiop:native-namestring (uri-path uri))))
    uri))

(declaim (ftype (function (uri-file) pathname) uri-file-pathname))
(defun uri-file-pathname (file)
  "Get a lisp pathname object from a file URI.
Assumes that the path of the file URI is correct path syntax for the environment."
  (parse-namestring (uri-path file)))
