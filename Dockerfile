# Investigating https://github.com/manics/jupyter-desktop-mate/actions/runs/14793661412/job/41536269082

# ------
# ERROR: failed to solve: failed to push ghcr.io/manics/jupyter-desktop-mate:latest: failed to copy: GET https://productionresultssa11.blob.core.windows.net/actions-cache/753-285568883
# --------------------------------------------------------------------------------
# RESPONSE 403: 403 Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature.
# ERROR CODE: AuthenticationFailed
# --------------------------------------------------------------------------------
# <?xml version="1.0" encoding="utf-8"?><Error><Code>AuthenticationFailed</Code><Message>Server failed to authenticate the request. Make sure the value of Authorization header is formed correctly including the signature.
# RequestId:c47577a7-001e-0046-7356-bb05ff000000
# Time:2025-05-02T11:34:12.6250694Z</Message><AuthenticationErrorDetail>Signature not valid in the specified time frame: Start [Fri, 02 May 2025 10:47:50 GMT] - Expiry [Fri, 02 May 2025 10:57:55 GMT] - Current [Fri, 02 May 2025 11:34:12 GMT]</AuthenticationErrorDetail></Error>
# --------------------------------------------------------------------------------

FROM docker.io/library/busybox:1.36.1-glibc

RUN for n in `seq 15`; do echo -n "$n: "; date; sleep 1m; done

RUN echo "Done!"
