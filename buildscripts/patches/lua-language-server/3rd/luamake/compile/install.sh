#!/usr/bin/env sh
DIR=$(cd `dirname $0`/..; pwd)

case "`uname`" in
  MSYS_NT*|MINGW64_NT*|Windows_NT*)
    ninja -f $DIR/compile/ninja/mingw.ninja
    ;;
  Linux)
    case "`uname -o`" in
      Android)
        ninja -f $DIR/compile/ninja/android.ninja
        ;;
      *)
        ninja -f $DIR/compile/ninja/linux.ninja
        ;;
    esac
    ;;
  Darwin)
    ninja -f $DIR/compile/ninja/macos.ninja
    ;;
  NetBSD)
    ninja -f $DIR/compile/ninja/netbsd.ninja
    ;;
  FreeBSD)
    ninja -f $DIR/compile/ninja/freebsd.ninja
    ;;
  *)
    echo "Unknown OS $OS"
    exit 1
    ;;
esac

if [ "$?" != "0" ]
then
  exit 1
fi

write_v1()
{
    grep -sq "luamake" $1 || echo -e "\nalias luamake=$DIR/luamake" >> $1
}

write_v2()
{
    grep -sq "luamake" $1 || echo -e "\nalias luamake $DIR/luamake" >> $1
}

include () {
    [ -f "$1" ] && source "$1"
}
