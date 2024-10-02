using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Common.Shared
{
    public static class QueryableExtensions
    {
        public static async Task<PagedResponse<TSelector>> GetPagedAsync<TEntity, TSelector, TOrderByKey>(this IQueryable<TEntity>? queryable, PagedRequest<TEntity> request, List<(bool ShouldFilter, Expression<Func<TEntity, bool>> FilterExpression)> filterExpressions, Expression<Func<TEntity, TOrderByKey>> orderByExpression, Expression<Func<TEntity, TSelector>> projection, CancellationToken cancellationToken) where TEntity : class
        {
            if (queryable == null)
            {
                throw new ArgumentNullException(nameof(queryable));
            }

            foreach (var filterExpression in filterExpressions)
            {
                if (filterExpression.ShouldFilter)
                {
                    queryable = queryable.Where(filterExpression.FilterExpression);
                }
            }

            var totalItems = await queryable.CountAsync(cancellationToken);

            if (request.OrderByDirection == OrderByDirection.Desc)
            {
                queryable = queryable.OrderByDescending(orderByExpression);
            }
            else
            {
                queryable = queryable.OrderBy(orderByExpression);
            }

            var items = await queryable
                .AsNoTracking()
                .Select(projection)
                .Skip(request.Skip)
                .Take((int)request.PageSize)
                .ToListAsync(cancellationToken);

            return new PagedResponse<TSelector>
            {
                TotalItems = totalItems,
                TotalPages = (long)Math.Ceiling(((double)totalItems / request.PageSize)),
                Items = items,
                PageSize = request.PageSize,
            };
        }
    }
}
