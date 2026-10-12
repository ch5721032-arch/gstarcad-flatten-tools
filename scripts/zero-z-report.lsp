;; zero-z-report.lsp - Find objects that are not on the Z=0 plane
;; Command: ZZREPORT
(defun c:ZZREPORT ( / ss i en ed p z n )
  (setq ss (ssget "_X") i 0 n 0)
  (if ss
    (repeat (sslength ss)
      (setq en (ssname ss i)
            ed (entget en)
            p  (cdr (assoc 10 ed))
            z  (if (and p (caddr p)) (caddr p) 0.0))
      (if (/= z 0.0)
        (progn
          (princ (strcat "\nZ=" (rtos z 2 4) " on " (cdr (assoc 0 ed))))
          (setq n (1+ n))
        )
      )
      (setq i (1+ i))
    )
  )
  (princ (strcat "\nObjects off the Z=0 plane: " (itoa n)))
  (princ)
)
