blueprint_sources = files(
  'window.blp'
)
subdir('pages')

blueprints = custom_target('blueprints',
  input: blueprint_sources,
  output: '.',
  command: [
    find_program('blueprint-compiler'), 
    'batch-compile', 
    '@OUTPUT@', 
    '@CURRENT_SOURCE_DIR@', 
    '@INPUT@'
  ],
)

devmgr_sources += gnome.compile_resources(
  'dm-resources',
  'dm.gresources.xml',
  c_name: 'dm_resources_',
  dependencies: blueprints
)

devmgr_sources += files(
  'main.vala',
  'window.vala',
)
