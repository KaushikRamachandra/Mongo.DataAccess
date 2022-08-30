using MongoDB.Driver;
using MongoDbGenericRepository;

namespace Common.Mongo.DataAccess
{
    public interface IMongoRepository : IBaseMongoRepository
    {

    }

    public class MongoRepository : BaseMongoRepository, IMongoRepository
    {
        public MongoRepository(IMongoDatabase mongoDatabase) : base(mongoDatabase)
        {

        }
    }
}