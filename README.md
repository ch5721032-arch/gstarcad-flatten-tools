# GstarCAD Flatten Tools

Bring geometry back to the Z=0 plane and scan the drawing for objects that are not flat.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Nothing causes strange snapping and plotting problems like geometry floating slightly off the Z=0 plane. These commands move a selection back onto Z=0 in one step, and scan the drawing for objects that are not on the plane so 2D drawings stay truly flat.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/flatten-selection.lsp` | ;; flatten-selection.lsp - Move selected objects to Z = 0
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
 |
| `scripts/zero-z-report.lsp` | ;; zero-z-report.lsp - Find objects that are not on the Z=0 plane
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
