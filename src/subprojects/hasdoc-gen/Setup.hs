import Distribution.Simple
import System.Directory
import System.FilePath


main = defaultMainWithHooks simpleUserHooks { postHaddock = posthaddock }

posthaddock args flags desc info = 
    do
        home <- getHomeDirectory
        createDirectoryIfMissing True (home ++ "/.hasdoc-gen")
        copyFile ("data/translations/en.msg") (home ++ "/.hasdoc-gen/en.msg")
        copyFile ("data/translations/pl.msg") (home ++ "/.hasdoc-gen/pl.msg")

  


