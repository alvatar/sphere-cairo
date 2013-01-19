(define modules '(cairo))

(define-task clean ()
  (sake:default-clean))

(define-task compile ()
  (let ((cc-options "-w -I/usr/include/cairo -I/usr/include/freetype2")
        (ld-options "-lcairo -lfreetype"))
    (for-each (lambda (m)
                (sake:compile-c-to-o (sake:compile-to-c m)
                                     cc-options: cc-options
                                     ld-options: ld-options))
              modules)))

(define-task install ()
  (for-each sake:install-compiled-module modules)
  (sake:install-sphere-to-system))

(define-task uninstall ()
  (sake:uninstall-sphere-from-system))

(define-task all (compile install)
  'all)
