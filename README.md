# XFEL-cmake

Steps:

1.  Run `prepare_xfel.sh`. This will check out `cctbx_project` (if not
    already done), and copy the `xfel` module files to the right places.
2.  Run `python3 generate_console_scripts.py`. This will walk over the
    module sources, generate a `console_scripts`-compatible entry point
    for each CLI script, and write an `entry_points.ini` file for
    setuptools.
3.  `pip install -e .`. This will install into the currently active
    python environment. Currently, plain installing (non-editable) does
    not work.
4.  Build the C++ parts: Generally, `mkdir build && cd build && cmake .. && make`.
    You will need to Take Steps to ensure these modules can be found by the
    runtime python modules e.g. export PYTHONPATH or similar. This is
    currently not done.
