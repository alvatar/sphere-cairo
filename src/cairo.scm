;;; Copyright (c) 2012, Alvaro Castro-Castilla. All rights reserved.
;;; Cairo library bindings for Scheme

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

(c-declare "#include <cairo.h>")
(cond-expand
 (desktop
  (c-declare "#include <cairo-ft.h>")
  (c-declare "#include <cairo-pdf.h>")
  (c-declare "#include <cairo-ps.h>")
  (c-declare "#include <cairo-svg.h>")
  (c-declare "#include <cairo-xlib.h>")
  (c-declare "#include <X11/Xlib.h>")
  (c-declare "#include <fontconfig/fontconfig.h>")
  (c-declare "#include <ft2build.h>")
  (c-declare "#include FT_FREETYPE_H"))
 (else))

;-------------------------------------------------------------------------------
; Enums
;-------------------------------------------------------------------------------

;(c-define-type cairo_format_t "cairo_format_t")
(c-define-type cairo_format_t unsigned-int)
(c-constants
 CAIRO_FORMAT_ARGB32
 CAIRO_FORMAT_RGB24
 CAIRO_FORMAT_A8
 CAIRO_FORMAT_A1
 CAIRO_FORMAT_RGB16_565)

(c-define-type cairo_line_cap_t "cairo_line_cap_t")
(c-constants
 CAIRO_LINE_CAP_BUTT
 CAIRO_LINE_CAP_ROUND
 CAIRO_LINE_CAP_SQUARE)

(cond-expand
 (desktop
  (c-define-type cairo_font_slant_t "cairo_font_slant_t")
  (c-constants
   CAIRO_FONT_SLANT_NORMAL
   CAIRO_FONT_SLANT_ITALIC
   CAIRO_FONT_SLANT_OBLIQUE)
  (c-define-type cairo_font_weight_t "cairo_font_weight_t")
  (c-constants
   CAIRO_FONT_WEIGHT_NORMAL
   CAIRO_FONT_WEIGHT_BOLD))
 (else))

;(c-define-type cairo_status_t (type "cairo_status_t"))
(c-define-type cairo_status_t unsigned-int)
(c-define-type cairo_status_t*  (pointer cairo_status_t))
(c-define-type cairo_status_t** (pointer cairo_status_t*))
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
 (desktop
  (c-define-type Display "Display")
  (c-define-type Display* (pointer Display))
  (c-define-type Screen "Screen")
  (c-define-type Screen* (pointer Screen))
  (c-define-type Visual "Visual")
  (c-define-type Visual* (pointer Visual))
  (c-define-type Drawable unsigned-long)
  (c-define-type Pixmap unsigned-long))
 (else))
;;; FreeType types
;; (c-define-type FT-Face (type "FT_Face"))
;; (c-define-type FcPattern (struct "FcPattern"))
;; (c-define-type FcPattern* (pointer "FcPattern"))
;; (c-define-type cairo_font_face_t "cairo_font_face_t")
;; (c-define-type cairo_font_face_t* (pointer "cairo_font_face_t"))

(c-define-type FT-Face "FT_Face")
(c-define-type FcPattern "FcPattern")
(c-define-type FcPattern* (pointer "FcPattern"))
;;; Windows types FIXME
;(c-define-type LOGFONTW* (pointer (pointer "LOGFONTW")))
;(c-define-type HFONT "HFONT")
;(c-define-type HDC "HDC")
;(c-define-type cairo_svg_version_t (type "cairo_svg_version_t"))
;(c-define-type cairo_svg_version_t** (pointer (pointer "cairo_svg_version_t")))
;(c-define-type cairo_destroy_func_t  (pointer "cairo_destroy_func_t"))

