using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class MessageConfiguration : BaseEntityTypeBuilder<Message>, IEntityTypeConfiguration<Message>
    {
        public override void Configure(EntityTypeBuilder<Message> builder)
        {
            base.Configure(builder);

            builder.ToTable("messages");

            builder.HasOne<User>(x => x.Sender).WithMany().HasForeignKey(x => x.SenderId).OnDelete(DeleteBehavior.Restrict);

            builder.HasOne<User>(x => x.Reciever).WithMany().HasForeignKey(x => x.RecieverId).OnDelete(DeleteBehavior.Restrict);

            builder.Property(x => x.Content);
        }
    }
}
