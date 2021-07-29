project('minisat', 'c', 'cpp', version: '2.2')

coresrc = [
	'minisat/core/Solver.cc',
	'minisat/core/Solver.h',
	'minisat/core/SolverTypes.h',
	'minisat/mtl/Alg.h',
	'minisat/mtl/Alloc.h',
	'minisat/mtl/Heap.h',
	'minisat/mtl/IntMap.h',
	'minisat/mtl/IntTypes.h',
	'minisat/mtl/Map.h',
	'minisat/mtl/Sort.h',
	'minisat/mtl/Vec.h',
	'minisat/mtl/XAlloc.h',
	'minisat/utils/Options.h',
	'minisat/utils/ParseUtils.h',
	'minisat/utils/System.cc',
	'minisat/utils/System.h',
]


syssrc = [
	'minisat/core/Dimacs.h',
	'minisat/mtl/Queue.h',
	'minisat/mtl/Rnd.h',
	'minisat/utils/Options.cc',
	'minisat/utils/Options.h',
	'minisat/utils/ParseUtils.h',
	'minisat/utils/System.h',
	'minisat/utils/ZUtils.h',
]

dot = include_directories('.')

coreminisat = static_library('minisat-core', coresrc, install: true)
minisat_dep = declare_dependency(
	link_with: coreminisat,
	include_directories: dot
)

zlib = dependency('zlib', default_options: ['default_library=static'])
sysminisat = static_library('minisat-sys', syssrc, install: true, dependencies: [minisat_dep, zlib])
minisat_full_dep = declare_dependency(
	link_with: sysminisat,
	include_directories: dot
)

if not meson.is_subproject()
	executable('minisat', 'minisat/core/Main.cc', dependencies: [minisat_full_dep, zlib])
endif
