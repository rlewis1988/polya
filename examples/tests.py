####################################################################################################
#
# tests.py
#
# Authors:
# Jeremy Avigad
# Rob Lewis
#
# Contains tests for Polya.
#
# TODO:
#
####################################################################################################

import terms
import blackboard
import poly_add_module
import poly_mult_module
import messages

x, y, u, v, w, z, r = terms.Vars('x, y, u, v, w, z, r')

def run(B):
    #try:
        while True:
            poly_add_module.update_blackboard(B)
            poly_mult_module.update_blackboard(B)
    #except Exception as e:
    #    print e

def test1():
    B = blackboard.Blackboard()
    B.assert_comparison(0 < x)
    B.assert_comparison(x < 3*y)
    B.assert_comparison(u < v)
    B.assert_comparison(v < 0)
    B.assert_comparison(1 < v**2)
    B.assert_comparison(v**2 < x)
    B.assert_comparison(u*(2*y)**2 + 1 >= x**2 * v + x)

    # This example has a model if the last inequality is <. FM blows up here, poly doesn't
    # It does not have a model if the last inequality is >=. Contradiction is found.
    # "0<x<3*y", "u<v<0", "1<v^2<x", "u*(3*y)^2+1 >= x^2*v+x"


    run(B)

def test2():
    messages.set_verbosity(messages.normal)
    B = blackboard.Blackboard()

    B.assert_comparison(0 < x)
    B.assert_comparison(x < y)
    B.assert_comparison(0 < u)
    B.assert_comparison(u < v)
    B.assert_comparison(0 < w + z)
    B.assert_comparison(w + z < r - 1)
    B.assert_comparison(u + (1+x)**2 * (2*w + 2*z + 3) >= 2*v + (1+y)**2 * (2*r + 1))
    #     print("  0 < x < y")
    # print("  0 < u < v")
    # print("  0 < w + z < r - 1")
    #"  u + (1 + x)^2 (2 w + 2 z + 3) < 2 v + (1 + y)^2 (2 r + 1)"
    # x y u v w z r
    # a b c d e f g
    run(B)

test1()