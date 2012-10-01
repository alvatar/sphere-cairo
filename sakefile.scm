(include "~~base/prelude#.scm")
(%include sake: utils#)

(define modules '(cairo))

(define-task init ()
  (make-directory (current-build-directory)))

(define-task clean (init)
  (delete-file (current-build-directory))
  (delete-file (default-lib-directory)))

(define-task compile (init)
  (let ((cc-options "-w -I/usr/include/cairo -I/usr/include/freetype2")
        (ld-options "-lcairo -lfreetype"))
   (for-each (lambda (m)
               (sake:compile-c-file (sake:generate-c-file m)
                                    cc-options: cc-options
                                    ld-options: ld-options)
               (sake:compile-c-file (sake:generate-c-file m features: '(mobile debug))
                                    cc-options: cc-options
                                    ld-options: ld-options))
             modules)))

;; TODO:       (define-cond-expand-feature arm)

(define-task install (compile)
  (make-directory (default-lib-directory))
  (for-each (lambda (m)
              (sake:install-compiled-module m)
              (sake:install-compiled-module m features: '(mobile debug)))
            modules))

(define-task all (install)
  'all)
