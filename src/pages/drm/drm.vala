const string DRM_SYSFS_DIR = "/sys/class/drm";

[GtkTemplate(ui="/io/github/ydalton/DeviceViewer/ui/pages/drm/drm.ui")]
public class Dm.Drm.Page : Adw.Bin {
	private List<Device> devices;

	private bool is_drm_device(string name) {
		Dir dir;
		try {
			dir = Dir.open(@"$DRM_SYSFS_DIR/$name");
		} catch {
			return false;
		}

		// Exclude renderD* devices
		if(name.has_prefix("render"))
			return false;

		while ((name = dir.read_name()) != null){
			// DRM devices don't have these
			switch(name) {
				case "enabled":
				case "dpms":
				case "connector_id":
					return false;
			}
		};
		return true;
	}

	private void debug_all_devices() {
		message("DRM devices:");
		foreach (var device in this.devices) {
			message("- %s %s", device.name, device.driver);
		}
	}

	construct {
		Dir sysdir;
		try {
			sysdir = Dir.open(DRM_SYSFS_DIR);
			string? name;
			while ((name = sysdir.read_name()) != null){
				if(is_drm_device(name)) {
					string driver = Path.get_basename(Posix.realpath(@"$DRM_SYSFS_DIR/$name/device/driver"));

					devices.append(new Device(name, driver));
				}
			};
		} catch (FileError e) {
			warning("Failed to open %s as directory: %s\n", DRM_SYSFS_DIR, e.message);
		}

		debug_all_devices();
	}
}
