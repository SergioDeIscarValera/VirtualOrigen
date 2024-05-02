using SmartDevicesService.Models;
using SmartDevicesService.Services.Mqtt.Device;
using SmartDevicesService.Services.Repository.Device;
using SmartDevicesService.Services.Repository.InversorNow;
using SmartDevicesService.Services.Repository.PropertyWeather;
using SmartDevicesService.Utils;

Console.WriteLine("SmartDevicesService v1.0");
IPropertyHourWeatherRepository propertyHourWeatherRepository = PropertyHourWeatherRepositoryFirebase.Instance;
ISmartDeviceRepository smartDeviceRepository = SmartDeviceFirebaseRepository.Instance;
IInversorNow inversorNowRepository = InversorNowFirebaseRepository.Instance;
SmartDeviceMqttService smartDeviceMqttService = SmartDeviceMqttService.Instance;
// 1 -> Obtener todos los dispositivos de la propiedad
var propertyId = Environment.GetEnvironmentVariable("PROPERTY_ID") ?? throw new("PROPERTY_ID");
Console.WriteLine($"Property: {propertyId}");
await smartDeviceMqttService.StartAsync();
var devices = await smartDeviceRepository.GetAllAsync(propertyId);

DateTime utcNow = DateTime.UtcNow;
var timeZone = Environment.GetEnvironmentVariable("TIME_ZONE") ?? "Europe/Madrid";
TimeZoneInfo timeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(timeZone);
DateTime now = TimeZoneInfo.ConvertTimeFromUtc(utcNow, timeZoneInfo);
Console.WriteLine("Now: " + now);

foreach (var device in devices)
{
    Console.WriteLine($"Device: {device.Id}");
    // 2 -> Comprobar las condiciones del dispositivo
    bool isValid = await SmartDeviceValidator.SmartDeviceValidate(
        device,
        inversorNowRepository.GetByIdcAsync,
        propertyHourWeatherRepository.GetByIdAsync,
        propertyId, now
    );
    // 3 -> Cambiar el estado del dispositivo en la base de datos y publicar en MQTT
    await SetNewStateAsync(device, isValid);
}

async Task SetNewStateAsync(SmartDevice device, bool newState)
{
    var oldState = device.IsOn;
    device.SetIsOn(newState);
    if (oldState != newState)
    {
        // Base de datos
        await smartDeviceRepository.SaveAsync(device, propertyId);
    }
    // MQTT, siempre se publica por seguridad
    await smartDeviceMqttService.PublishDeviceStateAsync(device);
}

