(sphere: "cairo")
(dependencies:
 (cairo
  (cc-options (pkg-config--cflags "cairo freetype2") "-w")
  (ld-options (pkg-config--libs "cairo freetype2"))
  (prelude
   (core: ffi-prelude)
   (cairo: cairo-prelude))
  (include
   (core: ffi-macros))))

