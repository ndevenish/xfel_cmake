#!/usr/bin/env python

from pathlib import Path
import re
import os
import ast

libtbx_config = ast.literal_eval(Path("src/xfel/libtbx_config").read_text())

locations = ["."] + libtbx_config["extra_command_line_locations"]
paths = [Path("src/xfel")/x /"command_line" for x in locations]

entries = []
for path in paths:
    for script in sorted(path.glob("*.py")):
        if script.name.startswith("_"):
            continue
        name = f"xfel.{script.stem}"
        data = script.read_text()
        if match := re.search(r"^\s*#\s*LIBTBX_SET_DISPATCHER_NAME\s*([^\s]+)", data, re.M):
            name = match.group(1)
        # print(f"Writing {script.name} as {name}")
        entries.append((name, script.relative_to(Path("src"))))

# Write a new file that dispatches to all of these
with Path("src/xfel/command_line/_console_scripts.py").open("w") as cs, Path("entry_points.ini").open("w") as ep:
    cs.write("""import runpy""")
    ep.write("[console_scripts]\n")
    for cliname, filename in sorted(entries):
        fn_name = cliname.replace(".", "_")
        import_name = ".".join(filename.parent.parts) + "." + filename.stem
        cs.write(f'\n\ndef {fn_name}():\n    runpy.run_module("{import_name}", run_name="__main__")')
        ep.write(f'{cliname} = xfel.command_line._console_scripts:{fn_name}\n')
print("Rewritten entry_points.ini and _console_scripts.py")