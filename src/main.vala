int main (string[] args) {
	var app = new Adw.Application(APP_ID, ApplicationFlags.DEFAULT_FLAGS);
	app.activate.connect(() => {
		var window = new Dm.Window(app);
		window.present();
	});
	return app.run(args);
}
