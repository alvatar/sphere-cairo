(include "~~spheres/prelude#.scm")
(%include sake: utils#)

(define modules '(cairo))

(define-task clean ()
  (sake:default-clean))

(define-task compile ()
  (let ((include '((base: ffi#)))
        (cc-options "-w -I/usr/include/cairo -I/usr/include/freetype2")
        (ld-options "-lcairo -lfreetype"))
    (for-each (lambda (m)
                (sake:compile-c-to-o (sake:compile-to-c m include: include)
                                     cc-options: cc-options
                                     ld-options: ld-options)
                (sake:compile-c-to-o (sake:compile-to-c m
                                                        version: '(debug)
                                                        include: include
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
