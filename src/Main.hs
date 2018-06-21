module Main
  where
import           Data.Semigroup      ((<>))
import           Lib
import           Options.Applicative

data Arguments = Arguments
  { _name      :: String
  , _extension :: String
  , _nmax      :: Int }

args :: Parser Arguments
args = Arguments
      <$> strOption
          ( long "name"
         <> short 'n'
         <> metavar "NAME"
         <> help "File name without numbers and extension" )
      <*> strOption
          ( long "extension"
         <> short 'e'
         <> metavar "EXTENSION"
         <> help "file extension" )
      <*> option auto
          ( long "max"
         <> short 'm'
         <> metavar "MAXIMUM"
         <> help "maximum number" )

run :: Arguments -> IO ()
run (Arguments name extension nmax) = renameAll name extension nmax

main :: IO ()
main = run =<< execParser opts
  where
    opts = info (args <**> helper)
      ( fullDesc
     <> progDesc "Harmonize files numbering"
     <> header "numberfiles" )
