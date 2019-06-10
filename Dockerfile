FROM busybox

ADD VERSION.txt /
CMD ["cat", "/VERSION.txt"]
