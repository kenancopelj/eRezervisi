﻿using eRezervisi.Common.Dtos.Statistics;
using eRezervisi.Common.Shared.Requests.Statistics;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IStatisticsService
    {
        Task<List<GetReservationsByYearDto>> GetReservationByYearAsync(GetReservationsByYearOrMonthRequest request, CancellationToken cancellationToken);
        Task<List<GetReservationsByYearDto>> GetReservationByMonthAsync(GetReservationsByYearOrMonthRequest request, CancellationToken cancellationToken);
        Task<List<GetGuestsByYearDto>> GetGuestsByYearAsync(GetGuestsByYearOrMonthRequest request, CancellationToken cancellationToken);
        Task<List<GetGuestsByYearDto>> GetGuestsByMonthAsync(GetGuestsByYearOrMonthRequest request, CancellationToken cancellationToken);
        Task<GetReservationsByYearDto> GetMostPopularAccommodationUnits(CancellationToken cancellationToken);
    }
}
