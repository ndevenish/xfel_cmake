# Distributes under BSD licence

# .rst:
# FindDIALS
# ---------
#
# Finds the DIALS package.
#
# Creates DIALS::dials target.

# Don't reconfigure every time
if(TARGET DIALS::dials)
    return()
endif()

# If python isn't already included, pull it in here
if(NOT TARGET Python::Interpreter)
    find_package(Python COMPONENTS Interpreter REQUIRED)
endif()

message(DEBUG "Looking for dials build dir via importing in python")
execute_process(COMMAND ${Python_EXECUTABLE} -c "import dials, pathlib; print(pathlib.Path(dials.__file__).parent.resolve())"
    RESULT_VARIABLE _IMPORT_RESULT
    OUTPUT_VARIABLE _IMPORT_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET)

if(NOT ${_IMPORT_RESULT})
    # We found it via python import
    set(DIALS_DIR "${_IMPORT_DIR}")
endif()

if(DIALS_DIR)
    add_library(DIALS::dials INTERFACE IMPORTED)
    cmake_path(GET DIALS_DIR PARENT_PATH _dials_include_root)
    target_include_directories(DIALS::dials INTERFACE "${_dials_include_root}")
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DIALS
    REQUIRED_VARS DIALS_DIR
    HANDLE_COMPONENTS
)