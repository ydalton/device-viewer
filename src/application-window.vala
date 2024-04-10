[GtkTemplate(ui="/io/github/ydalton/DeviceViewer/ui/window.ui")]
public class Dm.ApplicationWindow : Adw.ApplicationWindow {
	[GtkChild]
	private unowned Adw.NavigationPage main_page;
	[GtkChild]
	private unowned Gtk.Stack stack;
	/* HACK: apparently the DmPageDrm class isn't registered without putting it
	 * here.
	 */
	[GtkChild]
	private unowned Dm.PageDrm drm;

	[GtkCallback]
	public void notify_visible_child_cb()
	{
		main_page.title = stack.get_page(stack.visible_child).title;
	}

	public ApplicationWindow(Adw.Application app) {
		Object(application: app);

		notify_visible_child_cb();
	}
}
