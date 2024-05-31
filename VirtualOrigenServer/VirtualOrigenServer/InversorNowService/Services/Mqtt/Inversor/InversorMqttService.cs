using InversorNowService.Models;
using MQTTnet;
using MQTTnet.Client;
using MQTTnet.Server;
using System.Text;

namespace InversorNowService.Services.Mqtt.Inversor;

public class InversorMqttService : IMqttService<InversorData>
{
    private readonly string _topic;
    private readonly string _brokerIp;
    private readonly string _clientId;
    private readonly MqttClientOptions options;
    public IMqttClient mqttClient { get; private set; }
    private InversorMqttService()
    {
        _topic = Environment.GetEnvironmentVariable("MQTT_TOPIC") ?? "resumen";
        _brokerIp = Environment.GetEnvironmentVariable("MQTT_BROKER_IP") ?? "localhost";
        _clientId = Environment.GetEnvironmentVariable("MQTT_CLIENT_ID") ?? "inversor_now_service";

        options = new MqttClientOptionsBuilder()
            .WithTcpServer(_brokerIp)
            .WithClientId(_clientId)
            .Build();
        mqttClient = new MqttFactory().CreateMqttClient();
        mqttClient.ConnectedAsync += async e =>
        {
            Console.WriteLine($"MQTT connected\n\t- Host: {_brokerIp}\n\t- Topic: {_topic}\n\t- Time: {GetDateTime()}\n");
            await mqttClient.SubscribeAsync(new MqttTopicFilterBuilder().WithTopic(_topic).Build());
        };

    }

    private static InversorMqttService? _instance;

    public static InversorMqttService Instance
    {
        get
        {
            _instance ??= new InversorMqttService();
            return _instance;
        }
    }

    public async Task PublishAsync(InversorData data)
    {
        var applicationMessage = new MqttApplicationMessageBuilder()
          .WithTopic(_topic)
          .WithPayload(data.ToString())
          .Build();
        await mqttClient.PublishAsync(applicationMessage);
    }

    public void Subscribe(Action<InversorData> onMessageReceived)
    {
        mqttClient.ApplicationMessageReceivedAsync += (async e =>
        {
            var payload = Encoding.UTF8.GetString(e.ApplicationMessage.PayloadSegment);

            Console.WriteLine($"Received MQTT message - {GetDateTime()}");
            Console.WriteLine($" - Topic = {e.ApplicationMessage.Topic}");
            Console.WriteLine($" - Payload = {payload}\n\n");
            var split = payload.Split(',');
            var inversorData = new InversorData(int.Parse(split[1]), int.Parse(split[0]), int.Parse(split[2]));

            onMessageReceived?.Invoke(inversorData);
        });
    }

    public Task UnsubscribeAsync()
    {
        return mqttClient.UnsubscribeAsync(_topic);
    }

    public async Task StartAsync()
    {
        await mqttClient.ConnectAsync(options, CancellationToken.None);
    }

    private static DateTime GetDateTime()
    {
        DateTime utcNow = DateTime.UtcNow;
        var timeZone = Environment.GetEnvironmentVariable("TIME_ZONE") ?? "Europe/Madrid";
        TimeZoneInfo timeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(timeZone);
        return TimeZoneInfo.ConvertTimeFromUtc(utcNow, timeZoneInfo);
    }
}
