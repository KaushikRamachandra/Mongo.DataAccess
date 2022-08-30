using MongoDB.Driver;

namespace Common.Mongo.DataAccess
{
    public interface IMongoConnection
    {
        IMongoDatabase MongoDatabase { get; }
    }

    public class MongoConnection : IMongoConnection
    {
        public IMongoDatabase MongoDatabase { get; private set; }

        public MongoConnection(string mongoConnectionString)
        {
            MongoUrl mongoUrl = MongoUrl.Create(mongoConnectionString);

            MongoClient client = new MongoClient(mongoUrl);
            if (client != null)
                this.MongoDatabase = client.GetDatabase(mongoUrl.DatabaseName);
            else
                throw new System.Exception(string.Format("Unable to connect to Mongo DB, please check the Mongo Connection string"));
        }
    }
}