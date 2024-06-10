using SmartDevicesService.Models;
using static SmartDevicesService.Utils.SmartDeviceValidator;

namespace TestProject.SmartDevicesService;

public class SmartDeviceValidatorTest
{
    private List<SmartDevice> _smartDevices;
    private DateTime defaultNow;
    private List<InversorDataDelegate> inversorData;
    private List<PropertyHourWeatherDelegate> weatherData;
    [SetUp]
    public void Setup()
    {
        defaultNow = new DateTime(2024, 01, 01, 00, 30, 00);
        _smartDevices = [
            new(id: "0", name:"Device 0", timeZones: ["2024-01-01 00:02:00.000 - 2024-01-01 01:01:00.000"], days: [true, true, true, true, true, true, true], isManualMode: true, isOn: false), // Manual mode
            new(id: "1", name:"Device 1", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [false, false, false, false, false, false, false], isManualMode: false, isOn: false), // No days
            new(id: "2", name:"Device 2", timeZones: ["2024-01-01 00:30:01.000 - 2024-01-01 01:00:00.000"], days: [true, true, true, true, true, true, true], isManualMode: false, isOn: false), // Out of time (up)
            new(id: "3", name:"Device 3", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [true, true, true, true, true, true, true], isManualMode: false, isOn: false), // In time
            new(id: "4", name:"Device 4", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 00:29:59.000"], days: [true, true, true, true, true, true, true], isManualMode: false, isOn: false), // Out of time (down)
            new(id: "5", name:"Device 5", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [true, false, false, false, false, false, false], isManualMode: false, isOn: false), // Lunes
            new(id: "6", name:"Device 6", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [false, false, false, false, false, false, true], isManualMode: false, isOn: false), // Domingo
            new(id: "7", name:"Device 7", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [true, true, true, true, true, true, true], isManualMode: false, isOn: false, temperatureRange: "20:40"), // Temperature
            new(id: "8", name:"Device 8", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [true, true, true, true, true, true, true], isManualMode: false, isOn: false, rainRange: "10:90"), // Rain
            new(id: "9", name:"Device 9", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [true, true, true, true, true, true, true], isManualMode: false, isOn: false, batteryRange: "10:90"), // Battery
            new(id: "10", name:"Device 10", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [true, true, true, true, true, true, true], isManualMode: false, isOn: false, consumptionRange: "100:3000"), // Consumption
            new(id: "11", name:"Device 11", timeZones: ["2024-01-01 00:00:00.000 - 2024-01-01 01:00:00.000"], days: [true, true, true, true, true, true, true], isManualMode: false, isOn: false, productionRange: "100:3000"), // Production
        ];
        inversorData = [
            (string id) => { return Task.FromResult(new InversorData(battery:10, consumption:100, gain:100)); }, // All ok (down)
            (string id) => { return Task.FromResult(new InversorData(battery:90, consumption:3000, gain:3000)); }, // All ok (up)
            (string id) => { return Task.FromResult(new InversorData(battery:9, consumption:100, gain:100)); }, // Out of range Battery (down)
            (string id) => { return Task.FromResult(new InversorData(battery:91, consumption:3000, gain:3000)); }, // Out of range Battery (up)
            (string id) => { return Task.FromResult(new InversorData(battery:10, consumption:99, gain:100)); }, // Out of range Consumption (down)
            (string id) => { return Task.FromResult(new InversorData(battery:90, consumption:3001, gain:3000)); }, // Out of range Consumption (up)
            (string id) => { return Task.FromResult(new InversorData(battery:10, consumption:100, gain:99)); }, // Out of range Production (down)
            (string id) => { return Task.FromResult(new InversorData(battery:90, consumption:3000, gain:3001)); } // Out of range Production (up)
        ];
        weatherData =
        [
            (DateTime id,string idc) => { return Task.FromResult(new PropertyHourWeather(defaultNow.ToString(), defaultNow.AddHours(3).ToString(), 20, 19, 21, 22, 30, 5.45, 10, "", "")); }, // All ok (down)
            (DateTime id,string idc) => { return Task.FromResult(new PropertyHourWeather(defaultNow.ToString(), defaultNow.AddHours(3).ToString(), 40, 39, 41, 22, 30, 5.45, 90, "", "")); }, // All ok (up)
            (DateTime id,string idc) => { return Task.FromResult(new PropertyHourWeather(defaultNow.ToString(), defaultNow.AddHours(3).ToString(), 19, 19, 21, 22, 30, 5.45, 10, "", "")); }, // Out of range Temperature (down)
            (DateTime id,string idc) => { return Task.FromResult(new PropertyHourWeather(defaultNow.ToString(), defaultNow.AddHours(3).ToString(), 41, 39, 41, 22, 30, 5.45, 90, "", "")); }, // Out of range Temperature (up)
            (DateTime id,string idc) => { return Task.FromResult(new PropertyHourWeather(defaultNow.ToString(), defaultNow.AddHours(3).ToString(), 20, 19, 21, 22, 30, 5.45, 9, "", "")); }, // Out of range Rain (down)
            (DateTime id,string idc) => { return Task.FromResult(new PropertyHourWeather(defaultNow.ToString(), defaultNow.AddHours(3).ToString(), 40, 39, 41, 22, 30, 5.45, 91, "", "")); } // Out of range Rain (up)
        ];
    }
    [Test]
    public void TestManualMode()
    {
        Assert.Multiple(async () =>
        {
            Assert.That(await SmartDeviceValidate(_smartDevices[0], inversorData[0], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[1], inversorData[0], weatherData[0], "", defaultNow), Is.False);
        });
    }

    [Test]
    public void TestDateTime()
    {
        Assert.Multiple(async () =>
        {
            Assert.That(await SmartDeviceValidate(_smartDevices[3], inversorData[0], weatherData[0], "", defaultNow.AddDays(10)), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[2], inversorData[0], weatherData[0], "", defaultNow), Is.False);
            Assert.That(await SmartDeviceValidate(_smartDevices[4], inversorData[0], weatherData[0], "", defaultNow.AddDays(-80)), Is.False);
        });
    }

