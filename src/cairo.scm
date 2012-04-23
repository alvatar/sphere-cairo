;;; Copyright (c) 2008 Marco Benelli <mbenelli@yahoo.com>
;;; Copyright (c) 2012 Álvaro Castro-Castilla 

;; ("Linux" ("-w -I/usr/include/cairo -I/usr/include/freetype2" "-lcairo"))
;; ("Darwin" ("-w -I/opt/local/include/cairo -I/opt/local/include/freetype2 -I/opt/local/include" "-L/opt/local/lib -lobjc -lcairo"))

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

(c-declare "#include <cairo.h>")
(cond-expand
 ((not android)
  (c-declare "#include <cairo-ft.h>")
  (c-declare "#include <cairo-pdf.h>")
  (c-declare "#include <cairo-ps.h>")
  (c-declare "#include <cairo-svg.h>")
  (c-declare "#include <cairo-xlib.h>")
  (c-declare "#include <X11/Xlib.h>")
  (c-declare "#include <fontconfig/fontconfig.h>")
  (c-declare "#include <ft2build.h>")
  (c-declare "#include FT_FREETYPE_H")))

;-------------------------------------------------------------------------------
; Enums
;-------------------------------------------------------------------------------

;(c-define-type cairo:format-t "cairo_format_t")
(c-define-type cairo:format-t unsigned-int)
(c-constants
 CAIRO_FORMAT_ARGB32
 CAIRO_FORMAT_RGB24
 CAIRO_FORMAT_A8
 CAIRO_FORMAT_A1
 CAIRO_FORMAT_RGB16_565)
(define cairo:format-argb32 CAIRO_FORMAT_ARGB32)
(define cairo:format-rgb24 CAIRO_FORMAT_RGB24)
(define cairo:format-a8 CAIRO_FORMAT_A8)
(define cairo:format-a1 CAIRO_FORMAT_A1)
(define cairo:format-rgb16-565 CAIRO_FORMAT_RGB16_565)

(c-define-type cairo:line-cap-t "cairo_line_cap_t")
(c-constants
 CAIRO_LINE_CAP_BUTT
 CAIRO_LINE_CAP_ROUND
 CAIRO_LINE_CAP_SQUARE)
(define cairo:line-cap-butt CAIRO_LINE_CAP_BUTT)
(define cairo:line-cap-round CAIRO_LINE_CAP_ROUND)
(define cairo:line-cap-square CAIRO_LINE_CAP_SQUARE)

(cond-expand
 ((not android)
  (c-define-type cairo:font-slant-t "cairo_font_slant_t")
  (c-constants
   CAIRO_FONT_SLANT_NORMAL
   CAIRO_FONT_SLANT_ITALIC
   CAIRO_FONT_SLANT_OBLIQUE)
  (define cairo:font-slant-normal CAIRO_FONT_SLANT_NORMAL)
  (define cairo:font-slant-italic CAIRO_FONT_SLANT_ITALIC)
  (define cairo:font-slant-oblique CAIRO_FONT_SLANT_OBLIQUE)
  
  (c-define-type cairo:font-weight-t "cairo_font_weight_t")
  (c-constants
   CAIRO_FONT_WEIGHT_NORMAL
   CAIRO_FONT_WEIGHT_BOLD)
  (define cairo:font-weight-normal CAIRO_FONT_WEIGHT_NORMAL)
  (define cairo:font-weight-bold CAIRO_FONT_WEIGHT_BOLD)))

;(c-define-type cairo:status-t (type "cairo_status_t"))
(c-define-type cairo:status-t unsigned-int)
(c-define-type cairo:status-t*  (pointer cairo:status-t))
(c-define-type cairo:status-t** (pointer cairo:status-t*))
(c-constants
 CAIRO_STATUS_SUCCESS
 CAIRO_STATUS_NO_MEMORY
 CAIRO_STATUS_INVALID_RESTORE
 CAIRO_STATUS_INVALID_POP_GROUP
 CAIRO_STATUS_NO_CURRENT_POINT
 CAIRO_STATUS_INVALID_MATRIX
 CAIRO_STATUS_INVALID_STATUS
 CAIRO_STATUS_NULL_POINTER
 CAIRO_STATUS_INVALID_STRING
 CAIRO_STATUS_INVALID_PATH_DATA
 CAIRO_STATUS_READ_ERROR
 CAIRO_STATUS_WRITE_ERROR
 CAIRO_STATUS_SURFACE_FINISHED
 CAIRO_STATUS_SURFACE_TYPE_MISMATCH
 CAIRO_STATUS_PATTERN_TYPE_MISMATCH
 CAIRO_STATUS_INVALID_CONTENT
 CAIRO_STATUS_INVALID_FORMAT
 CAIRO_STATUS_INVALID_VISUAL
 CAIRO_STATUS_FILE_NOT_FOUND
 CAIRO_STATUS_INVALID_DASH
 CAIRO_STATUS_INVALID_DSC_COMMENT
 CAIRO_STATUS_INVALID_INDEX
 CAIRO_STATUS_CLIP_NOT_REPRESENTABLE
 CAIRO_STATUS_TEMP_FILE_ERROR
 CAIRO_STATUS_INVALID_STRIDE
 CAIRO_STATUS_FONT_TYPE_MISMATCH
 CAIRO_STATUS_USER_FONT_IMMUTABLE
 CAIRO_STATUS_USER_FONT_ERROR
 CAIRO_STATUS_NEGATIVE_COUNT
 CAIRO_STATUS_INVALID_CLUSTERS
 CAIRO_STATUS_INVALID_SLANT
 CAIRO_STATUS_INVALID_WEIGHT
 CAIRO_STATUS_INVALID_SIZE
 CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED
 CAIRO_STATUS_DEVICE_TYPE_MISMATCH
 CAIRO_STATUS_DEVICE_ERROR
 CAIRO_STATUS_LAST_STATUS)

;-------------------------------------------------------------------------------
; Types
;-------------------------------------------------------------------------------

