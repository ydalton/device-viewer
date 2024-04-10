blueprints = custom_target('blueprints',
  input: files(
    'window.blp',
    'pages/drm/drm.blp',
  ),
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
  'application-window.vala',
  'pages/drm/drm.vala',
)
