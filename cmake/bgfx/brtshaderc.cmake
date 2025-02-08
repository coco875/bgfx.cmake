# bgfx.cmake - bgfx building in cmake
# Written in 2017 by Joshua Brookover <joshua.al.brookover@gmail.com>
#
# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication along with
# this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

if( NOT BRTSHADERC_DIR )
	set( BRTSHADERC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/brtshaderc" CACHE STRING "Location of brtshaderc." )
elseif( NOT IS_ABSOLUTE "${BRTSHADERC_DIR}")
	get_filename_component(BRTSHADERC_DIR "${BRTSHADERC_DIR}" REALPATH BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
endif()

# Grab the brtshaderc source files
file(
	GLOB
	BRTSHADERC_SOURCES #
	${BGFX_DIR}/tools/shaderc/*.cpp #
	${BGFX_DIR}/tools/shaderc/*.h #
	${BGFX_DIR}/src/shader* #
    ${BRTSHADERC_DIR}/*.cpp #
    ${BRTSHADERC_DIR}/*.h #
)

add_library(brtshaderc ${BRTSHADERC_SOURCES})

target_include_directories(brtshaderc PRIVATE ${BRTSHADERC_DIR})

target_link_libraries(
	brtshaderc
	PRIVATE bx
			bgfx-vertexlayout
			fcpp
			glslang
			glsl-optimizer
			spirv-opt
			spirv-cross
)
target_link_libraries(
	brtshaderc
	PRIVATE bx
			bimg
			bgfx-vertexlayout
			fcpp
			glslang
			glsl-optimizer
			spirv-opt
			spirv-cross
			webgpu
)
if(BGFX_AMALGAMATED)
	target_link_libraries(brtshaderc PRIVATE bgfx-shader)
endif()

set_target_properties(
	brtshaderc PROPERTIES FOLDER "bgfx/tools" #
					   OUTPUT_NAME ${BGFX_TOOLS_PREFIX}brtshaderc #
)