    [Test]
    public void TestDays()
    {
        var sunday = new DateTime(2024, 01, 07, 00, 30, 00);
        var monday = new DateTime(2024, 01, 01, 00, 30, 00);
        var tuesday = new DateTime(2024, 01, 02, 00, 30, 00);
        Assert.Multiple(async () =>
        {
            Assert.That(await SmartDeviceValidate(_smartDevices[2], inversorData[0], weatherData[0], "", defaultNow), Is.False);
            Assert.That(await SmartDeviceValidate(_smartDevices[5], inversorData[0], weatherData[0], "", tuesday), Is.False);
            Assert.That(await SmartDeviceValidate(_smartDevices[5], inversorData[0], weatherData[0], "", monday), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[6], inversorData[0], weatherData[0], "", sunday), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[6], inversorData[0], weatherData[0], "", tuesday), Is.False);
        });
    }

    [Test]
    public void TestBattery()
    {
        Assert.Multiple(async () =>
        {
            Assert.That(await SmartDeviceValidate(_smartDevices[9], inversorData[0], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[9], inversorData[1], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[9], inversorData[2], weatherData[0], "", defaultNow), Is.False);
            Assert.That(await SmartDeviceValidate(_smartDevices[9], inversorData[3], weatherData[0], "", defaultNow), Is.False);
        });
    }

    [Test]
    public void TestConsumption()
    {
        Assert.Multiple(async () =>
        {
            Assert.That(await SmartDeviceValidate(_smartDevices[10], inversorData[0], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[10], inversorData[1], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[10], inversorData[4], weatherData[0], "", defaultNow), Is.False);
            Assert.That(await SmartDeviceValidate(_smartDevices[10], inversorData[5], weatherData[0], "", defaultNow), Is.False);
        });
    }

    [Test]
    public void TestProduction()
    {
        Assert.Multiple(async () =>
        {
            Assert.That(await SmartDeviceValidate(_smartDevices[11], inversorData[0], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[11], inversorData[1], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[11], inversorData[6], weatherData[0], "", defaultNow), Is.False);
            Assert.That(await SmartDeviceValidate(_smartDevices[11], inversorData[7], weatherData[0], "", defaultNow), Is.False);
        });
    }

    [Test]
    public void TestRain()
    {
        Assert.Multiple(async () =>
        {
            Assert.That(await SmartDeviceValidate(_smartDevices[8], inversorData[0], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[8], inversorData[0], weatherData[1], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[8], inversorData[0], weatherData[4], "", defaultNow), Is.False);
            Assert.That(await SmartDeviceValidate(_smartDevices[8], inversorData[0], weatherData[5], "", defaultNow), Is.False);
        });
    }

    [Test]
    public void TestTemperature()
    {
        Assert.Multiple(async () =>
        {
            Assert.That(await SmartDeviceValidate(_smartDevices[7], inversorData[0], weatherData[0], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[7], inversorData[0], weatherData[1], "", defaultNow), Is.True);
            Assert.That(await SmartDeviceValidate(_smartDevices[7], inversorData[0], weatherData[2], "", defaultNow), Is.False);
            Assert.That(await SmartDeviceValidate(_smartDevices[7], inversorData[0], weatherData[3], "", defaultNow), Is.False);
        });
    }
}