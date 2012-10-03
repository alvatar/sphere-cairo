(include "~~spheres/prelude#.scm")
(%include sake: utils#)

(define modules '(cairo))

(define-task clean ()
  (sake:default-clean))

(define-task compile ()
  (let ((cc-options "-w -I/usr/include/cairo -I/usr/include/freetype2")
        (ld-options "-lcairo -lfreetype"))
    (for-each (lambda (m)
                (sake:compile-c-file (sake:generate-c-file m)
                                     cc-options: cc-options
                                     ld-options: ld-options)
                (sake:compile-c-file (sake:generate-c-file m
                                                           version: '(debug)
                                                           compiler-options: '(debug))
                                     cc-options: cc-options
                                     ld-options: ld-options))
              modules)))

(define-task install ()
  (for-each (lambda (m)
              (sake:install-compiled-module m)
              (sake:install-compiled-module m version: '(debug)))
            modules)
  (sake:install-system-sphere))

(define-task uninstall ()
  (sake:uninstall-system-sphere))

(define-task all (compile install)
  'all)