(c-define-type cairo_surface_t (struct "cairo_surface_t"))
(c-define-type cairo_surface_t* (pointer "cairo_surface_t"))
(c-define-type cairo_surface_t** (pointer (pointer "cairo_surface_t")))
(c-define-type cairo_content_t "cairo_content_t")
(c-define-type cairo_surface_type_t "cairo_surface_type_t")
(c-define-type cairo_bool_t   (type "cairo_bool_t"))
(c-define-type cairo_destroy_func_t  (function (void*) void))
(c-define-type cairo_user_data_key_t  (type "cairo_user_data_key_t"))
(c-define-type cairo_user_data_key_t*  (pointer cairo_user_data_key_t))
(c-define-type cairo_read_func_t  "cairo_read_func_t")
(c-define-type cairo_write_func_t  "cairo_write_func_t")
(c-define-type cairo_t (struct "cairo_t"))
(c-define-type cairo_t* (pointer "cairo_t"))
(c-define-type cairo_t** (pointer (pointer "cairo_t")))
(c-define-type cairo_antialias_t "cairo_antialias_t")
(c-define-type cairo_fill_rule_t "cairo_fill_rule_t")
(c-define-type cairo_line_join_t "cairo_line_join_t")
(c-define-type cairo_operator_t "cairo_operator_t")
(c-define-type cairo_rectangle_t (struct "cairo_rectangle_t"))
(c-define-type cairo_rectangle_t* (pointer "cairo_rectangle_t"))
(c-define-type cairo_rectangle_t** (pointer (pointer "cairo_rectangle_t")))
(c-define-type cairo_rectangle_list_t (struct "cairo_rectangle_list_t"))
(c-define-type cairo_rectangle_list_t* (pointer "cairo_rectangle_list_t"))
(c-define-type cairo_rectangle_list_t** (pointer (pointer "cairo_rectangle_list_t")))
(c-define-type cairo_font_face_t (struct "cairo_font_face_t"))
(c-define-type cairo_font_face_t* (pointer "cairo_font_face_t"))
(c-define-type cairo_font_face_t** (pointer (pointer "cairo_font_face_t")))
(c-define-type cairo_font_type_t "cairo_font_type_t")
(c-define-type cairo_font_options_t (struct "cairo_font_options_t"))
(c-define-type cairo_font_options_t* (pointer "cairo_font_options_t"))
(c-define-type cairo_font_options_t** (pointer (pointer "cairo_font_options_t")))
(c-define-type cairo_subpixel_order_t "cairo_subpixel_order_t")
(c-define-type cairo_hint_style_t "cairo_hint_style_t")
(c-define-type cairo_hint_metrics_t "cairo_hint_metrics_t")
(c-define-type cairo_matrix_t (struct "cairo_matrix_t"))
(c-define-type cairo_matrix_t* (pointer "cairo_matrix_t"))
(c-define-type cairo_matrix_t** (pointer (pointer "cairo_matrix_t")))
(c-define-type cairo_path_t (struct "cairo_path_t"))
(c-define-type cairo_path_t* (pointer "cairo_path_t"))
(c-define-type cairo_path_t** (pointer (pointer "cairo_path_t")))
(c-define-type cairo_path_data_t (union "cairo_path_data_t"))
(c-define-type cairo_path_data_t* (pointer "cairo_path_data_t"))
(c-define-type cairo_path_data_t** (pointer (pointer "cairo_path_data_t")))
(c-define-type cairo_path_data_type_t "cairo_path_data_type_t")
(c-define-type cairo_pattern_t (struct "cairo_pattern_t"))
(c-define-type cairo_pattern_t* (pointer "cairo_pattern_t"))
(c-define-type cairo_pattern_t** (pointer (pointer "cairo_pattern_t")))
(c-define-type cairo_extend_t "cairo_extend_t")
(c-define-type cairo_filter_t "cairo_filter_t")
(c-define-type cairo_pattern_type_t "cairo_pattern_type_t")
(c-define-type cairo_scaled_font_t (struct "cairo_scaled_font_t"))
(c-define-type cairo_scaled_font_t* (pointer "cairo_scaled_font_t"))
(c-define-type cairo_scaled_font_t** (pointer (pointer "cairo_scaled_font_t")))
(c-define-type cairo_font_extents_t (struct "cairo_font_extents_t"))
(c-define-type cairo_font_extents_t* (pointer "cairo_font_extents_t"))
(c-define-type cairo_font_extents_t** (pointer (pointer "cairo_font_extents_t")))
(c-define-type cairo_text_extents_t (struct "cairo_text_extents_t"))
(c-define-type cairo_text_extents_t* (pointer "cairo_text_extents_t"))
(c-define-type cairo_text_extents_t** (pointer (pointer "cairo_text_extents_t")))
(c-define-type cairo_svg_version_t "cairo_svg_version_t")
(c-define-type cairo_glyph_t (struct "cairo_glyph_t"))
(c-define-type cairo_glyph_t* (pointer "cairo_glyph_t"))
(c-define-type cairo_glyph_t** (pointer (pointer "cairo_glyph_t")))

;-------------------------------------------------------------------------------
; Functions
;-------------------------------------------------------------------------------

