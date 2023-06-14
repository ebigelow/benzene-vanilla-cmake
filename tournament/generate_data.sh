# ----------------------------------------
# Parameters
SIZE=8
ROUNDS=1
OPENINGS=""
TYPE="iterative"

PROGRAM1="../build/src/mohex/mohex"
CONFIG1="config8.htp"  #"mohex-cg2010.htp"
PROGRAM2="../build/src/mohex/mohex"
CONFIG2="config8.htp"
# ----------------------------------------



# Local variables from args
OPENINGS="openings/"$SIZE"x"$SIZE"-all-1ply"
PROGNAME1=`basename $PROGRAM1`
NAME1=$PROGNAME1-$CONFIG1
PROGNAME2=`basename $PROGRAM2`
NAME2=$PROGNAME2-$CONFIG2

# Distinguish between the instances if doing self-play so that the logfiles are not clobbered.
if [ $NAME1 == $NAME2 ]; then
    NAME1=$NAME1"-a"
    NAME2=$NAME2"-b"
fi

DIRECTORY="jobs/"$SIZE"x"$SIZE"-"$NAME1"-vs-"$NAME2
mkdir -p $DIRECTORY

# Run the tournament. 
/Users/eric/.pyenv/shims/python2.7 ./twogtp.py \
    --type $TYPE \
    --dir "$DIRECTORY" \
    --openings $OPENINGS \
    --size $SIZE --rounds $ROUNDS \
    --p1cmd "$PROGRAM1 --config $CONFIG1" --p1name $NAME1 \
    --p2cmd "$PROGRAM2 --config $CONFIG2" --p2name $NAME2
