using InversorNowService.Models;
using InversorNowService.Services.Mqtt;
using InversorNowService.Services.Mqtt.Inversor;
using InversorNowService.Services.Repository.Inversor;

Console.WriteLine("InversorNowService v1.1");
IMqttService<InversorData> mqttService = InversorMqttService.Instance;
var inversorDataRepository = InversorDataRepository.Instance;
// 1 -> Suscribirse al servicio MQTT
mqttService.Subscribe((data) =>
{
    // 2 -> Guardar los datos recibidos en la base de datos
    inversorDataRepository.SaveAsync(data);
});

await mqttService.StartAsync();

// Bucle infinito para mantener el programa en ejecución
while (true)
{
    // Aquí puedes hacer otras tareas si es necesario
    await Task.Delay(TimeSpan.FromSeconds(0.5));
}
