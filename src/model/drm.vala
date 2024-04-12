const string DRM_SYSFS_DIR = "/sys/class/drm";

namespace Dm.Model {

public class Device {
	public string driver { get; private set; }
	public string name { get; private set; }
	public bool gpu { get; private set; }

	public Device(string name, string driver, bool gpu) {
		this.driver = driver;
		this.name = name;
		this.gpu = gpu;
	}

	public string to_string() {
		return @"{ name: $(this.name) driver: $(this.driver): rendering_device: $(this.gpu) }";
	}
}

public class Drm : Object {
	public List<Device> devices;
	private List<string> render_nodes;

	private bool is_drm_device(string name) {
		Dir dir;
		try {
			dir = Dir.open(@"$DRM_SYSFS_DIR/$name");
		} catch {
			return false;
		}

		// Exclude renderD* devices
		if(name.has_prefix("render")) {
			this.render_nodes.append(name);
			return false;
		}

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
			message(@"- $device");
		}
		message("DRM render nodes:");
		foreach(var render_node in this.render_nodes) {
			message(@"- $render_node");
		}
	}

	/* HACK: since the Linux kernel interface does not seem to expose the driver
	 * capabilities, go down the sysfs tree to find that information ourselves.
	 */
	private bool is_gpu(string driver_name) {
		foreach(var render_node in this.render_nodes) {
			/* A DRM device is a rendering device if it has an associated render node */
			string? path = Posix.realpath(@"$DRM_SYSFS_DIR/$render_node/device/driver");
			/* FIXME: systems with more than 2 GPUs might need special attention */
			if(path != null && driver_name == Path.get_basename(path))
				return true;
		}
		return false;
	}

	construct {
		Dir sysdir;
		try {
			sysdir = Dir.open(DRM_SYSFS_DIR);
			string? name;
			while ((name = sysdir.read_name()) != null){
				if(is_drm_device(name)) {
					string driver = Path.get_basename(Posix.realpath(@"$DRM_SYSFS_DIR/$name/device/driver"));

					devices.append(new Device(name, driver, is_gpu(driver)));
				}
			};
		} catch (FileError e) {
			warning("Failed to open %s as directory: %s\n", DRM_SYSFS_DIR, e.message);
		}

		debug_all_devices();
	}
}

} // namespace Dm.Model
