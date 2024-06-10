namespace InversorYesterdayService.Services.Mqtt;

internal interface IMqttService<T>
{
    public Task StartAsync();
    public Task PublishAsync(T data);
    public void Subscribe(Action<T> onMessageReceived);
    public Task UnsubscribeAsync();
}