(define cairo_create (c-lambda (cairo_surface_t*) cairo_t* "cairo_create"))
(define cairo_reference (c-lambda (cairo_t*) cairo_t* "cairo_reference"))
(define cairo_destroy (c-lambda (cairo_t*) void "cairo_destroy"))
(define cairo_status (c-lambda (cairo_t*) cairo_status_t "cairo_status"))
(define cairo_save (c-lambda (cairo_t*) void "cairo_save"))
(define cairo_restore (c-lambda (cairo_t*) void "cairo_restore"))
(define cairo_get_target (c-lambda (cairo_t*) cairo_surface_t* "cairo_get_target"))
(define cairo_push_group (c-lambda (cairo_t*) void "cairo_push_group"))
(define cairo_push_group_with_content (c-lambda (cairo_t* cairo_content_t) void "cairo_push_group_with_content"))
(define cairo_pop_group (c-lambda (cairo_t*) cairo_pattern_t* "cairo_pop_group"))
(define cairo_pop_group_to_source (c-lambda (cairo_t*) void "cairo_pop_group_to_source"))
(define cairo_get_group_target (c-lambda (cairo_t*) cairo_surface_t* "cairo_get_group_target"))
(define cairo_set_source_rgb (c-lambda (cairo_t* double double double) void "cairo_set_source_rgb"))
(define cairo_set_source_rgba (c-lambda (cairo_t* double double double double) void "cairo_set_source_rgba"))
(define cairo_set_source (c-lambda (cairo_t* cairo_pattern_t*) void "cairo_set_source"))
(define cairo_set_source_surface (c-lambda (cairo_t* cairo_surface_t* double double) void "cairo_set_source_surface"))
(define cairo_get_source (c-lambda (cairo_t*) cairo_pattern_t* "cairo_get_source"))
(define cairo_set_antialias (c-lambda (cairo_t* cairo_antialias_t) void "cairo_set_antialias"))
(define cairo_get_antialias (c-lambda (cairo_t*) cairo_antialias_t "cairo_get_antialias"))
(define cairo_set_dash (c-lambda (cairo_t* double* int double) void "cairo_set_dash"))
(define cairo_get_dash_count (c-lambda (cairo_t*) int "cairo_get_dash_count"))
(define cairo_get_dash (c-lambda (cairo_t* double* double*) void "cairo_get_dash"))
(define cairo_set_fill_rule (c-lambda (cairo_t* cairo_fill_rule_t) void "cairo_set_fill_rule"))
(define cairo_get_fill_rule (c-lambda (cairo_t*) cairo_fill_rule_t "cairo_get_fill_rule"))
(define cairo_set_line_cap (c-lambda (cairo_t* cairo_line_cap_t) void "cairo_set_line_cap"))
(define cairo_get_line_cap (c-lambda (cairo_t*) cairo_line_cap_t "cairo_get_line_cap"))
(define cairo_set_line_join (c-lambda (cairo_t* cairo_line_join_t) void "cairo_set_line_join"))
(define cairo_get_line_join (c-lambda (cairo_t*) cairo_line_join_t "cairo_get_line_join"))
(define cairo_set_line_width (c-lambda (cairo_t* double) void "cairo_set_line_width"))
(define cairo_get_line_width (c-lambda (cairo_t*) double "cairo_get_line_width"))
(define cairo_set_miter_limit (c-lambda (cairo_t* double) void "cairo_set_miter_limit"))
(define cairo_get_miter_limit (c-lambda (cairo_t*) double "cairo_get_miter_limit"))
(define cairo_set_operator (c-lambda (cairo_t* cairo_operator_t) void "cairo_set_operator"))
(define cairo_get_operator (c-lambda (cairo_t*) cairo_operator_t "cairo_get_operator"))
(define cairo_set_tolerance (c-lambda (cairo_t* double) void "cairo_set_tolerance"))
(define cairo_get_tolerance (c-lambda (cairo_t*) double "cairo_get_tolerance"))
(define cairo_clip (c-lambda (cairo_t*) void "cairo_clip"))
(define cairo_clip_preserve (c-lambda (cairo_t*) void "cairo_clip_preserve"))
(define cairo_clip_extents (c-lambda (cairo_t* double* double* double* double*) void "cairo_clip_extents"))
(define cairo_reset_clip (c-lambda (cairo_t*) void "cairo_reset_clip"))
(define cairo_rectangle_list_destroy (c-lambda (cairo_rectangle_list_t*) void "cairo_rectangle_list_destroy"))
(define cairo_copy_clip_rectangle_list (c-lambda (cairo_t*) cairo_rectangle_list_t* "cairo_copy_clip_rectangle_list"))
(define cairo_fill (c-lambda (cairo_t*) void "cairo_fill"))
(define cairo_fill_preserve (c-lambda (cairo_t*) void "cairo_fill_preserve"))
(define cairo_fill_extents (c-lambda (cairo_t* double* double* double* double*) void "cairo_fill_extents"))
(define cairo_in_fill (c-lambda (cairo_t* double double) cairo_bool_t "cairo_in_fill"))
(define cairo_mask (c-lambda (cairo_t* cairo_pattern_t*) void "cairo_mask"))
(define cairo_mask_surface (c-lambda (cairo_t* cairo_surface_t* double double) void "cairo_mask_surface"))
(define cairo_paint (c-lambda (cairo_t*) void "cairo_paint"))
(define cairo_paint_with_alpha (c-lambda (cairo_t* double) void "cairo_paint_with_alpha"))
(define cairo_stroke (c-lambda (cairo_t*) void "cairo_stroke"))
(define cairo_stroke_preserve (c-lambda (cairo_t*) void "cairo_stroke_preserve"))
(define cairo_stroke_extents (c-lambda (cairo_t* double* double* double* double*) void "cairo_stroke_extents"))
(define cairo_in_stroke (c-lambda (cairo_t* double double) cairo_bool_t "cairo_in_stroke"))
(define cairo_copy_page (c-lambda (cairo_t*) void "cairo_copy_page"))
(define cairo_show_page (c-lambda (cairo_t*) void "cairo_show_page"))
(define cairo_get_reference_count (c-lambda (cairo_t*) int "cairo_get_reference_count"))
(define cairo_set_user_data (c-lambda (cairo_t* cairo_user_data_key_t* void* cairo_destroy_func_t) cairo_status_t "cairo_set_user_data"))
(define cairo_get_user_data (c-lambda (cairo_t* cairo_user_data_key_t*) void* "cairo_get_user_data"))
(define cairo_font_face_reference (c-lambda (cairo_font_face_t*) cairo_font_face_t* "cairo_font_face_reference"))
(define cairo_font_face_destroy (c-lambda (cairo_font_face_t*) void "cairo_font_face_destroy"))
(define cairo_font_face_status (c-lambda (cairo_font_face_t*) cairo_status_t "cairo_font_face_status"))
(define cairo_font_face_get_type (c-lambda (cairo_font_face_t*) cairo_font_type_t "cairo_font_face_get_type"))
(define cairo_font_face_get_reference_count (c-lambda (cairo_font_face_t*) int "cairo_font_face_get_reference_count"))
(define cairo_font_face_set_user_data (c-lambda (cairo_font_face_t* cairo_user_data_key_t* void* cairo_destroy_func_t) cairo_status_t "cairo_font_face_set_user_data"))
(define cairo_font_face_get_user_data (c-lambda (cairo_font_face_t* cairo_user_data_key_t*) void* "cairo_font_face_get_user_data"))
(define cairo_font_options_create (c-lambda () cairo_font_options_t* "cairo_font_options_create"))
(define cairo_font_options_copy (c-lambda (cairo_font_options_t*) cairo_font_options_t* "cairo_font_options_copy"))
(define cairo_font_options_destroy (c-lambda (cairo_font_options_t*) void "cairo_font_options_destroy"))
(define cairo_font_options_status (c-lambda (cairo_font_options_t*) cairo_status_t "cairo_font_options_status"))
(define cairo_font_options_merge (c-lambda (cairo_font_options_t* cairo_font_options_t*) void "cairo_font_options_merge"))
(define cairo_font_options_hash (c-lambda (cairo_font_options_t*) long "cairo_font_options_hash"))
(define cairo_font_options_equal (c-lambda (cairo_font_options_t* cairo_font_options_t*) cairo_bool_t "cairo_font_options_equal"))
(define cairo_font_options_set_antialias (c-lambda (cairo_font_options_t* cairo_antialias_t) void "cairo_font_options_set_antialias"))
(define cairo_font_options_get_antialias (c-lambda (cairo_font_options_t*) cairo_antialias_t "cairo_font_options_get_antialias"))
(define cairo_font_options_set_subpixel_order (c-lambda (cairo_font_options_t* cairo_subpixel_order_t) void "cairo_font_options_set_subpixel_order"))
(define cairo_font_options_get_subpixel_order (c-lambda (cairo_font_options_t*) cairo_subpixel_order_t "cairo_font_options_get_subpixel_order"))
(define cairo_font_options_set_hint_style (c-lambda (cairo_font_options_t* cairo_hint_style_t) void "cairo_font_options_set_hint_style"))
(define cairo_font_options_get_hint_style (c-lambda (cairo_font_options_t*) cairo_hint_style_t "cairo_font_options_get_hint_style"))
(define cairo_font_options_set_hint_metrics (c-lambda (cairo_font_options_t* cairo_hint_metrics_t) void "cairo_font_options_set_hint_metrics"))
(define cairo_font_options_get_hint_metrics (c-lambda (cairo_font_options_t*) cairo_hint_metrics_t "cairo_font_options_get_hint_metrics"))
;(define cairo_ft_font_face_create_for_ft_face (c-lambda (FT-Face int) cairo_font_face_t* "cairo_ft_font_face_create_for_ft_face"))
;(define cairo_ft_font_face_create_for_pattern (c-lambda (FcPattern*) cairo_font_face_t* "cairo_ft_font_face_create_for_pattern"))
;(define cairo_ft_font_options_substitute (c-lambda (cairo_font_options_t* FcPattern*) void "cairo_ft_font_options_substitute"))
;(define cairo_ft_scaled_font_lock_face (c-lambda (cairo_scaled_font_t*) FT-Face "cairo_ft_scaled_font_lock_face"))
;(define cairo_ft_scaled_font_unlock_face (c-lambda (cairo_scaled_font_t*) void "cairo_ft_scaled_font_unlock_face"))
(define cairo_format_stride_for_width (c-lambda (cairo_format_t int) int "cairo_format_stride_for_width"))
(define cairo_image_surface_create (c-lambda (cairo_format_t int int) cairo_surface_t* "cairo_image_surface_create"))
(define cairo_image_surface_create_for_data (c-lambda (unsigned-char* cairo_format_t int int int) cairo_surface_t* "cairo_image_surface_create_for_data"))
(define cairo_image_surface_get_data (c-lambda (cairo_surface_t*) unsigned-char* "cairo_image_surface_get_data"))
(define cairo_image_surface_get_format (c-lambda (cairo_surface_t*) cairo_format_t "cairo_image_surface_get_format"))
(define cairo_image_surface_get_width (c-lambda (cairo_surface_t*) int "cairo_image_surface_get_width"))
(define cairo_image_surface_get_height (c-lambda (cairo_surface_t*) int "cairo_image_surface_get_height"))
(define cairo_image_surface_get_stride (c-lambda (cairo_surface_t*) int "cairo_image_surface_get_stride"))
(define cairo_matrix_init (c-lambda (cairo_matrix_t* double double double double double double) void "cairo_matrix_init"))
(define cairo_matrix_init_identity (c-lambda (cairo_matrix_t*) void "cairo_matrix_init_identity"))
(define cairo_matrix_init_translate (c-lambda (cairo_matrix_t* double double) void "cairo_matrix_init_translate"))
(define cairo_matrix_init_scale (c-lambda (cairo_matrix_t* double double) void "cairo_matrix_init_scale"))
(define cairo_matrix_init_rotate (c-lambda (cairo_matrix_t* double) void "cairo_matrix_init_rotate"))
(define cairo_matrix_translate (c-lambda (cairo_matrix_t* double double) void "cairo_matrix_translate"))
(define cairo_matrix_scale (c-lambda (cairo_matrix_t* double double) void "cairo_matrix_scale"))
(define cairo_matrix_rotate (c-lambda (cairo_matrix_t* double) void "cairo_matrix_rotate"))
(define cairo_matrix_invert (c-lambda (cairo_matrix_t*) cairo_status_t "cairo_matrix_invert"))
(define cairo_matrix_multiply (c-lambda (cairo_matrix_t* cairo_matrix_t* cairo_matrix_t*) void "cairo_matrix_multiply"))
(define cairo_matrix_transform_distance (c-lambda (cairo_matrix_t* double* double*) void "cairo_matrix_transform_distance"))
(define cairo_matrix_transform_point (c-lambda (cairo_matrix_t* double* double*) void "cairo_matrix_transform_point"))
(define cairo_copy_path (c-lambda (cairo_t*) cairo_path_t* "cairo_copy_path"))
(define cairo_copy_path_flat (c-lambda (cairo_t*) cairo_path_t* "cairo_copy_path_flat"))
(define cairo_path_destroy (c-lambda (cairo_path_t*) void "cairo_path_destroy"))
(define cairo_append_path (c-lambda (cairo_t* cairo_path_t*) void "cairo_append_path"))
(define cairo_get_current_point (c-lambda (cairo_t* double* double*) void "cairo_get_current_point"))
(define cairo_new_path (c-lambda (cairo_t*) void "cairo_new_path"))
(define cairo_new_sub_path (c-lambda (cairo_t*) void "cairo_new_sub_path"))
(define cairo_close_path (c-lambda (cairo_t*) void "cairo_close_path"))
(define cairo_arc (c-lambda (cairo_t* double double double double double) void "cairo_arc"))
(define cairo_arc_negative (c-lambda (cairo_t* double double double double double) void "cairo_arc_negative"))
(define cairo_curve_to (c-lambda (cairo_t* double double double double double double) void "cairo_curve_to"))
(define cairo_line_to (c-lambda (cairo_t* double double) void "cairo_line_to"))
(define cairo_move_to (c-lambda (cairo_t* double double) void "cairo_move_to"))
(define cairo_rectangle (c-lambda (cairo_t* double double double double) void "cairo_rectangle"))
(define cairo_glyph_path (c-lambda (cairo_t* cairo_glyph_t* int) void "cairo_glyph_path"))
(define cairo_text_path (c-lambda (cairo_t* char-string) void "cairo_text_path"))
(define cairo_rel_curve_to (c-lambda (cairo_t* double double double double double double) void "cairo_rel_curve_to"))
(define cairo_rel_line_to (c-lambda (cairo_t* double double) void "cairo_rel_line_to"))
(define cairo_rel_move_to (c-lambda (cairo_t* double double) void "cairo_rel_move_to"))
(define cairo_pattern_add_color_stop_rgb (c-lambda (cairo_pattern_t* double double double double) void "cairo_pattern_add_color_stop_rgb"))
(define cairo_pattern_add_color_stop_rgba (c-lambda (cairo_pattern_t* double double double double double) void "cairo_pattern_add_color_stop_rgba"))
(define cairo_pattern_get_color_stop_count (c-lambda (cairo_pattern_t* int*) cairo_status_t "cairo_pattern_get_color_stop_count"))
(define cairo_pattern_get_color_stop_rgba (c-lambda (cairo_pattern_t* int double* double* double* double* double*) cairo_status_t "cairo_pattern_get_color_stop_rgba"))
(define cairo_pattern_create_rgb (c-lambda (double double double) cairo_pattern_t* "cairo_pattern_create_rgb"))
(define cairo_pattern_create_rgba (c-lambda (double double double double) cairo_pattern_t* "cairo_pattern_create_rgba"))
(define cairo_pattern_get_rgba (c-lambda (cairo_pattern_t* double* double* double* double*) cairo_status_t "cairo_pattern_get_rgba"))
(define cairo_pattern_create_for_surface (c-lambda (cairo_surface_t*) cairo_pattern_t* "cairo_pattern_create_for_surface"))
(define cairo_pattern_get_surface (c-lambda (cairo_pattern_t* cairo_surface_t**) cairo_status_t "cairo_pattern_get_surface"))
(define cairo_pattern_create_linear (c-lambda (double double double double) cairo_pattern_t* "cairo_pattern_create_linear"))
(define cairo_pattern_get_linear_points (c-lambda (cairo_pattern_t* double* double* double* double*) cairo_status_t "cairo_pattern_get_linear_points"))
(define cairo_pattern_create_radial (c-lambda (double double double double double double) cairo_pattern_t* "cairo_pattern_create_radial"))
(define cairo_pattern_get_radial_circles (c-lambda (cairo_pattern_t* double* double* double* double* double* double*) cairo_status_t "cairo_pattern_get_radial_circles"))
(define cairo_pattern_reference (c-lambda (cairo_pattern_t*) cairo_pattern_t* "cairo_pattern_reference"))
(define cairo_pattern_destroy (c-lambda (cairo_pattern_t*) void "cairo_pattern_destroy"))
(define cairo_pattern_status (c-lambda (cairo_pattern_t*) cairo_status_t "cairo_pattern_status"))
(define cairo_pattern_set_extend (c-lambda (cairo_pattern_t* cairo_extend_t) void "cairo_pattern_set_extend"))
(define cairo_pattern_get_extend (c-lambda (cairo_pattern_t*) cairo_extend_t "cairo_pattern_get_extend"))
(define cairo_pattern_set_filter (c-lambda (cairo_pattern_t* cairo_filter_t) void "cairo_pattern_set_filter"))
(define cairo_pattern_get_filter (c-lambda (cairo_pattern_t*) cairo_filter_t "cairo_pattern_get_filter"))
(define cairo_pattern_set_matrix (c-lambda (cairo_pattern_t* cairo_matrix_t*) void "cairo_pattern_set_matrix"))
(define cairo_pattern_get_matrix (c-lambda (cairo_pattern_t* cairo_matrix_t*) void "cairo_pattern_get_matrix"))
(define cairo_pattern_get_type (c-lambda (cairo_pattern_t*) cairo_pattern_type_t "cairo_pattern_get_type"))
(define cairo_pattern_get_reference_count (c-lambda (cairo_pattern_t*) int "cairo_pattern_get_reference_count"))
(define cairo_pattern_set_user_data (c-lambda (cairo_pattern_t* cairo_user_data_key_t* void* cairo_destroy_func_t) cairo_status_t "cairo_pattern_set_user_data"))
(define cairo_pattern_get_user_data (c-lambda (cairo_pattern_t* cairo_user_data_key_t*) void* "cairo_pattern_get_user_data"))
;(define cairo_pdf_surface_create (c-lambda (char-string double double) cairo_surface_t* "cairo_pdf_surface_create"))
;(define cairo_pdf_surface_create_for_stream (c-lambda (cairo_write_func_t void* double double) cairo_surface_t* "cairo_pdf_surface_create_for_stream"))
;(define cairo_pdf_surface_set_size (c-lambda (cairo_surface_t* double double) void "cairo_pdf_surface_set_size"))
;(define cairo_image_surface_create_from_png (c-lambda (char-string) cairo_surface_t* "cairo_image_surface_create_from_png"))
;(define |(*cairo_read_func_t)| (c-lambda (void* unsigned-char* unsigned-int) cairo_status_t "(*cairo_read_func_t)"))
;(define cairo_image_surface_create_from_png_stream (c-lambda (cairo_read_func_t void*) cairo_surface_t* "cairo_image_surface_create_from_png_stream"))
;(define cairo_surface_write_to_png (c-lambda (cairo_surface_t* char-string) cairo_status_t "cairo_surface_write_to_png"))
;(define |(*cairo_write_func_t)| (c-lambda (void* unsigned-char* unsigned-int) cairo_status_t "(*cairo_write_func_t)"))
;(define cairo_surface_write_to_png_stream (c-lambda (cairo_surface_t* cairo_write_func_t void*) cairo_status_t "cairo_surface_write_to_png_stream"))
;(define cairo_ps_surface_create (c-lambda (char-string double double) cairo_surface_t* "cairo_ps_surface_create"))
;(define cairo_ps_surface_create_for_stream (c-lambda (cairo_write_func_t void* double double) cairo_surface_t* "cairo_ps_surface_create_for_stream"))
;(define cairo_ps_surface_set_size (c-lambda (cairo_surface_t* double double) void "cairo_ps_surface_set_size"))
;(define cairo_ps_surface_dsc_begin_setup (c-lambda (cairo_surface_t*) void "cairo_ps_surface_dsc_begin_setup"))
;(define cairo_ps_surface_dsc_begin_page_setup (c-lambda (cairo_surface_t*) void "cairo_ps_surface_dsc_begin_page_setup"))
;(define cairo_ps_surface_dsc_comment (c-lambda (cairo_surface_t* char-string) void "cairo_ps_surface_dsc_comment"))
(define cairo_scaled_font_create (c-lambda (cairo_font_face_t* cairo_matrix_t* cairo_matrix_t* cairo_font_options_t*) cairo_scaled_font_t* "cairo_scaled_font_create"))
(define cairo_scaled_font_reference (c-lambda (cairo_scaled_font_t*) cairo_scaled_font_t* "cairo_scaled_font_reference"))
(define cairo_scaled_font_destroy (c-lambda (cairo_scaled_font_t*) void "cairo_scaled_font_destroy"))
(define cairo_scaled_font_status (c-lambda (cairo_scaled_font_t*) cairo_status_t "cairo_scaled_font_status"))
(define cairo_scaled_font_extents (c-lambda (cairo_scaled_font_t* cairo_font_extents_t*) void "cairo_scaled_font_extents"))
(define cairo_scaled_font_text_extents (c-lambda (cairo_scaled_font_t* char-string cairo_text_extents_t*) void "cairo_scaled_font_text_extents"))
(define cairo_scaled_font_glyph_extents (c-lambda (cairo_scaled_font_t* cairo_glyph_t* int cairo_text_extents_t*) void "cairo_scaled_font_glyph_extents"))
(define cairo_scaled_font_get_font_face (c-lambda (cairo_scaled_font_t*) cairo_font_face_t* "cairo_scaled_font_get_font_face"))
(define cairo_scaled_font_get_font_options (c-lambda (cairo_scaled_font_t* cairo_font_options_t*) void "cairo_scaled_font_get_font_options"))
(define cairo_scaled_font_get_font_matrix (c-lambda (cairo_scaled_font_t* cairo_matrix_t*) void "cairo_scaled_font_get_font_matrix"))
(define cairo_scaled_font_get_ctm (c-lambda (cairo_scaled_font_t* cairo_matrix_t*) void "cairo_scaled_font_get_ctm"))
(define cairo_scaled_font_get_type (c-lambda (cairo_scaled_font_t*) cairo_font_type_t "cairo_scaled_font_get_type"))
(define cairo_scaled_font_get_reference_count (c-lambda (cairo_scaled_font_t*) int "cairo_scaled_font_get_reference_count"))
(define cairo_scaled_font_set_user_data (c-lambda (cairo_scaled_font_t* cairo_user_data_key_t* void* cairo_destroy_func_t) cairo_status_t "cairo_scaled_font_set_user_data"))
(define cairo_scaled_font_get_user_data (c-lambda (cairo_scaled_font_t* cairo_user_data_key_t*) void* "cairo_scaled_font_get_user_data"))
(define cairo_surface_create_similar (c-lambda (cairo_surface_t* cairo_content_t int int) cairo_surface_t* "cairo_surface_create_similar"))
(define cairo_surface_reference (c-lambda (cairo_surface_t*) cairo_surface_t* "cairo_surface_reference"))
(define cairo_surface_destroy (c-lambda (cairo_surface_t*) void "cairo_surface_destroy"))
(define cairo_surface_status (c-lambda (cairo_surface_t*) cairo_status_t "cairo_surface_status"))
(define cairo_surface_finish (c-lambda (cairo_surface_t*) void "cairo_surface_finish"))
(define cairo_surface_flush (c-lambda (cairo_surface_t*) void "cairo_surface_flush"))
(define cairo_surface_get_font_options (c-lambda (cairo_surface_t* cairo_font_options_t*) void "cairo_surface_get_font_options"))
(define cairo_surface_get_content (c-lambda (cairo_surface_t*) cairo_content_t "cairo_surface_get_content"))
(define cairo_surface_mark_dirty (c-lambda (cairo_surface_t*) void "cairo_surface_mark_dirty"))
(define cairo_surface_mark_dirty_rectangle (c-lambda (cairo_surface_t* int int int int) void "cairo_surface_mark_dirty_rectangle"))
(define cairo_surface_set_device_offset (c-lambda (cairo_surface_t* double double) void "cairo_surface_set_device_offset"))
(define cairo_surface_get_device_offset (c-lambda (cairo_surface_t* double* double*) void "cairo_surface_get_device_offset"))
(define cairo_surface_set_fallback_resolution (c-lambda (cairo_surface_t* double double) void "cairo_surface_set_fallback_resolution"))
(define cairo_surface_get_type (c-lambda (cairo_surface_t*) cairo_surface_type_t "cairo_surface_get_type"))
(define cairo_surface_get_reference_count (c-lambda (cairo_surface_t*) int "cairo_surface_get_reference_count"))
(define cairo_surface_set_user_data (c-lambda (cairo_surface_t* cairo_user_data_key_t* void* cairo_destroy_func_t) cairo_status_t "cairo_surface_set_user_data"))
(define cairo_surface_get_user_data (c-lambda (cairo_surface_t* cairo_user_data_key_t*) void* "cairo_surface_get_user_data"))
;(define cairo_svg_surface_create (c-lambda (char-string double double) cairo_surface_t* "cairo_svg_surface_create"))
;(define cairo_svg_surface_create_for_stream (c-lambda (cairo_write_func_t void* double double) cairo_surface_t* "cairo_svg_surface_create_for_stream"))
;(define cairo_svg_surface_restrict_to_version (c-lambda (cairo_surface_t* cairo_svg_version_t) void "cairo_svg_surface_restrict_to_version"))
;(define cairo_svg_get_versions (c-lambda (cairo_svg_version_t** int*) void "cairo_svg_get_versions"))
;(define cairo_svg_version_to_string (c-lambda (cairo_svg_version_t) char-string "cairo_svg_version_to_string"))

