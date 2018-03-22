// Private helper functions for dealing with c

pub fn toInt(expr: bool) c_int {
    return if (expr) c_int(1) else 0;
}
