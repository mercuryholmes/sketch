module Config (database) where

import Database.PostgreSQL.Simple

database :: ConnectInfo
database = defaultConnectInfo
           { connectHost = "postgres"
           , connectDatabase = "sketch"
           , connectUser = "postgres"
           , connectPassword = "postgres"
           }
