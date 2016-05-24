package = "LuaSec"
version = "0.6alpha-2"
source = {
   url = "git://github.com/brunoos/luasec.git",
   tag = "luasec-0.6alpha"
}
description = {
   summary = "A binding for OpenSSL library to provide TLS/SSL communication over LuaSocket.",
   detailed = "This version delegates to LuaSocket the TCP connection establishment between the client and server. Then LuaSec uses this connection to start a secure TLS/SSL session.",
   homepage = "https://github.com/brunoos/luasec/wiki",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1", "luasocket"
}
external_dependencies = {
   platforms = {
      unix = {
         OPENSSL = {
            header = "openssl/ssl.h",
            library = "ssl"
         }
      },
      windows = {
         OPENSSL = {
            header = "openssl/ssl.h",
         }
      },
   }
}
build = {
   type = "builtin",
   copy_directories = {
      "samples"
   },
   platforms = {
      unix = {
         install = {
            lib = {
               "ssl.so"
            },
            lua = {
               "jni/gssl.lua", ['ssl.https'] = "src/https.lua"
            }
         },
         modules = {
            ssl = {
               incdirs = {
                  "$(OPENSSL_INCDIR)", "jni/g", "src/luasocket",
               },
               libdirs = {
                  "$(OPENSSL_LIBDIR)"
               },
               libraries = {
                  "ssl", "crypto"
               },
               sources = {
                  "jni/gx509.c", "src/context.c", "src/ssl.c", 
                  "jni/gluasocket/buffer.c", "src/luasocket/io.c",
                  "jni/gluasocket/timeout.c", "src/luasocket/usocket.c"
               }
            }
         }
      },
      windows = {
         install = {
            lib = {
               "ssl.dll"
            },
            lua = {
               "jni/gssl.lua", ['ssl.https'] = "src/https.lua"
            }
         },
         modules = {
            ssl = {
               defines = {
                  "WIN32", "NDEBUG", "_WINDOWS", "_USRDLL", "LSEC_EXPORTS", "BUFFER_DEBUG", "LSEC_API=__declspec(dllexport)",
                  "LUASEC_INET_NTOP", "WINVER=0x0501", "_WIN32_WINNT=0x0501", "NTDDI_VERSION=0x05010300"
               },
               libdirs = {
                  "$(OPENSSL_LIBDIR)",
                  "$(OPENSSL_BINDIR)",
               },
               libraries = {
                  "libeay32", "ssleay32", "ws2_32"
               },
               incdirs = {
                  "$(OPENSSL_INCDIR)", "jni/g", "src/luasocket"
               },
               sources = {
                  "jni/gx509.c", "src/context.c", "src/ssl.c", 
                  "jni/gluasocket/buffer.c", "src/luasocket/io.c",
                  "jni/gluasocket/timeout.c", "src/luasocket/wsocket.c"
               }
            }
         }
      }
   }
}
