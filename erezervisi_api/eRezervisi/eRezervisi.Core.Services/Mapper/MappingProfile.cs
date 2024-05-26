using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.AccommodationUnitPolicy;
using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Dtos.Role;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Dtos.UserSettings;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.AccommodationUnit;
using eRezervisi.Common.Shared.Requests.AccommodationUnitCategory;
using eRezervisi.Common.Shared.Requests.Canton;
using eRezervisi.Common.Shared.Requests.Reservation;
using eRezervisi.Core.Domain.Authorization;
using eRezervisi.Core.Domain.Entities;

namespace eRezervisi.Core.Services.Mapper
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<UserCreateDto, User>();
            CreateMap<UserUpdateDto, User>();
            CreateMap<UserSettings, UserSettingsGetDto>();
            CreateMap<User, UserGetDto>();
            CreateMap<Role, RoleGetDto>();
            CreateMap<UpdateSettingsDto, UserSettings>();

            CreateMap<AccommodationUnitCreateDto, AccommodationUnit>();
            CreateMap<AccommodationUnitPolicyCreateDto, AccommodationUnitPolicy>();
            CreateMap<AccommodationUnit, AccommodationUnitGetDto>();
            CreateMap<GetAccommodationUnitsRequest, PagedRequest<AccommodationUnit>>();
            CreateMap<PagedRequest<AccommodationUnitCategory>, GetCategoriesRequest>();
            CreateMap<GetAccommodationUnitReviewsRequest, PagedRequest<AccommodationUnit>>();
            CreateMap<AccommodationUnitUpdateDto, AccommodationUnit>();

            CreateMap<GetCantonsRequest, PagedRequest<Canton>>();

            CreateMap<ReservationCreateDto, Reservation>();
            CreateMap<ReservationUpdateDto, Reservation>();
            CreateMap<Reservation, ReservationGetDto>();
            CreateMap<GetReservationsRequest, PagedRequest<Reservation>>();
        }
    }
}
