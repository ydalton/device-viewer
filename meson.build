project('io.github.ydalton.DeviceViewer', ['c', 'vala'],
  version : '0.1')

dependencies = [
    dependency('libadwaita-1'),
]

gnome = import('gnome')

devmgr_sources = files()
subdir('src')

exe = executable(
  meson.project_name(), 
  devmgr_sources, 
  dependencies: dependencies,
  vala_args: [
    '--gresourcesdir=' + blueprints.full_path(),
  ],
  install : true
)
