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
		typeof(Dm.PageDrm).ensure();
		typeof(Dm.PageMonitors).ensure();
	}

	public Window(Adw.Application app) {
		typeof(Dm.PageDrm).ensure();
		Object(application: app);

		notify_visible_child_cb();
	}
}
