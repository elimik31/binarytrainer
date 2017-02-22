;; Program intended for training the conversion of binary numbers to decimal ones.
;; Might add functionality for decimal to binary and also hex support.
;; Inspired by the "Binary Challenge" App for Android

;; Users should already understand binary and hex numbers and change of basis
;; Goal is memorization of simple numbers and binary patterns


;; for better format (with change of based) and might need for better loops
(require 'cl)

(setq nbits 8)

(defun num-to-binarystring (num nbits)
  (let ((formatstring (concat
                       "~"
                       (number-to-string nbits)
                       ",'0,' ,4:b")))
    (cl-format nil formatstring num)))

;; test code
;; (num-to-binarystring 1 20)


(defun play-binary ()
  (interactive "p")
  (let ((continue t))
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

(provide 'binarytrainer)
