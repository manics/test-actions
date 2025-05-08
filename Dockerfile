FROM busybox

RUN for n in `seq 11`; do echo -n "$n: "; date; sleep 1m; done

RUN echo "Done!"
