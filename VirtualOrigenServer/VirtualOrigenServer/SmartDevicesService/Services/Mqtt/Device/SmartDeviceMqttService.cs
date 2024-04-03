using MQTTnet;
using MQTTnet.Client;
using SmartDevicesService.Models;

namespace SmartDevicesService.Services.Mqtt.Device;

public class SmartDeviceMqttService
{
    private readonly string _topic;
    private readonly string _brokerIp;
    private readonly string _clientId;
    private readonly MqttClientOptions options;
    public IMqttClient mqttClient { get; private set; }
    public SmartDeviceMqttService()
    {
        _topic = Environment.GetEnvironmentVariable("MQTT_TOPIC") ?? "smart_devices";
        //_brokerIp = Environment.GetEnvironmentVariable("MQTT_BROKER_IP") ?? "localhost";
        _brokerIp = "192.168.195.199";
        _clientId = Environment.GetEnvironmentVariable("MQTT_CLIENT_ID") ?? "smart_devices_service";

        options = new MqttClientOptionsBuilder()
            .WithTcpServer(_brokerIp)
            .WithClientId(_clientId)
            .Build();
        mqttClient = new MqttFactory().CreateMqttClient();
        mqttClient.ConnectedAsync += async e =>
        {
            Console.WriteLine("MQTT connected\n");
            await mqttClient.SubscribeAsync(new MqttTopicFilterBuilder().WithTopic(_topic).Build());
        };
    }

    private static SmartDeviceMqttService? _instance;

    public static SmartDeviceMqttService Instance
    {
        get
        {
            _instance ??= new SmartDeviceMqttService();
            return _instance;
        }
    }

    public async Task PublishDeviceStateAsync(SmartDevice device)
    {
        var message = device.IsOn ? "1" : "0";
        var applicationMessage = new MqttApplicationMessageBuilder()
          .WithTopic($"{_topic}/{device.Id}")
          .WithPayload(message)
          .Build();
        await mqttClient.PublishAsync(applicationMessage);
    }

    public async Task StartAsync()
    {
        await mqttClient.ConnectAsync(options, CancellationToken.None);
    }
}
