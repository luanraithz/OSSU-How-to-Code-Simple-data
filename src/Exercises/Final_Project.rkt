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
    (has-been-shooted (first invader) missiles)
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

;(define (fn-for-invader invader)
  ;(... (invader-x invader) (invader-y invader) (invader-dx invader)))
;(missile-x m) (missile-y m)


(define (move-single-invader invader)
  (make-invader 
    (+ (invader-x invader) (invader-dx invader)) 
    (+ (invader-y invader) (invader-dx invader))
    (if (or (>= (invader-x invader) WIDTH) (<= (invader-x invader) 0)) 
      (* (invader-dx invader) -1)
      (invader-dx invader)
    ) 
  )
)

;(define (move-missles missiles)
  ;()
;)

(define (move-tank t)
  (make-tank (tank-x t) (+ (tank-x t) (tank-dir t))))