(define modules
  '(cairo))


(define-task compile ()
  ;; This fixes and issue in OSX when Cairo is installed with Homebrew
  (if (eq? (sake#host-platform) 'osx)
      (setenv "PKG_CONFIG_PATH" "/opt/X11/lib/pkgconfig/"))
  (for-each (lambda (m)
              (sake#compile-module m cond-expand-features: '(debug) version: '(debug))
              (sake#compile-module m cond-expand-features: '(optimize) verbose: #t))
            modules))

(define-task post-compile ()
  (for-each (lambda (m) (sake#make-module-available m versions: '(() (debug)))) modules))

(define-task install ()
  (sake#install-sphere-to-system))

(define-task test ()
  (sake#test-all))

(define-task clean ()
  (sake#default-clean))

(define-task all (compile post-compile)
  'all)

