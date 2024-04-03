using SmartDevicesService.Models;

namespace SmartDevicesService.Utils;

public class SmartDeviceValidator
{
    public delegate Task<InversorData> InversorDataDelegate(string id);
    public delegate Task<PropertyHourWeather> PropertyHourWeatherDelegate(DateTime id, string idc);
    static public async Task<bool> SmartDeviceValidate(
        SmartDevice device,
        InversorDataDelegate inversorDataDelegate,
        PropertyHourWeatherDelegate propertyHourWeatherDelegate,
        string propertyId,
        DateTime now
    )
    {
        // Manually mode
        if (device.IsManualMode)
        {
            return true;
        }
        // Days
        var day = (int)now.DayOfWeek; // Domingo = 0, Lunes = 1, Martes = 2, Miercoles = 3, Jueves = 4, Viernes = 5, Sabado = 6
        var dayDevice = NewDayListFormatted(device.Days);
        if (!dayDevice[day])
        {

            return false;
        }
        // Time
        // Check if the current time is in the time range
        if (!CheckTimeRange(now, device.TimeZones))
        {
            return false;
        }
        // Other conditions
        if (device.TemperatureRange != null || device.RainRange != null)
        {
            //var weather = await propertyHourWeatherRepository.GetByIdAsync(now, propertyId);
            var weather = await propertyHourWeatherDelegate(now, propertyId);
            if (!CheckWeather(device, weather))
            {
                return false;
            }
        }
        if (device.BatteryRange != null || device.ProductionRange != null || device.ConsumptionRange != null)
        {
            //var propertyWeather = await inversorNowRepository.GetByIdcAsync(propertyId);
            var propertyWeather = await inversorDataDelegate(propertyId);
            if (!CheckInversorNow(device, propertyWeather))
            {
                return false;
            }
        }
        return true;
    }

    static bool CheckInversorNow(SmartDevice device, InversorData? propertyWeather)
    {
        if (propertyWeather == null) return false;
        if (device.BatteryRange != null && !CheckIntRange(propertyWeather.Battery, device.BatteryRange)) return false;
        if (device.ProductionRange != null && !CheckIntRange(propertyWeather.Gain, device.ProductionRange)) return false;
        if (device.ConsumptionRange != null && !CheckIntRange(propertyWeather.Consumption, device.ConsumptionRange)) return false;
        return true;
    }

    static bool CheckWeather(SmartDevice device, PropertyHourWeather? weather)
    {
        if (weather == null) return false;
        if (device.TemperatureRange != null && !CheckDoubleRange(weather.Temperature, device.TemperatureRange)) return false;
        if (device.RainRange != null && !CheckDoubleRange(weather.RainProbability, device.RainRange)) return false;
        return true;
    }

    static bool CheckIntRange(int value, string range)
    {
        var tupleRange = Formatter.GetRangeInt(range);
        return value >= tupleRange.Item1 && value <= tupleRange.Item2;
    }

    static bool CheckDoubleRange(double value, string range)
    {
        var tupleRange = Formatter.GetRangeDouble(range);
        return value >= tupleRange.Item1 && value <= tupleRange.Item2;
    }

    static bool CheckTimeRange(DateTime now, List<string> timeRanges)
    {
        foreach (var timeRange in timeRanges)
        {
            var range = Formatter.GetRangeDateTime(timeRange);
            var rangeTime = new Tuple<TimeSpan, TimeSpan>(range.Item1.TimeOfDay, range.Item2.TimeOfDay);
            var nowTime = now.TimeOfDay;
            if (nowTime >= rangeTime.Item1 && nowTime <= rangeTime.Item2)
            {
                return true;
            }
        }
        return false;
    }

    static List<bool> NewDayListFormatted(List<bool> days)
    {
        var dayDevice = new List<bool>([.. days]);
        var last = days.Last();
        dayDevice.RemoveAt(dayDevice.Count - 1);
        dayDevice.Insert(0, last);
        return dayDevice;
    }
}