(cond-expand
 (desktop
  (define cairo_select_font_face (c-lambda (cairo_t* char-string cairo_font_slant_t cairo_font_weight_t) void "cairo_select_font_face"))
  (define cairo_set_font_size (c-lambda (cairo_t* double) void "cairo_set_font_size"))
  (define cairo_set_font_matrix (c-lambda (cairo_t* cairo_matrix_t*) void "cairo_set_font_matrix"))
  (define cairo_get_font_matrix (c-lambda (cairo_t* cairo_matrix_t*) void "cairo_get_font_matrix"))
  (define cairo_set_font_options (c-lambda (cairo_t* cairo_font_options_t*) void "cairo_set_font_options"))
  (define cairo_get_font_options (c-lambda (cairo_t* cairo_font_options_t*) void "cairo_get_font_options"))
  (define cairo_set_font_face (c-lambda (cairo_t* cairo_font_face_t*) void "cairo_set_font_face"))
  (define cairo_get_font_face (c-lambda (cairo_t*) cairo_font_face_t* "cairo_get_font_face"))
  (define cairo_set_scaled_font (c-lambda (cairo_t* cairo_scaled_font_t*) void "cairo_set_scaled_font"))
  (define cairo_get_scaled_font (c-lambda (cairo_t*) cairo_scaled_font_t* "cairo_get_scaled_font"))
  (define cairo_show_text (c-lambda (cairo_t* char-string) void "cairo_show_text"))
  (define cairo_show_glyphs (c-lambda (cairo_t* cairo_glyph_t* int) void "cairo_show_glyphs"))
  (define cairo_font_extents (c-lambda (cairo_t* cairo_font_extents_t*) void "cairo_font_extents"))
  (define cairo_text_extents (c-lambda (cairo_t* char-string cairo_text_extents_t*) void "cairo_text_extents"))
  (define cairo_glyph_extents (c-lambda (cairo_t* cairo_glyph_t* int cairo_text_extents_t*) void "cairo_glyph_extents")))
 (else))

