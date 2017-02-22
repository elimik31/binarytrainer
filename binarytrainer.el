;; Program intended for training the conversion of binary numbers to decimal ones.
;; Inspired by the "Binary Challenge" App for Android.
;; Users should already understand binary and hex numbers and change of basis.
;; Goal is memorization of simple numbers and binary patterns.

;; TODO's:
;; - Add proper documentation and naming schemes
;; - Use single interactive function with different modes
;; - Use extra game buffer instead of message area
;; - Add mode to convert other way round
;; - Implement arbitrary base conversion not dependening on cl-format
;; - Add highscores
;; - Additionaly to the random mode, add memorization mode with priority list
;;   where numbers where you make mistakes come more frequently.

;; used for cl-format
(require 'cl) 

(defun num-to-binarystring (num nbits)
  "Returns NUM as a string in binary representation, with NBITS of padding"
  (let ((formatstring (concat
                       "~"
                       (number-to-string nbits)
                       ",'0,' ,4:b")))
    (cl-format nil formatstring num)))

(defun num-to-hexstring (num nbits)
  "Returns NUM as a string in hex representation, with NBITS/4 of padding"
  (let ((formatstring (concat
                       "~"
                       (number-to-string (ceiling (/ nbits 4)))
                       ",'0,' ,4:x")))
    (cl-format nil formatstring num)))

(num-to-hexstring 35 16)

(defun play-binary ()
  "Train decimal to binary conversion"
  (interactive)
  (let ((continue t)
        (nbits (string-to-number (read-string "Play with number of bits: "))))
    (while continue
      (let* ((current-num (random  (expt 2 nbits)))
            (binstring (num-to-binarystring current-num nbits)))
        (if (equal
             (string-to-number
              (read-string (format "Binary: %s\nDecimal value: " binstring)))
             current-num)
            (message "Correct")
          ;; else
          (message (format "Wrong, decimal representation of %s is %d."
                           binstring current-num)))
        (setq continue (equal (read-event) 'return))))))

(defun play-hex ()
  "Train decimal to hex conversion"
  (interactive)
  (let ((continue t)
        (nbits (string-to-number (read-string "Play with number of bits: "))))
    (while continue
      (let* ((current-num (random  (expt 2 nbits)))
            (hexstring (num-to-hexstring current-num nbits)))
        (if (equal
             (string-to-number
              (read-string (format "Hex: %s\nDecimal value: " hexstring)))
             current-num)
            (message "Correct")
          ;; else
          (message (format "Wrong, decimal representation of %s is %d."
                           hexstring current-num)))
        (setq continue (equal (read-event) 'return))))))

(provide 'binarytrainer)
