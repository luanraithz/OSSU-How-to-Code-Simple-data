;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Final_Project) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders

;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)
(define INVADER-Y-SPEED 1.2)
(define TANK-SPEED 4)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 100)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")
              -5 6
              (ellipse 20 10 "solid"   "blue")))

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")
                       (ellipse 30 10 "solid" "green"))
              5 -14
              (above (rectangle 5 10 "solid" "black")
                     (rectangle 20 10 "solid" "black"))))

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))

(define MISSILE (ellipse 5 15 "solid" "red"))

(define GAME_OVER_BACKGROUND 
  (place-image (text "Game over" 24 "black") (/ WIDTH 2) (- (/ HEIGHT 2) 30) 
    (place-image (text "Press space to start again" 15 "black") (/ WIDTH 2) (/ HEIGHT 2) BACKGROUND)))

;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right

(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                       ;not hit U1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1

(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))

(define INITIAL_STATE (make-game 
  (list (make-invader (/ WIDTH 2) 0 1) (make-invader (* (/ WIDTH 4) 3) 70 -1))
  empty
  T1
))

(define (main initial-game-state)
  (big-bang initial-game-state
    (on-tick next-state)
    (to-draw render-game)
    (on-key on-key-pressed)
  ))

(define (on-key-pressed c key) 
  (cond 
    [(and (boolean? c) (not c) (key=? key " ")) INITIAL_STATE]
    [(key=? key " ") (shoot c)]
    [(key=? key "left") (change-direction-to-left c)]
    [(key=? key "right") (change-direction-to-right c)]
    [else c]
  ))

(define (render-game game) 
  (cond 
    [(and (boolean? game) (not game)) GAME_OVER_BACKGROUND]
    [else 
      (render-missiles (game-missiles game) (render-tank (game-tank game) (render-invaders (game-invaders game))))
    ]
  )
)

(define (next-state s)
  (cond
   [(and (boolean? s) (not s)) false]
   [(is-game-over? s) false]
   [else 
      (make-game (move-invaders-and-delete-shooted (add-invader-randomly (game-invaders s)) (game-missiles s))
          (move-missiles (filter-missiles (game-missiles s) (game-invaders s)))
          (move-tank (game-tank s))
      )
   ]
  )
)

;; ListOfInvaders -> ListOfInvaders
;; ramdomly add new invader with random X position
(define (add-invader-randomly invaders)
  (if (= (random 27) 0) 
    (cons (make-invader (random WIDTH) 30 1) invaders)
    invaders))

(define (move-invaders-and-delete-shooted invaders missiles)
  (cond 
   [(empty? invaders) empty]
   [(isNear? (first invaders) missiles) (move-invaders-and-delete-shooted (rest invaders) missiles)]
   [else (cons (move-single-invader (first invaders)) (move-invaders-and-delete-shooted (rest invaders) missiles))]
  )
)

;; ListOfMissiles ListOfInvasors -> ListOfMissiles
;; filter the missiles based on if there is a invasor near

(check-expect (filter-missiles empty empty) empty)
(check-expect (filter-missiles (list M1 M2 M3) (list I1 I2 I3)) (list M1))

(define (filter-missiles missiles invasors)
  (cond 
    [(empty? missiles) empty]
    [(has-any-invasors-near? (first missiles) invasors) (filter-missiles (rest missiles) invasors)]
    [else (cons (first missiles) (filter-missiles (rest missiles) invasors))]
  )
)

;; Missile ListOfInvasor -> Boolean

(check-expect (has-any-invasors-near? M2 (list I1)) true)
(check-expect (has-any-invasors-near? M3 (list I1)) true)
(check-expect (has-any-invasors-near? M1 (list I1)) false)

(define (has-any-invasors-near? missile invaders)
  (cond 
    [(empty? invaders) false]
    [else 
      (or 
        (isNear? (first invaders) (list missile)) 
        (has-any-invasors-near? missile (rest invaders))
      )
    ]
  )
)

;; ListOfMissiles Invader -> ListOfMissiles
;; remove the missiles that are near of a given invader

(check-expect (remove-near-missiles empty empty) empty)
(check-expect (remove-near-missiles (list M1 M2 M3) I1) (list M1))

(define (remove-near-missiles missiles invader)
  (cond 
    [(empty? missiles) empty]
    [(isNear? invader (cons (first missiles) empty)) (remove-near-missiles (rest missiles) invader) ]
    [else (cons (first missiles) (remove-near-missiles (rest missiles) invader))]
  )
)   

;; Invader missile -> Boolean
;; produces if the invader is near the missile, by 15 px

(check-expect (isNear? I1 (list M1)) false)
(check-expect (isNear? I1 (list M2)) true)
(check-expect (isNear? I1 (list M3)) true)

(define (isNear? invader missiles)
  (cond 
    [(empty? missiles) false]
    [else   
      (or (and 
        (< (missile-x (first missiles)) (+ (invader-x invader) 15)) (> (missile-x (first missiles)) (- (invader-x invader) 15))
        (< (missile-y (first missiles)) (+ (invader-y invader) 15)) (> (missile-y (first missiles)) (- (invader-y invader) 30))
      ) (isNear? invader (rest missiles)) )
    ])
  
)

