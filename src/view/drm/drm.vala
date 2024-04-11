namespace Dm.View {

[GtkTemplate(ui="/io/github/ydalton/DeviceViewer/ui/view/drm/device.ui")]
public class DrmDevice : Adw.Bin {
	[GtkChild]
	private unowned Gtk.Label title;
	[GtkChild]
	private unowned Gtk.Label driver_name;

	public DrmDevice(Dm.Model.Device _device) {
		this.title.label = @"/dev/dri/$(_device.name)";
		this.driver_name.label = @"Driver name: $(_device.driver)";
	}
}

[GtkTemplate(ui="/io/github/ydalton/DeviceViewer/ui/view/drm/drm.ui")]
public class Drm : Adw.Bin {
	[GtkChild]
	private unowned Gtk.Box devices;
	private Dm.Model.Drm _model;

	construct {
		_model = new Dm.Model.Drm();

		foreach (var device in _model.devices) {
			var device_view = new DrmDevice(device);
			this.devices.append(device_view);
		}
	}
}

} // namespace Dm.View
