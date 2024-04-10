int main (string[] args) {
	var app = new Adw.Application("io.github.ydalton.DeviceManager", 
								  ApplicationFlags.DEFAULT_FLAGS);
	app.activate.connect(() => {
		var window = new Dm.ApplicationWindow(app);
		window.present();
	});
	return app.run(args);
}
