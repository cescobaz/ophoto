module CreateMediaFromFile where

import           Media

import           Test.Tasty
import           Test.Tasty.HUnit

tests :: TestTree
tests = testGroup "CreateMediaFromFile"
                  [ createMediaFromImage, createMediaFromImage' ]

createMediaFromImage :: TestTree
createMediaFromImage = testCase "createMediaFromImage" $ do
    media <- Media.fromFile filePath
    filePath @=? Media.filePath media
    metadata @=? Media.metadata media
    date @=? Media.date media
  where
    filePath = "./test/image-with-exif.jpeg"

    metadata =
        Just Metadata { Media.dateTimeOriginal = Just "2019:07:15 08:55:58"
                      , Media.subSecTimeOriginal = Just "085"
                      , Media.offsetTimeOriginal = Nothing
                      , Media.dateTime = Just "2019:07:15 08:55:58"
                      , Media.subSecTime = Nothing
                      , Media.offsetTime = Nothing
                      , Media.dateTimeDigitized = Just "2019:07:15 08:55:58"
                      , Media.subSecTimeDigitized = Just "085"
                      , Media.offsetTimeDigitized = Nothing
                      }

    date = Just "2019-07-15T08:55:58.085"

createMediaFromImage' :: TestTree
createMediaFromImage' = testCase "createMediaFromImage'" $ do
    media <- Media.fromFile filePath
    filePath @=? Media.filePath media
    Just metadata @=? Media.metadata media
    date @=? Media.date media
  where
    filePath = "./test/image-with-exif-2.jpeg"

    metadata = Metadata { Media.dateTimeOriginal = Just "2020:03:07 12:05:05"
                        , Media.subSecTimeOriginal = Just "994"
                        , Media.offsetTimeOriginal = Just "+01:00"
                        , Media.dateTime = Just "2020:03:07 12:05:05"
                        , Media.subSecTime = Nothing
                        , Media.offsetTime = Just "+01:00"
                        , Media.subSecTimeDigitized = Just "994"
                        , Media.dateTimeDigitized = Just "2020:03:07 12:05:05"
                        , Media.offsetTimeDigitized = Just "+01:00"
                        }

    date = Just "2020-03-07T12:05:05.994+01:00"





