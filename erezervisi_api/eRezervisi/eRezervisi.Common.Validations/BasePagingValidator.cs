using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Validations.Constants;
using eRezervisi.Common.Validations.Extensions;
using FluentValidation;

namespace eRezervisi.Common.Validations
{
    public class BasePagingValidator<T> : AbstractValidator<T> where T : BasePagedRequest
    {
        public BasePagingValidator()
        {
            RuleFor(x => x.Page).ValidEntityId();

            When(x => !string.IsNullOrWhiteSpace(x.SearchTerm), () =>
            {
                RuleFor(x => x.SearchTerm).Length(0, 100);
            });

            RuleFor(x => x.PageSize).GreaterThanOrEqualTo(0).LessThanOrEqualTo(50000);

            RuleFor(x => x.OrderByColumn).MaximumLength(150);

            RuleFor(x => x.OrderBy).MaximumLength(4);
        }
    }
}
