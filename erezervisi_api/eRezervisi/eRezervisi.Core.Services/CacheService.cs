using eRezervisi.Core.Services.Interfaces;
using Microsoft.Extensions.Caching.Memory;

namespace eRezervisi.Core.Services
{
    public class CacheService : ICacheService
    {
        private IMemoryCache _memoryCache;


        public CacheService(IMemoryCache memoryCache)
        {
            _memoryCache = memoryCache;
        }

        public object? GetData(string key)
        {
            return _memoryCache.TryGetValue(key, out var value) ? value : new();
        }

        public void RemoveData(string key)
        {
            _memoryCache.Remove(key);
        }

        public void SetData(string key, object value, TimeSpan expirationTime)
        {
            var cacheEntryOptions = new MemoryCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = expirationTime
            };

            _memoryCache.Set(key, value, cacheEntryOptions);
        }
    }
}
