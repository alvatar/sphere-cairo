;;; Copyright (c) 2012, Alvaro Castro-Castilla. All rights reserved.
;;; Cairo library bindings for Scheme

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------

(c-declare "#include <cairo.h>")

(cond-expand
  (cairo-pdf (c-declare "#include <cairo-pdf.h>"))
  (else))
(cond-expand
  (cairo-ps (c-declare "#include <cairo-ps.h>"))
  (else))
(cond-expand
  (cairo-script (c-declare "#include <cairo-script.h>"))
  (else))
(cond-expand
  (cairo-svg (c-declare "#include <cairo-svg.h>"))
  (else))

(c-declare #<<end-of-string
struct cairo_font_extents_t {
    double ascent;
    double descent;
    double height;
    double max_x_advance;
    double max_y_advance;
};

struct cairo_glyph_t {
    unsigned long        index;
    double               x;
    double               y;
};

struct cairo_matrix_t {
    double xx;
    double yx;
    double xy;
    double yy;
    double x0;
    double y0;
};

struct cairo_text_cluster_t {
    int        num_bytes;
    int        num_glyphs;
};

struct cairo_text_extents_t {
    double x_bearing;
    double y_bearing;
    double width;
    double height;
    double x_advance;
    double y_advance;
};

end-of-string
)

;; (cond-expand
;;  (desktop
;;   (c-declare "#include <cairo-ft.h>")
;;   (c-declare "#include <cairo-xlib.h>")
;;   (c-declare "#include <X11/Xlib.h>")
;;   (c-declare "#include <fontconfig/fontconfig.h>")
;;   (c-declare "#include <ft2build.h>")
;;   (c-declare "#include FT_FREETYPE_H"))
;;  (else))

;-------------------------------------------------------------------------------
; Defines
;-------------------------------------------------------------------------------

;; CAIRO_HAS_FC_FONT, CAIRO_HAS_FC_FONT
;; CAIRO_HAS_FT_FONT, CAIRO_HAS_FT_FONT
;; CAIRO_HAS_IMAGE_SURFACE, CAIRO_HAS_IMAGE_SURFACE
;; CAIRO_HAS_MIME_SURFACE, CAIRO_HAS_MIME_SURFACE
;; CAIRO_HAS_PDF_SURFACE, CAIRO_HAS_PDF_SURFACE
;; CAIRO_HAS_PNG_FUNCTIONS, CAIRO_HAS_PNG_FUNCTIONS
;; CAIRO_HAS_PS_SURFACE, CAIRO_HAS_PS_SURFACE
;; CAIRO_HAS_QUARTZ_FONT, CAIRO_HAS_QUARTZ_FONT
;; CAIRO_HAS_QUARTZ_SURFACE, CAIRO_HAS_QUARTZ_SURFACE
;; CAIRO_HAS_RECORDING_SURFACE, CAIRO_HAS_RECORDING_SURFACE
;; CAIRO_HAS_SCRIPT_SURFACE, CAIRO_HAS_SCRIPT_SURFACE
;; CAIRO_HAS_SVG_SURFACE, CAIRO_HAS_SVG_SURFACE
;; CAIRO_HAS_USER_FONT, CAIRO_HAS_USER_FONT
;; CAIRO_HAS_WIN32_FONT, CAIRO_HAS_WIN32_FONT
;; CAIRO_HAS_WIN32_SURFACE, CAIRO_HAS_WIN32_SURFACE
;; CAIRO_HAS_XCB_SHM_FUNCTIONS, CAIRO_HAS_XCB_SHM_FUNCTIONS
;; CAIRO_HAS_XCB_SURFACE, CAIRO_HAS_XCB_SURFACE
;; CAIRO_HAS_XLIB_SURFACE, CAIRO_HAS_XLIB_SURFACE
;; CAIRO_HAS_XLIB_XRENDER_SURFACE, CAIRO_HAS_XLIB_XRENDER_SURFACE
;; CAIRO_MIME_TYPE_JP2, CAIRO_MIME_TYPE_JP2
;; CAIRO_MIME_TYPE_JPEG, CAIRO_MIME_TYPE_JPEG
;; CAIRO_MIME_TYPE_PNG, CAIRO_MIME_TYPE_PNG
;; CAIRO_MIME_TYPE_UNIQUE_ID, CAIRO_MIME_TYPE_UNIQUE_ID
;; CAIRO_MIME_TYPE_URI, CAIRO_MIME_TYPE_URI