;;; X-Window types
(cond-expand
 ((not android)
  (c-define-type Display "Display")
  (c-define-type Display* (pointer Display))
  (c-define-type Screen "Screen")
  (c-define-type Screen* (pointer Screen))
  (c-define-type Visual "Visual")
  (c-define-type Visual* (pointer Visual))
  (c-define-type Drawable unsigned-long)
  (c-define-type Pixmap unsigned-long)))
;;; FreeType types
;; (c-define-type FT-Face (type "FT_Face"))
;; (c-define-type FcPattern (struct "FcPattern"))
;; (c-define-type FcPattern* (pointer "FcPattern"))
;; (c-define-type cairo:font-face-t "cairo_font_face_t")
;; (c-define-type cairo:font-face-t* (pointer "cairo_font_face_t"))

(c-define-type FT-Face "FT_Face")
(c-define-type FcPattern "FcPattern")
(c-define-type FcPattern* (pointer "FcPattern"))
;;; Windows types FIXME
;(c-define-type LOGFONTW* (pointer (pointer "LOGFONTW")))
;(c-define-type HFONT "HFONT")
;(c-define-type HDC "HDC")
;(c-define-type cairo:svg-version-t (type "cairo_svg_version_t"))
;(c-define-type cairo:svg-version-t** (pointer (pointer "cairo_svg_version_t")))
;(c-define-type cairo:destroy-func-t  (pointer "cairo_destroy_func_t"))

(c-define-type double* (pointer double))
(c-define-type void* (pointer void))
(c-define-type char* char-string)
(c-define-type int* (pointer int))
(c-define-type unsigned-char* (pointer unsigned-char))
(c-define-type cairo:surface-t (struct "cairo_surface_t"))
(c-define-type cairo:surface-t* (pointer "cairo_surface_t"))
(c-define-type cairo:surface-t** (pointer (pointer "cairo_surface_t")))
(c-define-type cairo:content-t "cairo_content_t")
(c-define-type cairo:surface-type-t "cairo_surface_type_t")
(c-define-type cairo:bool-t   (type "cairo_bool_t"))
(c-define-type cairo:destroy-func-t  (function (void*) void))
(c-define-type cairo:user-data-key-t  (type "cairo_user_data_key_t"))
(c-define-type cairo:user-data-key-t*  (pointer cairo:user-data-key-t))
(c-define-type cairo:read-func-t  "cairo_read_func_t")
(c-define-type cairo:write-func-t  "cairo_write_func_t")
(c-define-type cairo:t (struct "cairo_t"))
(c-define-type cairo:t* (pointer "cairo_t"))
(c-define-type cairo:t** (pointer (pointer "cairo_t")))
(c-define-type cairo:antialias-t "cairo_antialias_t")
(c-define-type cairo:fill-rule-t "cairo_fill_rule_t")
(c-define-type cairo:line-join-t "cairo_line_join_t")
(c-define-type cairo:operator-t "cairo_operator_t")
(c-define-type cairo:rectangle-t (struct "cairo_rectangle_t"))
(c-define-type cairo:rectangle-t* (pointer "cairo_rectangle_t"))
(c-define-type cairo:rectangle-t** (pointer (pointer "cairo_rectangle_t")))
(c-define-type cairo:rectangle-list-t (struct "cairo_rectangle_list_t"))
(c-define-type cairo:rectangle-list-t* (pointer "cairo_rectangle_list_t"))
(c-define-type cairo:rectangle-list-t** (pointer (pointer "cairo_rectangle_list_t")))
(c-define-type cairo:font-face-t (struct "cairo_font_face_t"))
(c-define-type cairo:font-face-t* (pointer "cairo_font_face_t"))
(c-define-type cairo:font-face-t** (pointer (pointer "cairo_font_face_t")))
(c-define-type cairo:font-type-t "cairo_font_type_t")
(c-define-type cairo:font-options-t (struct "cairo_font_options_t"))
(c-define-type cairo:font-options-t* (pointer "cairo_font_options_t"))
(c-define-type cairo:font-options-t** (pointer (pointer "cairo_font_options_t")))
(c-define-type cairo:subpixel-order-t "cairo_subpixel_order_t")
(c-define-type cairo:hint-style-t "cairo_hint_style_t")
(c-define-type cairo:hint-metrics-t "cairo_hint_metrics_t")
(c-define-type cairo:matrix-t (struct "cairo_matrix_t"))
(c-define-type cairo:matrix-t* (pointer "cairo_matrix_t"))
(c-define-type cairo:matrix-t** (pointer (pointer "cairo_matrix_t")))
(c-define-type cairo:path-t (struct "cairo_path_t"))
(c-define-type cairo:path-t* (pointer "cairo_path_t"))
(c-define-type cairo:path-t** (pointer (pointer "cairo_path_t")))
(c-define-type cairo:path-data-t (union "cairo_path_data_t"))
(c-define-type cairo:path-data-t* (pointer "cairo_path_data_t"))
(c-define-type cairo:path-data-t** (pointer (pointer "cairo_path_data_t")))
(c-define-type cairo:path-data-type-t "cairo_path_data_type_t")
(c-define-type cairo:pattern-t (struct "cairo_pattern_t"))
(c-define-type cairo:pattern-t* (pointer "cairo_pattern_t"))
(c-define-type cairo:pattern-t** (pointer (pointer "cairo_pattern_t")))
(c-define-type cairo:extend-t "cairo_extend_t")
(c-define-type cairo:filter-t "cairo_filter_t")
(c-define-type cairo:pattern-type-t "cairo_pattern_type_t")
(c-define-type cairo:scaled-font-t (struct "cairo_scaled_font_t"))
(c-define-type cairo:scaled-font-t* (pointer "cairo_scaled_font_t"))
(c-define-type cairo:scaled-font-t** (pointer (pointer "cairo_scaled_font_t")))
(c-define-type cairo:font-extents-t (struct "cairo_font_extents_t"))
(c-define-type cairo:font-extents-t* (pointer "cairo_font_extents_t"))
(c-define-type cairo:font-extents-t** (pointer (pointer "cairo_font_extents_t")))
(c-define-type cairo:text-extents-t (struct "cairo_text_extents_t"))
(c-define-type cairo:text-extents-t* (pointer "cairo_text_extents_t"))
(c-define-type cairo:text-extents-t** (pointer (pointer "cairo_text_extents_t")))
(c-define-type cairo:svg-version-t "cairo_svg_version_t")
(c-define-type cairo:glyph-t (struct "cairo_glyph_t"))
(c-define-type cairo:glyph-t* (pointer "cairo_glyph_t"))
(c-define-type cairo:glyph-t** (pointer (pointer "cairo_glyph_t")))

