namespace SmartDevicesService.Utils;

public class Formatter
{
    public static Tuple<int, int> GetRangeInt(string range)
    {
        var split = range.Split(':');
        return new Tuple<int, int>(int.Parse(split[0]), int.Parse(split[1]));
    }
    public static Tuple<DateTime, DateTime> GetRangeDateTime(string range)
    {
        var split = range.Split(" - ");
        return new Tuple<DateTime, DateTime>(DateTime.Parse(split[0]), DateTime.Parse(split[1]));
    }

    public static string GetRangeString(Tuple<int, int> range)
    {
        return $"{range.Item1}:{range.Item2}";
    }

    public static string GetRangeString(Tuple<DateTime, DateTime> range)
    {
        return $"{range.Item1:yyyy-MM-dd HH:mm:ss} - {range.Item2:yyyy-MM-dd HH:mm:ss}";
    }

    internal static Tuple<double, double> GetRangeDouble(string range)
    {
        var split = range.Split(':');
        return new Tuple<double, double>(double.Parse(split[0]), double.Parse(split[1]));
    }
}
