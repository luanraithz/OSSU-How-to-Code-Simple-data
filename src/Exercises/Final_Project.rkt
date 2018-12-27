;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Final_Project) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders


;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 100)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))

(define MISSILE (ellipse 5 15 "solid" "red"))

;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game s)
  (... (fn-for-loinvader (game-invaders s))
       (fn-for-lom (game-missiles s))
       (fn-for-tank (game-tank s))))



(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))



(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right


#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                       ;not hit U1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))

(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))

(define (main initial-game-state)
  (big-bang initial-game-state
    (on-tick next-state)
    (to-draw render-game)
    (on-key on-key-pressed)
  ))

(define (next-state state) state)

(define (on-key-pressed c key) c)

(define (render-game game) BACKGROUND)

;(define (next-state s)
 ; (make-game (move-invaders-and-delete-shooted (game-invaders s) (game-missiles s))
 ;   (fn-for-lom (game-missiles s))
 ;   (move-tank (game-tank s))
 ; ))

#;
(define (move-invaders-and-delete-shooted invaders missiles)
  (if (isNear? (first invader) missiles)
    (move-invaders-and-delete-shooted invaders (rest invaders missles))
    (cons (move-single-invader (first invaders)) (move-invaders-and-delete-shooted invaders (rest invaders) missiles)) 
  )
)

;; Invader Missle -> Boolean
;; produces if the invader is near the missle, by 15 px

(check-expect (isNear? I1 M1) false)
(check-expect (isNear? I1 M2) true)
(check-expect (isNear? I1 M3) true)

(define (isNear? invader missle)
  (and 
    (< (missile-x missle) (+ (invader-x invader) 15)) (> (missile-x missle) (- (invader-x invader) 15))
    (< (missile-y missle) (+ (invader-y invader) 15)) (> (missile-y missle) (- (invader-y invader) 15))
  )
)

;; Invader -> Invader
;; produces a new invader with the x + speed and y + speed, and inverts speed if the
;; invader has cross the edge

(check-expect (move-single-invader (make-invader 10 12 1))
              (make-invader (+ 10 INVADER-X-SPEED) (- 12 INVADER-Y-SPEED) 1))

(check-expect (move-single-invader (make-invader (- WIDTH 1) 200 1))
              (make-invader  (+ (- WIDTH 1) INVADER-X-SPEED) (- 200 INVADER-Y-SPEED) -1))

(check-expect (move-single-invader (make-invader WIDTH 210 1))
              (make-invader (+ WIDTH INVADER-X-SPEED) (- 210 INVADER-Y-SPEED) -1))

(check-expect (move-single-invader (make-invader WIDTH 210 -1))
              (make-invader (- WIDTH INVADER-X-SPEED) (- 210 INVADER-Y-SPEED) -1))

(define (move-single-invader invader)
  (make-invader 
    (+ (invader-x invader) (* (invader-dx invader) INVADER-X-SPEED)) 
    (- (invader-y invader) INVADER-Y-SPEED)
    (if (or (>= (+ (invader-x invader) (* (invader-dx invader) INVADER-X-SPEED)) WIDTH)
           (<= (+ (invader-x invader) (* (invader-dx invader) INVADER-X-SPEED))  0)) 
      (* (invader-dx invader) -1)
      (invader-dx invader)
    ) 
  )
)

;; Tank -> Tank
;; moves the given tank.
;; - moves to the right if dir is 1
;; - moves to the left if dir is -1
;; If the tank is going to the edge, the direction is inverted

(define (move-tank t)
   (if (tank-out-of-box? t)
     (make-tank (- (tank-x t) (* (tank-dir t) TANK-SPEED) ) (* -1 (tank-dir t)))
     (make-tank (+ (tank-x t) (* (tank-dir t) TANK-SPEED) ) (tank-dir t))
      )
   )


;; Tank -> Boolean
;; produces true if a given tank is at the edge or out of the box

(check-expect (tank-out-of-box? T0) false)
(check-expect (tank-out-of-box? T1) false)
(check-expect (tank-out-of-box? T2) false)
(check-expect (tank-out-of-box? (make-tank WIDTH -1)) true)
(check-expect (tank-out-of-box? (make-tank (+ WIDTH 20) -1)) true)
  
(define (tank-out-of-box? tank)
  (or (>= (tank-x tank) WIDTH) (<= (tank-x tank) 0)))
  
;; ListOfInvaders -> Image
;; produces a background with the invasors within it

(check-expect (render-invaders empty) BACKGROUND)

(check-expect (render-invaders (cons (make-invader 20 40 1) empty))
                (place-image INVADER 20 40 BACKGROUND))

(check-expect (render-invaders (cons (make-invader 70 40 1) (cons (make-invader 20 40 1) empty)))
                (place-image INVADER 70 40 (place-image INVADER 20 40 BACKGROUND)))

(define (render-invaders invaders)
  (cond [(empty? invaders) BACKGROUND]
        [else (place-image INVADER (invader-x (first invaders)) (invader-y (first invaders))
                           (render-invaders (rest invaders)))]
        ))