;-------------------------------------------------------------------------------
; Functions
;-------------------------------------------------------------------------------

(define cairo:create (c-lambda (cairo:surface-t*) cairo:t* "cairo_create"))
(define cairo:reference (c-lambda (cairo:t*) cairo:t* "cairo_reference"))
(define cairo:destroy (c-lambda (cairo:t*) void "cairo_destroy"))
(define cairo:status (c-lambda (cairo:t*) cairo:status-t "cairo_status"))
(define cairo:save (c-lambda (cairo:t*) void "cairo_save"))
(define cairo:restore (c-lambda (cairo:t*) void "cairo_restore"))
(define cairo:get-target (c-lambda (cairo:t*) cairo:surface-t* "cairo_get_target"))
(define cairo:push-group (c-lambda (cairo:t*) void "cairo_push_group"))
(define cairo:push-group-with-content (c-lambda (cairo:t* cairo:content-t) void "cairo_push_group_with_content"))
(define cairo:pop-group (c-lambda (cairo:t*) cairo:pattern-t* "cairo_pop_group"))
(define cairo:pop-group-to-source (c-lambda (cairo:t*) void "cairo_pop_group_to_source"))
(define cairo:get-group-target (c-lambda (cairo:t*) cairo:surface-t* "cairo_get_group_target"))
(define cairo:set-source-rgb (c-lambda (cairo:t* double double double) void "cairo_set_source_rgb"))
(define cairo:set-source-rgba (c-lambda (cairo:t* double double double double) void "cairo_set_source_rgba"))
(define cairo:set-source (c-lambda (cairo:t* cairo:pattern-t*) void "cairo_set_source"))
(define cairo:set-source-surface (c-lambda (cairo:t* cairo:surface-t* double double) void "cairo_set_source_surface"))
(define cairo:get-source (c-lambda (cairo:t*) cairo:pattern-t* "cairo_get_source"))
(define cairo:set-antialias (c-lambda (cairo:t* cairo:antialias-t) void "cairo_set_antialias"))
(define cairo:get-antialias (c-lambda (cairo:t*) cairo:antialias-t "cairo_get_antialias"))
(define cairo:set-dash (c-lambda (cairo:t* double* int double) void "cairo_set_dash"))
(define cairo:get-dash-count (c-lambda (cairo:t*) int "cairo_get_dash_count"))
(define cairo:get-dash (c-lambda (cairo:t* double* double*) void "cairo_get_dash"))
(define cairo:set-fill-rule (c-lambda (cairo:t* cairo:fill-rule-t) void "cairo_set_fill_rule"))
(define cairo:get-fill-rule (c-lambda (cairo:t*) cairo:fill-rule-t "cairo_get_fill_rule"))
(define cairo:set-line-cap (c-lambda (cairo:t* cairo:line-cap-t) void "cairo_set_line_cap"))
(define cairo:get-line-cap (c-lambda (cairo:t*) cairo:line-cap-t "cairo_get_line_cap"))
(define cairo:set-line-join (c-lambda (cairo:t* cairo:line-join-t) void "cairo_set_line_join"))
(define cairo:get-line-join (c-lambda (cairo:t*) cairo:line-join-t "cairo_get_line_join"))
(define cairo:set-line-width (c-lambda (cairo:t* double) void "cairo_set_line_width"))
(define cairo:get-line-width (c-lambda (cairo:t*) double "cairo_get_line_width"))
(define cairo:set-miter-limit (c-lambda (cairo:t* double) void "cairo_set_miter_limit"))
(define cairo:get-miter-limit (c-lambda (cairo:t*) double "cairo_get_miter_limit"))
(define cairo:set-operator (c-lambda (cairo:t* cairo:operator-t) void "cairo_set_operator"))
(define cairo:get-operator (c-lambda (cairo:t*) cairo:operator-t "cairo_get_operator"))
(define cairo:set-tolerance (c-lambda (cairo:t* double) void "cairo_set_tolerance"))
(define cairo:get-tolerance (c-lambda (cairo:t*) double "cairo_get_tolerance"))
(define cairo:clip (c-lambda (cairo:t*) void "cairo_clip"))
(define cairo:clip-preserve (c-lambda (cairo:t*) void "cairo_clip_preserve"))
(define cairo:clip-extents (c-lambda (cairo:t* double* double* double* double*) void "cairo_clip_extents"))
(define cairo:reset-clip (c-lambda (cairo:t*) void "cairo_reset_clip"))
(define cairo:rectangle-list-destroy (c-lambda (cairo:rectangle-list-t*) void "cairo_rectangle_list_destroy"))
(define cairo:copy-clip-rectangle-list (c-lambda (cairo:t*) cairo:rectangle-list-t* "cairo_copy_clip_rectangle_list"))
(define cairo:fill (c-lambda (cairo:t*) void "cairo_fill"))
(define cairo:fill-preserve (c-lambda (cairo:t*) void "cairo_fill_preserve"))
(define cairo:fill-extents (c-lambda (cairo:t* double* double* double* double*) void "cairo_fill_extents"))
(define cairo:in-fill (c-lambda (cairo:t* double double) cairo:bool-t "cairo_in_fill"))
(define cairo:mask (c-lambda (cairo:t* cairo:pattern-t*) void "cairo_mask"))
(define cairo:mask-surface (c-lambda (cairo:t* cairo:surface-t* double double) void "cairo_mask_surface"))
(define cairo:paint (c-lambda (cairo:t*) void "cairo_paint"))
(define cairo:paint-with-alpha (c-lambda (cairo:t* double) void "cairo_paint_with_alpha"))
(define cairo:stroke (c-lambda (cairo:t*) void "cairo_stroke"))
(define cairo:stroke-preserve (c-lambda (cairo:t*) void "cairo_stroke_preserve"))
(define cairo:stroke-extents (c-lambda (cairo:t* double* double* double* double*) void "cairo_stroke_extents"))
(define cairo:in-stroke (c-lambda (cairo:t* double double) cairo:bool-t "cairo_in_stroke"))
(define cairo:copy-page (c-lambda (cairo:t*) void "cairo_copy_page"))
(define cairo:show-page (c-lambda (cairo:t*) void "cairo_show_page"))
(define cairo:get-reference-count (c-lambda (cairo:t*) int "cairo_get_reference_count"))
(define cairo:set-user-data (c-lambda (cairo:t* cairo:user-data-key-t* void* cairo:destroy-func-t) cairo:status-t "cairo_set_user_data"))
(define cairo:get-user-data (c-lambda (cairo:t* cairo:user-data-key-t*) void* "cairo_get_user_data"))
(define cairo:font-face-reference (c-lambda (cairo:font-face-t*) cairo:font-face-t* "cairo_font_face_reference"))
(define cairo:font-face-destroy (c-lambda (cairo:font-face-t*) void "cairo_font_face_destroy"))
(define cairo:font-face-status (c-lambda (cairo:font-face-t*) cairo:status-t "cairo_font_face_status"))
(define cairo:font-face-get-type (c-lambda (cairo:font-face-t*) cairo:font-type-t "cairo_font_face_get_type"))
(define cairo:font-face-get-reference-count (c-lambda (cairo:font-face-t*) int "cairo_font_face_get_reference_count"))
(define cairo:font-face-set-user-data (c-lambda (cairo:font-face-t* cairo:user-data-key-t* void* cairo:destroy-func-t) cairo:status-t "cairo_font_face_set_user_data"))
(define cairo:font-face-get-user-data (c-lambda (cairo:font-face-t* cairo:user-data-key-t*) void* "cairo_font_face_get_user_data"))
(define cairo:font-options-create (c-lambda () cairo:font-options-t* "cairo_font_options_create"))
(define cairo:font-options-copy (c-lambda (cairo:font-options-t*) cairo:font-options-t* "cairo_font_options_copy"))
(define cairo:font-options-destroy (c-lambda (cairo:font-options-t*) void "cairo_font_options_destroy"))
(define cairo:font-options-status (c-lambda (cairo:font-options-t*) cairo:status-t "cairo_font_options_status"))
(define cairo:font-options-merge (c-lambda (cairo:font-options-t* cairo:font-options-t*) void "cairo_font_options_merge"))
(define cairo:font-options-hash (c-lambda (cairo:font-options-t*) long "cairo_font_options_hash"))
(define cairo:font-options-equal (c-lambda (cairo:font-options-t* cairo:font-options-t*) cairo:bool-t "cairo_font_options_equal"))
(define cairo:font-options-set-antialias (c-lambda (cairo:font-options-t* cairo:antialias-t) void "cairo_font_options_set_antialias"))
(define cairo:font-options-get-antialias (c-lambda (cairo:font-options-t*) cairo:antialias-t "cairo_font_options_get_antialias"))
(define cairo:font-options-set-subpixel-order (c-lambda (cairo:font-options-t* cairo:subpixel-order-t) void "cairo_font_options_set_subpixel_order"))
(define cairo:font-options-get-subpixel-order (c-lambda (cairo:font-options-t*) cairo:subpixel-order-t "cairo_font_options_get_subpixel_order"))
(define cairo:font-options-set-hint-style (c-lambda (cairo:font-options-t* cairo:hint-style-t) void "cairo_font_options_set_hint_style"))
(define cairo:font-options-get-hint-style (c-lambda (cairo:font-options-t*) cairo:hint-style-t "cairo_font_options_get_hint_style"))
(define cairo:font-options-set-hint-metrics (c-lambda (cairo:font-options-t* cairo:hint-metrics-t) void "cairo_font_options_set_hint_metrics"))
(define cairo:font-options-get-hint-metrics (c-lambda (cairo:font-options-t*) cairo:hint-metrics-t "cairo_font_options_get_hint_metrics"))
;(define cairo:ft-font-face-create-for-ft-face (c-lambda (FT-Face int) cairo:font-face-t* "cairo_ft_font_face_create_for_ft_face"))
;(define cairo:ft-font-face-create-for-pattern (c-lambda (FcPattern*) cairo:font-face-t* "cairo_ft_font_face_create_for_pattern"))
;(define cairo:ft-font-options-substitute (c-lambda (cairo:font-options-t* FcPattern*) void "cairo_ft_font_options_substitute"))
;(define cairo:ft-scaled-font-lock-face (c-lambda (cairo:scaled-font-t*) FT-Face "cairo_ft_scaled_font_lock_face"))
;(define cairo:ft-scaled-font-unlock-face (c-lambda (cairo:scaled-font-t*) void "cairo_ft_scaled_font_unlock_face"))
(define cairo:format-stride-for-width (c-lambda (cairo:format-t int) int "cairo_format_stride_for_width"))
(define cairo:image-surface-create (c-lambda (cairo:format-t int int) cairo:surface-t* "cairo_image_surface_create"))
(define cairo:image-surface-create-for-data (c-lambda (unsigned-char* cairo:format-t int int int) cairo:surface-t* "cairo_image_surface_create_for_data"))
(define cairo:image-surface-get-data (c-lambda (cairo:surface-t*) unsigned-char* "cairo_image_surface_get_data"))
(define cairo:image-surface-get-format (c-lambda (cairo:surface-t*) cairo:format-t "cairo_image_surface_get_format"))
(define cairo:image-surface-get-width (c-lambda (cairo:surface-t*) int "cairo_image_surface_get_width"))
(define cairo:image-surface-get-height (c-lambda (cairo:surface-t*) int "cairo_image_surface_get_height"))
(define cairo:image-surface-get-stride (c-lambda (cairo:surface-t*) int "cairo_image_surface_get_stride"))
(define cairo:matrix-init (c-lambda (cairo:matrix-t* double double double double double double) void "cairo_matrix_init"))
(define cairo:matrix-init-identity (c-lambda (cairo:matrix-t*) void "cairo_matrix_init_identity"))
(define cairo:matrix-init-translate (c-lambda (cairo:matrix-t* double double) void "cairo_matrix_init_translate"))
(define cairo:matrix-init-scale (c-lambda (cairo:matrix-t* double double) void "cairo_matrix_init_scale"))
(define cairo:matrix-init-rotate (c-lambda (cairo:matrix-t* double) void "cairo_matrix_init_rotate"))
(define cairo:matrix-translate (c-lambda (cairo:matrix-t* double double) void "cairo_matrix_translate"))
(define cairo:matrix-scale (c-lambda (cairo:matrix-t* double double) void "cairo_matrix_scale"))
(define cairo:matrix-rotate (c-lambda (cairo:matrix-t* double) void "cairo_matrix_rotate"))
(define cairo:matrix-invert (c-lambda (cairo:matrix-t*) cairo:status-t "cairo_matrix_invert"))
(define cairo:matrix-multiply (c-lambda (cairo:matrix-t* cairo:matrix-t* cairo:matrix-t*) void "cairo_matrix_multiply"))
(define cairo:matrix-transform-distance (c-lambda (cairo:matrix-t* double* double*) void "cairo_matrix_transform_distance"))
(define cairo:matrix-transform-point (c-lambda (cairo:matrix-t* double* double*) void "cairo_matrix_transform_point"))
(define cairo:copy-path (c-lambda (cairo:t*) cairo:path-t* "cairo_copy_path"))
(define cairo:copy-path-flat (c-lambda (cairo:t*) cairo:path-t* "cairo_copy_path_flat"))
(define cairo:path-destroy (c-lambda (cairo:path-t*) void "cairo_path_destroy"))
(define cairo:append-path (c-lambda (cairo:t* cairo:path-t*) void "cairo_append_path"))
(define cairo:get-current-point (c-lambda (cairo:t* double* double*) void "cairo_get_current_point"))
(define cairo:new-path (c-lambda (cairo:t*) void "cairo_new_path"))
(define cairo:new-sub-path (c-lambda (cairo:t*) void "cairo_new_sub_path"))
(define cairo:close-path (c-lambda (cairo:t*) void "cairo_close_path"))
(define cairo:arc (c-lambda (cairo:t* double double double double double) void "cairo_arc"))
(define cairo:arc-negative (c-lambda (cairo:t* double double double double double) void "cairo_arc_negative"))
(define cairo:curve-to (c-lambda (cairo:t* double double double double double double) void "cairo_curve_to"))
(define cairo:line-to (c-lambda (cairo:t* double double) void "cairo_line_to"))
(define cairo:move-to (c-lambda (cairo:t* double double) void "cairo_move_to"))
(define cairo:rectangle (c-lambda (cairo:t* double double double double) void "cairo_rectangle"))
(define cairo:glyph-path (c-lambda (cairo:t* cairo:glyph-t* int) void "cairo_glyph_path"))
(define cairo:text-path (c-lambda (cairo:t* char-string) void "cairo_text_path"))
(define cairo:rel-curve-to (c-lambda (cairo:t* double double double double double double) void "cairo_rel_curve_to"))
(define cairo:rel-line-to (c-lambda (cairo:t* double double) void "cairo_rel_line_to"))
(define cairo:rel-move-to (c-lambda (cairo:t* double double) void "cairo_rel_move_to"))
(define cairo:pattern-add-color-stop-rgb (c-lambda (cairo:pattern-t* double double double double) void "cairo_pattern_add_color_stop_rgb"))
(define cairo:pattern-add-color-stop-rgba (c-lambda (cairo:pattern-t* double double double double double) void "cairo_pattern_add_color_stop_rgba"))
(define cairo:pattern-get-color-stop-count (c-lambda (cairo:pattern-t* int*) cairo:status-t "cairo_pattern_get_color_stop_count"))
(define cairo:pattern-get-color-stop-rgba (c-lambda (cairo:pattern-t* int double* double* double* double* double*) cairo:status-t "cairo_pattern_get_color_stop_rgba"))
(define cairo:pattern-create-rgb (c-lambda (double double double) cairo:pattern-t* "cairo_pattern_create_rgb"))
(define cairo:pattern-create-rgba (c-lambda (double double double double) cairo:pattern-t* "cairo_pattern_create_rgba"))
(define cairo:pattern-get-rgba (c-lambda (cairo:pattern-t* double* double* double* double*) cairo:status-t "cairo_pattern_get_rgba"))
(define cairo:pattern-create-for-surface (c-lambda (cairo:surface-t*) cairo:pattern-t* "cairo_pattern_create_for_surface"))
(define cairo:pattern-get-surface (c-lambda (cairo:pattern-t* cairo:surface-t**) cairo:status-t "cairo_pattern_get_surface"))
(define cairo:pattern-create-linear (c-lambda (double double double double) cairo:pattern-t* "cairo_pattern_create_linear"))
(define cairo:pattern-get-linear-points (c-lambda (cairo:pattern-t* double* double* double* double*) cairo:status-t "cairo_pattern_get_linear_points"))
(define cairo:pattern-create-radial (c-lambda (double double double double double double) cairo:pattern-t* "cairo_pattern_create_radial"))
(define cairo:pattern-get-radial-circles (c-lambda (cairo:pattern-t* double* double* double* double* double* double*) cairo:status-t "cairo_pattern_get_radial_circles"))
(define cairo:pattern-reference (c-lambda (cairo:pattern-t*) cairo:pattern-t* "cairo_pattern_reference"))
(define cairo:pattern-destroy (c-lambda (cairo:pattern-t*) void "cairo_pattern_destroy"))
(define cairo:pattern-status (c-lambda (cairo:pattern-t*) cairo:status-t "cairo_pattern_status"))
(define cairo:pattern-set-extend (c-lambda (cairo:pattern-t* cairo:extend-t) void "cairo_pattern_set_extend"))
(define cairo:pattern-get-extend (c-lambda (cairo:pattern-t*) cairo:extend-t "cairo_pattern_get_extend"))
(define cairo:pattern-set-filter (c-lambda (cairo:pattern-t* cairo:filter-t) void "cairo_pattern_set_filter"))
(define cairo:pattern-get-filter (c-lambda (cairo:pattern-t*) cairo:filter-t "cairo_pattern_get_filter"))
(define cairo:pattern-set-matrix (c-lambda (cairo:pattern-t* cairo:matrix-t*) void "cairo_pattern_set_matrix"))
(define cairo:pattern-get-matrix (c-lambda (cairo:pattern-t* cairo:matrix-t*) void "cairo_pattern_get_matrix"))
(define cairo:pattern-get-type (c-lambda (cairo:pattern-t*) cairo:pattern-type-t "cairo_pattern_get_type"))
(define cairo:pattern-get-reference-count (c-lambda (cairo:pattern-t*) int "cairo_pattern_get_reference_count"))
(define cairo:pattern-set-user-data (c-lambda (cairo:pattern-t* cairo:user-data-key-t* void* cairo:destroy-func-t) cairo:status-t "cairo_pattern_set_user_data"))
(define cairo:pattern-get-user-data (c-lambda (cairo:pattern-t* cairo:user-data-key-t*) void* "cairo_pattern_get_user_data"))
;(define cairo:pdf-surface-create (c-lambda (char-string double double) cairo:surface-t* "cairo_pdf_surface_create"))
;(define cairo:pdf-surface-create-for-stream (c-lambda (cairo:write-func-t void* double double) cairo:surface-t* "cairo_pdf_surface_create_for_stream"))
;(define cairo:pdf-surface-set-size (c-lambda (cairo:surface-t* double double) void "cairo_pdf_surface_set_size"))
;(define cairo:image-surface-create-from-png (c-lambda (char-string) cairo:surface-t* "cairo_image_surface_create_from_png"))
;(define |(*cairo:read-func-t)| (c-lambda (void* unsigned-char* unsigned-int) cairo:status-t "(*cairo_read_func_t)"))
;(define cairo:image-surface-create-from-png-stream (c-lambda (cairo:read-func-t void*) cairo:surface-t* "cairo_image_surface_create_from_png_stream"))
;(define cairo:surface-write-to-png (c-lambda (cairo:surface-t* char-string) cairo:status-t "cairo_surface_write_to_png"))
;(define |(*cairo:write-func-t)| (c-lambda (void* unsigned-char* unsigned-int) cairo:status-t "(*cairo_write_func_t)"))
;(define cairo:surface-write-to-png-stream (c-lambda (cairo:surface-t* cairo:write-func-t void*) cairo:status-t "cairo_surface_write_to_png_stream"))
;(define cairo:ps-surface-create (c-lambda (char-string double double) cairo:surface-t* "cairo_ps_surface_create"))
;(define cairo:ps-surface-create-for-stream (c-lambda (cairo:write-func-t void* double double) cairo:surface-t* "cairo_ps_surface_create_for_stream"))
;(define cairo:ps-surface-set-size (c-lambda (cairo:surface-t* double double) void "cairo_ps_surface_set_size"))
;(define cairo:ps-surface-dsc-begin-setup (c-lambda (cairo:surface-t*) void "cairo_ps_surface_dsc_begin_setup"))
;(define cairo:ps-surface-dsc-begin-page-setup (c-lambda (cairo:surface-t*) void "cairo_ps_surface_dsc_begin_page_setup"))
;(define cairo:ps-surface-dsc-comment (c-lambda (cairo:surface-t* char-string) void "cairo_ps_surface_dsc_comment"))
(define cairo:scaled-font-create (c-lambda (cairo:font-face-t* cairo:matrix-t* cairo:matrix-t* cairo:font-options-t*) cairo:scaled-font-t* "cairo_scaled_font_create"))
(define cairo:scaled-font-reference (c-lambda (cairo:scaled-font-t*) cairo:scaled-font-t* "cairo_scaled_font_reference"))
(define cairo:scaled-font-destroy (c-lambda (cairo:scaled-font-t*) void "cairo_scaled_font_destroy"))
(define cairo:scaled-font-status (c-lambda (cairo:scaled-font-t*) cairo:status-t "cairo_scaled_font_status"))
(define cairo:scaled-font-extents (c-lambda (cairo:scaled-font-t* cairo:font-extents-t*) void "cairo_scaled_font_extents"))
(define cairo:scaled-font-text-extents (c-lambda (cairo:scaled-font-t* char-string cairo:text-extents-t*) void "cairo_scaled_font_text_extents"))
(define cairo:scaled-font-glyph-extents (c-lambda (cairo:scaled-font-t* cairo:glyph-t* int cairo:text-extents-t*) void "cairo_scaled_font_glyph_extents"))
(define cairo:scaled-font-get-font-face (c-lambda (cairo:scaled-font-t*) cairo:font-face-t* "cairo_scaled_font_get_font_face"))
(define cairo:scaled-font-get-font-options (c-lambda (cairo:scaled-font-t* cairo:font-options-t*) void "cairo_scaled_font_get_font_options"))
(define cairo:scaled-font-get-font-matrix (c-lambda (cairo:scaled-font-t* cairo:matrix-t*) void "cairo_scaled_font_get_font_matrix"))
(define cairo:scaled-font-get-ctm (c-lambda (cairo:scaled-font-t* cairo:matrix-t*) void "cairo_scaled_font_get_ctm"))
(define cairo:scaled-font-get-type (c-lambda (cairo:scaled-font-t*) cairo:font-type-t "cairo_scaled_font_get_type"))
(define cairo:scaled-font-get-reference-count (c-lambda (cairo:scaled-font-t*) int "cairo_scaled_font_get_reference_count"))
(define cairo:scaled-font-set-user-data (c-lambda (cairo:scaled-font-t* cairo:user-data-key-t* void* cairo:destroy-func-t) cairo:status-t "cairo_scaled_font_set_user_data"))
(define cairo:scaled-font-get-user-data (c-lambda (cairo:scaled-font-t* cairo:user-data-key-t*) void* "cairo_scaled_font_get_user_data"))
(define cairo:surface-create-similar (c-lambda (cairo:surface-t* cairo:content-t int int) cairo:surface-t* "cairo_surface_create_similar"))
(define cairo:surface-reference (c-lambda (cairo:surface-t*) cairo:surface-t* "cairo_surface_reference"))
(define cairo:surface-destroy (c-lambda (cairo:surface-t*) void "cairo_surface_destroy"))
(define cairo:surface-status (c-lambda (cairo:surface-t*) cairo:status-t "cairo_surface_status"))
(define cairo:surface-finish (c-lambda (cairo:surface-t*) void "cairo_surface_finish"))
(define cairo:surface-flush (c-lambda (cairo:surface-t*) void "cairo_surface_flush"))
(define cairo:surface-get-font-options (c-lambda (cairo:surface-t* cairo:font-options-t*) void "cairo_surface_get_font_options"))
(define cairo:surface-get-content (c-lambda (cairo:surface-t*) cairo:content-t "cairo_surface_get_content"))
(define cairo:surface-mark-dirty (c-lambda (cairo:surface-t*) void "cairo_surface_mark_dirty"))
(define cairo:surface-mark-dirty-rectangle (c-lambda (cairo:surface-t* int int int int) void "cairo_surface_mark_dirty_rectangle"))
(define cairo:surface-set-device-offset (c-lambda (cairo:surface-t* double double) void "cairo_surface_set_device_offset"))
(define cairo:surface-get-device-offset (c-lambda (cairo:surface-t* double* double*) void "cairo_surface_get_device_offset"))
(define cairo:surface-set-fallback-resolution (c-lambda (cairo:surface-t* double double) void "cairo_surface_set_fallback_resolution"))
(define cairo:surface-get-type (c-lambda (cairo:surface-t*) cairo:surface-type-t "cairo_surface_get_type"))
(define cairo:surface-get-reference-count (c-lambda (cairo:surface-t*) int "cairo_surface_get_reference_count"))
(define cairo:surface-set-user-data (c-lambda (cairo:surface-t* cairo:user-data-key-t* void* cairo:destroy-func-t) cairo:status-t "cairo_surface_set_user_data"))
(define cairo:surface-get-user-data (c-lambda (cairo:surface-t* cairo:user-data-key-t*) void* "cairo_surface_get_user_data"))
;(define cairo:svg-surface-create (c-lambda (char-string double double) cairo:surface-t* "cairo_svg_surface_create"))
;(define cairo:svg-surface-create-for-stream (c-lambda (cairo:write-func-t void* double double) cairo:surface-t* "cairo_svg_surface_create_for_stream"))
;(define cairo:svg-surface-restrict-to-version (c-lambda (cairo:surface-t* cairo:svg-version-t) void "cairo_svg_surface_restrict_to_version"))
;(define cairo:svg-get-versions (c-lambda (cairo:svg-version-t** int*) void "cairo_svg_get_versions"))
;(define cairo:svg-version-to-string (c-lambda (cairo:svg-version-t) char-string "cairo_svg_version_to_string"))
(define cairo:select-font-face (c-lambda (cairo:t* char-string cairo:font-slant-t cairo:font-weight-t) void "cairo_select_font_face"))
(define cairo:set-font-size (c-lambda (cairo:t* double) void "cairo_set_font_size"))
(define cairo:set-font-matrix (c-lambda (cairo:t* cairo:matrix-t*) void "cairo_set_font_matrix"))
(define cairo:get-font-matrix (c-lambda (cairo:t* cairo:matrix-t*) void "cairo_get_font_matrix"))
(define cairo:set-font-options (c-lambda (cairo:t* cairo:font-options-t*) void "cairo_set_font_options"))
(define cairo:get-font-options (c-lambda (cairo:t* cairo:font-options-t*) void "cairo_get_font_options"))
(define cairo:set-font-face (c-lambda (cairo:t* cairo:font-face-t*) void "cairo_set_font_face"))
(define cairo:get-font-face (c-lambda (cairo:t*) cairo:font-face-t* "cairo_get_font_face"))
(define cairo:set-scaled-font (c-lambda (cairo:t* cairo:scaled-font-t*) void "cairo_set_scaled_font"))
(define cairo:get-scaled-font (c-lambda (cairo:t*) cairo:scaled-font-t* "cairo_get_scaled_font"))
(define cairo:show-text (c-lambda (cairo:t* char-string) void "cairo_show_text"))
(define cairo:show-glyphs (c-lambda (cairo:t* cairo:glyph-t* int) void "cairo_show_glyphs"))
(define cairo:font-extents (c-lambda (cairo:t* cairo:font-extents-t*) void "cairo_font_extents"))
(define cairo:text-extents (c-lambda (cairo:t* char-string cairo:text-extents-t*) void "cairo_text_extents"))
(define cairo:glyph-extents (c-lambda (cairo:t* cairo:glyph-t* int cairo:text-extents-t*) void "cairo_glyph_extents"))
(define cairo:translate (c-lambda (cairo:t* double double) void "cairo_translate"))
(define cairo:scale (c-lambda (cairo:t* double double) void "cairo_scale"))
(define cairo:rotate (c-lambda (cairo:t* double) void "cairo_rotate"))
(define cairo:transform (c-lambda (cairo:t* cairo:matrix-t*) void "cairo_transform"))
(define cairo:set-matrix (c-lambda (cairo:t* cairo:matrix-t*) void "cairo_set_matrix"))
(define cairo:get-matrix (c-lambda (cairo:t* cairo:matrix-t*) void "cairo_get_matrix"))
(define cairo:identity-matrix (c-lambda (cairo:t*) void "cairo_identity_matrix"))
(define cairo:user-to-device (c-lambda (cairo:t* double* double*) void "cairo_user_to_device"))
(define cairo:user-to-device-distance (c-lambda (cairo:t* double* double*) void "cairo_user_to_device_distance"))
(define cairo:device-to-user (c-lambda (cairo:t* double* double*) void "cairo_device_to_user"))
(define cairo:device-to-user-distance (c-lambda (cairo:t* double* double*) void "cairo_device_to_user_distance"))

