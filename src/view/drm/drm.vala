namespace Dm.View {

[GtkTemplate(ui="/io/github/ydalton/DeviceViewer/ui/view/drm/device.ui")]
public class DrmDevice : Adw.Bin {
	[GtkChild]
	private unowned Adw.ActionRow title;
	[GtkChild]
	private unowned Adw.ActionRow driver_name;
	[GtkChild]
	private unowned Adw.ActionRow type;

	public DrmDevice(Dm.Model.Device _device) {
		this.title.subtitle = @"/dev/dri/$(_device.name)";
		this.driver_name.subtitle = _device.driver;
		this.type.subtitle = _device.gpu ? "Yes" : "No";
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
