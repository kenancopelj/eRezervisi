using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;

namespace eRezervisi.Api.Extensions
{
    public class Firebase
    {
        public void ConfigureFirebase(IServiceCollection services)
        {
            FirebaseApp.Create(new AppOptions
            {
                Credential = GoogleCredential.FromFile("C:\\Projects\\RS2\\eRezervisi\\erezervisi_api\\eRezervisi\\eRezervisi.Api\\key.json"),
                ProjectId = "erezervisifcm"
            });
        }
    }
}
