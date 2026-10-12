;; flatten-selection.lsp - Move selected objects to Z = 0
;; Command: FLAT2D
;; Usage: select objects; anything off the Z=0 plane lands on it
(defun c:FLAT2D ( / ss )
  (setq ss (ssget "\nSelect objects to flatten: "))
  (if ss
    (progn
      (command "_.MOVE" ss "" "0,0,1e99" "0,0,0")
      (princ (strcat "\n" (itoa (sslength ss)) " objects flattened to Z=0."))
    )
  )
  (princ)
)