(cond-expand
 ((not android)
  (define cairo:xlib-surface-create (c-lambda (Display* Drawable Visual* int int) cairo:surface-t* "cairo_xlib_surface_create"))
  (define cairo:xlib-surface-create-for-bitmap (c-lambda (Display* Pixmap Screen* int int) cairo:surface-t* "cairo_xlib_surface_create_for_bitmap"))
  (define cairo:xlib-surface-set-size (c-lambda (cairo:surface-t* int int) void "cairo_xlib_surface_set_size"))
  (define cairo:xlib-surface-get-display (c-lambda (cairo:surface-t*) Display* "cairo_xlib_surface_get_display"))
  (define cairo:xlib-surface-get-screen (c-lambda (cairo:surface-t*) Screen* "cairo_xlib_surface_get_screen"))
  (define cairo:xlib-surface-set-drawable (c-lambda (cairo:surface-t* Drawable int int) void "cairo_xlib_surface_set_drawable"))
  (define cairo:xlib-surface-get-drawable (c-lambda (cairo:surface-t*) Drawable "cairo_xlib_surface_get_drawable"))
  (define cairo:xlib-surface-get-visual (c-lambda (cairo:surface-t*) Visual* "cairo_xlib_surface_get_visual"))
  (define cairo:xlib-surface-get-width (c-lambda (cairo:surface-t*) int "cairo_xlib_surface_get_width"))
  (define cairo:xlib-surface-get-height (c-lambda (cairo:surface-t*) int "cairo_xlib_surface_get_height"))
  (define cairo:xlib-surface-get-depth (c-lambda (cairo:surface-t*) int "cairo_xlib_surface_get_depth")))
 (else))

