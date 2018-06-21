module Lib
  where
import           Control.Monad    (when, zipWithM_)
import           System.Directory
import           Text.Printf

newFilename :: String -> String -> Int -> Int -> String
newFilename name extension n = printf format
  where
  k = floor(logBase 10 (fromIntegral n)) + 1
  format = name ++ "%0" ++ show k ++ "d." ++ extension

oldnames :: String -> String -> Int -> [String]
oldnames name extension n =
  map(\i -> name ++ show i ++ "." ++ extension) [0..n]

newnames :: String -> String -> Int -> [String]
newnames name extension n =
  map (newFilename name extension n) [0..n]

renameOne :: String -> String -> IO ()
renameOne oldname newname = do
  exists <- doesFileExist oldname
  when exists $ renameFile oldname newname

renameAll :: String -> String -> Int -> IO ()
renameAll name extension n =
  zipWithM_ renameOne (oldnames name extension n) (newnames name extension n)
