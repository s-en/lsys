#!/bin/sh
:; exec gosh -I../../src -I../../lib $0 "$@"
;; A minimum demo to use gl.simple.viewer

(use gl)
(use gl.glut)
(use gl.simple.viewer)

(define (main args)
  (glut-init args)
  (simple-viewer-display (^[state] 
                            (gl-begin* GL_LINE_STRIP
                                       (gl-color '#f32(1.0 0.0 0.0))
                                       (gl-vertex '#f32(0 0 0))
                                       (gl-vertex '#f32(0 5 0)))))
  (simple-viewer-window 'demo)
  (simple-viewer-run)
  0)
