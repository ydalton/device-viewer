[GtkTemplate(ui="/io/github/ydalton/DeviceViewer/ui/window.ui")]
public class Dm.Window : Adw.ApplicationWindow {
	[GtkChild]
	private unowned Adw.NavigationPage main_page;
	[GtkChild]
	private unowned Gtk.Stack stack;

	[GtkCallback]
	public void notify_visible_child_cb()
	{
		main_page.title = stack.get_page(stack.visible_child).title;
	}

	/* Ensure type of component so that its type is registered when using it in
	 * a UI file.
	 */
	static construct {
		typeof(Dm.View.Drm).ensure();
		typeof(Dm.View.Monitors).ensure();
	}

	public Window(Adw.Application app) {
		Object(application: app);

		notify_visible_child_cb();
	}
}
