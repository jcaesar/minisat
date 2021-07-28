project('minisat', 'c', 'cpp', version: '2.2')

src = [
	'minisat/core/Solver.cc',
	'minisat/core/Solver.h',
	'minisat/core/SolverTypes.h',
	'minisat/mtl/Alg.h',
	'minisat/mtl/Alloc.h',
	'minisat/mtl/IntMap.h',
	'minisat/mtl/IntTypes.h',
	'minisat/mtl/Map.h',
	'minisat/mtl/Vec.h',
	'minisat/utils/System.cc',
]

dot = include_directories('.')

minisat = static_library('minisat', src, install: true)
minisat_dep = declare_dependency(
	link_with: minisat,
	include_directories: dot
)
