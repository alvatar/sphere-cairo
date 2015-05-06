(include "~~lib/ssrun/tasks/core.scm")

(define libraries
  `(((spheres/cairo cairo)
     .
     ,(lambda (lib)
        (if (eq? 'osx (ssrun#host-platform))
            (begin
              ;; This fixes and issue in OSX when Cairo is installed with Homebrew
              (setenv "PKG_CONFIG_PATH" "/opt/X11/lib/pkgconfig/")
              (let ((cc-options
                     (string-append
                      (with-input-from-process
                       (list path: "pkg-config"
                             arguments: '("--cflags" "cairo")) read-line)
                      "-w"))
                    (ld-options
                     (with-input-from-process
                      (list path: "pkg-config"
                            arguments: '("--libs" "cairo"))
                      read-line)))
                (ssrun#compile-library
                 lib
                 cond-expand-features: '(debug)
                 cc-options: cc-options
                 ld-options: ld-options)))
            (ssrun#compile-library
             lib
             cond-expand-features: '(debug)
             cc-options: "-w"
             ld-options: ""))))))

(define-task (compile library) ()
  ;; This fixes and issue in OSX: pkg-config not finding GL
  ;; (if (eq? (sake#host-platform) 'osx)
  ;;     (setenv "PKG_CONFIG_PATH" "/opt/X11/lib/pkgconfig/"))
  (if library
      (let ((entry (assoc library libraries))) ((cdr entry) (car entry)))
      (for-each (lambda (entry) ((cdr entry) (car entry))) libraries)))

(define-task (test file) ()
  (if file
      (ssrun#run-file (string-append "test/" file))
      (ssrun#run-all-files "test/")))

(define-task clean ()
  (ssrun#clean-libraries (map car libraries)))

(define-task all (compile)
  (void))
