namespace eRezervisi.Common.Dtos.Auth
{
    public class JwtTokenResponse
    {
        public bool LoggedIn { get; set; }
        public string? Token { get; set; }
        public DateTime? ExpiresAtUtc { get; set; }
        public string? RefreshToken { get; set; }
        public DateTime? RefreshTokenExpiresAtUtc { get; }
        public long RoleId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Initials => $"{FirstName.First()}{LastName.First()}";
        public string Email { get; set; }
        public string Username { get; set; }
        public long UserId { get; set; }

        public JwtTokenResponse(bool loggedIn, string? token, DateTime? expiresAtUtc, string? refreshToken,
            DateTime? refreshTokenExpiresAtUtc, long roleId, string firstName, string lastName,
            string email, string username, long userId)
        {
            LoggedIn = loggedIn;
            Token = token;
            ExpiresAtUtc = expiresAtUtc;
            RefreshToken = refreshToken;
            RefreshTokenExpiresAtUtc = refreshTokenExpiresAtUtc;
            RoleId = roleId;
            FirstName = firstName;
            LastName = lastName;
            Email = email;
            Username = username;
            UserId = userId;
        }
    }
}
