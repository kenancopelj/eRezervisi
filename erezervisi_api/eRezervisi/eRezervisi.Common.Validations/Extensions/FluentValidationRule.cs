using eRezervisi.Common.Validations.Constants;
using FluentValidation;

namespace eRezervisi.Common.Validations.Extensions
{
    internal static class FluentValidationRule
    {
        internal static IRuleBuilderOptions<T, TProperty> WithErrorCodeAndMessage<T, TProperty>(this IRuleBuilderOptions<T, TProperty> rule, string errorCode, string errorMessage = "")
        {
            if (string.IsNullOrWhiteSpace(errorMessage))
            {
                rule.WithMessage(errorCode);

                return rule;
            }

            rule.WithMessage($"{errorCode} - {errorMessage}");

            return rule;
        }

        internal static IRuleBuilderOptions<T, long> ValidEntityId<T>(this IRuleBuilder<T, long> ruleBuilder)
        {
            return ruleBuilder.NotEmpty().GreaterThanOrEqualTo(1).LessThanOrEqualTo(long.MaxValue).WithErrorCodeAndMessage(ValidationErrorCodes.ValidEntityId);
        }

        internal static IRuleBuilderOptions<T, int> ValidEntityId<T>(this IRuleBuilder<T, int> ruleBuilder)
        {
            return ruleBuilder.NotEmpty().GreaterThanOrEqualTo(1).LessThanOrEqualTo(int.MaxValue).WithErrorCodeAndMessage(ValidationErrorCodes.ValidEntityId);
        }

        internal static IRuleBuilderOptions<T, string> ValidString<T>(this IRuleBuilder<T, string> ruleBuilder)
        {
            return ruleBuilder.NotEmpty().WithErrorCodeAndMessage(ValidationErrorCodes.NotEmpty);
        }
    }
}
