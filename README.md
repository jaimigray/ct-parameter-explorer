# CT Parameter Explorer

An interactive page that helps anatomy students see how CT scan settings change the image, using real scans of a raccoon (*Procyon lotor*) skull.

> **Use a computer.** This tool is designed for a PC, Mac or laptop with a mouse and a large screen. It is not built for phones or tablets; visitors on those devices see a notice asking them to switch to a computer.

Choose an anatomical level, then change a scan setting and compare the result against a reference scan, side by side or with a wipe slider. Zoom and pan are shared between the two images, and a measurement tool reports mean, noise (SD) and contrast-to-noise ratio for the same spot in both scans.

**Settings that can be compared:** tube voltage (60 / 100 / 200 kV), beam filter (none / aluminum / brass), frame averaging (1 / 4), beam-hardening correction (0 / 0.1 / 0.5 / 1), ring reduction, and number of projections (7200 down to 112).

> All images are real reconstructions. The fewer-projection sets (3600, 1800, 900, 450, 225, 112) were re-reconstructed from every 2nd, 4th, 8th, 16th, 32nd and 64th radiograph of the same 7200-projection scan, with the same reconstruction settings. (225 cannot be halved evenly, so the last set is 7200 / 64 rounded down to 112.)

## Run it locally

The page loads its slices with `fetch()`, so it must be served over http (opening `index.html` directly from disk will not work).

```powershell
powershell -ExecutionPolicy Bypass -File serve.ps1
```

Then open <http://localhost:3456/>.

## Data

`ct-data/` holds the slices at 8 anatomical levels (slice numbers 250, 450, 700, 913, 1100, 1300, 1450, 1600 of each 1825-slice stack). Each file is a 960 x 960, 16-bit, little-endian image, gzip-compressed, registered to a common grid. `ct-data/manifest.json` lists every scan, its settings, and the anatomical levels. The setting buttons in the app are built from this manifest, so adding a scan (a folder of 8 slices plus a manifest entry) adds its buttons automatically.

## Acknowledgement

Created by Dr. Jaimi A. Gray, [University of Texas High-Resolution X-ray Computed Tomography Facility](https://www.ctlab.geo.utexas.edu/).

These data and/or images were produced at the University of Texas High-Resolution X-ray CT Facility (UTCT), which is supported by NSF EAR-2223808 and NASA PSEF 80NSSC23K0199.
