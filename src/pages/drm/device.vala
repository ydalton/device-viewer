class Dm.Drm.Device {
	public string driver { get; private set; }
	public string name { get; private set; }

	public Device(string name, string driver) {
		this.driver = driver;
		this.name = name;
	}
}
