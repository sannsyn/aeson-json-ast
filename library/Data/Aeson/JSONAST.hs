-- |
-- This module exports 'FromJSON' and 'ToJSON' instance for 'JSONAST.JSON',
-- as well as the conversion utilities.
-- All of them bear zero runtime overhead compared to
-- the native Aeson 'Value',
-- because they are implemented using type coersion.
module Data.Aeson.JSONAST where

import Unsafe.Coerce
import Data.Aeson
import qualified JSONAST


{-# INLINE jsonToValue #-}
jsonToValue :: JSONAST.JSON -> Value
jsonToValue =
  unsafeCoerce

{-# INLINE valueToJSON #-}
valueToJSON :: Value -> JSONAST.JSON
valueToJSON =
  unsafeCoerce

instance ToJSON JSONAST.JSON where
  {-# INLINE toJSON #-}
  toJSON =
    jsonToValue
  {-# INLINE toEncoding #-}
  toEncoding =
    toEncoding . jsonToValue

instance FromJSON JSONAST.JSON where
  {-# INLINE parseJSON #-}
  parseJSON =
    fmap valueToJSON .
    parseJSON
