namespace eRezervisi.Common.Dtos.Statistics;

public class GetRevenuesDto
{
    public int TotalNumberOfReservations { get; set; }
    public decimal AverageReservationPrice { get; set; }
    public decimal RevenueThisMonth { get; set; }
    public decimal RevenueLastMonth { get; set; }
    public decimal TotalRevenue { get; set; }
}

