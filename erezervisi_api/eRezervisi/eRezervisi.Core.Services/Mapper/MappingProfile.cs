﻿using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.AccommodationUnitPolicy;
using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Dtos.FavoriteAccommodationUnit;
using eRezervisi.Common.Dtos.Image;
using eRezervisi.Common.Dtos.Message;
using eRezervisi.Common.Dtos.Notification;
using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.Role;
using eRezervisi.Common.Dtos.Storage;
using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Dtos.UserSettings;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.AccommodationUnit;
using eRezervisi.Common.Shared.Requests.AccommodationUnitCategory;
using eRezervisi.Common.Shared.Requests.Canton;
using eRezervisi.Common.Shared.Requests.FavoriteAccommodationUnit;
using eRezervisi.Common.Shared.Requests.Guest;
using eRezervisi.Common.Shared.Requests.Message;
using eRezervisi.Common.Shared.Requests.Reservation;
using eRezervisi.Common.Shared.Requests.Township;
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
            CreateMap<AccommodationUnitGetDto, AccommodationUnit>();
            CreateMap<GetAccommodationUnitsRequest, PagedRequest<AccommodationUnit>>();
            CreateMap<PagedRequest<AccommodationUnitCategory>, GetCategoriesRequest>();
            CreateMap<GetAccommodationUnitReviewsRequest, PagedRequest<AccommodationUnit>>();
            CreateMap<AccommodationUnitUpdateDto, AccommodationUnit>();
            CreateMap<GetCantonsRequest, PagedRequest<Canton>>();
            CreateMap<ReservationCreateDto, Reservation>();
            CreateMap<ReservationUpdateDto, Reservation>();
            CreateMap<Reservation, ReservationGetDto>();
            CreateMap<GetReservationsRequest, PagedRequest<Reservation>>();
            CreateMap<GetTownshipsRequest, PagedRequest<Township>>();
            CreateMap<GetGuestsRequest, PagedRequest<Reservation>>();
            CreateMap<UploadedFileGetDto, Image>();
            CreateMap<ImageGetDto, Image>();
            CreateMap<ReviewCreateDto, Review>();
            CreateMap<ReviewGetDto, Review>();
            CreateMap<PagedRequest<AccommodationUnit>, GetAccommodationUnitReviewsRequest>();
            CreateMap<PagedRequest<AccommodationUnitCategory>, GetCategoriesRequest>();
            CreateMap<ImageCreateDto, Image>();
            CreateMap<Image, ImageCreateDto>();
            CreateMap<Image, ImageGetDto>();
            CreateMap<TownshipGetDto, Township>();
            CreateMap<CantonGetDto, Canton>();
            CreateMap<FavoriteAccommodationUnit, FavoriteAccommodationUnitGetDto>();
            CreateMap<GetFavoriteAccommodationUnitsRequest, PagedRequest<FavoriteAccommodationUnit>>();
            CreateMap<Review, ReviewGetDto>();
            CreateMap<FirebaseAdmin.Messaging.Notification, NotificationCreateDto>();
            CreateMap<Township, TownshipGetDto>();
            CreateMap<Canton, CantonGetDto>();
            CreateMap<AccommodationUnitPolicy, PolicyGetDto>();
            CreateMap<AccommodationUnitCategory, CategoryGetDto>();
            CreateMap<NotificationCreateDto, Notification>();
            CreateMap<MessageCreateDto, Message>();
            CreateMap<Message, MessageGetDto>();
            CreateMap<GetMessagesRequest, PagedRequest<Message>>();
            CreateMap<User, UserGetShortDto>();
            CreateMap<PagedRequest<AccommodationUnitReview>, GetAccommodationUnitReviewsRequest>();
        }
    }
}
