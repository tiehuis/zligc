var errno: c_int = 0;

export fn __errno_location() ?&c_int {
    return &errno;
}
