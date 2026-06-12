#!/usr/bin/env python3
"""Mark the MOUSE-layer activator key as 'held' in the parsed keymap-drawer YAML.

keymap-drawer auto-highlights the key that activates each layer, but it can't see
through the &mslt -> ms_hold macro that activates MOUSE (the macro also holds Pause
to flip the trackball daemon into scroll mode). So we mark it by hand here, matching
how the other layers' activators are highlighted.
"""
import sys
import yaml

f = sys.argv[1] if len(sys.argv) > 1 else "glove80.kd.yaml"
d = yaml.safe_load(open(f))
d["layers"]["mouse"][65] = {"type": "held"}  # left C5R6 = the `mouse` key
yaml.safe_dump(d, open(f, "w"), sort_keys=False, allow_unicode=True, width=1000)
