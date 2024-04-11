project('io.github.ydalton.DeviceViewer', ['c', 'vala'],
  version : '0.1')

valac = meson.get_compiler('vala')

dependencies = [
    dependency('libadwaita-1'),
    valac.find_library('posix'),
]

gnome = import('gnome')
i18n = import('i18n')

devmgr_sources = files()
subdir('src')
subdir('po')

conf = configuration_data()
conf.set_quoted('APP_ID', meson.project_name())
conf.set_quoted('VERSION', meson.project_version())

config_file = configure_file(
  input: 'src/config.vala.in',
  output: '@BASENAME@',
  configuration: conf
)

devmgr_sources += config_file

exe = executable(
  meson.project_name(), 
  devmgr_sources, 
  dependencies: dependencies,
  vala_args: [
    '--gresourcesdir=' + blueprints.full_path(),
  ],
  install : true
)
