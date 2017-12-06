(library (lib glfw)
    (export
        GLFW_VERSION_MAJOR GLFW_VERSION_MINOR GLFW_VERSION_REVISION GLFW_TRUE
        GLFW_FALSE GLFW_RELEASE GLFW_PRESS GLFW_REPEAT GLFW_KEY_UNKNOWN
        GLFW_KEY_SPACE GLFW_KEY_APOSTROPHE GLFW_KEY_COMMA GLFW_KEY_MINUS
        GLFW_KEY_PERIOD GLFW_KEY_SLASH GLFW_KEY_0 GLFW_KEY_1 GLFW_KEY_2
        GLFW_KEY_3 GLFW_KEY_4 GLFW_KEY_5 GLFW_KEY_6 GLFW_KEY_7 GLFW_KEY_8
        GLFW_KEY_9 GLFW_KEY_SEMICOLON GLFW_KEY_EQUAL GLFW_KEY_A GLFW_KEY_B
        GLFW_KEY_C GLFW_KEY_D GLFW_KEY_E GLFW_KEY_F GLFW_KEY_G GLFW_KEY_H
        GLFW_KEY_I GLFW_KEY_J GLFW_KEY_K GLFW_KEY_L GLFW_KEY_M GLFW_KEY_N
        GLFW_KEY_O GLFW_KEY_P GLFW_KEY_Q GLFW_KEY_R GLFW_KEY_S GLFW_KEY_T
        GLFW_KEY_U GLFW_KEY_V GLFW_KEY_W GLFW_KEY_X GLFW_KEY_Y GLFW_KEY_Z
        GLFW_KEY_LEFT_BRACKET GLFW_KEY_BACKSLASH GLFW_KEY_RIGHT_BRACKET
        GLFW_KEY_GRAVE_ACCENT GLFW_KEY_WORLD_1 GLFW_KEY_WORLD_2
        GLFW_KEY_ESCAPE GLFW_KEY_ENTER GLFW_KEY_TAB GLFW_KEY_BACKSPACE
        GLFW_KEY_INSERT GLFW_KEY_DELETE GLFW_KEY_RIGHT GLFW_KEY_LEFT
        GLFW_KEY_DOWN GLFW_KEY_UP GLFW_KEY_PAGE_UP GLFW_KEY_PAGE_DOWN
        GLFW_KEY_HOME GLFW_KEY_END GLFW_KEY_CAPS_LOCK GLFW_KEY_SCROLL_LOCK
        GLFW_KEY_NUM_LOCK GLFW_KEY_PRINT_SCREEN GLFW_KEY_PAUSE GLFW_KEY_F1
        GLFW_KEY_F2 GLFW_KEY_F3 GLFW_KEY_F4 GLFW_KEY_F5 GLFW_KEY_F6
        GLFW_KEY_F7 GLFW_KEY_F8 GLFW_KEY_F9 GLFW_KEY_F10 GLFW_KEY_F11
        GLFW_KEY_F12 GLFW_KEY_F13 GLFW_KEY_F14 GLFW_KEY_F15 GLFW_KEY_F16
        GLFW_KEY_F17 GLFW_KEY_F18 GLFW_KEY_F19 GLFW_KEY_F20 GLFW_KEY_F21
        GLFW_KEY_F22 GLFW_KEY_F23 GLFW_KEY_F24 GLFW_KEY_F25 GLFW_KEY_KP_0
        GLFW_KEY_KP_1 GLFW_KEY_KP_2 GLFW_KEY_KP_3 GLFW_KEY_KP_4 GLFW_KEY_KP_5
        GLFW_KEY_KP_6 GLFW_KEY_KP_7 GLFW_KEY_KP_8 GLFW_KEY_KP_9
        GLFW_KEY_KP_DECIMAL GLFW_KEY_KP_DIVIDE GLFW_KEY_KP_MULTIPLY
        GLFW_KEY_KP_SUBTRACT GLFW_KEY_KP_ADD GLFW_KEY_KP_ENTER
        GLFW_KEY_KP_EQUAL GLFW_KEY_LEFT_SHIFT GLFW_KEY_LEFT_CONTROL
        GLFW_KEY_LEFT_ALT GLFW_KEY_LEFT_SUPER GLFW_KEY_RIGHT_SHIFT
        GLFW_KEY_RIGHT_CONTROL GLFW_KEY_RIGHT_ALT GLFW_KEY_RIGHT_SUPER
        GLFW_KEY_MENU GLFW_KEY_LAST GLFW_MOD_SHIFT GLFW_MOD_CONTROL
        GLFW_MOD_ALT GLFW_MOD_SUPER GLFW_MOUSE_BUTTON_1 GLFW_MOUSE_BUTTON_2
        GLFW_MOUSE_BUTTON_3 GLFW_MOUSE_BUTTON_4 GLFW_MOUSE_BUTTON_5
        GLFW_MOUSE_BUTTON_6 GLFW_MOUSE_BUTTON_7 GLFW_MOUSE_BUTTON_8
        GLFW_MOUSE_BUTTON_LAST GLFW_MOUSE_BUTTON_LEFT GLFW_MOUSE_BUTTON_RIGHT
        GLFW_MOUSE_BUTTON_MIDDLE GLFW_JOYSTICK_1 GLFW_JOYSTICK_2
        GLFW_JOYSTICK_3 GLFW_JOYSTICK_4 GLFW_JOYSTICK_5 GLFW_JOYSTICK_6
        GLFW_JOYSTICK_7 GLFW_JOYSTICK_8 GLFW_JOYSTICK_9 GLFW_JOYSTICK_10
        GLFW_JOYSTICK_11 GLFW_JOYSTICK_12 GLFW_JOYSTICK_13 GLFW_JOYSTICK_14
        GLFW_JOYSTICK_15 GLFW_JOYSTICK_16 GLFW_JOYSTICK_LAST
        GLFW_NOT_INITIALIZED GLFW_NO_CURRENT_CONTEXT GLFW_INVALID_ENUM
        GLFW_INVALID_VALUE GLFW_OUT_OF_MEMORY GLFW_API_UNAVAILABLE
        GLFW_VERSION_UNAVAILABLE GLFW_PLATFORM_ERROR GLFW_FORMAT_UNAVAILABLE
        GLFW_NO_WINDOW_CONTEXT GLFW_FOCUSED GLFW_ICONIFIED GLFW_RESIZABLE
        GLFW_VISIBLE GLFW_DECORATED GLFW_AUTO_ICONIFY GLFW_FLOATING
        GLFW_MAXIMIZED GLFW_RED_BITS GLFW_GREEN_BITS GLFW_BLUE_BITS
        GLFW_ALPHA_BITS GLFW_DEPTH_BITS GLFW_STENCIL_BITS GLFW_ACCUM_RED_BITS
        GLFW_ACCUM_GREEN_BITS GLFW_ACCUM_BLUE_BITS GLFW_ACCUM_ALPHA_BITS
        GLFW_AUX_BUFFERS GLFW_STEREO GLFW_SAMPLES GLFW_SRGB_CAPABLE
        GLFW_REFRESH_RATE GLFW_DOUBLEBUFFER GLFW_CLIENT_API
        GLFW_CONTEXT_VERSION_MAJOR GLFW_CONTEXT_VERSION_MINOR
        GLFW_CONTEXT_REVISION GLFW_CONTEXT_ROBUSTNESS
        GLFW_OPENGL_FORWARD_COMPAT GLFW_OPENGL_DEBUG_CONTEXT
        GLFW_OPENGL_PROFILE GLFW_CONTEXT_RELEASE_BEHAVIOR
        GLFW_CONTEXT_NO_ERROR GLFW_CONTEXT_CREATION_API GLFW_NO_API
        GLFW_OPENGL_API GLFW_OPENGL_ES_API GLFW_NO_ROBUSTNESS
        GLFW_NO_RESET_NOTIFICATION GLFW_LOSE_CONTEXT_ON_RESET
        GLFW_OPENGL_ANY_PROFILE GLFW_OPENGL_CORE_PROFILE
        GLFW_OPENGL_COMPAT_PROFILE GLFW_CURSOR GLFW_STICKY_KEYS
        GLFW_STICKY_MOUSE_BUTTONS GLFW_CURSOR_NORMAL GLFW_CURSOR_HIDDEN
        GLFW_CURSOR_DISABLED GLFW_ANY_RELEASE_BEHAVIOR
        GLFW_RELEASE_BEHAVIOR_FLUSH GLFW_RELEASE_BEHAVIOR_NONE
        GLFW_NATIVE_CONTEXT_API GLFW_EGL_CONTEXT_API GLFW_ARROW_CURSOR
        GLFW_IBEAM_CURSOR GLFW_CROSSHAIR_CURSOR GLFW_HAND_CURSOR
        GLFW_HRESIZE_CURSOR GLFW_VRESIZE_CURSOR GLFW_CONNECTED
        GLFW_DISCONNECTED GLFW_DONT_CARE
        glfwInit glfwTerminate glfwGetVersionString
        glfwCreateWindow
        glfwSetInputMode glfwGetInputMode
        glfwGetFramebufferSize
        glfwGetTime glfwSetTime
        glfwSetErrorCallback glfwSetKeyCallback
        glfwSetCharCallback
        glfwSetWindowCloseCallback
        glfwSetFramebufferSizeCallback
        glfwSetMouseButtonCallback
        glfwSetCursorPosCallback
        glfwSetWindowAspectRatio
        glfwWindowHint
        glfwGetPrimaryMonitor
        glfwGetVideoMode
        glfwMakeContextCurrent
        glfwWindowShouldClose glfwSetWindowShouldClose
        glfwSwapBuffers glfwSwapInterval
        glfwPollEvents glfwWaitEvents glfwWaitEventsTimeout
        glfwGetProcAddress glfwExtensionSupported)

    (import
        (rnrs base(6))
        (only (chezscheme)
            foreign-callable
            foreign-callable-entry-point
            foreign-free
            foreign-ref
            foreign-alloc
            foreign-sizeof
            foreign-procedure
            lock-object
            load-shared-object
            define-ftype))

    (define GLFW_VERSION_MAJOR 3)
    (define GLFW_VERSION_MINOR 2)
    (define GLFW_VERSION_REVISION 1)
    (define GLFW_TRUE 1)
    (define GLFW_FALSE 0)
    (define GLFW_RELEASE 0)
    (define GLFW_PRESS 1)
    (define GLFW_REPEAT 2)
    (define GLFW_KEY_UNKNOWN -1)
    (define GLFW_KEY_SPACE 32)
    (define GLFW_KEY_APOSTROPHE 39)
    (define GLFW_KEY_COMMA 44)
    (define GLFW_KEY_MINUS 45)
    (define GLFW_KEY_PERIOD 46)
    (define GLFW_KEY_SLASH 47)
    (define GLFW_KEY_0 48)
    (define GLFW_KEY_1 49)
    (define GLFW_KEY_2 50)
    (define GLFW_KEY_3 51)
    (define GLFW_KEY_4 52)
    (define GLFW_KEY_5 53)
    (define GLFW_KEY_6 54)
    (define GLFW_KEY_7 55)
    (define GLFW_KEY_8 56)
    (define GLFW_KEY_9 57)
    (define GLFW_KEY_SEMICOLON 59)
    (define GLFW_KEY_EQUAL 61)
    (define GLFW_KEY_A 65)
    (define GLFW_KEY_B 66)
    (define GLFW_KEY_C 67)
    (define GLFW_KEY_D 68)
    (define GLFW_KEY_E 69)
    (define GLFW_KEY_F 70)
    (define GLFW_KEY_G 71)
    (define GLFW_KEY_H 72)
    (define GLFW_KEY_I 73)
    (define GLFW_KEY_J 74)
    (define GLFW_KEY_K 75)
    (define GLFW_KEY_L 76)
    (define GLFW_KEY_M 77)
    (define GLFW_KEY_N 78)
    (define GLFW_KEY_O 79)
    (define GLFW_KEY_P 80)
    (define GLFW_KEY_Q 81)
    (define GLFW_KEY_R 82)
    (define GLFW_KEY_S 83)
    (define GLFW_KEY_T 84)
    (define GLFW_KEY_U 85)
    (define GLFW_KEY_V 86)
    (define GLFW_KEY_W 87)
    (define GLFW_KEY_X 88)
    (define GLFW_KEY_Y 89)
    (define GLFW_KEY_Z 90)
    (define GLFW_KEY_LEFT_BRACKET 91)
    (define GLFW_KEY_BACKSLASH 92)
    (define GLFW_KEY_RIGHT_BRACKET 93)
    (define GLFW_KEY_GRAVE_ACCENT 96)
    (define GLFW_KEY_WORLD_1 161)
    (define GLFW_KEY_WORLD_2 162)
    (define GLFW_KEY_ESCAPE 256)
    (define GLFW_KEY_ENTER 257)
    (define GLFW_KEY_TAB 258)
    (define GLFW_KEY_BACKSPACE 259)
    (define GLFW_KEY_INSERT 260)
    (define GLFW_KEY_DELETE 261)
    (define GLFW_KEY_RIGHT 262)
    (define GLFW_KEY_LEFT 263)
    (define GLFW_KEY_DOWN 264)
    (define GLFW_KEY_UP 265)
    (define GLFW_KEY_PAGE_UP 266)
    (define GLFW_KEY_PAGE_DOWN 267)
    (define GLFW_KEY_HOME 268)
    (define GLFW_KEY_END 269)
    (define GLFW_KEY_CAPS_LOCK 280)
    (define GLFW_KEY_SCROLL_LOCK 281)
    (define GLFW_KEY_NUM_LOCK 282)
    (define GLFW_KEY_PRINT_SCREEN 283)
    (define GLFW_KEY_PAUSE 284)
    (define GLFW_KEY_F1 290)
    (define GLFW_KEY_F2 291)
    (define GLFW_KEY_F3 292)
    (define GLFW_KEY_F4 293)
    (define GLFW_KEY_F5 294)
    (define GLFW_KEY_F6 295)
    (define GLFW_KEY_F7 296)
    (define GLFW_KEY_F8 297)
    (define GLFW_KEY_F9 298)
    (define GLFW_KEY_F10 299)
    (define GLFW_KEY_F11 300)
    (define GLFW_KEY_F12 301)
    (define GLFW_KEY_F13 302)
    (define GLFW_KEY_F14 303)
    (define GLFW_KEY_F15 304)
    (define GLFW_KEY_F16 305)
    (define GLFW_KEY_F17 306)
    (define GLFW_KEY_F18 307)
    (define GLFW_KEY_F19 308)
    (define GLFW_KEY_F20 309)
    (define GLFW_KEY_F21 310)
    (define GLFW_KEY_F22 311)
    (define GLFW_KEY_F23 312)
    (define GLFW_KEY_F24 313)
    (define GLFW_KEY_F25 314)
    (define GLFW_KEY_KP_0 320)
    (define GLFW_KEY_KP_1 321)
    (define GLFW_KEY_KP_2 322)
    (define GLFW_KEY_KP_3 323)
    (define GLFW_KEY_KP_4 324)
    (define GLFW_KEY_KP_5 325)
    (define GLFW_KEY_KP_6 326)
    (define GLFW_KEY_KP_7 327)
    (define GLFW_KEY_KP_8 328)
    (define GLFW_KEY_KP_9 329)
    (define GLFW_KEY_KP_DECIMAL 330)
    (define GLFW_KEY_KP_DIVIDE 331)
    (define GLFW_KEY_KP_MULTIPLY 332)
    (define GLFW_KEY_KP_SUBTRACT 333)
    (define GLFW_KEY_KP_ADD 334)
    (define GLFW_KEY_KP_ENTER 335)
    (define GLFW_KEY_KP_EQUAL 336)
    (define GLFW_KEY_LEFT_SHIFT 340)
    (define GLFW_KEY_LEFT_CONTROL 341)
    (define GLFW_KEY_LEFT_ALT 342)
    (define GLFW_KEY_LEFT_SUPER 343)
    (define GLFW_KEY_RIGHT_SHIFT 344)
    (define GLFW_KEY_RIGHT_CONTROL 345)
    (define GLFW_KEY_RIGHT_ALT 346)
    (define GLFW_KEY_RIGHT_SUPER 347)
    (define GLFW_KEY_MENU 348)
    (define GLFW_KEY_LAST GLFW_KEY_MENU)
    (define GLFW_MOD_SHIFT #x0001)
    (define GLFW_MOD_CONTROL #x0002)
    (define GLFW_MOD_ALT #x0004)
    (define GLFW_MOD_SUPER #x0008)
    (define GLFW_MOUSE_BUTTON_1 0)
    (define GLFW_MOUSE_BUTTON_2 1)
    (define GLFW_MOUSE_BUTTON_3 2)
    (define GLFW_MOUSE_BUTTON_4 3)
    (define GLFW_MOUSE_BUTTON_5 4)
    (define GLFW_MOUSE_BUTTON_6 5)
    (define GLFW_MOUSE_BUTTON_7 6)
    (define GLFW_MOUSE_BUTTON_8 7)
    (define GLFW_MOUSE_BUTTON_LAST GLFW_MOUSE_BUTTON_8)
    (define GLFW_MOUSE_BUTTON_LEFT GLFW_MOUSE_BUTTON_1)
    (define GLFW_MOUSE_BUTTON_RIGHT GLFW_MOUSE_BUTTON_2)
    (define GLFW_MOUSE_BUTTON_MIDDLE GLFW_MOUSE_BUTTON_3)
    (define GLFW_JOYSTICK_1 0)
    (define GLFW_JOYSTICK_2 1)
    (define GLFW_JOYSTICK_3 2)
    (define GLFW_JOYSTICK_4 3)
    (define GLFW_JOYSTICK_5 4)
    (define GLFW_JOYSTICK_6 5)
    (define GLFW_JOYSTICK_7 6)
    (define GLFW_JOYSTICK_8 7)
    (define GLFW_JOYSTICK_9 8)
    (define GLFW_JOYSTICK_10 9)
    (define GLFW_JOYSTICK_11 10)
    (define GLFW_JOYSTICK_12 11)
    (define GLFW_JOYSTICK_13 12)
    (define GLFW_JOYSTICK_14 13)
    (define GLFW_JOYSTICK_15 14)
    (define GLFW_JOYSTICK_16 15)
    (define GLFW_JOYSTICK_LAST GLFW_JOYSTICK_16)
    (define GLFW_NOT_INITIALIZED #x00010001)
    (define GLFW_NO_CURRENT_CONTEXT #x00010002)
    (define GLFW_INVALID_ENUM #x00010003)
    (define GLFW_INVALID_VALUE #x00010004)
    (define GLFW_OUT_OF_MEMORY #x00010005)
    (define GLFW_API_UNAVAILABLE #x00010006)
    (define GLFW_VERSION_UNAVAILABLE #x00010007)
    (define GLFW_PLATFORM_ERROR #x00010008)
    (define GLFW_FORMAT_UNAVAILABLE #x00010009)
    (define GLFW_NO_WINDOW_CONTEXT #x0001000A)
    (define GLFW_FOCUSED #x00020001)
    (define GLFW_ICONIFIED #x00020002)
    (define GLFW_RESIZABLE #x00020003)
    (define GLFW_VISIBLE #x00020004)
    (define GLFW_DECORATED #x00020005)
    (define GLFW_AUTO_ICONIFY #x00020006)
    (define GLFW_FLOATING #x00020007)
    (define GLFW_MAXIMIZED #x00020008)
    (define GLFW_RED_BITS #x00021001)
    (define GLFW_GREEN_BITS #x00021002)
    (define GLFW_BLUE_BITS #x00021003)
    (define GLFW_ALPHA_BITS #x00021004)
    (define GLFW_DEPTH_BITS #x00021005)
    (define GLFW_STENCIL_BITS #x00021006)
    (define GLFW_ACCUM_RED_BITS #x00021007)
    (define GLFW_ACCUM_GREEN_BITS #x00021008)
    (define GLFW_ACCUM_BLUE_BITS #x00021009)
    (define GLFW_ACCUM_ALPHA_BITS #x0002100A)
    (define GLFW_AUX_BUFFERS #x0002100B)
    (define GLFW_STEREO #x0002100C)
    (define GLFW_SAMPLES #x0002100D)
    (define GLFW_SRGB_CAPABLE #x0002100E)
    (define GLFW_REFRESH_RATE #x0002100F)
    (define GLFW_DOUBLEBUFFER #x00021010)
    (define GLFW_CLIENT_API #x00022001)
    (define GLFW_CONTEXT_VERSION_MAJOR #x00022002)
    (define GLFW_CONTEXT_VERSION_MINOR #x00022003)
    (define GLFW_CONTEXT_REVISION #x00022004)
    (define GLFW_CONTEXT_ROBUSTNESS #x00022005)
    (define GLFW_OPENGL_FORWARD_COMPAT #x00022006)
    (define GLFW_OPENGL_DEBUG_CONTEXT #x00022007)
    (define GLFW_OPENGL_PROFILE #x00022008)
    (define GLFW_CONTEXT_RELEASE_BEHAVIOR #x00022009)
    (define GLFW_CONTEXT_NO_ERROR #x0002200A)
    (define GLFW_CONTEXT_CREATION_API #x0002200B)
    (define GLFW_NO_API 0)
    (define GLFW_OPENGL_API #x00030001)
    (define GLFW_OPENGL_ES_API #x00030002)
    (define GLFW_NO_ROBUSTNESS 0)
    (define GLFW_NO_RESET_NOTIFICATION #x00031001)
    (define GLFW_LOSE_CONTEXT_ON_RESET #x00031002)
    (define GLFW_OPENGL_ANY_PROFILE 0)
    (define GLFW_OPENGL_CORE_PROFILE #x00032001)
    (define GLFW_OPENGL_COMPAT_PROFILE #x00032002)
    (define GLFW_CURSOR #x00033001)
    (define GLFW_STICKY_KEYS #x00033002)
    (define GLFW_STICKY_MOUSE_BUTTONS #x00033003)
    (define GLFW_CURSOR_NORMAL #x00034001)
    (define GLFW_CURSOR_HIDDEN #x00034002)
    (define GLFW_CURSOR_DISABLED #x00034003)
    (define GLFW_ANY_RELEASE_BEHAVIOR 0)
    (define GLFW_RELEASE_BEHAVIOR_FLUSH #x00035001)
    (define GLFW_RELEASE_BEHAVIOR_NONE #x00035002)
    (define GLFW_NATIVE_CONTEXT_API #x00036001)
    (define GLFW_EGL_CONTEXT_API #x00036002)
    (define GLFW_ARROW_CURSOR #x00036001)
    (define GLFW_IBEAM_CURSOR #x00036002)
    (define GLFW_CROSSHAIR_CURSOR #x00036003)
    (define GLFW_HAND_CURSOR #x00036004)
    (define GLFW_HRESIZE_CURSOR #x00036005)
    (define GLFW_VRESIZE_CURSOR #x00036006)
    (define GLFW_CONNECTED #x00040001)
    (define GLFW_DISCONNECTED #x00040002)
    (define GLFW_DONT_CARE -1)

    (define-syntax define-function
        (syntax-rules ()
            ((_ ret name args)
                (define name
                    (foreign-procedure (symbol->string 'name) args ret)))))

    (define-syntax define-function/callback
        (syntax-rules (callback)
          ((_ ret name args (callback c-ret c-params))
             (define name
               (let ((f (foreign-procedure (symbol->string 'name) args ret)))
                 (lambda (proc)
                   (let ((code (foreign-callable proc c-params c-ret)))
                     (lock-object code)
                 (f (foreign-callable-entry-point code)))))))))

    (define-syntax define-function/window-callback
        (syntax-rules (callback)
          ((_ ret name args (callback c-ret c-params))
             (define name
               (let ((f (foreign-procedure (symbol->string 'name) args ret)))
                 (lambda (window proc)
                   (let ((code (foreign-callable proc c-params c-ret)))
                     (lock-object code)
                 (f window (foreign-callable-entry-point code)))))))))

    (define lib (load-shared-object "libglfw.3.2.dylib"))

    (define-ftype glfw-vid-mode
        (struct
            [width        int]
            [height       int]
            [red-bits     int]
            [green-bits   int]
            [blue-bits    int]
        [refresh-rate int]))

    (define-function boolean glfwInit ())
    (define-function void glfwTerminate ())
    (define-function string glfwGetVersionString ())
    (define-function void glfwSetInputMode (uptr int int))
    (define-function int glfwGetInputMode (uptr int))

    (define-function/callback void glfwSetErrorCallback (uptr)
        (callback void (int string)))
    (define-function/window-callback uptr glfwSetWindowCloseCallback (uptr uptr)
        (callback void (uptr)))
    (define-function/window-callback uptr glfwSetKeyCallback (uptr uptr)
        (callback void (uptr int int int int)))
    (define-function/window-callback uptr glfwSetFramebufferSizeCallback (uptr uptr)
        (callback void (uptr int int)))
    (define-function/window-callback uptr glfwSetCharCallback (uptr uptr)
        (callback void (uptr unsigned-32)))
    (define-function/window-callback uptr glfwSetMouseButtonCallback (uptr uptr)
        (callback void (uptr int int int)))
    (define-function/window-callback uptr glfwSetCursorPosCallback (uptr uptr)
        (callback void (uptr double double)))

    (define-function double glfwGetTime ())
    (define-function void glfwSetTime (double))
    (define-function uptr glfwGetPrimaryMonitor ())
    (define-function (* glfw-vid-mode) glfwGetVideoMode (uptr))
    (define-function uptr glfwCreateWindow (int int string uptr uptr))
    (define-function void glfwDestroyWindow (uptr))
    (define-function void glfwWindowHint (int int))
    (define-function void glfwSetWindowAspectRatio (uptr int int))
    (define-function boolean glfwWindowShouldClose (uptr))
    (define-function void glfwSetWindowShouldClose (uptr boolean))

    (define glfwGetFramebufferSize
        (let ([get-framebuffer-size
               (foreign-procedure "glfwGetFramebufferSize" (uptr uptr uptr) void)])
        (lambda (window)
            (let* ([int-size (foreign-sizeof 'int)]
            [data     (foreign-alloc (* 2 int-size))])
            (get-framebuffer-size window data (+ data int-size))
            (let ([w (foreign-ref 'int data 0)]
            [h (foreign-ref 'int data int-size)])
            (foreign-free data)
        (values w h))))))

    (define-function void glfwPollEvents ())
    (define-function void glfwWaitEvents ())
    (define-function void glfwWaitEventsTimeout (double))
    (define-function void glfwMakeContextCurrent (uptr))
    (define-function void glfwSwapBuffers (uptr))
    (define-function void glfwSwapInterval (int))
    (define-function uptr glfwGetProcAddress (string))
    (define-function int glfwExtensionSupported (string))

)