;-------------------------------------------------------------------------------
; Enums
;-------------------------------------------------------------------------------


  (c-define-type cairo_content_t unsigned-int)
  (c-define-constants
   CAIRO_CONTENT_COLOR
   CAIRO_CONTENT_ALPHA
   CAIRO_CONTENT_COLOR_ALPHA)

  (c-define-type cairo_device_type_t unsigned-int)
  (c-define-constants
   CAIRO_DEVICE_TYPE_DRM
   CAIRO_DEVICE_TYPE_GL
   CAIRO_DEVICE_TYPE_SCRIPT
   CAIRO_DEVICE_TYPE_XCB
   CAIRO_DEVICE_TYPE_XLIB
   CAIRO_DEVICE_TYPE_XML
   CAIRO_DEVICE_TYPE_COGL
   CAIRO_DEVICE_TYPE_WIN32
   CAIRO_DEVICE_TYPE_INVALID)

  (c-define-type cairo_extend_t unsigned-int)
  (c-define-constants
   CAIRO_EXTEND_NONE
   CAIRO_EXTEND_REPEAT
   CAIRO_EXTEND_REFLECT
   CAIRO_EXTEND_PAD)

  (c-define-type cairo_fill_rule_t unsigned-int)
  (c-define-constants
   CAIRO_FILL_RULE_WINDING
   CAIRO_FILL_RULE_EVEN_ODD)

  (c-define-type cairo_filter_t unsigned-int)
  (c-define-constants
   CAIRO_FILTER_FAST
   CAIRO_FILTER_GOOD
   CAIRO_FILTER_BEST
   CAIRO_FILTER_NEAREST
   CAIRO_FILTER_BILINEAR
   CAIRO_FILTER_GAUSSIAN)

  (c-define-type cairo_font_slant_t unsigned-int)
  (c-define-constants
   CAIRO_FONT_SLANT_NORMAL
   CAIRO_FONT_SLANT_ITALIC
   CAIRO_FONT_SLANT_OBLIQUE)

  (c-define-type cairo_font_type_t unsigned-int)
  (c-define-constants
   CAIRO_FONT_TYPE_TOY
   CAIRO_FONT_TYPE_FT
   CAIRO_FONT_TYPE_WIN32
   CAIRO_FONT_TYPE_QUARTZ
   CAIRO_FONT_TYPE_USER)

  (c-define-type cairo_font_weight_t unsigned-int)
  (c-define-constants
   CAIRO_FONT_WEIGHT_NORMAL
   CAIRO_FONT_WEIGHT_BOLD)

  (c-define-type cairo_format_t unsigned-int)
  (c-define-constants
   CAIRO_FORMAT_INVALID
   CAIRO_FORMAT_ARGB32
   CAIRO_FORMAT_RGB24
   CAIRO_FORMAT_A8
   CAIRO_FORMAT_A1
   CAIRO_FORMAT_RGB16_565
   CAIRO_FORMAT_RGB30)

  ;; (c-define-type cairo_ft_synthesize_t unsigned-int)
  ;; (c-define-constants
  ;;  CAIRO_FT_SYNTHESIZE_BOLD
  ;;  CAIRO_FT_SYNTHESIZE_OBLIQUE)

  (c-define-type cairo_hint_metrics_t unsigned-int)
  (c-define-constants
   CAIRO_HINT_METRICS_DEFAULT
   CAIRO_HINT_METRICS_OFF
   CAIRO_HINT_METRICS_ON)

  (c-define-type cairo_hint_style_t unsigned-int)
  (c-define-constants
   CAIRO_HINT_STYLE_DEFAULT
   CAIRO_HINT_STYLE_NONE
   CAIRO_HINT_STYLE_SLIGHT
   CAIRO_HINT_STYLE_MEDIUM
   CAIRO_HINT_STYLE_FULL)

  (c-define-type cairo_line_cap_t unsigned-int)
  (c-define-constants
   CAIRO_LINE_CAP_BUTT
   CAIRO_LINE_CAP_ROUND
   CAIRO_LINE_CAP_SQUARE)

  (c-define-type cairo_line_join_t unsigned-int)
  (c-define-constants
   CAIRO_LINE_JOIN_MITER
   CAIRO_LINE_JOIN_ROUND
   CAIRO_LINE_JOIN_BEVEL)

  (c-define-type cairo_operator_t unsigned-int)
  (c-define-constants
   CAIRO_OPERATOR_CLEAR
   CAIRO_OPERATOR_SOURCE
   CAIRO_OPERATOR_OVER
   CAIRO_OPERATOR_IN
   CAIRO_OPERATOR_OUT
   CAIRO_OPERATOR_ATOP
   CAIRO_OPERATOR_DEST
   CAIRO_OPERATOR_DEST_OVER
   CAIRO_OPERATOR_DEST_IN
   CAIRO_OPERATOR_DEST_OUT
   CAIRO_OPERATOR_DEST_ATOP
   CAIRO_OPERATOR_XOR
   CAIRO_OPERATOR_ADD
   CAIRO_OPERATOR_SATURATE
   CAIRO_OPERATOR_MULTIPLY
   CAIRO_OPERATOR_SCREEN
   CAIRO_OPERATOR_OVERLAY
   CAIRO_OPERATOR_DARKEN
   CAIRO_OPERATOR_LIGHTEN
   CAIRO_OPERATOR_COLOR_DODGE
   CAIRO_OPERATOR_COLOR_BURN
   CAIRO_OPERATOR_HARD_LIGHT
   CAIRO_OPERATOR_SOFT_LIGHT
   CAIRO_OPERATOR_DIFFERENCE
   CAIRO_OPERATOR_EXCLUSION
   CAIRO_OPERATOR_HSL_HUE
   CAIRO_OPERATOR_HSL_SATURATION
   CAIRO_OPERATOR_HSL_COLOR
   CAIRO_OPERATOR_HSL_LUMINOSITY)
  
  (c-define-type cairo_path_data_type_t unsigned-int)
  (c-define-constants
   CAIRO_PATH_MOVE_TO
   CAIRO_PATH_LINE_TO
   CAIRO_PATH_CURVE_TO
   CAIRO_PATH_CLOSE_PATH)

  (c-define-type cairo_pattern_type_t unsigned-int)
  (c-define-constants
   CAIRO_PATTERN_TYPE_SOLID
   CAIRO_PATTERN_TYPE_SURFACE
   CAIRO_PATTERN_TYPE_LINEAR
   CAIRO_PATTERN_TYPE_RADIAL
   CAIRO_PATTERN_TYPE_MESH
   CAIRO_PATTERN_TYPE_RASTER_SOURCE)

  (cond-expand
   (cairo-pdf
    (c-define-type cairo_pdf_version_t unsigned-int)
    (c-define-type cairo_pdf_version_t* (pointer cairo_pdf_version_t))
    (c-define-type cairo_pdf_version_t** (pointer cairo_pdf_version_t*))
    (c-define-constants
     CAIRO_PDF_VERSION_1_4
     CAIRO_PDF_VERSION_1_5))
   (else))

  (cond-expand
   (cairo-ps
    (c-define-type cairo_ps_level_t unsigned-int)
    (c-define-type cairo_ps_level_t* (pointer cairo_ps_level_t))
    (c-define-type cairo_ps_level_t** (pointer cairo_ps_level_t*))
    (c-define-constants
     CAIRO_PS_LEVEL_2
     CAIRO_PS_LEVEL_3))
   (else))

  (c-define-type cairo_region_overlap_t unsigned-int)
  (c-define-constants
   CAIRO_REGION_OVERLAP_IN
   CAIRO_REGION_OVERLAP_OUT
   CAIRO_REGION_OVERLAP_PART)

  (cond-expand
   (cairo-script
    (c-define-type cairo_script_mode_t unsigned-int)
    (c-define-constants
     CAIRO_SCRIPT_MODE_ASCII
     CAIRO_SCRIPT_MODE_BINARY))
   (else))
  
  (c-define-type cairo_status_t unsigned-int)
  (c-define-type cairo_status_t*  (pointer cairo_status_t))
  (c-define-type cairo_status_t** (pointer cairo_status_t*))
  (c-define-constants
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
   CAIRO_STATUS_INVALID_MESH_CONSTRUCTION
   CAIRO_STATUS_DEVICE_FINISHED
   CAIRO_STATUS_LAST_STATUS)

  (c-define-type cairo_subpixel_order_t unsigned-int)
  (c-define-constants
   CAIRO_SUBPIXEL_ORDER_DEFAULT
   CAIRO_SUBPIXEL_ORDER_RGB
   CAIRO_SUBPIXEL_ORDER_BGR
   CAIRO_SUBPIXEL_ORDER_VRGB
   CAIRO_SUBPIXEL_ORDER_VBGR)

  (c-define-type cairo_surface_type_t unsigned-int)
  (c-define-constants
   CAIRO_SURFACE_TYPE_IMAGE
   CAIRO_SURFACE_TYPE_PDF
   CAIRO_SURFACE_TYPE_PS
   CAIRO_SURFACE_TYPE_XLIB
   CAIRO_SURFACE_TYPE_XCB
   CAIRO_SURFACE_TYPE_GLITZ
   CAIRO_SURFACE_TYPE_QUARTZ
   CAIRO_SURFACE_TYPE_WIN32
   CAIRO_SURFACE_TYPE_BEOS
   CAIRO_SURFACE_TYPE_DIRECTFB
   CAIRO_SURFACE_TYPE_SVG
   CAIRO_SURFACE_TYPE_OS2
   CAIRO_SURFACE_TYPE_WIN32_PRINTING
   CAIRO_SURFACE_TYPE_QUARTZ_IMAGE
   CAIRO_SURFACE_TYPE_SCRIPT
   CAIRO_SURFACE_TYPE_QT
   CAIRO_SURFACE_TYPE_RECORDING
   CAIRO_SURFACE_TYPE_VG
   CAIRO_SURFACE_TYPE_GL
   CAIRO_SURFACE_TYPE_DRM
   CAIRO_SURFACE_TYPE_TEE
   CAIRO_SURFACE_TYPE_XML
   CAIRO_SURFACE_TYPE_SKIA
   CAIRO_SURFACE_TYPE_SUBSURFACE
   CAIRO_SURFACE_TYPE_COGL)

  (cond-expand
   (cairo-svg
    (c-define-type cairo_svg_version_t unsigned-int)
    (c-define-type cairo_svg_version_t* (pointer cairo_svg_version_t))
    (c-define-type cairo_svg_version_t** (pointer cairo_svg_version_t*))
    (c-define-constants
     CAIRO_SVG_VERSION_1_1
     CAIRO_SVG_VERSION_1_2))
   (else))

  (c-define-type cairo_text_cluster_flags_t unsigned-int)
  (c-define-type cairo_text_cluster_flags_t* (pointer cairo_text_cluster_flags_t))
  (c-define-type cairo_text_cluster_flags_t** (pointer cairo_text_cluster_flags_t*))
  (c-define-constants
   CAIRO_TEXT_CLUSTER_FLAG_BACKWARD)



