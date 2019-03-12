{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_wxdirect (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,93,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/juliagoda/Dokumenty/PDF/Praca_dyplomowa/Projekt/Kod/hasdoc/.stack-work/install/x86_64-linux-tinfo6/lts-11.9/8.2.2/bin"
libdir     = "/home/juliagoda/Dokumenty/PDF/Praca_dyplomowa/Projekt/Kod/hasdoc/.stack-work/install/x86_64-linux-tinfo6/lts-11.9/8.2.2/lib/x86_64-linux-ghc-8.2.2/wxdirect-0.93.0.0-K4S3GpvqpAYKLMn1eHhvEk-wxdirect"
dynlibdir  = "/home/juliagoda/Dokumenty/PDF/Praca_dyplomowa/Projekt/Kod/hasdoc/.stack-work/install/x86_64-linux-tinfo6/lts-11.9/8.2.2/lib/x86_64-linux-ghc-8.2.2"
datadir    = "/home/juliagoda/Dokumenty/PDF/Praca_dyplomowa/Projekt/Kod/hasdoc/.stack-work/install/x86_64-linux-tinfo6/lts-11.9/8.2.2/share/x86_64-linux-ghc-8.2.2/wxdirect-0.93.0.0"
libexecdir = "/home/juliagoda/Dokumenty/PDF/Praca_dyplomowa/Projekt/Kod/hasdoc/.stack-work/install/x86_64-linux-tinfo6/lts-11.9/8.2.2/libexec/x86_64-linux-ghc-8.2.2/wxdirect-0.93.0.0"
sysconfdir = "/home/juliagoda/Dokumenty/PDF/Praca_dyplomowa/Projekt/Kod/hasdoc/.stack-work/install/x86_64-linux-tinfo6/lts-11.9/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "wxdirect_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "wxdirect_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "wxdirect_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "wxdirect_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "wxdirect_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "wxdirect_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)