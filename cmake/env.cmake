# SPDX-License-Identifier: MIT
#
# Load from a .env file variables into cmake, enabling easy
# deterministic overwrite of specific variables.

set(ENV_FILE "${CMAKE_CURRENT_LIST_DIR}/../.env")
if(NOT EXISTS ${ENV_FILE})
    return()
endif()

file(READ "${ENV_FILE}" OUT_ENV_FILE)

# foreach every newline
string(REGEX MATCHALL "[^ \t\r\n]+" LINES_OUT ${OUT_ENV_FILE})
foreach(LINE IN LISTS LINES_OUT)
    string(REGEX MATCH "^ *\([^=]*\) *= *\(.*\)$"
        REGEX_OUT ${LINE})

    set(${CMAKE_MATCH_1} "${CMAKE_MATCH_2}")
endforeach()
