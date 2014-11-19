fmadd = "Fourier Motzkin elimination (additive)"
fmmul = "Fourier Motzkin elimination (multiplicative)"
import random
import asciitree

class Proof(object):
    def __init__(self, reason, parents):
        self.reason = reason
        self.parents = parents

    def __str__(self):
        return "By {0!s}, from [{1!s}]".format(self.reason, ", ".join(str(s) for s in self.parents))

    def trace2(self, level=0):
        # r = random.randint(0, 100)
        # print 'getting source from:', r
        # for s in self.parents:
        #     print 'parent', s
        #     print s.source
        # print 'done:', r
        retval = "By {0!s}, from: \n".format(self.reason)
        for s in self.parents:
            retval += " "*level + str(s) + ": " + s.source.trace(level+1) + "\n"
        return retval
        

            
unknown = Proof('Unknown', [])