namespace eRezervisi.Common.Shared
{
    public enum ExceptionCode
    {
        // Standard statuses
        Success = 200,
        BadRequest = 400,
        NotFound = 404,
        ServerError = 500,

        // Custom statuses
        UserInactive = 601,
        DeviceBlocked = 602,
        Relogin = 603,
        InvalidCredentials = 604,
    }
}