;; Invader -> Invader
;; produces a new invader with the x + speed and y + speed, and inverts speed if the
;; invader has cross the edge

(check-expect (move-single-invader (make-invader 10 12 1))
              (make-invader (+ 10 INVADER-X-SPEED) (+ 12 INVADER-Y-SPEED) 1))

(check-expect (move-single-invader (make-invader (- WIDTH 1) 200 1))
              (make-invader  (+ (- WIDTH 1) INVADER-X-SPEED) (+ 200 INVADER-Y-SPEED) -1))

(check-expect (move-single-invader (make-invader WIDTH 210 1))
              (make-invader (+ WIDTH INVADER-X-SPEED) (+ 210 INVADER-Y-SPEED) -1))

(check-expect (move-single-invader (make-invader WIDTH 210 -1))
              (make-invader (- WIDTH INVADER-X-SPEED) (+ 210 INVADER-Y-SPEED) -1))

(define (move-single-invader invader)
  (make-invader 
    (+ (invader-x invader) (* (invader-dx invader) INVADER-X-SPEED)) 
    (+ (invader-y invader) INVADER-Y-SPEED)
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

;; Tank Image -> Image
;; produces a tank over a given image

(define INI (render-invaders (cons (make-invader 70 40 1) (cons (make-invader 20 70 1) empty))))

(check-expect (render-tank (make-tank 30 1) BACKGROUND)
     (place-image TANK 30 (- HEIGHT 25) BACKGROUND))

(check-expect (render-tank (make-tank 30 1) INI)
     (place-image TANK 30 (- HEIGHT 25) INI))

(define (render-tank tank image)
  (place-image TANK (tank-x tank) (- HEIGHT 25) image))

;; ListOfMissiles Image -> Image
;; produces the given image with the missiles

(check-expect (render-missiles empty BACKGROUND) BACKGROUND);

(define M4 (make-missile 100 50))
(check-expect (render-missiles (list M1 M2 M4) BACKGROUND)
     (place-image MISSILE (missile-x M1) (missile-y M1)
       (place-image MISSILE (missile-x M2) (missile-y M2)
         (place-image MISSILE (missile-x M4) (missile-y M4) BACKGROUND))))

(define TANKANDINVADERS (render-tank (make-tank 30 1) INI))

(check-expect (render-missiles (list M1 M2 M4) TANKANDINVADERS)
     (place-image MISSILE (missile-x M1) (missile-y M1)
       (place-image MISSILE (missile-x M2) (missile-y M2)
         (place-image MISSILE (missile-x M4) (missile-y M4) TANKANDINVADERS))))
    
(define (render-missiles missiles image)
  (cond 
    [(empty? missiles) image]
    [else (place-image MISSILE (missile-x (first missiles)) (missile-y (first missiles)) (render-missiles (rest missiles) image))])
  )

;; ListOfMissiles -> ListOfMissiles
;; moves the given missiles up;

(check-expect (move-missiles empty) empty)
(check-expect (move-missiles (list M1 M2))
     (list
      (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED))
      (make-missile (missile-x M2) (- (missile-y M2) MISSILE-SPEED))))

(define (move-missiles missiles)
  (cond 
    [(empty? missiles) empty]
    [else
     (cons
      (make-missile (missile-x (first missiles)) (- (missile-y (first missiles)) MISSILE-SPEED))
      (move-missiles (rest missiles)))
    ]
  ))

(define (is-game-over? game)
  (is-any-invader-at-the-end? (game-invaders game)))

(define (is-any-invader-at-the-end? invaders)
  (cond 
    [(empty? invaders) false]
    [else 
      (or (> (invader-y (first invaders)) (- HEIGHT (image-height TANK) 25))
       (is-any-invader-at-the-end? (rest invaders)))
      ]))

;; Game -> Game
;; inserts a new missile to the game, with current tank position as start

;(define G3 (make-game (list I1 I2) (list M1 M2) T1))

(check-expect (shoot (make-game empty (list M1 M2) T1))
  (make-game empty (list (make-missile (tank-x T1) (- HEIGHT 25)) M1 M2) T1))

(define (shoot game) 
  (make-game (game-invaders game) (cons (make-missile (tank-x (game-tank game)) (- HEIGHT 25)) (game-missiles game)) (game-tank game)))

;; Game -> Game
;; turns the tank to the left direction
(check-expect (change-direction-to-left (make-game empty (list M1 M2) T1))
              (make-game empty (list M1 M2) (make-tank (tank-x T1) -1)))

(define (change-direction-to-left game) 
  (make-game (game-invaders game) (game-missiles game) (make-tank (tank-x (game-tank game)) -1)))

;; Game -> Game 
;; turns the tank to the right
(check-expect (change-direction-to-right (make-game empty (list M1 M2) T1))
  (make-game empty (list M1 M2) (make-tank (tank-x T1) 1)))

(define (change-direction-to-right game)
  (make-game (game-invaders game) (game-missiles game) (make-tank (tank-x (game-tank game)) 1))
)

(main INITIAL_STATE)