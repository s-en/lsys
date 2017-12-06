#!/usr/local/bin/chez --program

(import (rnrs) (lib gl_4_1) (lib glfw))

(define (program-loop window)
    (unless (glfwWindowShouldClose window)
        (glClearColor 0.1 0.1 0.1 1.0)
        (glClear GL_COLOR_BUFFER_BIT)
        (glfwSwapBuffers window)
        (glfwPollEvents)
        (program-loop window)))

(define (key-event window key scancode action mods)
  (let ([action-str (cond
                      [(= action GLFW_PRESS) "press"]
                      [(= action GLFW_REPEAT) "repeat"]
                      [(= action GLFW_RELEASE) "release"]
                      [else "<unknown>"])])
    (format #t "~a: ~a ~a ~a\n" action-str key scancode mods)
    (cond
      [(= key GLFW_KEY_ESCAPE) (glfwSetWindowShouldClose window #t)])))

(glfwInit)
(let ((window (glfwCreateWindow 640 480 "Hello World" 0 0)))
    (unless window
        (glfwTerminate)
        (exit))
    (glfwMakeContextCurrent window)
    (glfwSetKeyCallback window key-event)
    (program-loop window)
    (glfwTerminate))