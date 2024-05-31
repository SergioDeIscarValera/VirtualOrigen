using InversorYesterdayService.Models;
using InversorYesterdayService.Services.Mqtt;
using InversorYesterdayService.Services.Mqtt.Inversor;
using InversorYesterdayService.Services.Repository.Inversor;

Console.WriteLine("InversorYesterdayService v1.0");
IMqttService<InversorData> mqttService = InversorMqttService.Instance;
var inversorDataRepository = InversorDataRepository.Instance;
var documentId = Environment.GetEnvironmentVariable("DOCUMENT_ID") ?? throw new("DOCUMENT_ID");

// 1 -> Suscribirse al servicio MQTT
mqttService.Subscribe(async (data) =>
{
    // 2 -> Guardar los datos recibidos en la base de datos
    await inversorDataRepository.SaveAsync(data, documentId);
});

await mqttService.StartAsync();

// Bucle infinito para mantener el programa en ejecución
while (true)
{
    // Aquí puedes hacer otras tareas si es necesario
    await Task.Delay(TimeSpan.FromSeconds(0.5));
}