(define cairo_translate (c-lambda (cairo_t* double double) void "cairo_translate"))
(define cairo_scale (c-lambda (cairo_t* double double) void "cairo_scale"))
(define cairo_rotate (c-lambda (cairo_t* double) void "cairo_rotate"))
(define cairo_transform (c-lambda (cairo_t* cairo_matrix_t*) void "cairo_transform"))
(define cairo_set_matrix (c-lambda (cairo_t* cairo_matrix_t*) void "cairo_set_matrix"))
(define cairo_get_matrix (c-lambda (cairo_t* cairo_matrix_t*) void "cairo_get_matrix"))
(define cairo_identity_matrix (c-lambda (cairo_t*) void "cairo_identity_matrix"))
(define cairo_user_to_device (c-lambda (cairo_t* double* double*) void "cairo_user_to_device"))
(define cairo_user_to_device_distance (c-lambda (cairo_t* double* double*) void "cairo_user_to_device_distance"))
(define cairo_device_to_user (c-lambda (cairo_t* double* double*) void "cairo_device_to_user"))
(define cairo_device_to_user_distance (c-lambda (cairo_t* double* double*) void "cairo_device_to_user_distance"))

(cond-expand
 (desktop
  (define cairo_xlib_surface_create (c-lambda (Display* Drawable Visual* int int) cairo_surface_t* "cairo_xlib_surface_create"))
  (define cairo_xlib_surface_create_for_bitmap (c-lambda (Display* Pixmap Screen* int int) cairo_surface_t* "cairo_xlib_surface_create_for_bitmap"))
  (define cairo_xlib_surface_set_size (c-lambda (cairo_surface_t* int int) void "cairo_xlib_surface_set_size"))
  (define cairo_xlib_surface_get_display (c-lambda (cairo_surface_t*) Display* "cairo_xlib_surface_get_display"))
  (define cairo_xlib_surface_get_screen (c-lambda (cairo_surface_t*) Screen* "cairo_xlib_surface_get_screen"))
  (define cairo_xlib_surface_set_drawable (c-lambda (cairo_surface_t* Drawable int int) void "cairo_xlib_surface_set_drawable"))
  (define cairo_xlib_surface_get_drawable (c-lambda (cairo_surface_t*) Drawable "cairo_xlib_surface_get_drawable"))
  (define cairo_xlib_surface_get_visual (c-lambda (cairo_surface_t*) Visual* "cairo_xlib_surface_get_visual"))
  (define cairo_xlib_surface_get_width (c-lambda (cairo_surface_t*) int "cairo_xlib_surface_get_width"))
  (define cairo_xlib_surface_get_height (c-lambda (cairo_surface_t*) int "cairo_xlib_surface_get_height"))
  (define cairo_xlib_surface_get_depth (c-lambda (cairo_surface_t*) int "cairo_xlib_surface_get_depth")))
 (else))
