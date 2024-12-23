﻿namespace eRezervisi.Core.Domain.Entities
{
    public class UserCredentials
    {
        public long UserId { get; set; }
        public string Username { get; set; } = null!;
        public string PasswordHash { get; set; } = null!;
        public string PasswordSalt { get; set; } = null!;
        public string? RefreshToken { get; set; }
        public DateTime? RefreshTokenExpiresAtUtc { get; set; }
        public DateTime LastPasswordChangeAt { get; set; }
        public bool ReminderSent { get; set; }

        public UserCredentials() { }

        public void SetRefreshToken(string refreshToken, DateTime refreshTokenExpiresAt)
        {
            RefreshToken = refreshToken;
            RefreshTokenExpiresAtUtc = refreshTokenExpiresAt;
        }

        public void InvalidateRefreshToken()
        {
            RefreshToken = null;
            RefreshTokenExpiresAtUtc = null;
        }
    }
}