;-------------------------------------------------------------------------------
; Types
;-------------------------------------------------------------------------------

(c-define-constants
    CAIRO_ANTIALIAS_DEFAULT
    CAIRO_ANTIALIAS_NONE
    CAIRO_ANTIALIAS_GRAY
    CAIRO_ANTIALIAS_SUBPIXEL
    CAIRO_ANTIALIAS_FAST
    CAIRO_ANTIALIAS_GOOD
    CAIRO_ANTIALIAS_BEST)

  (c-define-type cairo_antialias_t "cairo_antialias_t")
  (c-define-type cairo_bool_t (type "cairo_bool_t"))
  (c-define-type cairo_device_t "cairo_device_t")
  (c-define-type cairo_device_t* (pointer cairo_device_t))


  (c-define-type* (struct cairo_font_extents_t))
  (c-define-struct cairo_font_extents_t
                   (ascent double)
                   (descent double)
                   (height double)
                   (max_x_advance double)
                   (max_y_advance double))

  (c-define-type cairo_font_face_t "cairo_font_face_t")
  (c-define-type cairo_font_face_t* (pointer cairo_font_face_t))
  (c-define-type cairo_font_face_t** (pointer cairo_font_face_t*))
  (c-define-type cairo_font_options_t (struct "cairo_font_options_t"))
  (c-define-type cairo_font_options_t* (pointer cairo_font_options_t))
  (c-define-type cairo_font_options_t** (pointer cairo_font_options_t*))

  (c-define-type* (struct cairo_glyph_t))
  (c-define-struct cairo_glyph_t
                   (index unsigned-long)
                   (x double)
                   (y double))
  (c-define-type cairo_glyph_t** (pointer cairo_glyph_t*))

  (c-define-type* (struct cairo_matrix_t))
  (c-define-struct cairo_matrix_t
                   (xx double)
                   (yx double)
                   (xy double)
                   (yy double)
                   (x0 double)
                   (y0 double))
  (c-define-type cairo_matrix_t** (pointer cairo_matrix_t*))

  ;; TODO: Access to cairo_path_data_t
  ;; (c-declare "
  ;; typedef struct {
  ;;   cairo_path_data_type_t type;
  ;;   int length;
  ;; } ___scheme_cairo_path_data_header_t;
  ;; ")
  ;; (c-define-type scheme_cairo_path_data_header_t "___scheme_cairo_path_data_header_t")
  ;; (c-declare "
  ;; typedef struct {
  ;;   double x;
  ;;   double y;
  ;; } ___scheme_cairo_path_point_t;
  ;; ")
  ;; (c-define-type scheme_cairo_path_point_t "___scheme_cairo_path_point_t")
  ;; (c-union cairo_path_data_t
  ;;          (header scheme_cairo_path_data_header_t)
  ;;          (point scheme_cairo_path_point_t))
  (c-define-type cairo_path_data_t (union "cairo_path_data_t"))
  (c-define-type cairo_path_data_t* (pointer cairo_path_data_t))
  (c-define-type cairo_path_data_t** (pointer cairo_path_data_t*))
  (c-define-type cairo_path_t (struct "cairo_path_t"))
  (c-define-type cairo_path_t* (pointer cairo_path_t))
  (c-define-type cairo_path_t** (pointer cairo_path_t*))
  (c-define-type cairo_pattern_t (struct "cairo_pattern_t"))
  (c-define-type cairo_pattern_t* (pointer cairo_pattern_t))
  (c-define-type cairo_pattern_t** (pointer cairo_pattern_t*))
  (c-define-type cairo_rectangle_int_t (struct "cairo_rectangle_int_t"))
  (c-define-type cairo_rectangle_int_t* (pointer cairo_rectangle_int_t))
  (c-define-type cairo_rectangle_int_t** (pointer cairo_rectangle_int_t*))
  (c-define-type cairo_rectangle_list_t (struct "cairo_rectangle_list_t"))
  (c-define-type cairo_rectangle_list_t* (pointer cairo_rectangle_list_t))
  (c-define-type cairo_rectangle_list_t** (pointer cairo_rectangle_list_t*))
  (c-define-type cairo_rectangle_t (struct "cairo_rectangle_t"))
  (c-define-type cairo_rectangle_t* (pointer cairo_rectangle_t))
  (c-define-type cairo_rectangle_t** (pointer cairo_rectangle_t*))
  (c-define-type cairo_region_t (struct "cairo_region_t"))
  (c-define-type cairo_region_t* (pointer cairo_region_t))
  (c-define-type cairo_region_t** (pointer cairo_region_t*))
  (c-define-type cairo_scaled_font_t (struct "cairo_scaled_font_t"))
  (c-define-type cairo_scaled_font_t* (pointer cairo_scaled_font_t))
  (c-define-type cairo_scaled_font_t** (pointer cairo_scaled_font_t*))
  (c-define-type cairo_surface_t (struct "cairo_surface_t"))
  (c-define-type cairo_surface_t* (pointer cairo_surface_t))
  (c-define-type cairo_surface_t** (pointer cairo_surface_t*))
  (c-define-type cairo_t (struct "cairo_t"))
  (c-define-type cairo_t* (pointer cairo_t))
  (c-define-type cairo_t** (pointer cairo_t*))

  (c-define-type* (struct cairo_text_cluster_t))
  (c-define-struct cairo_text_cluster_t
                   (num_bytes int)
                   (num_glyphs int))
  (c-define-type cairo_text_cluster_t** (pointer cairo_text_cluster_t*))

  (c-define-type* (struct cairo_text_extents_t))
  (c-define-struct cairo_text_extents_t
                   (x_bearing double)
                   (y_bearing double)
                   (width double)
                   (height double)
                   (x_advance double)
                   (y_advance double))
  (c-define-type cairo_text_extents_t** (pointer cairo_text_extents_t*))

  (c-define-type cairo_user_data_key_t  (type "cairo_user_data_key_t"))
  (c-define-type cairo_user_data_key_t*  (pointer cairo_user_data_key_t))

  (c-define-type cairo_destroy_func_t (function (void*) void))
  (c-define-type cairo_raster_source_acquire_func_t (function (cairo_pattern_t* void* cairo_surface_t* cairo_rectangle_int_t*) cairo_surface_t))
  (c-define-type cairo_raster_source_acquire_func_t* (pointer cairo_raster_source_acquire_func_t))
  (c-define-type cairo_raster_source_copy_func_t (function (cairo_pattern_t* void* cairo_pattern_t*) cairo_status_t))
  (c-define-type cairo_raster_source_copy_func_t* (pointer cairo_raster_source_copy_func_t))
  (c-define-type cairo_raster_source_finish_func_t (function (cairo_pattern_t* void*) void))
  (c-define-type cairo_raster_source_finish_func_t* (pointer cairo_raster_source_finish_func_t))
  (c-define-type cairo_raster_source_release_func_t (function (cairo_pattern_t* void* cairo_surface_t*) void))
  (c-define-type cairo_raster_source_release_func_t* (pointer cairo_raster_source_release_func_t))
  (c-define-type cairo_raster_source_snapshot_func_t (function (cairo_pattern_t* void*) cairo_status_t))
  (c-define-type cairo_raster_source_snapshot_func_t* (pointer cairo_raster_source_snapshot_func_t))
  (c-define-type cairo_read_func_t (function (void* unsigned-char* unsigned-int) cairo_status_t))
  (c-define-type cairo_read_func_t* (pointer cairo_read_func_t))
  (c-define-type cairo_user_scaled_font_init_func_t (function (cairo_scaled_font_t* cairo_t* cairo_font_extents_t*) cairo_status_t))
  (c-define-type cairo_user_scaled_font_render_glyph_func_t (function (cairo_scaled_font_t* unsigned-long cairo_t* cairo_text_extents_t*) cairo_status_t))
  (c-define-type cairo_user_scaled_font_text_to_glyphs_func_t (function (cairo_scaled_font_t* char-string int cairo_glyph_t** int*  cairo_text_cluster_t** int* cairo_text_cluster_flags_t*) cairo_status_t))
  (c-define-type cairo_user_scaled_font_unicode_to_glyph_func_t (function (cairo_scaled_font_t* unsigned-long unsigned-long*) cairo_status_t))
  (c-define-type cairo_write_func_t (function (void* unsigned-char* unsigned-int) cairo_status_t))


;; (c-define-type Display "Display")
;; (c-define-type Display* (pointer Display))
;; (c-define-type Screen "Screen")
;; (c-define-type Screen* (pointer Screen))
;; (c-define-type Visual "Visual")
;; (c-define-type Visual* (pointer Visual))
;; (c-define-type Drawable unsigned-long)
;; (c-define-type Pixmap unsigned-long)

;; (c-define-type FT-Face (type "FT_Face"))
;; (c-define-type FcPattern (struct "FcPattern"))
;; (c-define-type FcPattern* (pointer "FcPattern"))

;; (c-define-type LOGFONTW* (pointer (pointer "LOGFONTW")))
;; (c-define-type HFONT "HFONT")
;; (c-define-type HDC "HDC")
;; (c-define-type cairo_destroy_func_t  (pointer "cairo_destroy_func_t"))

