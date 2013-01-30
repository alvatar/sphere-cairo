(define-task clean ()
  (sake:default-clean))

(define-task compile ()
  (let ((cc-options "-w -I/usr/include/cairo -I/usr/include/freetype2")
        (ld-options "-lcairo -lfreetype"))
    (sake:compile-c-to-o (sake:compile-to-c 'cairo compiler-options: '(debug))
                         cc-options: cc-options
                         ld-options: ld-options)
    (sake:compile-c-to-o (sake:compile-to-c 'cairo)
                         cc-options: cc-options
                         ld-options: ld-options)))

(define-task install ()
  (sake:install-compiled-module 'cairo versions: '(() (debug)))
  (sake:install-sphere-to-system))

(define-task uninstall ()
  (sake:uninstall-sphere-from-system))

(define-task all (compile install)
  'all)
