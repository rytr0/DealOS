if [ "$#" -eq 0 ]; then
	echo "Missing name of program to run."
	exit 1
fi

make

rval=$?
if [ $rval -ne 0 ]; then
	exit $rval
fi

echo -n "compiling $1.f..."
./fortran.native "$1"

rval=$?
if [ $rval -ne 0 ]; then
	exit $rval
fi

echo "done"
echo -n "assembling $1.asm..."

nasm $1.asm -o $1.bin

if [ $? -ne 0 ]; then
	exit $?
fi

echo "done"