;-------------------------------------------------------------------------------
; Custom functions
;-------------------------------------------------------------------------------

;; ;; (define make-cairo:a8-image-WRONG
;; ;;   (c-lambda (int int)
;; ;;             cairo:surface-t*
;; ;;             "
;; ;;     int stride;
;; ;;     unsigned char *data;
;; ;;     cairo_surface_t *surface;
;; ;;     int format = CAIRO_FORMAT_A8;
    
;; ;;     stride = cairo_format_stride_for_width (format, ___arg1);
;; ;;     data = malloc (stride * ___arg2);
;; ;;     surface = cairo_image_surface_create_for_data (data, format,
;; ;;               ___arg1, ___arg2,
;; ;;               stride);
;; ;;     ___result_voidstar = surface;
;; ;;             "))

;; (define-structure data-image data-ptr surface-ptr stride size)

;; (define (make-cairo:a8-image cairo size-x size-y)
;;   (let* ((stride (cairo:format-stride-for-width CAIRO_FORMAT_A8 size-x))
;;          (data (malloc-a8-image stride size-y))
;;          (image (cairo:image-surface-create-for-data data CAIRO_FORMAT_A8 size-x size-y stride)))
;;     (if (not image)
;;         (error "make-cairo:a8-image: image could not be created"))
;;     (make-will image (lambda (img) (cairo:surface-destroy img)))
;;     (make-will data (lambda (data) (free-a8-image data)))
;;     (make-data-image data image stride (* stride size-y))))

;; (define malloc-a8-image
;;   (c-lambda (int int)
;;             unsigned-char*
;;             "
;; unsigned char *data;
;; int total_size = ___arg1 * ___arg2;
;; data = (unsigned char*)malloc(total_size);
;; int i;
;; for(i = 0; i < total_size; i++) {
;;     data[i] = 0;
;; }
;; ___result_voidstar = data;
;;             "))

;; (define free-a8-image
;;   (c-lambda (unsigned-char*)
;;             void
;;             "
;; if(___arg1 == 0) {
;;     printf(\"This is bad: I could not deallocate the memory of an image\");
;; } else {
;;     free(___arg1);
;; }
;;             "))

;; (define (grayscale-color-from-normalized value)
;;   (- 255 (modulo (inexact->exact (round (* 255 value))) 255)))
  

;; (define (cairo:a8-image-set-pixel! image pix-i pix-j value)
;;   (set-pixel-a8-image! (data-image-data-ptr image)
;;                        (data-image-stride image)
;;                        pix-i
;;                        pix-j
;;                        (grayscale-color-from-normalized value)))

;; (define set-pixel-a8-image!
;;   (c-lambda (unsigned-char* int int int int)
;;             void
;;             "
;; ___arg1[___arg2*___arg4+___arg3] = ___arg5 ^ 0xff;
;;             "))

;; (define (cairo:a8-image-set! image vect)
;;   (set-a8-image! (data-image-data-ptr image) (data-image-size image) vect (u8vector-length vect)))

;; (define set-a8-image!
;;   (c-lambda (unsigned-char* int scheme-object int) ; image-data, 
;;             void
;;             "
;; //void *u8vectorptr = ___CAST(void*,&___FETCH_U8(___BODY(___arg3),___INT(0)));
;; //void *u8vectorptr = ___CAST(void*,&___FETCH_U8(___arg3,0));
;; //void *u8vectorptr = ___CAST(void*,___BODY(___arg3));

;; unsigned char *u8vectorptr = ___CAST(___U8*,___BODY_AS(___arg3,___tSUBTYPED));

;; int i;
;; for (i = 0; i < ___arg2 && i < ___arg4; i++) {
;;     ___arg1[i] = u8vectorptr[i] ^ 0xff;
;; }
;;             "))

;; (define (cairo:set-line-style cairo style-as-list)
;;   (define cairo:interface
;;     (c-lambda (cairo:t* scheme-object int)
;;               void
;;               "
;; double *vectorptr = ___CAST(double*,___BODY(___arg2));
;; cairo_set_dash(___arg1, vectorptr, ___arg3, 0.0);
;;               "))
;;   (cairo:interface cairo (list->f64vector style-as-list) (length style-as-list)))

;; (define cairo:restore-line-style
;;   (c-lambda (cairo:t*)
;;             void
;;             "
;;             cairo_set_dash(___arg1, (double*)0, 0, 0.0);
;;             "))
