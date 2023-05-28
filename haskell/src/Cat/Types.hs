module Cat.Types (Cat(..), CreateCat(..), UpdateCat(..)) where

import Data.Aeson
import Database.PostgreSQL.Simple.FromRow
import Data.Text
import GHC.Generics (Generic)

data Cat = Cat
  {
    _id :: Int,
    name  :: Text,
    breed :: Maybe Text,
    description :: Maybe Text
  } deriving (Generic, Show)

instance ToJSON Cat where
  toJSON (Cat _id name breed description) =
    object
      [
        "id" .= _id,
        "name" .= name,
        "breed" .= breed,
        "description" .= description
      ]

data CreateCat = CreateCat
  {
    createCatName  :: Text,
    createCatBreed :: Maybe Text,
    createCatDescription :: Maybe Text
  } deriving (Generic, Show)

instance FromJSON CreateCat where
  parseJSON (Object v) = CreateCat
    <$> (v .: "name")
    <*> (v .:? "breed")
    <*> (v .:? "description")
  parseJSON _ = fail "invalid json"

data UpdateCat = UpdateCat
  {
    updateCatName  :: Text,
    updateCatBreed :: Maybe Text,
    updateCatDescription :: Maybe Text
  } deriving (Generic, Show)

instance FromJSON UpdateCat where
  parseJSON (Object v) = UpdateCat
    <$> (v .: "name")
    <*> (v .:? "breed")
    <*> (v .:? "description")
  parseJSON _ = fail "invalid json"

instance FromRow Cat where
  fromRow = Cat
    <$> field
    <*> field
    <*> field
    <*> field
